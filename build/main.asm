;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12439 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _abs
	.globl _set_sprite_data
	.globl _delay
	.globl _speedY
	.globl _speedX
	.globl _LogoSprite
	.globl _logoY
	.globl _logoX
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_logoX::
	.ds 2
_logoY::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_LogoSprite::
	.ds 64
_speedX::
	.ds 2
_speedY::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:15: int main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:17: set_sprite_data(0, 4, LogoSprite);
	ld	de, #_LogoSprite
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;src/main.c:19: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:22: logoX = abs( rand()%(80-10) + 10);
	call	_rand
	ld	bc, #0x0046
	push	bc
	push	de
	call	__modsint
	add	sp, #4
	ld	hl, #0x000a
	add	hl, de
	push	hl
	call	_abs
	pop	hl
;setupPair	HL
	ld	hl, #_logoX
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:23: logoY = abs(rand()%(80-10) + 10);
	call	_rand
	ld	bc, #0x0046
	push	bc
	push	de
	call	__modsint
	add	sp, #4
	ld	hl, #0x000a
	add	hl, de
	push	hl
	call	_abs
	pop	hl
;setupPair	HL
	ld	hl, #_logoY
;setupPair	HL
	ld	a, e
	ld	(hl+), a
;src/main.c:26: move_sprite(0, logoX, logoY);
;setupPair	HL
	ld	a, d
	ld	(hl-), a
	ld	b, (hl)
;setupPair	HL
	ld	hl, #_logoX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/main.c:28: while(1){
00112$:
;src/main.c:31: if(logoX >= 160){
;setupPair	HL
	ld	hl, #_logoX
	ld	a, (hl+)
	sub	a, #0xa0
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00148$
	bit	7, d
	jr	NZ, 00149$
	cp	a, a
	jr	00149$
00148$:
	bit	7, d
	jr	Z, 00149$
	scf
00149$:
	jr	C, 00104$
;src/main.c:32: speedX = -1;
;setupPair	HL
	ld	hl, #_speedX
;setupPair	HL
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x01
;src/main.c:33: set_sprite_tile(0, 1);
	jr	00105$
00104$:
;src/main.c:34: }else if(logoX-8 <= 0){
;setupPair	HL
	ld	hl, #_logoX
;setupPair	HL
	ld	a, (hl+)
	add	a, #0xf8
	ld	c, a
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00150$
	bit	7, d
	jr	NZ, 00151$
	cp	a, a
	jr	00151$
00150$:
	bit	7, d
	jr	Z, 00151$
	scf
00151$:
	jr	C, 00105$
;src/main.c:35: speedX = 1;
;setupPair	HL
	ld	hl, #_speedX
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;src/main.c:36: set_sprite_tile(0, 2);
00105$:
;src/main.c:39: if(logoY-8 >= 144){
;setupPair	HL
	ld	hl, #_logoY
;setupPair	HL
	ld	a, (hl+)
	add	a, #0xf8
	ld	c, a
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	ld	a, c
	sub	a, #0x90
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00109$
;src/main.c:40: speedY = -1;
;setupPair	HL
	ld	hl, #_speedY
;setupPair	HL
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;src/main.c:41: set_sprite_tile(0, 0);
	jr	00110$
00109$:
;src/main.c:42: }else if(logoY-16 <= 0){
;setupPair	HL
	ld	hl, #_logoY
;setupPair	HL
	ld	a, (hl+)
	add	a, #0xf0
	ld	c, a
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00152$
	bit	7, d
	jr	NZ, 00153$
	cp	a, a
	jr	00153$
00152$:
	bit	7, d
	jr	Z, 00153$
	scf
00153$:
	jr	C, 00110$
;src/main.c:43: speedY = 1;
;setupPair	HL
	ld	hl, #_speedY
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x03
;src/main.c:44: set_sprite_tile(0, 3);
00110$:
;src/main.c:48: logoX = logoX + speedX;
;setupPair	HL
	ld	a, (#_logoX)
;setupPair	HL
	ld	hl, #_speedX
	add	a, (hl)
;setupPair	HL
	ld	hl, #_logoX
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_speedX + 1
	adc	a, (hl)
;setupPair	HL
	ld	(#_logoX + 1),a
;src/main.c:49: logoY = logoY + speedY;
;setupPair	HL
	ld	a, (#_logoY)
;setupPair	HL
	ld	hl, #_speedY
	add	a, (hl)
;setupPair	HL
	ld	hl, #_logoY
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_speedY + 1
	adc	a, (hl)
;setupPair	HL
	ld	(#_logoY + 1),a
;src/main.c:52: delay(25);
	ld	de, #0x0019
	push	de
	call	_delay
	pop	hl
;src/main.c:55: move_sprite(0, logoX, logoY);
;setupPair	HL
	ld	hl, #_logoY
	ld	b, (hl)
;setupPair	HL
	ld	hl, #_logoX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/main.c:55: move_sprite(0, logoX, logoY);
;src/main.c:57: }
	jp	00112$
	.area _CODE
	.area _INITIALIZER
__xinit__LogoSprite:
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x56	; 86	'V'
	.db #0x95	; 149
	.db #0x56	; 86	'V'
	.db #0x95	; 149
	.db #0x56	; 86	'V'
	.db #0x95	; 149
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x6a	; 106	'j'
	.db #0xa9	; 169
	.db #0x6a	; 106	'j'
	.db #0xa9	; 169
	.db #0x6a	; 106	'j'
	.db #0xa9	; 169
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x56	; 86	'V'
	.db #0x95	; 149
	.db #0x56	; 86	'V'
	.db #0x95	; 149
	.db #0x56	; 86	'V'
	.db #0x95	; 149
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x6a	; 106	'j'
	.db #0xa9	; 169
	.db #0x6a	; 106	'j'
	.db #0xa9	; 169
	.db #0x6a	; 106	'j'
	.db #0xa9	; 169
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
__xinit__speedX:
	.dw #0x0001
__xinit__speedY:
	.dw #0x0001
	.area _CABS (ABS)
