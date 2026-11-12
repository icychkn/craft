module gfx;

import opengl::gl;

alias GLvoid = void;

fn void bindBuffer(GLenum target, GLuint buffer) @export("glBindBuffer") {
  gl::bindBuffer(target, buffer);
}

fn void enableVertexAttribArray(GLuint index) @export("glEnableVertexAttribArray") {
  gl::enableVertexAttribArray(index);
}

fn void disableVertexAttribArray(GLuint index) @export("glDisableVertexAttribArray") {
  gl::disableVertexAttribArray(index);
}

fn void vertexAttribPointer(GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLvoid* pointer) @export("glVertexAttribPointer") {
  gl::vertexAttribPointer(index, size, type, normalized, stride, pointer);
}

fn void drawArrays(GLenum mode, GLint first, GLsizei count) @export("glDrawArrays") {
  gl::drawArrays(mode, first, count);
}

fn GLint getUniformLocation(GLuint program, GLchar* name) @export("glGetUniformLocation") {
  return gl::getUniformLocation(program, name);
}

fn GLint getAttribLocation(GLuint program, GLchar* name) @export("glGetAttribLocation") {
  return gl::getAttribLocation(program, name);
}

fn void activeTexture(GLenum texture) @export("glActiveTexture") {
  gl::activeTexture(texture);
}

fn void attachShader(GLuint program, GLuint shader) @export("glAttachShader") {
  gl::attachShader(program, shader);
}

fn void bindTexture(GLenum target, GLuint texture) @export("glBindTexture") {
  gl::bindTexture(target, texture);
}

fn void blendFunc(GLenum sfactor, GLenum dfactor) @export("glBlendFunc") {
  gl::blendFunc(sfactor, dfactor);
}

fn void bufferData(GLenum target, GLsizeiptr size, GLvoid* data, GLenum usage) @export("glBufferData") {
  gl::bufferData(target, size, data, usage);
}

fn void clear(GLbitfield mask) @export("glClear") {
  gl::clear(mask);
}

fn void clearColor(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha) @export("glClearColor") {
  gl::clearColor(red, green, blue, alpha);
}

fn void compileShader(GLuint shader) @export("glCompileShader") {
  gl::compileShader(shader);
}

fn void deleteBuffers(GLsizei n, GLuint* buffers) @export("glDeleteBuffers") {
  gl::deleteBuffers(n, buffers);
}

fn void deleteShader(GLuint shader) @export("glDeleteShader") {
  gl::deleteShader(shader);
}

fn void detachShader(GLuint program, GLuint shader) @export("glDetachShader") {
  gl::detachShader(program, shader);
}

fn void enable(GLenum cap) @export("glEnable") {
  gl::enable(cap);
}

fn void disable(GLenum cap) @export("glDisable") {
  gl::disable(cap);
}

fn void genBuffers(GLsizei n, GLuint* buffers) @export("glGenBuffers") {
  gl::genBuffers(n, buffers);
}

fn void genTextures(GLsizei n, GLuint* textures) @export("glGenTextures") {
  gl::genTextures(n, textures);
}

fn void getProgramInfoLog(GLuint program, GLsizei maxLength, GLsizei* length, GLchar* infoLog) @export("glGetProgramInfoLog") {
  gl::getProgramInfoLog(program, maxLength, length, infoLog);
}

fn void getProgramiv(GLuint program, GLenum pname, GLint* params) @export("glGetProgramiv") {
  gl::getProgramiv(program, pname, params);
}

fn void getShaderInfoLog(GLuint shader, GLsizei maxLength, GLsizei* length, GLchar* infoLog) @export("glGetShaderInfoLog") {
  gl::getShaderInfoLog(shader, maxLength, length, infoLog);
}

fn void getShaderiv(GLuint shader, GLenum pname, GLint* params) @export("glGetShaderiv") {
  gl::getShaderiv(shader, pname, params);
}

fn void lineWidth(GLfloat width) @export("glLineWidth") {
  gl::lineWidth(width);
}

fn void linkProgram(GLuint program) @export("glLinkProgram") {
  gl::linkProgram(program);
}

fn void logicOp(GLenum opcode) @export("glLogicOp") {
  gl::logicOp(opcode);
}

fn void polygonOffset(GLfloat factor, GLfloat units) @export("glPolygonOffset") {
  gl::polygonOffset(factor, units);
}

fn void scissor(GLint x, GLint y, GLsizei width, GLsizei height) @export("glScissor") {
  gl::scissor(x, y, width, height);
}

fn void shaderSource(GLuint shader, GLsizei count, GLchar** string, GLint* length) @export("glShaderSource") {
  gl::shaderSource(shader, count, string, length);
}

fn void texImage2D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, GLvoid* data) @export("glTexImage2D") {
  gl::texImage2D(target, level, internalFormat, width, height, border, format, type, data);
}

fn void texParameteri(GLenum target, GLenum pname, GLint param) @export("glTexParameteri") {
  gl::texParameteri(target, pname, param);
}

fn GLuint createProgram() @export("glCreateProgram") {
  return gl::createProgram();
}

fn GLuint createShader(GLenum shaderType) @export("glCreateShader") {
  return gl::createShader(shaderType);
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

fn void viewport(GLint x, GLint y, GLsizei width, GLsizei height) @export("glViewport") {
  gl::viewport(x, y, width, height);
}


