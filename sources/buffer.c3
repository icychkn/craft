module buffer;
import opengl::gl;
import std::io;

import ffi;
import util;

fn GLuint gen_crosshair_buffer() @export("gen_crosshair_buffer") {
  int x = (ffi::g.width / 2);
  int y = (ffi::g.height / 2);
  int p = (10 * ffi::g.scale);
  float[] data = {
    x, (float)(y - p), x, (float)(y + p),
    (float)(x - p), y, (float)(x + p), y
  };
  return util::gen_buffer(float::size * data.len, data);
}

extern fn void make_cube_wireframe(float* data, float x, float y, float z, float n);
fn GLuint gen_wireframe_buffer(float x, float y, float z, float n) @export("gen_wireframe_buffer") {
  float[72] data;
  make_cube_wireframe(&data, x, y, z, n);
  return util::gen_buffer(float::size * data.len, &data);
}


