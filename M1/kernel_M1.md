# Kernel (M1) — G4, RV32IM, -O0

Seçilen iterasyon: i = 0, j = 0 (arr[0] = 464, arr[1] = 324 → yer değiştirme yok).
C satırları: 24 (çağrı ve if), 8–13 (should_swap). Adresler `build/objdump_O0.txt` ile aynı.

| # | Adres | Instruction | Kategori | PC sonrası |
| --- | --- | --- | --- | --- |
| 1 | 0x40012C | jal ra, should_swap | control | 0x400000 (ra = 0x400130) |
| 2 | 0x400000 | addi sp,sp,-32 | data processing | 0x400004 |
| 3 | 0x400004 | sw ra,28(sp) | processor–memory (store) | 0x400008 |
| 4 | 0x400008 | sw s0,24(sp) | processor–memory (store) | 0x40000C |
| 5 | 0x40000C | addi s0,sp,32 | data processing | 0x400010 |
| 6 | 0x400010 | sw a0,-20(s0) | processor–memory (store) | 0x400014 |
| 7 | 0x400014 | sw a1,-24(s0) | processor–memory (store) | 0x400018 |
| 8 | 0x400018 | lw a4,-20(s0) | processor–memory (load) | 0x40001C |
| 9 | 0x40001C | lw a5,-24(s0) | processor–memory (load) | 0x400020 |
| 10 | 0x400020 | bge a4,a5,0x40002C | control (alınır) | 0x40002C |
| 11 | 0x40002C | li a5,0 | data processing | 0x400030 |
| 12 | 0x400030 | mv a0,a5 | data processing | 0x400034 |
| 13 | 0x400034 | lw ra,28(sp) | processor–memory (load) | 0x400038 |
| 14 | 0x400038 | lw s0,24(sp) | processor–memory (load) | 0x40003C |
| 15 | 0x40003C | addi sp,sp,32 | data processing | 0x400040 |
| 16 | 0x400040 | ret (jalr x0,0(ra)) | control | 0x400130 |
| 17 | 0x400130 | mv a5,a0 | data processing | 0x400134 |
| 18 | 0x400134 | beqz a5,0x4001B4 | control (alınır) | 0x4001B4 |

Toplamlar: instruction fetch 18, operand fetch 4 (8, 9, 13, 14), operand store 4 (3, 4, 6, 7), PC'nin sıra dışı değiştiği instruction 4 (1, 10, 16, 18).
