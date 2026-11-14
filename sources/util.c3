module util;

import std::io, std::math, std::os, std::math::random;

import glfw;
import opengl::gl;

import config;
import shaders;

fn void my_gl_init() @export("my_gl_init") {
  if (catch excuse = opengl::init((GLLoadFn)&glfw::getProcAddress)) {
    io::printn("Failed to load OpenGL");
    os::exit(-1);
  }

  shaders::init();
}

fn GLuint gen_buffer(GLsizei size, GLfloat* data) @export("gen_buffer") {
  GLuint buffer;

  gl::genBuffers(1, &buffer);
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, buffer);
  gl::bufferData(gl::GL_ARRAY_BUFFER, size, data, gl::GL_STATIC_DRAW);
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, 0);

  return buffer;
}

fn GLuint gen_faces(int components, int faces, GLfloat* data) @export("gen_faces") {
  GLuint buffer = gen_buffer(float::size * 6 * components * faces, data);
  free(data);
  return buffer;
}

fn GLuint create_buffer(GLsizei size, GLfloat* data) {
  GLuint buffer;

  gl::createBuffers(1, &buffer);
  gl::namedBufferData(buffer, size, data, gl::GL_STATIC_DRAW);

  return buffer;
}

fn GLuint create_faces(int components, int faces, GLfloat* data) @export("ICY_create_faces") {
  GLuint buffer = create_buffer(float::size * components * faces * 6, data);
  free(data);
  return buffer;
}

fn void del_buffer(GLuint buffer) @export("del_buffer") {
  gl::deleteBuffers(1, &buffer);
}

fn GLfloat* malloc_faces(int components, int faces) @export("malloc_faces"){
  return malloc(GLfloat::size * 6 * components * faces);
}


fn int chunked(float x) @export("chunked") {
  return (int)(math::floor(math::round(x) / config::CHUNK_SIZE));
}

fn int rand_int(int n) @export("rand_int") {
  return random::rand(n);
}

fn double rand_double() @export("rand_double") {
  return (double)random::rand(1001) / 1000.0;
}

struct FPSContainer {
  uint fps;
  uint frames;
  double since;
}

fn void update_fps(FPSContainer* fps) @export("update_fps") {
  fps.frames++;
  double now = glfw::getTime();
  double elapsed = now - fps.since;
  if (elapsed >= 1) {
    fps.fps = (uint)math::round(fps.frames / elapsed);
    fps.frames = 0;
    fps.since = now;
  }
}
