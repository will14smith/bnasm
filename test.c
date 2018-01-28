#include <assert.h>

#include "date.h"

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

int main() {
	test_expires_in();

	return 0;
}
