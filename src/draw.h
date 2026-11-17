#ifndef _draw_
#define _draw_
#include "structs.h"

extern void draw_triangles_3d(Attrib *attrib, GLuint buffer, int count);
extern void draw_lines(Attrib *attrib, GLuint buffer, int components, int count);
extern void draw_chunk(Attrib *attrib, Chunk *chunk);
extern void draw_text(Attrib *attrib, GLuint buffer, int length);
extern void draw_signs(Attrib *attrib, Chunk *chunk);
extern void draw_sign(Attrib *attrib, GLuint buffer, int length);
extern void draw_cube(Attrib *attrib, GLuint buffer);
extern void draw_plant(Attrib *attrib, GLuint buffer);
extern void draw_player(Attrib *attrib, Player *player);

#endif
