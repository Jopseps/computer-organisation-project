#!/usr/bin/env python3
# C satırı -> -O0 instruction adres aralığı tablosu (M2, 2a). Kullanım: map_lines.py main.c elf_with_-g
import re, subprocess, sys
srcf, elf = sys.argv[1], sys.argv[2]
src = open(srcf).read().split("\n")
dis = subprocess.check_output(["riscv64-elf-objdump", "-d", elf], text=True)
ins = []
for l in dis.splitlines():
    m = re.match(r"\s*([0-9a-f]+):\s+[0-9a-f]{8}\s+(\S+)\s*(.*)", l)
    if m:
        ins.append((int(m.group(1), 16), (m.group(2) + " " + m.group(3).split("#")[0].strip()).strip()))
out = subprocess.check_output(["riscv64-elf-addr2line", "-e", elf] + [hex(a) for a, _ in ins], text=True).splitlines()
lines = [int(re.search(r":(\d+)", o).group(1)) for o in out]
groups = []
for (a, t), ln in zip(ins, lines):
    if groups and groups[-1][0] == ln:
        groups[-1][2] = a; groups[-1][3] += 1; groups[-1][4].append(t)
    else:
        groups.append([ln, a, a, 1, [t]])
for ln, a, b, n, ts in groups:
    print("%3d | 0x%06X-0x%06X | %2d | %-46s | %s ... %s" % (ln, a, b, n, src[ln - 1].strip()[:46], ts[0], ts[-1]))
