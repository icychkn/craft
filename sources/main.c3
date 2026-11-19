import std::io,
       std::math::random,
       std::os,
       std::time;

import glfw;
import opengl;

import ffi;
import shaders;

fn void my_main() @export("my_main") {
  random::srand((ulong)time::now());
  random::rand(1);

  my_gl_init();
}

fn void init_window() {
  ffi::g.window = glfw::createWindow(1920, 1080, "Craft", null, null);
}

fn void my_gl_init() {
  if (!glfw::init()) {
    os::exit(-1);
  }

  init_window();
  if (!ffi::g.window) {
    glfw::terminate();
    os::exit(-1);
  }

  glfw::makeContextCurrent(ffi::g.window);
  glfw::swapInterval(1);
  glfw::setInputMode(ffi::g.window, glfw::CURSOR, glfw::CURSOR_DISABLED);

  if (catch excuse = opengl::init((GLLoadFn)&glfw::getProcAddress)) {
    io::printn("Failed to load OpenGL");
    os::exit(-1);
  }

  shaders::init();
}
