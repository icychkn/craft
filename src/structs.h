#ifndef STRUCTS
#define STRUCTS

#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "config.h"
#include "map.h"
#include "sign.h"
#include "tinycthread.h"

#define MAX_CHUNKS 8192
#define MAX_PLAYERS 128
#define WORKERS 4
#define MAX_NAME_LENGTH 32
#define MAX_TEXT_LENGTH 256
#define MAX_PATH_LENGTH 256
#define MAX_ADDR_LENGTH 256

typedef struct {
  Map map, lights;
  SignList signs;
  int p, q, faces, sign_faces, dirty, miny, maxy;
  GLuint buffer, sign_buffer;
} Chunk;

typedef struct {
  int p, q, load;
  Map *block_maps[3][3], *light_maps[3][3];
  int miny, maxy, faces;
  GLfloat *data;
} WorkerItem;

typedef struct {
  int index, state;
  thrd_t thrd;
  mtx_t mtx;
  cnd_t cnd;
  WorkerItem item;
} Worker;

typedef struct {
  int x, y, z, w;
} Block;

typedef struct {
  float x, y, z, rx, ry, t;
} State;

typedef struct {
  int id;
  char name[MAX_NAME_LENGTH];
  State state, state1, state2;
  GLuint buffer;
} Player;

typedef struct {
  GLuint program,
         position, normal, uv, matrix, sampler,
         camera, timer,
         extra1, extra2, extra3, extra4;
} Attrib;

typedef struct {
  GLFWwindow *window;
  Worker workers[WORKERS];
  Chunk chunks[MAX_CHUNKS];
  int chunk_count,
      create_radius, render_radius, delete_radius, sign_radius;
  Player players[MAX_PLAYERS];
  int player_count, typing;
  char typing_buffer[MAX_TEXT_LENGTH];
  int message_index;
  char messages[MAX_MESSAGES][MAX_TEXT_LENGTH];
  int width, height,
      observe1, observe2,
      flying, item_index,
      scale, ortho;
  float fov;
  int suppress_char, mode, mode_changed;
  char db_path[MAX_PATH_LENGTH];
  char server_addr[MAX_ADDR_LENGTH];
  int server_port;
  unsigned int day_length;
  int time_changed;
  Block block0, block1, copy0, copy1;
} Model;
#endif
