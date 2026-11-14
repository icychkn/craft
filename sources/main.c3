import std::math::random, std::time;

fn void my_main() @export("my_main") {
  random::srand((ulong)time::now());
  random::rand(1);
}
