#include "mymachine.h"

void cryomach(void *insts, void **data) {
  while (1) {
    switch (AS_INT(insts)++[0]) {
      case RETURN:
        return;
      case INC:
        AS_FLOAT(*data)[0] = AS_FLOAT(*data)[0] + 1.0;
        break;
      case ADD:
        AS_FLOAT(*data)[1] = AS_FLOAT(*data)[0] + AS_FLOAT(*data)[1];
        AS_FLOAT(*data)++;
        break;
      case DIV:
        AS_FLOAT(*data)[1] = AS_FLOAT(*data)[0] / AS_FLOAT(*data)[1];
        AS_FLOAT(*data)++;
        break;
      case FRACTION:
        AS_FLOAT(*data)[0] = AS_FLOAT(*data)[0] - (int)AS_FLOAT(*data)[0];
        break;
    }
  }
}
