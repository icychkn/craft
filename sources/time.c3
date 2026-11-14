import std::io, std::math;
import glfw;

import ffi;

fn float time_of_day() @export("time_of_day") {
  float time = (float)glfw::getTime();
  float length = ffi::g.day_length;
  float t = (time / length);
  return t - (int)t;
}

fn float get_daylight() @export("get_daylight") {
  float timer = time_of_day();
  if (timer < 0.5) {
    float t = (timer - 0.25) * 100;
    return 1 / (1 + math::pow(2, -t));
  } else {
    float t = (timer - 0.85) * 100;
    return 1 - 1 / (1 + math::pow(2, -t));
  }
}
