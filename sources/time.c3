import std::io;
import glfw;

import ffi;

fn float time_of_day() @export("time_of_day") {
  float time = (float)glfw::getTime();
  float length = ffi::g.day_length;
  float t = (time / length);
  return t - (int)t;
}
