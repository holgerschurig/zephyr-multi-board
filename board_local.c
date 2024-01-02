#include <zephyr/shell/shell.h>

static int cmd_bat(const struct shell *shell, size_t argc, char **argv)
{
	(void) argc;
	(void) argv;

	shell_print(shell, "Executing a command that exists on the 'local' board");
	return 0;
}
SHELL_CMD_REGISTER(local, NULL, "Local command", cmd_local);
