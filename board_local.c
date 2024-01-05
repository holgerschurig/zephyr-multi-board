// Copyright (c) 2024 Holger Schurig
// SPDX-License-Identifier: Apache-2.0

#include <zephyr/shell/shell.h>

static int cmd_local(const struct shell *shell, size_t argc, char **argv)
{
	(void) argc;
	(void) argv;

	shell_print(shell, "Executing a command that exists on the 'local' board");
	return 0;
}
SHELL_CMD_REGISTER(local, NULL, "Local command", cmd_local);
