#include <zephyr/ztest.h>

ZTEST_SUITE(tests, NULL, NULL, NULL, NULL, NULL);

ZTEST(tests, demo_test)
{
	int a = 1;
	int b = 5-4;
    zassert_equal(a, b, "");
}
