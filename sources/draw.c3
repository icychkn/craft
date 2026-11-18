module draw;

import std::io;

import opengl::gl;

import ffi;

struct Attrib {
  gl::GLuint program;
  gl::GLuint position;
  gl::GLuint normal;
  gl::GLuint uv;
  gl::GLuint matrix;
  gl::GLuint sampler;
  gl::GLuint camera;
  gl::GLuint timer;
  gl::GLuint extra1;
  gl::GLuint extra2;
  gl::GLuint extra3;
  gl::GLuint extra4;
}

alias VertexArrayObject = GLuint;
VertexArrayObject chunk_vao;

fn void callback(GLenum src, GLenum type, GLuint id, GLenum severity, ulong length, ZString msg, void* param) {
  if (type == gl::GL_DEBUG_TYPE_OTHER) {
    return;
  }

  String parsed_src;
  switch (src) {
    case gl::GL_DEBUG_SOURCE_API:
      parsed_src = "API"; break;
    case gl::GL_DEBUG_SOURCE_WINDOW_SYSTEM:
      parsed_src = "WINDOW SYSTEM"; break;
    case gl::GL_DEBUG_SOURCE_APPLICATION:
      parsed_src = "APPLICATION"; break;
    case gl::GL_DEBUG_SOURCE_OTHER:
      parsed_src = "OTHER";
  }

  String parsed_type;
  switch (type) {
    case gl::GL_DEBUG_TYPE_ERROR:
      parsed_type = "ERROR"; break;
    case gl::GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR:
      parsed_type = "DEPRECATED_BEHAVIOR"; break;
  }

  io::printfn("%s %s %s", parsed_src, parsed_type, msg);
}

fn void init() {
  gl::enable(gl::GL_DEBUG_OUTPUT);
  gl::debugMessageCallback(&callback, null);
}

fn void init_chunk_vao(Attrib* attrib) @export("ICY_init_chunk_vao") {
  gl::createVertexArrays(1, &chunk_vao);

  gl::enableVertexArrayAttrib(chunk_vao, attrib.position);
  gl::vertexArrayAttribFormat(chunk_vao, attrib.position, 3, gl::GL_FLOAT, gl::GL_FALSE, 0);
  gl::vertexArrayAttribBinding(chunk_vao, attrib.position, 0);

  gl::enableVertexArrayAttrib(chunk_vao, attrib.normal);
  gl::vertexArrayAttribFormat(chunk_vao, attrib.normal, 3, gl::GL_FLOAT, gl::GL_FALSE, (float::size * 3));
  gl::vertexArrayAttribBinding(chunk_vao, attrib.normal, 0);

  gl::enableVertexArrayAttrib(chunk_vao, attrib.uv);
  gl::vertexArrayAttribFormat(chunk_vao, attrib.uv, 4, gl::GL_FLOAT, gl::GL_FALSE, (float::size * 6));
  gl::vertexArrayAttribBinding(chunk_vao, attrib.uv, 0);
}


fn void draw_triangles_3d_ao(GLuint buffer, int count) {
  gl::bindVertexArray(chunk_vao);
  gl::vertexArrayVertexBuffer(chunk_vao, 0, buffer, 0, float::size * 10);
  gl::drawArrays(gl::GL_TRIANGLES, 0, count);
  gl::bindVertexArray(0);
}

fn void draw_chunk(Chunk* chunk) @export("draw_chunk") {
  draw_triangles_3d_ao(chunk.buffer, chunk.faces * 6);
}

fn void draw_triangles_3d_text(Attrib* attrib, GLuint buffer, int count) {
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, buffer);

  gl::enableVertexAttribArray(attrib.position);
  gl::enableVertexAttribArray(attrib.uv);

  gl::vertexAttribPointer(attrib.position, 3, gl::GL_FLOAT, gl::GL_FALSE, float::size * 5, (void*)0);
  gl::vertexAttribPointer(attrib.uv, 2, gl::GL_FLOAT, gl::GL_FALSE, float::size * 5, (void*)(float::size * 3));

  gl::drawArrays(gl::GL_TRIANGLES, 0, count);

  gl::disableVertexAttribArray(attrib.position);
  gl::disableVertexAttribArray(attrib.uv);

  gl::bindBuffer(gl::GL_ARRAY_BUFFER, 0);
}

fn void draw_triangles_3d(Attrib* attrib, GLuint buffer, int count) @export("draw_triangles_3d") {
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, buffer);

  gl::enableVertexAttribArray(attrib.position);
  // the normal attribute is being culled by the OpenGL shader compiler, the
  // debug callback above kept spamming console about the invalid value (-1)
  // being passed to these calls.
  //gl::enableVertexAttribArray(attrib.normal);
  gl::enableVertexAttribArray(attrib.uv);

  gl::vertexAttribPointer(attrib.position, 3, gl::GL_FLOAT, gl::GL_FALSE, GLfloat::size * 8, (void*)0);
  // no idea if this stride will cause issues. The clouds look alright though,
  // so maybe its okay?
  //gl::vertexAttribPointer(attrib.normal, 3, gl::GL_FLOAT, gl::GL_FALSE, float::size * 8, (void*)(float::size * 3));
  gl::vertexAttribPointer(attrib.uv, 2, gl::GL_FLOAT, gl::GL_FALSE, GLfloat::size * 8, (void*)(GLfloat::size * 6));

  gl::drawArrays(gl::GL_TRIANGLES, 0, count);

  gl::disableVertexAttribArray(attrib.position);
  //gl::disableVertexAttribArray(attrib.normal);
  gl::disableVertexAttribArray(attrib.uv);

  gl::bindBuffer(gl::GL_ARRAY_BUFFER, 0);
}

VertexArrayObject text_vao;
fn void init_text_vao(Attrib* attrib) @export("ICY_init_text_vao") {
  gl::createVertexArrays(1, &text_vao);

  gl::enableVertexArrayAttrib(text_vao, attrib.position);
  gl::vertexArrayAttribFormat(text_vao, attrib.position, 2, gl::GL_FLOAT, gl::GL_FALSE, 0);
  gl::vertexArrayAttribBinding(text_vao, attrib.position, 0);

  gl::enableVertexArrayAttrib(text_vao, attrib.uv);
  gl::vertexArrayAttribFormat(text_vao, attrib.uv, 2, gl::GL_FLOAT, gl::GL_FALSE, (GLfloat::size * 2));
  gl::vertexArrayAttribBinding(text_vao, attrib.uv, 0);
}

fn void draw_triangles_2d(GLuint buffer, int count) {
  gl::bindVertexArray(text_vao);
  gl::vertexArrayVertexBuffer(text_vao, 0, buffer, 0, GLfloat::size * 4);
  gl::drawArrays(gl::GL_TRIANGLES, 0, count);
  gl::bindVertexArray(0);
}

fn void draw_text(GLuint buffer, int length) @export("draw_text") {
  gl::enable(gl::GL_BLEND);
  gl::blendFunc(gl::GL_SRC_ALPHA, gl::GL_ONE_MINUS_SRC_ALPHA);
  draw_triangles_2d(buffer, length * 6);
  gl::disable(gl::GL_BLEND);
}

fn void draw_lines(Attrib* attrib, GLuint buffer, int components, int count) @export("draw_lines") {
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, buffer);

  gl::enableVertexAttribArray(attrib.position);
  gl::vertexAttribPointer(attrib.position, components, gl::GL_FLOAT, gl::GL_FALSE, 0, (void*)0);
  gl::drawArrays(gl::GL_LINES, 0, count);
  gl::disableVertexAttribArray(attrib.position);
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, 0);
}


fn void draw_item(GLuint buffer, int count) {
  draw_triangles_3d_ao(buffer, count);
}

fn void draw_cube(GLuint buffer) @export("draw_cube") {
  draw_item(buffer, 36);
}
fn void draw_player(Player* player) @export("draw_player") {
  draw_cube(player.buffer);
}

fn void draw_plant(Attrib* attrib, GLuint buffer) @export("draw_plant") {
  // don't know why the original code just early returned
  //draw_item(attrib, buffer, 24);
}
fn void draw_signs(Attrib* attrib, Chunk* chunk) @export("draw_signs") {
  // this was also early returned in the original code, see draw_plant
  //gl::enable(gl::GL_POLYGON_OFFSET_FILL);
  //gl::polygonOffset(-8, -1024);
  //draw_triangles_3d_text(attrib, chunk.sign_buffer, chunk.sign_faces * 6);
  //gl::disable(gl::GL_POLYGON_OFFSET_FILL);
}
fn void draw_sign(Attrib* attrib, GLuint buffer, int length) @export("draw_sign") {
  gl::enable(gl::GL_POLYGON_OFFSET_FILL);
  gl::polygonOffset(-8, -1024);
  draw_triangles_3d_text(attrib, buffer, length * 6);
  gl::disable(gl::GL_POLYGON_OFFSET_FILL);
}
