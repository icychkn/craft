module gfx;

import opengl::gl;

alias GLvoid = void;

fn GLint getUniformLocation(GLuint program, GLchar* name) @export("glGetUniformLocation") {
  return gl::getUniformLocation(program, name);
}

fn GLint getAttribLocation(GLuint program, GLchar* name) @export("glGetAttribLocation") {
  return gl::getAttribLocation(program, name);
}

fn void uniform1f(GLint location, GLfloat v0) @export("glUniform1f") {
  gl::uniform1f(location, v0);
}

fn void uniform1i(GLint location, GLint v0) @export("glUniform1i") {
  gl::uniform1i(location, v0);
}

fn void uniform3f(GLint location, GLfloat v0, GLfloat v1, GLfloat v2) @export("glUniform3f") {
  gl::uniform3f(location, v0, v1, v2);
}

fn void uniformMatrix4fv(GLint location, GLsizei count, GLboolean transpose, GLfloat* value) @export("glUniformMatrix4fv") {
  gl::uniformMatrix4fv(location, count, transpose, value);
}

fn void useProgram(GLuint program) @export("glUseProgram") {
  gl::useProgram(program);
}

