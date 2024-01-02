/*
 * Copyright (c) 2024 Holger Schurig
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef CONFIG_ZTEST
// The "native_sim" target defined CONFIG_ZTEST and contains it's own main()
// function in board_native.c

int main(void)
{
	return 0;
};

#endif
