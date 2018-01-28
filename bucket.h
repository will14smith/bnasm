#pragma once

#include <stdint.h>

#include "date.h"

typedef struct {
	const char* id;
	const char* asset_class;
	int32_t market_value;
	date_t maturity_date;
} asset_t;

typedef struct {
	int32_t bucket;
	int32_t market_value;
} bucket_t;

extern int32_t get_bucket(date_t *data_date, asset_t *asset);
extern void add_to_bucket(date_t *data_date, asset_t *asset, bucket_t buckets[4]);
