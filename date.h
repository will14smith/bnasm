#include <stdbool.h>
#include <stdint.h>

typedef struct {
	int32_t year;
	int8_t month;
	int8_t day;
} date_t;

extern bool expires_in(date_t *base, date_t *maturity, int32_t range);
