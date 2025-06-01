#!/bin/sh

tcc -o craft src/* \
  -lm -lGL -lglfw -lGLEW -lsqlite3 \
  deps/lodepng/lodepng.c deps/tinycthread/tinycthread.c deps/noise/noise.c \
  -I deps/lodepng -I deps/tinycthread/ -I deps/noise
