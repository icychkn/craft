module shaders;

import opengl::gl;
import std::io;

GLuint block_shader @export("ICY_program_block");
GLuint line_shader @export("ICY_program_line");
GLuint text_shader @export("ICY_program_text");
GLuint sky_shader @export("ICY_program_sky");

fn void init() {
  block_shader = load_program("../shaders/block_vertex.glsl", "../shaders/block_fragment.glsl");
  line_shader = load_program("../shaders/line_vertex.glsl", "../shaders/line_fragment.glsl");
  text_shader = load_program("../shaders/text_vertex.glsl", "../shaders/text_fragment.glsl");
  sky_shader = load_program("../shaders/sky_vertex.glsl", "../shaders/sky_fragment.glsl");
}

fn GLuint make_shader(GLenum type, ZString source) {
  GLuint shader = gl::createShader(type);
  gl::shaderSource(shader, 1, &&((GLchar*)source), null);
  gl::compileShader(shader);
  GLint status;
  gl::getShaderiv(shader, gl::GL_COMPILE_STATUS, &status);
  if (status == gl::GL_FALSE) {
    GLint length;
    gl::getShaderiv(shader, gl::GL_INFO_LOG_LENGTH, &length);
    GLchar* info = calloc(length * GLchar::size);
    gl::getShaderInfoLog(shader, length, null, info);
    io::printfn("gl::compileShader failed: %s", info);
    free(info);
  }
  return shader;
}

fn GLuint make_program(GLuint vertex_shader, GLuint fragment_shader) {
  GLuint program = gl::createProgram();
  gl::attachShader(program, vertex_shader);
  gl::attachShader(program, fragment_shader);
  gl::linkProgram(program);
  GLint status;
  gl::getProgramiv(program, gl::GL_LINK_STATUS, &status);
  if (status == gl::GL_FALSE) {
    GLint length;
    gl::getProgramiv(program, gl::GL_INFO_LOG_LENGTH, &length);
    GLchar* info = calloc(length * GLchar::size);
    gl::getShaderInfoLog(program, length, null, info);
    io::printfn("gl::linkProgram failed: %s", info);
    free(info);
  }
  gl::detachShader(program, vertex_shader);
  gl::detachShader(program, fragment_shader);
  gl::deleteShader(vertex_shader);
  gl::deleteShader(fragment_shader);
  return program;
}

macro GLuint load_program($vertex_path, $fragment_path) {
  // This puts the shader texts into the executable, no need to package the
  // shader folder separately now. Next is probably the texture folder.
  var vertex_source = (ZString)$embed($vertex_path);
  var fragment_source = (ZString)$embed($fragment_path);

  return make_program(make_shader(gl::GL_VERTEX_SHADER, vertex_source), make_shader(gl::GL_FRAGMENT_SHADER, fragment_source));
}
