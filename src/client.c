#ifdef _WIN32
    #include <winsock2.h>
    #include <windows.h>
    #define close closesocket
    #define sleep Sleep
#else
    #include <netdb.h>
    #include <unistd.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "client.h"
#include "tinycthread.h"

#define QUEUE_SIZE 1048576
#define RECV_SIZE 4096

static int client_enabled = 0;
static int running = 0;
static int sd = 0;
static int bytes_sent = 0;
static int bytes_received = 0;
static char *queue = 0;
static int qsize = 0;
static thrd_t recv_thread;
static mtx_t mutex;

#define ONLINE_ONLY if(!client_enabled) { return; }
void client_enable() { client_enabled = 1; }
void client_disable() { client_enabled = 0; }
int get_client_enabled() { return client_enabled; }


int client_sendall(int sd, char *data, int length) {
    if (!client_enabled) { return 0; }
    int count = 0;
    while (count < length) {
        int n = send(sd, data + count, length, 0);
        if (n == -1) {
            return -1;
        }
        count += n;
        length -= n;
        bytes_sent += n;
    }
    return 0;
}

void client_send(char *data) { ONLINE_ONLY
    if (client_sendall(sd, data, strlen(data)) == -1) {
        perror("client_sendall");
        exit(1);
    }
}

#include <stdarg.h>
void fmt_send(const char* fmt, ...) {
  va_list args;
  va_start(args, fmt);
  char buffer[1024];
  vsnprintf(buffer, 1024, fmt, args);
  va_end(args);
  client_send(buffer);
}

void client_version(int version) { ONLINE_ONLY
    fmt_send("V,%d\n", version); }

void client_login(const char *username,
                  const char *identity_token) { ONLINE_ONLY
    fmt_send("A,%s,%s\n", username, identity_token); }

#define PRECISE_COORD(a, b, c) float a, float b, float c
void client_position(PRECISE_COORD(x, y, z), float rx, float ry) { ONLINE_ONLY
    static float px, py, pz, prx, pry = 0;
    float distance =
        (px - x) * (px - x) +
        (py - y) * (py - y) +
        (pz - z) * (pz - z) +
        (prx - rx) * (prx - rx) +
        (pry - ry) * (pry - ry);
    if (distance < 0.0001) { return; }
    px = x; py = y; pz = z; prx = rx; pry = ry;
    fmt_send("P,%.2f,%.2f,%.2f,%.2f,%.2f\n", x, y, z, rx, ry);
}

void client_chunk(int p, int q, int key) { ONLINE_ONLY
    fmt_send("C,%d,%d,%d\n", p, q, key); }

#define COORD(a, b, c) int a, int b, int c
void client_block(COORD(x, y, z), int w) { ONLINE_ONLY
    fmt_send("B,%d,%d,%d,%d\n", x, y, z, w); }

void client_light(COORD(x, y, z), int w) { ONLINE_ONLY
    fmt_send("L,%d,%d,%d,%d\n", x, y, z, w); }

void client_sign(COORD(x, y, z), int face, const char *text) { ONLINE_ONLY
    fmt_send("S,%d,%d,%d,%d,%s\n", x, y, z, face, text); }

void client_talk(const char *text) { ONLINE_ONLY
    if (strlen(text) == 0) { return; }
    fmt_send("T,%s\n", text); }

char *client_recv() {
    if (!client_enabled) {
        return 0;
    }
    char *result = 0;
    mtx_lock(&mutex);
    char *p = queue + qsize - 1;
    while (p >= queue && *p != '\n') {
        p--;
    }
    if (p >= queue) {
        int length = p - queue + 1;
        result = malloc(sizeof(char) * (length + 1));
        memcpy(result, queue, sizeof(char) * length);
        result[length] = '\0';
        int remaining = qsize - length;
        memmove(queue, p + 1, remaining);
        qsize -= length;
        bytes_received += length;
    }
    mtx_unlock(&mutex);
    return result;
}

int recv_worker(void *arg) {
    char *data = malloc(sizeof(char) * RECV_SIZE);
    while (1) {
        int length;
        if ((length = recv(sd, data, RECV_SIZE - 1, 0)) <= 0) {
            if (running) {
                perror("recv");
                exit(1);
            }
            else {
                break;
            }
        }
        data[length] = '\0';
        while (1) {
            int done = 0;
            mtx_lock(&mutex);
            if (qsize + length < QUEUE_SIZE) {
                memcpy(queue + qsize, data, sizeof(char) * (length + 1));
                qsize += length;
                done = 1;
            }
            mtx_unlock(&mutex);
            if (done) {
                break;
            }
            sleep(0);
        }
    }
    free(data);
    return 0;
}

void client_connect(char *hostname, int port) { ONLINE_ONLY
    struct hostent *host;
    struct sockaddr_in address;
    if ((host = gethostbyname(hostname)) == 0) {
        perror("gethostbyname");
        exit(1);
    }
    memset(&address, 0, sizeof(address));
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = ((struct in_addr *)(host->h_addr_list[0]))->s_addr;
    address.sin_port = htons(port);
    if ((sd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }
    if (connect(sd, (struct sockaddr *)&address, sizeof(address)) == -1) {
        perror("connect");
        exit(1);
    }
}

void client_start() { ONLINE_ONLY
    running = 1;
    queue = (char *)calloc(QUEUE_SIZE, sizeof(char));
    qsize = 0;
    mtx_init(&mutex, mtx_plain);
    if (thrd_create(&recv_thread, recv_worker, NULL) != thrd_success) {
        perror("thrd_create");
        exit(1);
    }
}

void client_stop() { ONLINE_ONLY
    running = 0;
    close(sd);
    // if (thrd_join(recv_thread, NULL) != thrd_success) {
    //     perror("thrd_join");
    //     exit(1);
    // }
    // mtx_destroy(&mutex);
    qsize = 0;
    free(queue);
    // printf("Bytes Sent: %d, Bytes Received: %d\n",
    //     bytes_sent, bytes_received);
}
