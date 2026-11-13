#!/bin/sh

# obsoleted by project.json
#c3c.sh --cc gcc compile time.c3 --no-entry \
#  -z -fcommon \
#  -z -lm -z -lGL -z -lglfw -z -lGLEW -z -lsqlite3 \
#  -z deps/lodepng/lodepng.c -z deps/tinycthread/tinycthread.c -z deps/noise/noise.c \
#  -z -I -z deps/lodepng -z -I -z deps/tinycthread -z -I -z deps/noise \
#  -z src/main.c -z src/map.c -z src/map.h -z src/matrix.c -z src/matrix.h \
#  -z src/db.c -z src/db.h -z src/draw.c -z src/draw.h -z src/global.c -z src/global.h -z src/item.c -z src/item.h \
#  -z src/buffer.c -z src/buffer.h -z src/client.c -z src/client.h -z src/config.h -z src/cube.c -z src/cube.h \
#  -z src/ring.c -z src/ring.h -z src/sign.c -z src/sign.h -z src/structs.h -z src/util.c -z src/util.h -z src/world.c \
#  -z src/world.h

c3c build
