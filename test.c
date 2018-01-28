#include <assert.h>

#include "date.h"
#include "bucket.h"

void test_expires_in() {
	date_t true_tests[] = {
		{ 2017,1,1 },{ 2017,1,1 },
		{ 2016,2,1 },{ 2017,1,1 },
		{ 2016,1,1 },{ 2017,1,1 },
	};
	date_t false_tests[] = {
		{ 2015,1,1 },{ 2017,1,1 },
		{ 2016,1,1 },{ 2017,2,1 },
		{ 2016,1,1 },{ 2017,1,2 },
	};

	for (int i = 0; i < sizeof(true_tests) / sizeof(true_tests[0]); i += 2) {
		assert(expires_in(&true_tests[i], &true_tests[i + 1], 1));
	}
	for (int i = 0; i < sizeof(false_tests) / sizeof(false_tests[0]); i += 2) {
		assert(!expires_in(&false_tests[i], &false_tests[i + 1], 1));
	}
}

void test_equity_ignored() {
	date_t date = { 0,0,0 };
	asset_t asset = { "Equity1", "Equity", 1000 };

	assert(get_bucket(&date, &asset) == -1);
}

void test_bucket1() {
	date_t date = { 2018, 1, 1 };
	asset_t asset = { "Future1", "Future", 1000, { 2018, 6, 1 } };

	assert(get_bucket(&date, &asset) == 1);
}
void test_bucket2() {
	date_t date = { 2018, 1, 1 };
	asset_t asset = { "Future1", "Future", 1000,{ 2023, 6, 1 } };

	assert(get_bucket(&date, &asset) == 2);
}
void test_bucket3() {
	date_t date = { 2018, 1, 1 };
	asset_t asset = { "Future1", "Future", 1000,{ 2028, 6, 1 } };

	assert(get_bucket(&date, &asset) == 3);
}
void test_bucket4() {
	date_t date = { 2018, 1, 1 };
	asset_t asset = { "Future1", "Future", 1000,{ 2038, 6, 1 } };

	assert(get_bucket(&date, &asset) == 4);
}

int main() {
	test_expires_in();

	test_equity_ignored();

	test_bucket1();
	test_bucket2();
	test_bucket3();
	test_bucket4();

	return 0;
}
