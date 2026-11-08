#!/usr/bin/env python3
# RV32 instruction decoder: alanları ayırır, kendi kodlamanı kontrol etmek için. Kullanım: decode_rv.py 0x00f75663
import sys
for a in sys.argv[1:]:
    w = int(a, 16) & 0xFFFFFFFF
    op, rd, f3, rs1, rs2, f7 = w & 0x7F, (w >> 7) & 31, (w >> 12) & 7, (w >> 15) & 31, (w >> 20) & 31, w >> 25
    s = lambda v, n: v - (1 << n) if v >> (n - 1) else v
    fmt = {0x33: "R", 0x13: "I", 0x03: "I", 0x67: "I", 0x23: "S", 0x63: "B", 0x37: "U", 0x17: "U", 0x6F: "J"}.get(op, "?")
    imm = {"I": s(w >> 20, 12), "S": s(((w >> 25) << 5) | ((w >> 7) & 31), 12),
           "B": s((((w >> 31) & 1) << 12) | (((w >> 7) & 1) << 11) | (((w >> 25) & 63) << 5) | (((w >> 8) & 15) << 1), 13),
           "U": w >> 12, "J": s((((w >> 31) & 1) << 20) | (((w >> 12) & 255) << 12) | (((w >> 20) & 1) << 11) | (((w >> 21) & 1023) << 1), 21),
           "R": None}.get(fmt)
    print("%s  %s-tipi  opcode=%s rd=%d funct3=%s rs1=%d rs2=%d funct7=%s imm=%s  | ikili: %s" % (
        a, fmt, format(op, "07b"), rd, format(f3, "03b"), rs1, rs2, format(f7, "07b"), imm, format(w, "032b")))
