#!/bin/sh

gcc -std=c99 -O3 -fPIC -shared -o world -I src -I deps/noise deps/noise/noise.c src/world.c
#tcc -z execstack -shared -lm -o world -I src -I deps/noise deps/noise/noise.c src/world.c
