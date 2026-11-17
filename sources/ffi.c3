module ffi;

import std::io;
import opengl::gl;
import glfw;

import config;
/*struct WorkerItem {
  int p; int q; int load;
  Map* block_maps[3][3]; Map* light_maps[3][3];
  int miny; int maxy; int faces;
  GLfloat* data;  
}

// no idea how I'm going to interface with pthread's structs.
struct Worker {
  int index; int state;
  thr_t thrd;
  mtx_t mtx;
  cnd_t cnd;
  WorkerItem item;
}*/

alias State = void*;
struct Player {
  int id;
  char[config::MAX_NAME_LENGTH] name;
  GLuint buffer;
  State state;
  State state1;
  State state2;
}

struct Block {
  int x; int y; int z; int w;
}

struct MapEntry {
  uint value;
  struct e {
    char x;
    char y;
    char z;
    char w;
  }
}
struct Map {
  int dx; int dy; int dz;
  uint mask; uint size; MapEntry* data;
}
const MAX_SIGN_LENGTH = 64;
struct Sign {
  int x; int y; int z; int face; char[MAX_SIGN_LENGTH] text;
}
struct SignList {
  uint capacity;
  uint size;
  Sign* data;
}

struct Chunk {
  Map map; Map lights;
  SignList signs;
  int p; int q; int faces; int sign_faces; int dirty; int miny; int maxy;
  GLuint buffer; GLuint sign_buffer;
}

alias Worker = void*;

// rearranged struct so I can delay interfacing with the more complicated structs.
struct Model {
  uint day_length;
  int chunk_count;
  int create_radius;
  int render_radius;
  int delete_radius;
  int sign_radius;
  int player_count;
  int typing;
  char[config::MAX_TEXT_LENGTH] typing_buffer;
  int message_index;
  char[config::MAX_MESSAGES][config::MAX_TEXT_LENGTH] messages;
  int width; int height;
  int observe1; int observe2;
  int flying; int item_index;
  int scale; int ortho;
  float fov;
  int suppress_char; int mode; int mode_changed;
  char[config::MAX_PATH_LENGTH] db_path;
  char[config::MAX_ADDR_LENGTH] server_addr;
  int server_port;
  int time_changed;
  GlfwWindow* window;
  Player[config::MAX_PLAYERS] players;
  Chunk[config::MAX_CHUNKS] chunks;
  Block block0; Block block1; Block copy0; Block copy1;
  Worker[] workers;
}

extern Model* g;
