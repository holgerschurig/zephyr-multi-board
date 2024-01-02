PWD := $(shell pwd)
UID := $(shell id -u)

.PHONY:: all
all::


# Include common boilerplate Makefile to get Zephyr up on running
include Makefile.zephyr_init


#############################################################################
#
# Basic configuration and compilation setup

.PHONY:: help_boards

define show_boards
	@echo ""
	@echo "-----------------------------------------------------------------------------"
	@echo ""
	@echo "You must first select with with board you want to work:"
	@$(MAKE) --no-print-directory help_boards
	@echo ""
	@echo "-----------------------------------------------------------------------------"
	@echo ""
endef

# If we have a build/ directory, just compile. If we don't, show for which
# boards you can compile Zephyr.
all::
ifeq ("$(wildcard build/build.ninja)","")
	@$(call show_boards)
else
	ninja -C build
endif

help::


# If we have a build/ directory, just call menuconfig or xconfig. If we don't,
# show for which boards you can configure Zephyr.
.PHONY:: menuconfig xconfig
menuconfig:
ifeq ("$(wildcard build/build.ninja)","")
	@$(call show_boards)
else
	ninja -C build menuconfig
endif

xconfig:
ifeq ("$(wildcard build/build.ninja)","")
	@$(call show_boards)
else
	ninja -C build guiconfig
endif

help::
	@echo
	@echo "all                   compile for current board"
	@echo "menuconfig            run menuconfig for current board"
	@echo "xconfig               run xconfig for current board"



#############################################################################
#
# Configuration for the various supported boards:

# This creates build/zephyr/zephyr.exe which can be run on your development
# computer. Good e.g. for unit-tests

.PHONY:: native
native: .west/config
	west build \
		--pristine \
		-b native_sim \
		-o "build.ninja" \
		-- \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DOVERLAY_CONFIG="native_sim.conf"
	west build

help help_boards::
	@echo ""
	@echo "native                configure and compile for native (used for unit-tests)"


# This compiles the same source for a board that is fully specified by Zephyr's
# source code

.PHONY:: nucleo
nucleo: .west/config
	west build \
		--pristine \
		-b nucleo_f303re \
		-o "build.ninja" \
		-- \
		-Wno-dev \
		-Wno-deprecated \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DOVERLAY_CONFIG="nucleo_f303re.conf"
	west build

help help_boards::
	@echo "nucleo                configure and compile for STM32 Nucleo"


# This compiles the same source for a board that is locally defined. We call
# this board "local" for demo's sake. Note that you can have any board
# definitions below the boards/ directory --- at work I so far have two.

.PHONY:: local
local: .west/config
	west build \
		--pristine \
		-b local \
		-o "build.ninja" \
		-- \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DOVERLAY_CONFIG="boards/arm/local/local_defconfig" \
		-DBOARD_ROOT=.
	west build

help help_boards::
	@echo "local                 configure and compile for locally defined board"
