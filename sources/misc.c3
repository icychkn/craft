
import std::math;
import config;

fn int chunked(float x) {
  return math::floor(math::round(x) / config::CHUNKS_SIZE);
}
