#!/usr/bin/python3

# Copyright (c) 2024 Holger Schurig
# SPDX-License-Identifier: Apache-2.0


import subprocess, os


for fname in subprocess.Popen(["/usr/bin/git", "ls-files"], stdout=subprocess.PIPE).communicate()[0].decode().split("\n"):
	if not fname:
		continue
	# print("FNAME:", fname)
	ext = os.path.splitext(fname)[1]
	# print("EXT:", ext)
	if ext == ".png":
		continue
	f = open(fname, "r")
	s = f.read()
	idx = s.find("SPDX-License-Identifier:")
	if idx == -1:
		print("SPDX missing in:", fname)
