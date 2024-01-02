# Copyright (c) 2024 Holger Schurig
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.20.0)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(devmem_load)

# These sources are compiled for all boards
target_sources(app PRIVATE
  main.c)

# This is an example on how to compile a source only for one board. A use case
# could be that program hardware access that is only in some of your boards
# available, but not in e.g. native_sim.
target_sources_ifdef(CONFIG_BOARD_LOCAL app PRIVATE
  board_local.c)

target_sources_ifdef(CONFIG_BOARD_NATIVE_SIM app PRIVATE
  board_native.c)
