module util;

import std::io, std::os;

import glfw;
import opengl::gl;

extern fn GLuint gen_buffer(GLsizei, GLfloat*);

fn void my_gl_init() @export("my_gl_init") {
  if (catch excuse = opengl::init((GLLoadFn)&glfw::getProcAddress)) {
    io::printn("Failed to load OpenGL");
    os::exit(-1);
  }
}

/*fn GLuint gen_buffer(GLsizei size, GLfloat* data) {
  GLuint buffer;

  gl::genBuffers(1, &buffer);
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, buffer);
  gl::bufferData(gl::GL_ARRAY_BUFFER, size, data, gl::GL_STATIC_DRAW);
  gl::bindBuffer(gl::GL_ARRAY_BUFFER, 0);

  //gl::createBuffers(1, &buffer);
  //gl::namedBufferData(buffer, size, data, gl::GL_STATIC_DRAW);
  return buffer;
}*/
