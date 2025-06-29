#ifndef _gen_buffer_
#define _gen_buffer_

#include <GL/glew.h>
#include <string.h>
#include "cube.h"
#include "global.h"
#include "util.h"

GLuint gen_crosshair_buffer();
GLuint gen_wireframe_buffer(float x, float y, float z, float n);
GLuint gen_sky_buffer();
GLuint gen_cube_buffer(float x, float y, float z, float n, int w);
GLuint gen_plant_buffer(float x, float y, float z, float n, int w);
GLuint gen_player_buffer(float x, float y, float z, float rx, float ry);
GLuint gen_text_buffer(float x, float y, float n, char *text);
#endif
