	.file	"hash_func.cpp"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"size_t hash_crc_32(void*, size_t)"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"hash_func.cpp"
.LC2:
	.string	"ptr != nullptr"
	.text
	.p2align 4
	.globl	_Z11hash_crc_32Pvm
	.type	_Z11hash_crc_32Pvm, @function
_Z11hash_crc_32Pvm:
.LFB57:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L12
	test	rsi, rsi
	je	.L5
	add	rsi, rdi
	mov	eax, -1
	lea	rcx, CRCTable[rip]
	.p2align 4,,10
	.p2align 3
.L4:
	movzx	edx, BYTE PTR [rdi]
	add	rdi, 1
	xor	edx, eax
	shr	eax, 8
	movzx	edx, dl
	xor	eax, DWORD PTR [rcx+rdx*8]
	cmp	rsi, rdi
	jne	.L4
	and	eax, 1023
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	mov	eax, 1023
	ret
.L12:
	push	rax
	.cfi_def_cfa_offset 16
	lea	rcx, .LC0[rip]
	mov	edx, 7
	lea	rsi, .LC1[rip]
	lea	rdi, .LC2[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE57:
	.size	_Z11hash_crc_32Pvm, .-_Z11hash_crc_32Pvm
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"size_t hash_rol(void*, size_t)"
	.text
	.p2align 4
	.globl	_Z8hash_rolPvm
	.type	_Z8hash_rolPvm, @function
_Z8hash_rolPvm:
.LFB58:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L24
	movsx	rax, BYTE PTR [rdi]
	lea	rdx, 1[rdi]
	test	rsi, rsi
	je	.L15
	lea	rsi, 1[rdi+rsi]
	.p2align 4,,10
	.p2align 3
.L16:
	lea	rcx, [rax+rax]
	shr	rax, 31
	add	rdx, 1
	or	rcx, rax
	movsx	rax, BYTE PTR -1[rdx]
	xor	rax, rcx
	cmp	rdx, rsi
	jne	.L16
.L15:
	and	eax, 1023
	ret
.L24:
	push	rax
	.cfi_def_cfa_offset 16
	lea	rcx, .LC3[rip]
	mov	edx, 22
	lea	rsi, .LC1[rip]
	lea	rdi, .LC2[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE58:
	.size	_Z8hash_rolPvm, .-_Z8hash_rolPvm
	.p2align 4
	.globl	_Z11hash_only_1Pvm
	.type	_Z11hash_only_1Pvm, @function
_Z11hash_only_1Pvm:
.LFB59:
	.cfi_startproc
	endbr64
	mov	eax, 1
	ret
	.cfi_endproc
.LFE59:
	.size	_Z11hash_only_1Pvm, .-_Z11hash_only_1Pvm
	.p2align 4
	.globl	_Z15hash_first_symbPvm
	.type	_Z15hash_first_symbPvm, @function
_Z15hash_first_symbPvm:
.LFB60:
	.cfi_startproc
	endbr64
	movsx	rax, BYTE PTR [rdi]
	ret
	.cfi_endproc
.LFE60:
	.size	_Z15hash_first_symbPvm, .-_Z15hash_first_symbPvm
	.p2align 4
	.globl	_Z8hash_lenPvm
	.type	_Z8hash_lenPvm, @function
_Z8hash_lenPvm:
.LFB61:
	.cfi_startproc
	endbr64
	mov	rax, rsi
	and	eax, 1023
	ret
	.cfi_endproc
.LFE61:
	.size	_Z8hash_lenPvm, .-_Z8hash_lenPvm
	.section	.rodata.str1.8
	.align 8
.LC4:
	.string	"size_t hash_sum_symb(void*, size_t)"
	.text
	.p2align 4
	.globl	_Z13hash_sum_symbPvm
	.type	_Z13hash_sum_symbPvm, @function
_Z13hash_sum_symbPvm:
.LFB62:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L38
	movsx	rdx, BYTE PTR [rdi]
	xor	eax, eax
	test	dl, dl
	je	.L32
	.p2align 4,,10
	.p2align 3
.L31:
	add	rdi, 1
	add	rax, rdx
	movsx	rdx, BYTE PTR [rdi]
	test	dl, dl
	jne	.L31
	and	eax, 1023
	ret
	.p2align 4,,10
	.p2align 3
.L32:
	ret
.L38:
	push	rax
	.cfi_def_cfa_offset 16
	lea	rcx, .LC4[rip]
	mov	edx, 56
	lea	rsi, .LC1[rip]
	lea	rdi, .LC2[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE62:
	.size	_Z13hash_sum_symbPvm, .-_Z13hash_sum_symbPvm
	.globl	CRCTable
	.data
	.align 32
	.type	CRCTable, @object
	.size	CRCTable, 2048
CRCTable:
	.quad	0
	.quad	1996959894
	.quad	3993919788
	.quad	2567524794
	.quad	124634137
	.quad	1886057615
	.quad	3915621685
	.quad	2657392035
	.quad	249268274
	.quad	2044508324
	.quad	3772115230
	.quad	2547177864
	.quad	162941995
	.quad	2125561021
	.quad	3887607047
	.quad	2428444049
	.quad	498536548
	.quad	1789927666
	.quad	4089016648
	.quad	2227061214
	.quad	450548861
	.quad	1843258603
	.quad	4107580753
	.quad	2211677639
	.quad	325883990
	.quad	1684777152
	.quad	4251122042
	.quad	2321926636
	.quad	335633487
	.quad	1661365465
	.quad	4195302755
	.quad	2366115317
	.quad	997073096
	.quad	1281953886
	.quad	3579855332
	.quad	2724688242
	.quad	1006888145
	.quad	1258607687
	.quad	3524101629
	.quad	2768942443
	.quad	901097722
	.quad	1119000684
	.quad	3686517206
	.quad	2898065728
	.quad	853044451
	.quad	1172266101
	.quad	3705015759
	.quad	2882616665
	.quad	651767980
	.quad	1373503546
	.quad	3369554304
	.quad	3218104598
	.quad	565507253
	.quad	1454621731
	.quad	3485111705
	.quad	3099436303
	.quad	671266974
	.quad	1594198024
	.quad	3322730930
	.quad	2970347812
	.quad	795835527
	.quad	1483230225
	.quad	3244367275
	.quad	3060149565
	.quad	1994146192
	.quad	31158534
	.quad	2563907772
	.quad	4023717930
	.quad	1907459465
	.quad	112637215
	.quad	2680153253
	.quad	3904427059
	.quad	2013776290
	.quad	251722036
	.quad	2517215374
	.quad	3775830040
	.quad	2137656763
	.quad	141376813
	.quad	2439277719
	.quad	3865271297
	.quad	1802195444
	.quad	476864866
	.quad	2238001368
	.quad	4066508878
	.quad	1812370925
	.quad	453092731
	.quad	2181625025
	.quad	4111451223
	.quad	1706088902
	.quad	314042704
	.quad	2344532202
	.quad	4240017532
	.quad	1658658271
	.quad	366619977
	.quad	2362670323
	.quad	4224994405
	.quad	1303535960
	.quad	984961486
	.quad	2747007092
	.quad	3569037538
	.quad	1256170817
	.quad	1037604311
	.quad	2765210733
	.quad	3554079995
	.quad	1131014506
	.quad	879679996
	.quad	2909243462
	.quad	3663771856
	.quad	1141124467
	.quad	855842277
	.quad	2852801631
	.quad	3708648649
	.quad	1342533948
	.quad	654459306
	.quad	3188396048
	.quad	3373015174
	.quad	1466479909
	.quad	544179635
	.quad	3110523913
	.quad	3462522015
	.quad	1591671054
	.quad	702138776
	.quad	2966460450
	.quad	3352799412
	.quad	1504918807
	.quad	783551873
	.quad	3082640443
	.quad	3233442989
	.quad	3988292384
	.quad	2596254646
	.quad	62317068
	.quad	1957810842
	.quad	3939845945
	.quad	2647816111
	.quad	81470997
	.quad	1943803523
	.quad	3814918930
	.quad	2489596804
	.quad	225274430
	.quad	2053790376
	.quad	3826175755
	.quad	2466906013
	.quad	167816743
	.quad	2097651377
	.quad	4027552580
	.quad	2265490386
	.quad	503444072
	.quad	1762050814
	.quad	4150417245
	.quad	2154129355
	.quad	426522225
	.quad	1852507879
	.quad	4275313526
	.quad	2312317920
	.quad	282753626
	.quad	1742555852
	.quad	4189708143
	.quad	2394877945
	.quad	397917763
	.quad	1622183637
	.quad	3604390888
	.quad	2714866558
	.quad	953729732
	.quad	1340076626
	.quad	3518719985
	.quad	2797360999
	.quad	1068828381
	.quad	1219638859
	.quad	3624741850
	.quad	2936675148
	.quad	906185462
	.quad	1090812512
	.quad	3747672003
	.quad	2825379669
	.quad	829329135
	.quad	1181335161
	.quad	3412177804
	.quad	3160834842
	.quad	628085408
	.quad	1382605366
	.quad	3423369109
	.quad	3138078467
	.quad	570562233
	.quad	1426400815
	.quad	3317316542
	.quad	2998733608
	.quad	733239954
	.quad	1555261956
	.quad	3268935591
	.quad	3050360625
	.quad	752459403
	.quad	1541320221
	.quad	2607071920
	.quad	3965973030
	.quad	1969922972
	.quad	40735498
	.quad	2617837225
	.quad	3943577151
	.quad	1913087877
	.quad	83908371
	.quad	2512341634
	.quad	3803740692
	.quad	2075208622
	.quad	213261112
	.quad	2463272603
	.quad	3855990285
	.quad	2094854071
	.quad	198958881
	.quad	2262029012
	.quad	4057260610
	.quad	1759359992
	.quad	534414190
	.quad	2176718541
	.quad	4139329115
	.quad	1873836001
	.quad	414664567
	.quad	2282248934
	.quad	4279200368
	.quad	1711684554
	.quad	285281116
	.quad	2405801727
	.quad	4167216745
	.quad	1634467795
	.quad	376229701
	.quad	2685067896
	.quad	3608007406
	.quad	1308918612
	.quad	956543938
	.quad	2808555105
	.quad	3495958263
	.quad	1231636301
	.quad	1047427035
	.quad	2932959818
	.quad	3654703836
	.quad	1088359270
	.quad	936918000
	.quad	2847714899
	.quad	3736837829
	.quad	1202900863
	.quad	817233897
	.quad	3183342108
	.quad	3401237130
	.quad	1404277552
	.quad	615818150
	.quad	3134207493
	.quad	3453421203
	.quad	1423857449
	.quad	601450431
	.quad	3009837614
	.quad	3294710456
	.quad	1567103746
	.quad	711928724
	.quad	3020668471
	.quad	3272380065
	.quad	1510334235
	.quad	755167117
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
