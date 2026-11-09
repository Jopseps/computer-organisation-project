#!/usr/bin/env python3
# Minimal RV32IM simulator for objdump -d output: dinamik instruction izi. Kullanım: rvsim.py objdump.txt elf_nm_gp
import re, sys, subprocess
M = 0xFFFFFFFF
dump, elf = sys.argv[1], sys.argv[2]
code = {}
for l in open(dump):
    m = re.match(r"\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(\S+)", l)
    if m: code[int(m.group(1), 16)] = (int(m.group(2), 16), m.group(3))
gp = int([l.split()[0] for l in subprocess.check_output(["riscv64-elf-nm", elf], text=True).splitlines() if "__global_pointer$" in l][0], 16)
mem = {}
def sw(a, v):
    for i in range(4): mem[a + i] = (v >> (8 * i)) & 255
def lw(a): return sum(mem.get(a + i, 0) << (8 * i) for i in range(4))
sw(0x10010000, 1240003)  # SID (.sdata); geri kalan veri sıfır
x = [0] * 32; x[2] = 0x7FFFF000; x[3] = gp; pc = 0x400008 if 0x400008 in code and "main" in open(dump).read().split("<main>")[0][-40:] else None
pc = [a for a in code if re.search(r"^%08x <main>:" % a, open(dump).read(), re.M)][0]
s = lambda v, n: v - (1 << n) if v >> (n - 1) else v
trace = []; cls = {"alu": 0, "mul": 0, "load": 0, "store": 0, "branch": 0}
while pc != 0:
    w, name = code[pc]; trace.append(pc)
    op, rd, f3, rs1, rs2, f7 = w & 127, (w >> 7) & 31, (w >> 12) & 7, (w >> 15) & 31, (w >> 20) & 31, w >> 25
    a, b = x[rs1], x[rs2]; npc = pc + 4; res = None
    immI = s(w >> 20, 12); immS = s(((w >> 25) << 5) | ((w >> 7) & 31), 12)
    immB = s((((w >> 31) & 1) << 12) | (((w >> 7) & 1) << 11) | (((w >> 25) & 63) << 5) | (((w >> 8) & 15) << 1), 13)
    immJ = s((((w >> 31) & 1) << 20) | (((w >> 12) & 255) << 12) | (((w >> 20) & 1) << 11) | (((w >> 21) & 1023) << 1), 21)
    if op == 0x37: res = w & 0xFFFFF000; cls["alu"] += 1
    elif op == 0x13:
        cls["alu"] += 1
        res = {0: (a + immI) & M, 1: (a << rs2) & M, 5: (a >> rs2) if f7 == 0 else (s(a, 32) >> rs2) & M, 7: a & immI & M, 4: a ^ immI & M, 2: int(s(a, 32) < immI), 3: int(a < (immI & M))}[f3]
    elif op == 0x33:
        if f7 == 1:
            cls["mul"] += 1; res = {0: (a * b) & M, 3: (a * b) >> 32}[f3]
        else:
            cls["alu"] += 1
            res = {0: (a + b) & M if f7 == 0 else (a - b) & M, 1: (a << (b & 31)) & M, 2: int(s(a, 32) < s(b, 32)), 3: int(a < b), 4: a ^ b, 5: a >> (b & 31), 6: a | b, 7: a & b}[f3]
    elif op == 0x03: cls["load"] += 1; res = lw((a + immI) & M)
    elif op == 0x23: cls["store"] += 1; sw((a + immS) & M, b)
    elif op == 0x63:
        cls["branch"] += 1
        t = {0: a == b, 1: a != b, 4: s(a, 32) < s(b, 32), 5: s(a, 32) >= s(b, 32), 6: a < b, 7: a >= b}[f3]
        if t: npc = (pc + immB) & M
    elif op == 0x6F: cls["branch"] += 1; res = pc + 4; npc = (pc + immJ) & M
    elif op == 0x67: cls["branch"] += 1; res = pc + 4; npc = (a + immI) & ~1 & M
    else: raise SystemExit("bilinmeyen: %08x @%x" % (w, pc))
    if res is not None and rd: x[rd] = res & M
    pc = npc
print("Ic =", len(trace), cls)
syms = {"SID": 0x10010000}
import subprocess as sp
for l in sp.check_output(["riscv64-elf-nm", elf], text=True).splitlines():
    p = l.split()
    if len(p) == 3 and p[2] in ("median", "min_v", "max_v", "swaps"): print(p[2], lw(int(p[0], 16)))
call = [i for i, p in enumerate(trace) if code[p][1] == "jal" and trace[i + 1] == 0x400000]
if call:
    i = call[0]; print("ilk should_swap çağrısı: jal @0x%X, sonraki 18:" % trace[i], " ".join("%X" % p for p in trace[i:i + 18]))
