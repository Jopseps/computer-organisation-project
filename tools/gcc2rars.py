#!/usr/bin/env python3
# GCC (riscv64-elf-gcc -S) assembly -> RARS-compatible assembly.
# Usage: gcc2rars.py in.s out.s
import re
import sys

src = open(sys.argv[1]).read().splitlines()
data = []
bss = []  # linker places .bss after .sbss; keep the same order so addresses match the ELF
text = []
cur = text
drop = (".file", ".option", ".attribute", ".type", ".size", ".ident", ".globl")

for line in src:
    s = line.strip()
    if not s:
        continue
    if s.startswith(".section"):
        if ".note" in s:
            cur = None
        elif ".srodata" in s or ".sbss" in s or ".sdata" in s:
            cur = data
        else:
            cur = text
        continue
    if s == ".text":
        cur = text
        continue
    if s == ".bss":
        cur = bss
        continue
    if s == ".data":
        cur = data
        continue
    if s == ".globl\tmain" or s == ".globl main":
        text.append("    .globl main")
        continue
    if cur is None or s.startswith(drop):
        continue
    s = re.sub(r"\.zero\b", ".space", s)
    s = s.replace(".L", "L_")
    # %hi/%lo: load full address with la, then use offset 0
    m = re.match(r"lui\s+(\w+),%hi\((\w+)\)", s)
    if m:
        s = "la %s,%s" % (m.group(1), m.group(2))
    s = re.sub(r"addi\s+(\w+),(\w+),%lo\(\w+\)$", r"mv \1,\2", s)
    s = re.sub(r"%lo\(\w+\)\((\w+)\)", r"0(\1)", s)
    # main returns via exit ecall in RARS
    s = s.replace("\t", " ")
    (cur if not (cur is text and s.endswith(":")) else text).append(s if s.endswith(":") else "    " + s)

out = [".data"] + data + bss + [".text"] + text
# replace the last 'jr ra' (end of main) with exit ecall
for i in range(len(out) - 1, -1, -1):
    if out[i].strip() == "jr ra":
        out[i] = "    li a7,10\n    ecall"
        break
open(sys.argv[2], "w").write("\n".join(out) + "\n")
