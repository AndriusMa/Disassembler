; Gyvenimo tikslas - Disasembleris
.model small
.stack 100h

.data

	failo_klaida db 0Dh, 0Ah, "Dirbant su failais ivyko klaida$"
	be_klaidu db 0Dh, 0Ah, "Programa sekmingai baige darba$"
	nuskaitymo_klaida db "Failo nepavyko nuskaityti, patikrinkite, ar jis egzistuoja, nepamirskite nurodyti isvesties failo$" 
	atidarymo_klaida db "Failo nepavyko atidaryti$"
	pagalbos_tekstas db "Norint nusiskaityti faila reikia ivesti jo varda SU FORMATU .com ir rezultato failo varda SU FORMATU .txt atskirtus tarpais$" ; pagalbos tekstas
	uzdarytas_failas db "Darbas baigtas, failas uzdarytas$"
	komanda_neatpazinta db "KOMANDA NEATPAZINTA"
	komanda_atpazinta db "KOMANDA ATPAZINTA"
	
	com_failas db 12 dup(0)
	rezultatu_failas db 12 dup(0)
	nera_parametru db "Nenurodyta is kurio failo(u) skaityti$"
	
	ent 	db	0Dh, 0Ah, 24h ; enteris
	kablelis db ','
	pliusas db '+'
	lauztinis_is_kaires db '['
	lauztinis_is_desines db ']'
	h_raide db 'h'
	dvitaskis db ':'
	nuliukas db '0'
	byte_ptr db 'byte ptr'
	vienetas db '1'
	prefixas db ?
	
	duom_deskriptorius_com dw ?
	duom_deskriptorius_rezultatas dw ?
	
	buferis db 512 dup (?)
	dabartine_pozicija dw 0
	nuskaitytu_baitu_kiekis dw 0
	baitukas db ?
	ar_failas_baigesi db 0
	
	spausdinimui_paruostas_bo db 5 dup(' ')
	spausdinimui_paruostas_op_numeris db '0', '0', '0', '0', ':', ' ', ' ', ' ', ' ', ' '
	spausdinimui_paruostas_poslinkis_jumpui db 4 dup(' ')
	spausdinimui_paruostas_op_kodas db 16 dup(' ')
	spausdinimui_paruostas_poslinkis db 4 dup(' ')
	
	
	dabartinis_formatas db 0
	dabartine_komanda db 0
	
	; operacijos kodui ir numeriui paruosti
	dabartines_op_baitai db 0
	operacijos_numeris dw 0
	operacijos_kodas db 0
	laikinas_baitas db 0
	laikinas_zodis dw 0
	
	; operacijos skaitymui
	pirmas_spausdinimui db ?
	antras_spausdinimui db ? 
	dabartinis_baitas db ?
	pirmas_baitas db ?
	reg db ?
	modd db ?
	rm db ?
	bojb db ?
	bovb db ?
	d db ?
	w db ?
	v db ?
	s db ?
	s_seg db ?
	r_seg db ?
	prfx db 0
	
	; registrai
	r_AX db 'ax', 0
	r_BX db 'bx', 0
    r_CX db 'cx', 0
    r_DX db 'dx', 0
    r_SP db 'sp', 0
    r_BP db 'bp', 0
    r_SI db 'si', 0
    r_DI db 'di', 0
	
	r_AH db 'ah', 0
	r_AL db 'al', 0
    r_BH db 'bh', 0
    r_BL db 'bl', 0
    r_CH db 'ch', 0
    r_CL db 'cl', 0
    r_DH db 'dh', 0
    r_DL db 'dl', 0
	
	; segmentiniai registrai
	r_ES db 'es', 0
	r_CS db 'cs', 0
	r_SS db 'ss', 0
	r_DS db 'ds', 0
	
	r_BXSI db 'bx+si', 0
	r_BXDI db 'bx+di', 0
	r_BPSI db 'bp+si', 0
	r_BPDI db 'bp+di', 0
	
	;komandu vardai
	k_MOV db 'mov ', 0
	k_ADD db 'add ', 0
	k_SUB db 'sub ', 0
    k_INC db 'inc ', 0
	k_DEC db 'dec ', 0
	k_PUSH db 'push ', 0
    k_POP db 'pop ', 0
    k_INT db 'int ', 0
	k_OR db 'or', 0
	k_ADC db 'adc', 0
	k_SBB db 'sbb', 0
	k_AND db 'and', 0
	k_XOR db 'xor', 0
	k_CMP db 'cmp', 0
	k_TEST db 'test', 0
	k_DAA db 'daa', 0
	k_DAS db 'das', 0
	k_AAA db 'aaa', 0
	k_AAS db 'aas', 0
	k_NOP db 'nop', 0
	k_CBW db 'cbw', 0
	k_CWD db 'cwd', 0
	k_WAIT db 'wait', 0
	k_PUSHF db 'pushf', 0
	k_POPF db 'popf', 0
	k_SAHF db 'sahf', 0
	k_LAHF db 'lahf', 0
	k_RET db 'ret', 0
	k_RETF db 'retf', 0
	k_INT3 db 'int3', 0
	k_INTO db 'into', 0
	k_IRET db 'iret', 0
	k_XLAT db 'xlat', 0
	k_LOCK db 'lock', 0
	k_REPNZ db 'repnz', 0
	k_REPZ db 'repz', 0
	k_HLT db 'hlt', 0
	k_CMC db ' cmc', 0
	k_CLC db 'clc', 0
	k_STC db 'stc', 0
	k_CLI db 'cli', 0
	k_STI db 'sti', 0
	k_CLD db 'cld', 0
	k_STD db 'std', 0
	k_XCHG db 'xchg', 0
	k_JO db 'jo', 0
	k_JNO db 'jno', 0
	k_JNAE db 'jnae', 0
	k_JAE db 'jae', 0
	k_JE db 'je', 0
	k_JNE db 'jne', 0
	k_JBE db 'jbe', 0
	k_JA db 'ja', 0
	k_JS db 'js', 0
	k_JNS db 'jns', 0
	k_JP db 'jp', 0
	k_JNP db 'jnp', 0
	k_JL db 'jl', 0
	k_JGE db 'jge', 0
	k_JLE db 'jle', 0
	k_JG db 'jg', 0
	k_LOOPNE db 'loopne', 0
	k_LOOPE db 'loope', 0
	k_LOOP db 'loop', 0
	k_JCXZ db 'jcxz', 0
	k_JMP db 'jmp', 0
	k_CALL db 'call', 0
	k_AAM db 'aam', 0
	k_AAD db 'aad', 0
	k_MOVSB db 'movsb', 0
	k_MOVSW db 'movsw', 0
	k_CMPSB db 'cmpsb', 0
	k_CMPSW db 'cmpsw', 0
	k_STOSB db 'stosb', 0
	k_STOSW db 'stosw', 0
	k_LODSB db 'lodsb', 0
	k_LODSW db 'lodsw', 0
	k_SCASB db 'scasb', 0
	k_SCASW db 'scasw', 0
	k_IN db 'in', 0
	k_OUT db 'out', 0
	k_ROL db 'rol', 0
	k_ROR db 'ror', 0
	k_RCL db 'rcl', 0
	k_RCR db 'rcr', 0
	k_SHL db 'shl', 0
	k_SHR db 'shr', 0
	k_SAR db 'sar', 0
	k_NOT db 'not', 0
	k_NEG db 'neg', 0
	k_MUL db 'mul', 0
	k_IMUL db 'imul', 0
	k_DIV db 'div', 0
	k_IDIV db 'idiv', 0
	k_LEA db 'lea', 0
	k_LES db 'les', 0
	k_LDS db 'lds', 0
	
	TIESIOGINIS_ADRESAS db 4 dup (' ')
	;00 - FF		  ;0 ;1 ;2 ;3 ;4 ;5 ;6 ;7 ;8 ;9 ;A ;B ;C ;D ;E ;F
	formatu_lentele db 1, 1, 1, 1, 2, 2, 3, 3, 1, 1, 1, 1, 2, 2, 3, 3 ;0
					db 1, 1, 1, 1, 2, 2, 3, 3, 1, 1, 1, 1, 2, 2, 3, 3 ;1
					db 1, 1, 1, 1, 2, 2, 3, 4, 1, 1, 1, 1, 2, 2, 3, 4 ;2
					db 1, 1, 1, 1, 2, 2, 3, 4, 1, 1, 1, 1, 2, 2, 3, 4 ;3
					db 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 ;4
					db 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 ;5
					db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;6
					db 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 ;7
					db 7, 7, 7, 7, 2, 2, 2, 2, 1, 1, 1, 17, 16, 16, 16, 16 ;8
					db 4, 5, 5, 5, 5, 5, 5, 5, 4, 4, 8, 4, 4, 4, 4, 4 ;9
					db 19, 19, 19, 19, 13, 13, 13, 13, 2, 2, 13, 13, 13, 13, 13, 13 ;A
					db 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 ;B
					db 0, 0, 2, 4, 17, 17, 15, 15, 0, 0, 2, 4, 4, 10, 4, 4 ;C
					db 11, 11, 11, 11, 12, 12, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0 ;D 
					db 6, 6, 6, 6, 14, 14, 14, 14, 19, 19, 8, 6, 13, 13, 13, 13;E
					db 4, 4, 4, 4, 4, 4, 16, 16, 4, 4, 4, 4, 4, 4, 18, 18 ;F
					
.code

start:
	mov ax, @data
	mov ds, ax

	mov ax, 0100h
	mov operacijos_numeris, ax ; issaugomas operacijos numeris
	call skaityk_komandine_eilute
	call skaityk_faila
	jmp returnas
		
PROC skaityk_komandine_eilute	
	; parametru perdavimui komandinei eilutei ir failo atidarymas:
	mov bx, 82h ; adresuosime su bx
	mov si, offset com_failas ;rasysime po simboli i vieta skirta duomenu failo vardui
	
	cmp byte ptr es:[80h], 0 ; nepaduota parametru, cmp 0 su es segmento ZODZIU, byte ptr praso, jog as lyginciau es registro reiksme kaip BAITA
	je nera_parametru_klaida
	cmp es:[82h], '?/' ; paduotas /?, tik del jaunesnio vyresnio baitu sekos zodzius saugant atmintyje reikia tikrinti atvirksciai
	jne skaityti_skaitymui
	cmp byte ptr es:[84h], 13 ; po parametro /? daugiau nieko ir nera
	je pagalba
	jmp skaityti_skaitymui ; vis tik yra, nors ir nelabai prasminga atidarinet faila kuris prasideda vardu '/?'
	
skaityti_skaitymui:
	cmp byte ptr es:[bx], ' ' ; ar jau tarpas?
	je ieskomas_tarpas ; jeigu jau tarpas, reikia skaityti antra parametra
	
	; dar neturiu pilno pavadinimo, pasiimu is komandines eilutes simboli, is atminties i atminti negalima rasyti tiesiogiai
	; tai tarpininkas bus registras, siuo atveju tiesiog pasirenku DL
	mov dl, byte ptr es:[bx]
	mov [si], dl
	
	inc bx
	inc si
	jmp skaityti_skaitymui

ieskomas_tarpas:
	mov si, offset rezultatu_failas
	tarpas:
		mov dl, byte ptr es:[bx]
		inc bx
		cmp dl, " "
		je tarpas
		mov[si], dl
		inc si

skaityti_rasymui:
	cmp byte ptr es:[bx], 13 ; ar jau enteris?
	je proc_baigta; jeigu jau enteris, pavadinimas pilnas yra
	
	; dar neturiu pilno pavadinimo, pasiimu is komandines eilutes simboli, is atminties i atminti negalima rasyti tiesiogiai
	; tai tarpininkas bus registras, siuo atveju tiesiog pasirenku DL
	mov dl, byte ptr es:[bx]
	mov [si], dl
	
	inc bx
	inc si
	jmp skaityti_rasymui
	
	nera_parametru_klaida:
		mov ah, 9h
		mov dx, offset nera_parametru
		int 21h
		jmp returnas
	
	pagalba:
		call spausdink_pagalba
		jmp returnas
		
	proc_baigta:
		RET
ENDP skaityk_komandine_eilute
tarpinis_returnas:
	call returnas

PROC skaityk_faila

		call atidaryk_com_faila ; atidaromi com ir rezultato failai
		call atidaryk_rezultatu_faila

		baitu_skaitymo_cikliukas:
			call spausdink_eilute_ip
			call po_baita
			cmp ar_failas_baigesi, 1
			je failas_pasibaiges_tai_lekiam_is_ciklo
			
			mov byte ptr[dabartinis_baitas], al
			mov byte ptr[pirmas_baitas], al
			call surink_informacija
			; call spausdink_instrukcija_i_faila
			
		jmp baitu_skaitymo_cikliukas
		
		failas_pasibaiges_tai_lekiam_is_ciklo:
		call uzdaryk_com_faila
		call uzdaryk_rezultatu_faila
	
	RET
ENDP skaityk_faila

PROC surink_informacija
		
		call gauk_formato_numeri
		call tikrink_formato_numeri
		cmp bl, 1h
		je returnas_info_jmp
		jne skaityk_formata
		returnas_info_jmp:
			jmp returnas_info
		
		skaityk_formata:
		cmp byte ptr[dabartinis_formatas], 1h ;jei formato numeris 1
		je formuojam_pagal_pirma_formata_call_tarp1
		cmp byte ptr[dabartinis_formatas], 2h ;jei formato numeris 2
		je formuojam_pagal_antra_formata_call_tarp1
		cmp byte ptr[dabartinis_formatas], 3h ;jei formato numeris 3
		je formuojam_pagal_trecia_formata_call_tarp1	
		cmp byte ptr[dabartinis_formatas], 4h ;jei formato numeris 4
		je formuojam_pagal_ketvirta_formata_call_tarp1
		cmp byte ptr[dabartinis_formatas], 5h ;jei formato numeris 5
		je formuojam_pagal_penkta_formata_call_tarp1
		cmp byte ptr[dabartinis_formatas], 6h ;jei formato numeris 6
		je formuojam_pagal_sesta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 7h ;jei formato numeris 7
		je formuojam_pagal_septinta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 8h ;jei formato numeris 8
		je formuojam_pagal_astunta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 9h ;jei formato numeris 9
		je formuojam_pagal_devinta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 0ah ;jei formato numeris 10
		je formuojam_pagal_desimta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 0bh ;jei formato numeris 11
		je formuojam_pagal_vienuolikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 0ch ;jei formato numeris 12
		je formuojam_pagal_dvylikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 0dh ;jei formato numeris 13
		je formuojam_pagal_trylikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 0eh ;jei formato numeris 14
		je formuojam_pagal_keturiolikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 0fh ;jei formato numeris 15
		je formuojam_pagal_penkiolikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 10h ;jei formato numeris 16
		je formuojam_pagal_sesiolikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 11h ;jei formato numeris 17
		je formuojam_pagal_septyniolikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 12h ;jei formato numeris 18
		je formuojam_pagal_astuoniolikta_formata_call_tarp
		cmp byte ptr[dabartinis_formatas], 13h ;jei formato numeris 19
		je formuojam_pagal_devyniolikta_formata_call_tarp	
				
		formuojam_pagal_pirma_formata_call_tarp1:
			jmp formuojam_pagal_pirma_formata_call_tarp
		formuojam_pagal_antra_formata_call_tarp1:
			jmp formuojam_pagal_antra_formata_call_tarp
		formuojam_pagal_trecia_formata_call_tarp1:
			jmp formuojam_pagal_trecia_formata_call_tarp	
		formuojam_pagal_ketvirta_formata_call_tarp1:
			jmp formuojam_pagal_ketvirta_formata_call_tarp
		formuojam_pagal_penkta_formata_call_tarp1:
			jmp formuojam_pagal_penkta_formata_call_tarp	
		;tarpiniai jumpai
		formuojam_pagal_pirma_formata_call_tarp:
			jmp formuojam_pagal_pirma_formata_call
		formuojam_pagal_antra_formata_call_tarp:
			 jmp formuojam_pagal_antra_formata_call
		formuojam_pagal_trecia_formata_call_tarp:
			jmp formuojam_pagal_trecia_formata_call
		formuojam_pagal_ketvirta_formata_call_tarp:
			 jmp formuojam_pagal_ketvirta_formata_call
		formuojam_pagal_penkta_formata_call_tarp:
			jmp formuojam_pagal_penkta_formata_call
		formuojam_pagal_sesta_formata_call_tarp:
			 jmp formuojam_pagal_sesta_formata_call
		formuojam_pagal_septinta_formata_call_tarp:
			jmp formuojam_pagal_septinta_formata_call
		formuojam_pagal_astunta_formata_call_tarp:
			 jmp formuojam_pagal_astunta_formata_call
		formuojam_pagal_devinta_formata_call_tarp:
			jmp formuojam_pagal_devinta_formata_call
		formuojam_pagal_desimta_formata_call_tarp:
			 jmp formuojam_pagal_desimta_formata_call
		formuojam_pagal_vienuolikta_formata_call_tarp:
			jmp formuojam_pagal_vienuolikta_formata_call
		formuojam_pagal_dvylikta_formata_call_tarp:
			 jmp formuojam_pagal_dvylikta_formata_call
		formuojam_pagal_trylikta_formata_call_tarp:
			jmp formuojam_pagal_trylikta_formata_call
		formuojam_pagal_keturiolikta_formata_call_tarp:
			 jmp formuojam_pagal_keturiolikta_formata_call
		formuojam_pagal_penkiolikta_formata_call_tarp:
			jmp formuojam_pagal_penkiolikta_formata_call
		formuojam_pagal_sesiolikta_formata_call_tarp:
			 jmp formuojam_pagal_sesiolikta_formata_call
		formuojam_pagal_septyniolikta_formata_call_tarp:
			jmp formuojam_pagal_septyniolikta_formata_call
		formuojam_pagal_astuoniolikta_formata_call_tarp:
			 jmp formuojam_pagal_astuoniolikta_formata_call
		formuojam_pagal_devyniolikta_formata_call_tarp:
			 jmp formuojam_pagal_devyniolikta_formata_call
			 
			;jumpai i callus 
		formuojam_pagal_pirma_formata_call:				; xxxx xxdw mod reg r/m [poslinkis]
			call formuojam_pagal_pirma_formata
			jmp returnas_info
		formuojam_pagal_antra_formata_call:				; xxxx xxxw bojb [bovb]
			call formuojam_pagal_antra_formata
			jmp returnas_info
		formuojam_pagal_trecia_formata_call:				; xxxs rxxx
			call formuojam_pagal_trecia_formata
			jmp returnas_info
		formuojam_pagal_ketvirta_formata_call:			; xxxx xxxx
			call formuojam_pagal_ketvirta_formata
			jmp returnas_info
		formuojam_pagal_penkta_formata_call:				; xxxx xreg
			call formuojam_pagal_penkta_formata
			jmp returnas_info
		formuojam_pagal_sesta_formata_call:				; xxxx xxxx poslinkis
			call formuojam_pagal_sesta_formata
			jmp returnas_info
		formuojam_pagal_septinta_formata_call:			; 1000 00sw mod reg r/m bojb [bovb]
			call formuojam_pagal_septinta_formata
			jmp returnas_info
		formuojam_pagal_astunta_formata_call:				; xxxx xxxx ajb avb srjb srvb
			call formuojam_pagal_astunta_formata
			jmp returnas_info
		formuojam_pagal_devinta_formata_call:				; 1011 wreg bojb [bovb]
			call formuojam_pagal_devinta_formata
			jmp returnas_info	
		formuojam_pagal_desimta_formata_call:				; xxxx xxxx numeris
			call formuojam_pagal_desimta_formata
			jmp returnas_info
		formuojam_pagal_vienuolikta_formata_call:				; 1101 00vw mod reg r/m [poslinkis] 
			call formuojam_pagal_vienuolikta_formata
			jmp returnas_info
		formuojam_pagal_dvylikta_formata_call:				; xxxx xxxx 00001010 
			call formuojam_pagal_dvylikta_formata
			jmp returnas_info
		formuojam_pagal_trylikta_formata_call:				; xxxx xxxw 
			call formuojam_pagal_trylikta_formata			
			jmp returnas_info
		formuojam_pagal_keturiolikta_formata_call:				; xxxx xxxx portas 
			call formuojam_pagal_keturiolikta_formata			
			jmp returnas_info
		formuojam_pagal_penkiolikta_formata_call:				; xxxx xxxx mod reg r/m [poslinkis] bojb [bovb] 
			call formuojam_pagal_penkiolikta_formata			
			jmp returnas_info
		formuojam_pagal_sesiolikta_formata_call:				; xxxx xxxw mod reg r/m [poslinkis]
			call formuojam_pagal_sesiolikta_formata			
			jmp returnas_info
		formuojam_pagal_septyniolikta_formata_call:				; xxxx xxxx mod reg r/m [poslinkis] LEA/LDS/LES
			call formuojam_pagal_septyniolikta_formata			
			jmp returnas_info
		formuojam_pagal_astuoniolikta_formata_call:				; xxxx xxxx mod reg r/m [poslinkis] pop-push
			call formuojam_pagal_astuoniolikta_formata			
			jmp returnas_info
		formuojam_pagal_devyniolikta_formata_call:				; xxxx xxxx ajb avb
			call formuojam_pagal_devyniolikta_formata			
			jmp returnas_info	

	returnas_info:		
		RET
ENDP surink_informacija

PROC tikrink_formato_numeri
	xor bx, bx
	cmp byte ptr[dabartinis_formatas], 14h
	jl maziau_13h
	jmp netinkamas_formatas
	
	maziau_13h:
		cmp byte ptr[dabartinis_formatas], 0h
		jg tinkamas_formatas
		jmp netinkamas_formatas
	
	netinkamas_formatas:
		call spausdink_komanda_neatpazinta
		mov bl, 1h
		jmp tikrink_returnas
	
	tinkamas_formatas:
		mov bl, 0h
		jmp tikrink_returnas
	tikrink_returnas:
		RET
ENDP tikrink_formato_numeri

PROC gauk_formato_numeri
	push ax
	push bx
	push cx
		mov al, byte ptr[dabartinis_baitas]
		mov ah, 0
		mov bx, offset formatu_lentele
		add bx, ax ; pridedu pirmo baito reiksme, kur lentelej jis bus kaip poslinkis
		mov cl, [bx] ; susirandu formato numeri
		mov dabartinis_formatas, cl
	
	pop cx
	pop bx
	pop ax
	RET
	ENDP gauk_formato_numeri

PROC formuojam_pagal_pirma_formata
	push ax
	;randu d ir w
	mov al, byte ptr[dabartinis_baitas]
	and al, 00000001b
	cmp al, 00000001b
	je nustatau_w1_f1
	jne nustatau_w0_f1
	
	nustatau_w0_f1:
		mov w, 0
		jmp statyk_d_f1
	nustatau_w1_f1:
		mov w, 1
		jmp statyk_d_f1
	
	statyk_d_f1:
	mov al, byte ptr[dabartinis_baitas]
	shl al, 6
	shr al, 7
	and al, 00000001b
	cmp al, 00000000b
	je nustatau_d0_f1
	jne nustatau_d1_f1
	
	nustatau_d0_f1:
		mov d, 0
		jmp spausdinimas_f1
	nustatau_d1_f1:
		mov d, 1
		jmp spausdinimas_f1
	
	spausdinimas_f1:
		call po_baita
		; nusistatau mod reg r/m
		mov byte ptr[dabartinis_baitas], al
		shr al, 6
		mov modd, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00111000b
		shr al, 3
		mov reg, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00000111b
		mov rm, al

		cmp d, 1 
		je f1_d1
		jne f1_d0
		
		f1_d1:
			call kviesk_pagal_moda_d1
			call spausdink_enteri
			jmp returnas_f1
			
		f1_d0:
			call kviesk_pagal_moda_d0
			call spausdink_enteri
			jmp returnas_f1

	returnas_f1:
		pop ax
		RET
ENDP formuojam_pagal_pirma_formata

PROC gauk_operacijos_varda_f1
	mov al, byte ptr[pirmas_baitas]
	shr al, 2
	cmp al, 00000000b
	je v_add_f1
	cmp al, 00000010b
	je v_or_f1
	cmp al, 00000100b
	je v_adc_f1
	cmp al, 00000110b
	je v_sbb_f1
	cmp al, 00001000b
	je v_and_f1
	cmp al, 00001010b
	je v_sub_f1
	cmp al, 00001100b
	je v_xor_f1
	cmp al, 00001110b
	je v_cmp_f1
	cmp al, 00100010b
	je v_mov_f1_tarp
	
	v_mov_f1_tarp:
		jmp v_mov_f1
	
	v_add_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_ADD
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_or_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_OR
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_adc_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_ADC
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_sbb_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_SBB
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_and_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_AND
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_sub_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_SUB
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_xor_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_XOR ; XOR
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_cmp_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CMP
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	v_mov_f1:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_MOV
		int 21h
		jmp gauk_operacijos_varda_f1_ret
	
	gauk_operacijos_varda_f1_ret:
		RET
ENDP gauk_operacijos_varda_f1

PROC formuojam_pagal_antra_formata
	push ax
	mov al, byte ptr[dabartinis_baitas]
	and al, 00000001b
	mov w, al	; nustatau w
	cmp w, 1
	je w1_f2
	jne w0_f2
	
	w1_f2:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f2
		call spausdink_r_AX
		call spausdink_kableli
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_enteri
		jmp returnas_f2
	w0_f2:
		call gamink_poslinki_1b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f2
		call spausdink_r_AL
		call spausdink_kableli
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_enteri
		jmp returnas_f2
	returnas_f2:
	pop ax
	RET
ENDP formuojam_pagal_antra_formata

PROC gauk_operacijos_varda_f2
	mov al, byte ptr[pirmas_baitas]
	shr al, 1
	cmp al, 00000010b
	je v_add_f2
	cmp al, 00000110b
	je v_or_f2
	cmp al, 00001010b
	je v_adc_f2
	cmp al, 00001110b
	je v_sbb_f2
	cmp al, 00010010b
	je v_and_f2
	cmp al, 00010110b
	je v_sub_f2
	cmp al, 00011010b
	je v_xor_f2_tarp
	cmp al, 00011110b
	je v_cmp_f2_tarp
	cmp al, 01000010b
	je v_test_f2_tarp
	cmp al, 01000011b
	je v_xchg_f2_tarp
	
	v_xor_f2_tarp:
		jmp v_xor_f2
	v_cmp_f2_tarp:
		jmp v_cmp_f2
	v_test_f2_tarp:
		jmp v_test_f2
	v_xchg_f2_tarp:
		jmp v_xchg_f2
	
	v_add_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_ADD
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_or_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_OR
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_adc_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_ADC
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_sbb_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_SBB
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_and_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_AND
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_sub_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_SUB
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_xor_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_XOR
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_cmp_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CMP
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_test_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_TEST
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	v_xchg_f2:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_XCHG
		int 21h
		jmp gauk_operacijos_varda_f2_ret
	
	gauk_operacijos_varda_f2_ret:
		RET
ENDP gauk_operacijos_varda_f2

PROC formuojam_pagal_trecia_formata
	push ax
	;randu s ir r
	mov al, byte ptr[dabartinis_baitas]
	mov laikinas_baitas, al
	shr al, 4
	and al, 00000001b
	cmp al, 00000001b
	je s1_f3
	jne s0_f3
	
	s1_f3:
		mov s_seg, 1
		jmp statyk_r_f3
			
		
	s0_f3:
		mov s_seg, 0
		jmp statyk_r_f3
	
	statyk_r_f3:
		mov al, laikinas_baitas
		shl al, 4
		shr al, 7
		cmp al, 00000001b
		je r1_f3
		jne r0_f3
	r1_f3:
		mov r_seg, 1
		jmp tikrink_komanda_f3
	r0_f3:
		mov r_seg, 0
		jmp tikrink_komanda_f3
		
	tikrink_komanda_f3:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f3
		cmp prfx, 0
		je prfx0_f3
		jne prfx1_f3
		
		prfx0_f3:
		call spausdink_segmentini_reg
		call spausdink_enteri
		;tikrink komanda pagal s ir r
		jmp returnas_f3
		
		prfx1_f3:
		;mov prfx, 0
		jmp returnas_f3
		
	returnas_f3:
		pop ax
		RET
ENDP formuojam_pagal_trecia_formata

PROC gauk_operacijos_varda_f3
	mov al, laikinas_baitas
	shr al, 5
	cmp al, 00000001b
	je seg_keit_prefix
	jne push_arba_pop
	
	seg_keit_prefix:
		call spausdink_segmentini_reg
		jmp gauk_k_v_f3_returnas
	
	push_arba_pop:
		mov al, laikinas_baitas
		and al, 00000111b
		cmp al, 00000110b
		je push_f3
		jne pop_f3
		
	push_f3:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_PUSH
		int 21h
		jmp gauk_k_v_f3_returnas
		
	pop_f3:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_POP
		int 21h
		jmp gauk_k_v_f3_returnas
		
	gauk_k_v_f3_returnas:
		RET
ENDP gauk_operacijos_varda_f3

PROC formuojam_pagal_ketvirta_formata
	mov al, byte ptr[dabartinis_baitas]
	mov laikinas_baitas, al
	call spausdink_eilute_ok
	call gauk_operacijos_varda_f4
	call spausdink_enteri
	jmp returnas_f4
	
	returnas_f4:
		RET
ENDP formuojam_pagal_ketvirta_formata

PROC gauk_operacijos_varda_f4
	cmp al, 00100111b
	je sp_DAA_f4_tarp
	cmp al, 00101111b
	je sp_DAS_f4_tarp
	cmp al, 00110111b
	je sp_AAA_f4_tarp
	cmp al, 00111111b
	je sp_AAS_f4_tarp
	cmp al, 10010000b
	je sp_NOP_f4_tarp
	cmp al, 10011000b
	je sp_CBW_f4_tarp
	cmp al, 10011001b
	je sp_CWD_f4_tarp
	cmp al, 10011011b
	je sp_WAIT_f4_tarp
	cmp al, 10011100b
	je sp_PUSHF_f4_tarp
	cmp al, 10011101b
	je sp_POPF_f4_tarp
	cmp al, 10011110b
	je sp_SAHF_f4_tarp
	cmp al, 10011111b
	je sp_LAHF_f4_tarp
	cmp al, 11000011b
	je sp_RET_f4_tarp
	cmp al, 11001011b
	je sp_RETF_f4_tarp
	cmp al, 11001100b
	je sp_INT3_f4_tarp
	cmp al, 11001110b
	je sp_INTO_f4_tarp
	cmp al, 11001111b
	je sp_IRET_f4_tarp
	cmp al, 11010111b
	je sp_XLAT_f4_tarp
	cmp al, 11110000b
	je sp_LOCK_f4_tarp
	cmp al, 11110010b
	je sp_REPNZ_f4_tarp
	cmp al, 11110011b
	je sp_REP_f4_tarp
	cmp al, 11110100b
	je sp_HLT_f4_tarp
	cmp al, 11110101b
	je sp_CMC_f4_tarp
	cmp al, 11111000b
	je sp_CLC_f4_tarp
	cmp al, 11111001b
	je sp_STC_f4_tarp
	cmp al, 11111010b
	je sp_CLI_f4_tarp
	cmp al, 11111011b
	je sp_STI_f4_tarp
	cmp al, 11111100b
	je sp_CLD_f4_tarp
	cmp al, 11111101b
	je sp_STD_f4_tarp
	
	jmp gauk_k_v_f4_returnas
	
	sp_DAA_f4_tarp:
		jmp sp_DAA_f4
	sp_DAS_f4_tarp:
		jmp sp_DAS_f4
	sp_AAA_f4_tarp:
		jmp sp_AAA_f4
	sp_AAS_f4_tarp:
		jmp sp_AAS_f4
	sp_NOP_f4_tarp:
		jmp sp_NOP_f4
	sp_CBW_f4_tarp:
		jmp sp_CBW_f4
	sp_CWD_f4_tarp:
		jmp sp_CWD_f4
	sp_WAIT_f4_tarp:
		jmp sp_WAIT_f4
	sp_PUSHF_f4_tarp:
		jmp sp_PUSHF_f4
	sp_POPF_f4_tarp:
		jmp sp_POPF_f4
	sp_SAHF_f4_tarp:
		jmp sp_SAHF_f4
	sp_LAHF_f4_tarp:
		jmp sp_LAHF_f4
	sp_RET_f4_tarp:
		jmp sp_RET_f4
	sp_RETF_f4_tarp:
		jmp sp_RETF_f4
	sp_INT3_f4_tarp:
		jmp sp_INT3_f4
	sp_INTO_f4_tarp:
		jmp sp_INTO_f4
	sp_IRET_f4_tarp:
		jmp sp_IRET_f4
	sp_XLAT_f4_tarp:
		jmp sp_XLAT_f4
	sp_LOCK_f4_tarp:
		jmp sp_LOCK_f4
	sp_REPNZ_f4_tarp:
		jmp sp_REPNZ_f4
	sp_REP_f4_tarp:
		jmp sp_REP_f4
	sp_HLT_f4_tarp:
		jmp sp_HLT_f4
	sp_CMC_f4_tarp:
		jmp sp_CMC_f4
	sp_CLC_f4_tarp:
		jmp sp_CLC_f4
	sp_STC_f4_tarp:
		jmp sp_STC_f4
	sp_CLI_f4_tarp:
		jmp sp_CLI_f4
	sp_STI_f4_tarp:
		jmp sp_STI_f4
	sp_CLD_f4_tarp:
		jmp sp_CLD_f4
	sp_STD_f4_tarp:
		jmp sp_STD_f4
	
	sp_DAA_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_DAA
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_DAS_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_DAS
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_AAA_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_AAA
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_AAS_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_AAS
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_NOP_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_NOP
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_CBW_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CBW
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_CWD_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CWD
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_WAIT_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_WAIT
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_PUSHF_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		mov dx, offset k_PUSHF
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_POPF_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_POPF
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_SAHF_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_SAHF
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_LAHF_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_LAHF
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_RET_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_RET
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_RETF_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_RETF
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_INT3_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_INT3
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_INTO_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_INTO
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_IRET_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_IRET
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_XLAT_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_XLAT
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_LOCK_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_LOCK
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_REPNZ_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		mov dx, offset k_REPNZ
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_REP_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_REPZ
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_HLT_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_HLT
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_CMC_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CMC
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_CLC_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CLC
		int 21h
		jmp gauk_k_v_f4_returnas		
	sp_STC_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_STC
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_CLI_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CLI
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_STI_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_STI
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_CLD_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CLD
		int 21h
		jmp gauk_k_v_f4_returnas
	sp_STD_f4:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_STD
		int 21h
		jmp gauk_k_v_f4_returnas
	gauk_k_v_f4_returnas:
		RET
ENDP gauk_operacijos_varda_f4

PROC formuojam_pagal_penkta_formata
	mov al, byte ptr[dabartinis_baitas]
	mov laikinas_baitas, al
	call spausdink_eilute_ok
	call gauk_operacijos_varda_f5
	;gaunam reg ir pagal ji spausdinam registrai
	; mov al, laikinas_baitas
	; and al, 00000111b
	; mov reg, al;
	mov al, laikinas_baitas
	call print_reg_w1
	shr al, 3
	cmp al, 00010010b
	je cia_xchg_f5
	jne returnas_f5
	
	cia_xchg_f5:
		call spausdink_kableli
		call spausdink_r_AX
		jmp returnas_f5
	returnas_f5:
		call spausdink_enteri
		RET
ENDP formuojam_pagal_penkta_formata

PROC gauk_operacijos_varda_f5
	shr al, 3
	cmp al, 00001000b
	je sp_INC_f5
	cmp al, 00001001b
	je sp_DEC_f5
	cmp al, 00001010b
	je sp_PUSH_f5
	cmp al, 00001011b
	je sp_POP_f5
	cmp al, 00010010b
	je sp_XCHG_f5
	
	sp_INC_f5:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_INC
		int 21h
		jmp gauk_k_v_f5_returnas
	sp_DEC_f5:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_DEC
		int 21h
		jmp gauk_k_v_f5_returnas
	sp_PUSH_f5:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_PUSH
		int 21h
		jmp gauk_k_v_f5_returnas
	sp_POP_f5:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_POP
		int 21h
		jmp gauk_k_v_f5_returnas
	sp_XCHG_f5:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_XCHG
		int 21h
		jmp gauk_k_v_f5_returnas
		
	gauk_k_v_f5_returnas:	
		RET
ENDP gauk_operacijos_varda_f5

PROC formuojam_pagal_sesta_formata
	call po_baita
	xor ax, ax
	xor bx, bx
	mov ax, operacijos_numeris
	mov bl, byte ptr[baitukas]
	and bl, 10000000b
	cmp bl, 10000000b
	je su_zenklu_f6
	jne be_zenklu_f6
	
	su_zenklu_f6:
		mov bl, byte ptr[baitukas]
		add ax, bx
		dec ah ; 256
		mov laikinas_zodis, ax
		jmp spausdink_f6
		
	be_zenklu_f6:
		mov bl, byte ptr[baitukas]
		add ax, bx
		mov laikinas_zodis, ax ; prideta reiksme pasidedu i laikinas_baitas
		jmp spausdink_f6
		
	spausdink_f6:
	call spausdink_eilute_ok
	call gauk_operacijos_varda_f6
	call spausdink_poslinki_jumpui
	call spausdink_enteri
	jmp returnas_f6
	returnas_f6:
		RET
ENDP formuojam_pagal_sesta_formata

PROC gauk_operacijos_varda_f6
	mov al, byte ptr[pirmas_baitas]
	cmp al, 01110000b
	je sp_JO_f6_tarp
	cmp al, 01110001b
	je sp_JNO_f6_tarp
	cmp al, 01110010b
	je sp_JNAE_f6_tarp
	cmp al, 01110011b
	je sp_JAE_f6_tarp
	cmp al, 01110100b
	je sp_JE_f6_tarp
	cmp al, 01110101b
	je sp_JNE_f6_tarp
	cmp al, 01110110b
	je sp_JBE_f6_tarp
	cmp al, 01110111b
	je sp_JA_f6_tarp
	cmp al, 01111000b
	je sp_JS_f6_tarp
	cmp al, 01111001b
	je sp_JNS_f6_tarp
	cmp al, 01111010b
	je sp_JP_f6_tarp
	cmp al, 01111011b
	je sp_JNP_f6_tarp
	cmp al, 01111100b
	je sp_JL_f6_tarp
	cmp al, 01111101b
	je sp_JGE_f6_tarp
	cmp al, 01111110b
	je sp_JLE_f6_tarp
	cmp al, 01111111b
	je sp_JG_f6_tarp
	cmp al, 11100000b
	je sp_LOOPNE_f6_tarp
	cmp al, 11100001b
	je sp_LOOPE_f6_tarp
	cmp al, 11100010b
	je sp_LOOP_f6_tarp
	cmp al, 11100011b
	je sp_JCXZ_f6_tarp
	cmp al, 11101011b
	je sp_JMP_f6_tarp
	
	sp_JO_f6_tarp:
		jmp sp_JO_f6
	sp_JNO_f6_tarp:
		jmp sp_JNO_f6
	sp_JNAE_f6_tarp:
		jmp sp_JNAE_f6
	sp_JAE_f6_tarp:
		jmp sp_JAE_f6
	sp_JE_f6_tarp:
		jmp sp_JE_f6
	sp_JNE_f6_tarp:
		jmp sp_JNE_f6
	sp_JBE_f6_tarp:
		jmp sp_JBE_f6
	sp_JA_f6_tarp:
		jmp sp_JA_f6
	sp_JS_f6_tarp:
		jmp sp_JS_f6
	sp_JNS_f6_tarp:
		jmp sp_JNS_f6
	sp_JP_f6_tarp:
		jmp sp_JP_f6
	sp_JNP_f6_tarp:
		jmp sp_JNP_f6
	sp_JL_f6_tarp:
		jmp sp_JL_f6
	sp_JGE_f6_tarp:
		jmp sp_JGE_f6
	sp_JLE_f6_tarp:
		jmp sp_JLE_f6
	sp_JG_f6_tarp:
		jmp sp_JG_f6
	sp_LOOPNE_f6_tarp:
		jmp sp_LOOPNE_f6
	sp_LOOPE_f6_tarp:
		jmp sp_LOOPE_f6
	sp_LOOP_f6_tarp:
		jmp sp_LOOP_f6
	sp_JCXZ_f6_tarp:
		jmp sp_JCXZ_f6
	sp_JMP_f6_tarp:
		jmp sp_JMP_f6
	
	
	sp_JO_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_JO
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JNO_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JNO
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JNAE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_JNAE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JAE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JAE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_JE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JNE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JNE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JBE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JBE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JA_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_JA
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JS_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_JS
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JNS_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JNS
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JP_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_JP
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JNP_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JNP
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JL_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_JL
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JGE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JGE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JLE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JLE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JG_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_JG
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_LOOPNE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 7d 
		mov dx, offset k_LOOPNE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_LOOPE_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		mov dx, offset k_LOOPE
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_LOOP_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_LOOP
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JCXZ_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_JCXZ
		int 21h
		jmp gauk_k_v_f6_returnas
	sp_JMP_f6:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JMP ; vidinis artimas
		int 21h
		jmp gauk_k_v_f6_returnas
	
	gauk_k_v_f6_returnas:
		RET
ENDP gauk_operacijos_varda_f6

PROC formuojam_pagal_septinta_formata
	mov al, byte ptr[dabartinis_baitas]
	mov laikinas_baitas, al
	mov al, laikinas_baitas
	and al, 00000001b
	cmp al, 00000001b
	je w1_f7
	jne w0_f7_tarp
		
	w0_f7_tarp:
		jmp w0_f7
	
	w1_f7:
		mov al, laikinas_baitas
		and al, 00000010b
		cmp al, 00000010b
		je s1_f7_set
		jne s0_f7_set
		s1_f7_set:
			mov s, 1
			jmp tesk_w1_f7
		s0_f7_set:
			mov s, 0
			jmp tesk_w1_f7
			
		tesk_w1_f7:
		mov w, 1
		call po_baita
		mov byte ptr[dabartinis_baitas], al
		shr al, 6
		mov modd, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00111000b
		shr al, 3
		mov reg, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00000111b
		mov rm, al
		
		;kokie yra s
		mov al, byte ptr[pirmas_baitas]
		cmp s, 1
		je s1_f7
		jne s0_f7
		
		s1_f7:
		mov reg, 00011111b ; sugadinu reg reiksme, kad nepraeitu conditional jmpu
		call pagamink_bo_pletimui
		jmp w1_end
		
		s0_f7:
		mov reg, 00011111b ; sugadinu reg reiksme, kad nepraeitu conditional jmpu
		call gamink_operanda_2b ; operandas bus is dvieju OPK baitu
		jmp w1_end
		
		w1_end:
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f7
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_nuli
			call spausdink_operanda_2b
			call spausdink_h_raide
			jmp returnas_f7
	
	w0_f7:
		mov w, 0
		call po_baita
		mov byte ptr[dabartinis_baitas], al
		shr al, 6
		mov modd, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00111000b
		shr al, 3
		mov reg, al
		mov laikinas_baitas, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00000111b
		mov rm, al
		
		cmp modd, 00000011b
		je kviesk_11_f7
		cmp modd, 00000010b
		je kviesk_10_f7
		cmp modd, 00000001b
		je kviesk_01_f7
		cmp modd, 00000000b
		je kviesk_00_f7
		
		kviesk_11_f7:
			mov reg, 00011111b ; sugadinu reg reiksme, kad nepraeitu conditional jmpu
			call gauk_registro_varda_11_d1
			jmp returnas_f7
		
		kviesk_10_f7:
			mov reg, 00011111b ; sugadinu reg reiksme, kad nepraeitu conditional jmpu
			jmp gamink_pos_2b_f7
			jmp returnas_f7
			
		kviesk_01_f7:
			mov reg, 00011111b ; sugadinu reg reiksme, kad nepraeitu conditional jmpu
			jmp gamink_pos_2b_f7
			jmp returnas_f7
		
		kviesk_00_f7:
			mov reg, 00011111b ; sugadinu reg reiksme, kad nepraeitu conditional jmpu
			cmp rm, 00000110b
			je gamink_pos_2b_f7
			
	gamink_pos_2b_f7:
		call gamink_poslinki_2b
		call gamink_operanda_1b
		call spausdink_eilute_ok
		mov al, laikinas_baitas
		mov reg, al
		call gauk_operacijos_varda_f7
		jmp tesk_su_pos
		
	gamink_pos_1b_f7:
		call gamink_poslinki_1b
		call gamink_operanda_1b
		call spausdink_eilute_ok
		mov al, laikinas_baitas
		mov reg, al
		call gauk_operacijos_varda_f7
		jmp tesk_su_pos
		
	tesk_su_pos:
		call gauk_registro_varda_00_d1
		call spausdink_kableli
		call spausdink_nuli
		call spausdink_operanda_1b
		call spausdink_h_raide
		jmp returnas_f7
	returnas_f7:
		call spausdink_enteri
		RET
ENDP formuojam_pagal_septinta_formata

PROC gauk_operacijos_varda_f7
	cmp reg, 00000000b
	je sp_ADD_f7_tarp
	cmp reg, 00000001b
	je sp_OR_f7_tarp
	cmp reg, 00000010b
	je sp_ADC_f7_tarp
	cmp reg, 00000011b
	je sp_SBB_f7_tarp
	cmp reg, 00000100b
	je sp_AND_f7_tarp
	cmp reg, 00000101b
	je sp_SUB_f7_tarp
	cmp reg, 00000110b
	je sp_XOR_f7_tarp
	cmp reg, 00000111b
	je sp_CMP_f7_tarp
	
	sp_ADD_f7_tarp:
		jmp sp_ADD_f7
	sp_OR_f7_tarp:
		jmp sp_OR_f7
	sp_ADC_f7_tarp:
		jmp sp_ADC_f7
	sp_SBB_f7_tarp:
		jmp sp_SBB_f7
	sp_AND_f7_tarp:
		jmp sp_AND_f7
	sp_SUB_f7_tarp:
		jmp sp_SUB_f7
	sp_XOR_f7_tarp:
		jmp sp_XOR_f7
	sp_CMP_f7_tarp:
		jmp sp_CMP_f7
		
	sp_ADD_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_ADD
		int 21h
		jmp gauk_k_v_f7_returnas
	sp_OR_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		mov dx, offset k_OR
		int 21h
		jmp gauk_k_v_f7_returnas
	sp_ADC_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_ADC
		int 21h
		jmp gauk_k_v_f7_returnas
	sp_SBB_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_SBB
		int 21h
		jmp gauk_k_v_f7_returnas
	sp_AND_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_AND 
		int 21h
		jmp gauk_k_v_f7_returnas
	sp_SUB_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_SUB 
		int 21h
		jmp gauk_k_v_f7_returnas
	sp_XOR_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_XOR
		int 21h
		jmp gauk_k_v_f7_returnas
	sp_CMP_f7:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_CMP 
		int 21h
		jmp gauk_k_v_f7_returnas
	
	
	gauk_k_v_f7_returnas:
		RET
ENDP gauk_operacijos_varda_f7

PROC formuojam_pagal_astunta_formata
	call gamink_poslinki_2b
	xor ax, ax
	mov ax, offset spausdinimui_paruostas_poslinkis
	call gamink_poslinki_2b
	call spausdink_eilute_ok
	call gauk_operacijos_varda_f8
	call spausdink_poslinki_2b
	call spausdink_dvitaski
	mov dx, ax
	mov ah, 40h
	mov bx, duom_deskriptorius_rezultatas
	mov cx, 4d
	int 21h
	call spausdink_enteri
	
	RET
ENDP formuojam_pagal_astunta_formata

PROC gauk_operacijos_varda_f8
	mov al, byte ptr[pirmas_baitas]
	cmp al, 10011010b
	je sp_CALL_f8
	jne sp_JMP_f8
	
	sp_CALL_f8:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset k_CALL 
		int 21h
		jmp gauk_k_v_f8_returnas
	sp_JMP_f8:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_JMP 
		int 21h
		jmp gauk_k_v_f8_returnas
		
		
	gauk_k_v_f8_returnas:
		RET
ENDP gauk_operacijos_varda_f8

PROC formuojam_pagal_devinta_formata
	mov laikinas_baitas, al
	and al, 00000111b
	mov reg, al
	mov rm, 00011111b ; sugadinu rm reiksme, kad nepraeitu gauk_registro_varda_11_d0
	mov al, laikinas_baitas
	and al, 00001000b
	cmp al, 00001000b
	je w1_f9
	jne w0_f9
	
	w1_f9:
		mov w, 1
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call spausdink_mov_f9
		call gauk_registro_varda_11_d0
		call spausdink_kableli
		call spausdink_nuli
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_enteri
		jmp returnas_f9
		
	w0_f9:
		mov w, 0
		call gamink_poslinki_1b
		call spausdink_eilute_ok
		call spausdink_mov_f9
		call gauk_registro_varda_11_d0
		call spausdink_kableli
		call spausdink_nuli
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_enteri
		jmp returnas_f9
		
	returnas_f9:
		RET
ENDP formuojam_pagal_devinta_formata

PROC spausdink_mov_f9
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_MOV
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_mov_f9

PROC formuojam_pagal_desimta_formata
	call gamink_poslinki_1b
	call spausdink_eilute_ok
	call spausdink_int_f10
	call spausdink_nuli
	call spausdink_poslinki_1b
	call spausdink_h_raide
	call spausdink_enteri
	
	RET
ENDP formuojam_pagal_desimta_formata

PROC spausdink_int_f10
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_INT
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_int_f10

PROC formuojam_pagal_vienuolikta_formata
	mov byte ptr[laikinas_baitas], al
	and al, 00000010b
	cmp al, 00000010b
	je v1_f11
	jne v0_f11
	
	v1_f11:
		mov v, 1
		jmp w_lygink_f11
	v0_f11:
		mov v, 0
		jmp w_lygink_f11
		
	w_lygink_f11:
	mov al, byte ptr[laikinas_baitas]
	and al, 00000001b
	cmp al, 00000001b
	je w1_f11
	jne w0_f11
	
	w1_f11:
		mov w, 1
		jmp tesk_f11
	w0_f11:
		mov w, 0
		jmp tesk_f11
		
	tesk_f11:
		call po_baita ; reikia nusistatyti mod reg r/m
		mov byte ptr[dabartinis_baitas], al
		shr al, 6
		mov modd, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00111000b
		shr al, 3
		mov reg, al
		
		mov al, byte ptr[dabartinis_baitas]
		and al, 00000111b
		mov rm, al
		
		cmp modd, 00000011b
		je tesk_11_f11
		jne tesk_00_f11
		
		tesk_11_f11:
			call spausdink_eilute_ok ; zinau, kad poslinkio nebus
			call gauk_operacijos_varda_f11
			mov reg, 11100000b ; sugadinu
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			cmp v, 1
			je v1_sp
			jne v0_sp
			
			jmp returnas_f11
			
		v1_sp:
			call gamink_operanda_1b ; special treatment, jeigu v=1
			call spausdink_operanda_1b ; siuo atveju bus cl reiksme
			jmp returnas_f11
		v0_sp:
			mov ah, 40h
			mov bx, duom_deskriptorius_rezultatas
			mov cx, 1d
			mov dx, offset vienetas
			int 21h
			jmp returnas_f11
			
		tesk_00_f11:
			cmp modd, 00000000b
			je spausdinu_tesk_00_f11
			
			cmp modd, 00000001b
				je sp_01_f11
				jne sp_10_f11
				
			sp_01_f11:
				call gamink_poslinki_1b
				jmp spausdinu_tesk_00_f11
			sp_10_f11:
				call gamink_poslinki_2b
				jmp spausdinu_tesk_00_f11
				
			spausdinu_tesk_00_f11:
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f11
			mov reg, 11100000b ; sugadinu
			call gauk_registro_varda_00_d1
			call spausdink_kableli
			cmp v, 1
			je v1_sp
			jne v0_sp
			
		call gauk_operacijos_varda_f11
		jmp returnas_f11
		
	returnas_f11:
	call spausdink_enteri
	RET
ENDP formuojam_pagal_vienuolikta_formata

PROC gauk_operacijos_varda_f11
	cmp reg, 00000000b
	je sp_ROL_f11_tarp
	cmp reg, 00000001b
	je sp_ROR_f11_tarp
	cmp reg, 00000010b
	je sp_RCL_f11_tarp
	cmp reg, 00000011b
	je sp_ROR_f11_tarp
	cmp reg, 00000100b
	je sp_SHL_f11_tarp
	cmp reg, 00000101b
	je sp_SHR_f11_tarp
	cmp reg, 00000111b
	je sp_SAR_f11_tarp
	
	sp_ROL_f11_tarp:
		jmp sp_ROL_f11
	sp_ROR_f11_tarp:
		jmp sp_ROR_f11
	sp_RCL_f11_tarp:
		jmp sp_RCL_f11
	sp_RCR_f11_tarp:
		jmp sp_RCR_f11
	sp_SHL_f11_tarp:
		jmp sp_SHL_f11
	sp_SHR_f11_tarp:
		jmp sp_SHR_f11
	sp_SAR_f11_tarp:
		jmp sp_SAR_f11
	
	sp_ROL_f11:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_ROL
		int 21h
		jmp gauk_k_v_f11_returnas
	sp_ROR_f11:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_ROR
		int 21h
		jmp gauk_k_v_f11_returnas
	sp_RCL_f11:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_RCL
		int 21h
		jmp gauk_k_v_f11_returnas
	sp_RCR_f11:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_RCR
		int 21h
		jmp gauk_k_v_f11_returnas
	sp_SHL_f11:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_SHL
		int 21h
		jmp gauk_k_v_f11_returnas
	sp_SHR_f11:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_SHR
		int 21h
		jmp gauk_k_v_f11_returnas
	sp_SAR_f11:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_SAR
		int 21h
		jmp gauk_k_v_f11_returnas
	gauk_k_v_f11_returnas:
	RET
ENDP gauk_operacijos_varda_f11

PROC formuojam_pagal_dvylikta_formata
	call po_baita
	call spausdink_eilute_ok
	call gauk_operacijos_varda_f12
	call spausdink_enteri
	RET
ENDP formuojam_pagal_dvylikta_formata

PROC gauk_operacijos_varda_f12
	mov al, byte ptr[pirmas_baitas]
	cmp al, 11010100b
	je sp_AAM_f12
	jne sp_AAD_f12

	sp_AAM_f12:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_AAM 
		int 21h
		jmp gauk_k_v_f12_returnas	
	sp_AAD_f12:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset k_AAD 
		int 21h
		jmp gauk_k_v_f12_returnas
	gauk_k_v_f12_returnas:	
		RET
ENDP gauk_operacijos_varda_f12

PROC formuojam_pagal_trylikta_formata
	mov laikinas_baitas, al
	and al, 00000001b
	cmp al, 00000001b
	je w1_f13
	jne w0_f13
	
	w1_f13:
		mov w, 1
		jmp tesk_f13
	w0_f13:
		mov w, 0
		jmp tesk_f13
		
	tesk_f13:
	call gauk_operacijos_varda_f13
	call spausdink_enteri
	RET
ENDP formuojam_pagal_trylikta_formata

PROC gauk_operacijos_varda_f13
	mov al, byte ptr[pirmas_baitas]
	shr al, 1
	cmp al, 01010010b
	je sp_MOV_f13_tarp
	cmp al, 01010011b
	je sp_CMP_f13_tarp
	cmp al, 01010101b
	je sp_STO_f13_tarp
	cmp al, 01010110b
	je sp_LOD_f13_tarp
	cmp al, 01010111b
	je sp_SCA_f13_tarp
	cmp al, 01110110b
	je sp_IN_f13_tarp
	cmp al, 01110111b
	je sp_OUT_f13_tarp
	
	sp_MOV_f13_tarp:
		jmp sp_MOV_f13
	sp_CMP_f13_tarp:
		jmp sp_CMP_f13
	sp_STO_f13_tarp:
		jmp sp_STO_f13
	sp_LOD_f13_tarp:
		jmp sp_LOD_f13
	sp_SCA_f13_tarp:
		jmp sp_SCA_f13
	sp_IN_f13_tarp:
		jmp sp_IN_f13
	sp_OUT_f13_tarp:
		jmp sp_OUT_f13
	
	sp_MOV_f13:
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		cmp w, 1
		je sp_MOVSB_f13
		jne sp_MOVSW_f13
		
		sp_MOVSB_f13:
		mov dx, offset k_MOVSB
		int 21h
		jmp gauk_k_v_f13_returnas
		
		sp_MOVSW_f13:
		mov dx, offset k_MOVSW
		int 21h
		jmp gauk_k_v_f13_returnas	
	sp_CMP_f13:
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		cmp w, 1
		je sp_CMPSB_f13
		jne sp_CMPSW_f13
		
		sp_CMPSB_f13:
		mov dx, offset k_CMPSB
		int 21h
		jmp gauk_k_v_f13_returnas
		
		sp_CMPSW_f13:
		mov dx, offset k_CMPSW
		int 21h
		jmp gauk_k_v_f13_returnas
	sp_STO_f13:
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		cmp w, 1
		je sp_STOSB_f13
		jne sp_STOSW_f13
		
		sp_STOSB_f13:
		mov dx, offset k_STOSB
		int 21h
		jmp gauk_k_v_f13_returnas
		
		sp_STOSW_f13:
		mov dx, offset k_STOSW
		int 21h
		jmp gauk_k_v_f13_returnas
	sp_LOD_f13:
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		cmp w, 1
		je sp_LODSB_f13
		jne sp_LODSW_f13
		
		sp_LODSB_f13:
		mov dx, offset k_LODSB
		int 21h
		jmp gauk_k_v_f13_returnas
		
		sp_LODSW_f13:
		mov dx, offset k_LODSW
		int 21h
		jmp gauk_k_v_f13_returnas
	sp_SCA_f13:
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 6d 
		cmp w, 1
		je sp_SCASB_f13
		jne sp_SCASW_f13
		
		sp_SCASB_f13:
		mov dx, offset k_SCASB
		int 21h
		jmp gauk_k_v_f13_returnas
		
		sp_SCASW_f13:
		mov dx, offset k_SCASW
		int 21h
		jmp gauk_k_v_f13_returnas
	sp_IN_f13:
		call gamink_poslinki_1b
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d 
		cmp w, 1
		je sp_INB_f13
		jne sp_INW_f13
		
		sp_INB_f13:
		mov dx, offset k_IN
		int 21h
		mov reg, 11110000b ; sugadinu reg reiksme
		mov rm, 00000000b ; padarau, kad butu al/ax registras
		call gauk_registro_varda_11_d1
		call spausdink_kableli
		mov w, 1
		mov rm, 00000010b ;padarau, kad butu dx registras
		call gauk_registro_varda_11_d1
		call spausdink_lauztini_is_kaires
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp gauk_k_v_f13_returnas
		
		sp_INW_f13:
		mov dx, offset k_IN
		int 21h
		mov reg, 11110000b ; sugadinu reg reiksme
		mov rm, 00000000b ; padarau, kad butu al/ax registras
		call spausdink_kableli
		mov rm, 00000010b ; padarau, kad butu dx registras
		call gauk_registro_varda_11_d1
		call spausdink_lauztini_is_kaires
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp gauk_k_v_f13_returnas
		
	sp_OUT_f13:
		call gamink_poslinki_1b
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		cmp w, 1
		je sp_OUTB_f13
		jne sp_OUTW_f13
		
	sp_OUTB_f13:
		mov dx, offset k_OUT
		int 21h
		
		mov w, 1 ; kad gauciau dx
		mov reg, 11110000b ; sugadinu reg reiksme
		mov rm, 00000010b ; padarau, kad butu dx registras
		call gauk_registro_varda_11_d1
		call spausdink_lauztini_is_kaires
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		call spausdink_kableli
		mov w, 0 ; kad gauciau al
		mov rm, 00000000b ; padarau, kad butu al/ax registras
		call gauk_registro_varda_11_d1
		jmp gauk_k_v_f13_returnas
		
		sp_OUTW_f13:
		mov dx, offset k_OUT
		int 21h

		mov reg, 11110000b ; sugadinu reg reiksme
		mov rm, 00000010b ; padarau, kad butu dx registras
		call gauk_registro_varda_11_d1
		call spausdink_lauztini_is_kaires
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		call spausdink_kableli
		mov rm, 00000000b ; padarau, kad butu al/ax registras
		call gauk_registro_varda_11_d1
		jmp gauk_k_v_f13_returnas
		
	gauk_k_v_f13_returnas:	
		RET
ENDP gauk_operacijos_varda_f13

PROC formuojam_pagal_keturiolikta_formata
	mov laikinas_baitas, al
	mov rm, 00000000b ; kad butu al
	mov reg, 11110000b ; kad nepraeitu conditional jumpu
	and al, 00000001b
	cmp al, 00000001b
	je w1_f14
	jne w0_f14
	
	w1_f14:
		mov w, 1
		jmp tesk_f14
	w0_f14:
		mov w, 0
		jmp tesk_f14
		
	tesk_f14:
	call gamink_poslinki_1b
	call spausdink_eilute_ok
	call gauk_operacijos_varda_f14
	call spausdink_enteri
	
	returnas_f14:
	RET
ENDP formuojam_pagal_keturiolikta_formata

PROC gauk_operacijos_varda_f14
	mov al, byte ptr[pirmas_baitas]
	shr al, 1
	cmp al, 01110010b
	je sp_IN_f14
	jne sp_OUT_f14
	
	sp_IN_f14:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 3d
		mov dx, offset k_IN
		int 21h
		
		cmp w, 1
		je sp_INW_f14
		jne sp_INB_f14
		
		sp_INB_f14:
			mov w, 0
			jmp sp_INW_f14
		
		sp_INW_f14:
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_lauztini_is_kaires
			call spausdink_poslinki_1b
			call spausdink_h_raide
			call spausdink_lauztini_is_desines
		jmp gauk_k_v_f14_returnas
		
	sp_OUT_f14:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset k_OUT
		int 21h
		
		cmp w, 1
		je sp_INW_f14
		jne sp_INB_f14
		
		sp_OUTB_f14:
			mov w, 0
			jmp sp_OUTW_f14
		
		sp_OUTW_f14:
			call spausdink_lauztini_is_kaires
			call spausdink_poslinki_1b
			call spausdink_h_raide
			call spausdink_lauztini_is_desines
			call spausdink_kableli
			call gauk_registro_varda_11_d1
		jmp gauk_k_v_f14_returnas
	
	gauk_k_v_f14_returnas:
	RET
ENDP gauk_operacijos_varda_f14

PROC formuojam_pagal_penkiolikta_formata
	mov laikinas_baitas, al
	mov reg, 11100000b
	and al, 00000001b
	cmp al, 1
	je w1_f15
	jne w0_f15
	
	w1_f15:
		mov w, 1
		jmp tesk_f15
	w0_f15:
		mov w, 0
		jmp tesk_f15
		
	tesk_f15:
		call po_baita
		mov laikinas_baitas, al
		shr al, 6
		and al, 00000011b
		mov modd, al
		
		mov al, laikinas_baitas
		and al, 00000111b
		mov rm, al
		
		cmp modd, 00000011b
		je sp_11_f15
		jne sp_00_f15
		
	sp_11_f15:
		cmp w, 1
		je sp_11_f15_w1
		jne sp_11_f15_w0
	sp_00_f15:
		cmp w, 1
		je sp_00_f15_w1_tarp
		jne sp_00_f15_w0
		
	sp_00_f15_w1_tarp:
		jmp sp_00_f15_w1
		
	sp_11_f15_w0:
		call gamink_operanda_1b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f15
		call gauk_registro_varda_11_d1
		call spausdink_kableli
		call spausdink_nuli
		call spausdink_operanda_1b
		call spausdink_h_raide
		jmp returnas_f15
	sp_11_f15_w1:
		call gamink_operanda_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f15
		call gauk_registro_varda_11_d1
		call spausdink_kableli
		call spausdink_nuli
		call spausdink_operanda_2b
		call spausdink_h_raide
		jmp returnas_f15
	
	sp_00_f15_w0:
		cmp modd, 00000000b
		je modd00_w0_f15
		cmp modd, 00000001b
		je modd01_w0_f15
		jne modd10_w0_f15
		
		modd00_w0_f15:	
			call gamink_operanda_1b
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f15
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_nuli
			call spausdink_operanda_1b
			call spausdink_h_raide
			jmp returnas_f15
			
		modd01_w0_f15:
			call gamink_poslinki_1b
			call gamink_operanda_1b
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f15
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_nuli
			call spausdink_operanda_1b
			call spausdink_h_raide
			jmp returnas_f15
		modd10_w0_f15:
			call gamink_poslinki_2b
			call gamink_operanda_1b
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f15
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_nuli
			call spausdink_operanda_1b
			call spausdink_h_raide
			jmp returnas_f15
		
	sp_00_f15_w1:
		cmp modd, 00000000b
		je modd00_w1_f15
		cmp modd, 00000001b
		je modd01_w1_f15
		jne modd10_w1_f15
		
		modd00_w1_f15:	
			call gamink_operanda_2b
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f15
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_nuli
			call spausdink_operanda_1b
			call spausdink_h_raide
			jmp returnas_f15
			
		modd01_w1_f15:
			call gamink_poslinki_1b
			call gamink_operanda_2b
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f15
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_nuli
			call spausdink_operanda_1b
			call spausdink_h_raide
			jmp returnas_f15
		modd10_w1_f15:
			call gamink_poslinki_2b
			call gamink_operanda_2b
			call spausdink_eilute_ok
			call gauk_operacijos_varda_f15
			call gauk_registro_varda_11_d1
			call spausdink_kableli
			call spausdink_nuli
			call spausdink_operanda_1b
			call spausdink_h_raide
			jmp returnas_f15
		
	
	returnas_f15:
		call spausdink_enteri
		RET
ENDP formuojam_pagal_penkiolikta_formata

PROC gauk_operacijos_varda_f15
	mov al, pirmas_baitas
	shr al, 1
	cmp al, 01100011b
	je sp_MOV_f15
	jne sp_TEST_f15
	
	sp_MOV_f15:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset k_MOV
		int 21h
		jmp gauk_k_v_f15_returnas
	sp_TEST_f15:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d
		mov dx, offset k_TEST
		int 21h
		jmp gauk_k_v_f15_returnas
	
	gauk_k_v_f15_returnas:
		RET
ENDP gauk_operacijos_varda_f15

PROC formuojam_pagal_sesiolikta_formata
	mov laikinas_baitas, al
	and al, 00000001b
	cmp al, 00000001b
	je w1_f16
	jne w0_f16
	
	w0_f16:
		mov w, 0
		jmp tesk_f16
		
	w1_f16:
		mov w, 1
		jmp tesk_f16
		
	tesk_f16:
		call po_baita
		mov laikinas_baitas, al
		shr al, 6
		and al, 00000011b
		mov modd, al
		
		mov al, laikinas_baitas
		and al, 00111000b
		shr al, 3
		mov reg, al
		
		mov al, laikinas_baitas
		and al, 00000111b
		mov rm, al
		
		cmp modd, 00000011b
		je sp_11_f16
		jne sp_00_f16
		
	sp_11_f16:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f16
		mov reg, 11100000b
		call gauk_registro_varda_11_d1
		jmp returnas_f16
	
	sp_00_f16:
		cmp modd, 00000000b
		je modd_00_f16
		cmp modd, 00000001b
		je modd_01_f16
		jne modd_10_f16
		
		modd_00_f16:
			call spausdink_eilute_ok
			jmp tesk_sp_00_f16
		modd_01_f16:
			call gamink_poslinki_1b
			call spausdink_eilute_ok
			jmp tesk_sp_00_f16
		modd_10_f16:
			call gamink_poslinki_2b
			call spausdink_eilute_ok
			jmp tesk_sp_00_f16
		
		tesk_sp_00_f16:
		call gauk_operacijos_varda_f16
		mov reg, 11100000b
		call gauk_registro_varda_00_d1
		jmp returnas_f16
		
	returnas_f16:
		call spausdink_enteri
		RET
ENDP formuojam_pagal_sesiolikta_formata

PROC gauk_operacijos_varda_f16
	cmp reg, 00000000b
	je sp_POP_f16_tarp
	cmp reg, 00000010b
	je sp_NOT_f16_tarp
	cmp reg, 00000011b
	je sp_NEG_f16_tarp
	cmp reg, 00000100b
	je sp_MUL_f16_tarp
	cmp reg, 00000101b
	je sp_IMUL_f16_tarp
	cmp reg, 00000110b
	je sp_DIVarPUSH_f16_tarp
	cmp reg, 00000111b
	je sp_IDIV_f16_tarp
	
	sp_POP_f16_tarp:
	jmp sp_POP_f16
	sp_NOT_f16_tarp:
	jmp sp_NOT_f16
	sp_NEG_f16_tarp:
	jmp sp_NEG_f16
	sp_MUL_f16_tarp:
	jmp sp_MUL_f16
	sp_IMUL_f16_tarp:
	jmp sp_IMUL_f16
	sp_DIVarPUSH_f16_tarp:
	jmp sp_DIVarPUSH_f16
	sp_IDIV_f16_tarp:
	jmp sp_IDIV_f16
	
	sp_POP_f16:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset k_POP
		int 21h
		jmp gauk_k_v_f16_returnas
	sp_NOT_f16:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset k_NOT
		int 21h
		jmp gauk_k_v_f16_returnas
	sp_NEG_f16:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset k_NEG
		int 21h
		jmp gauk_k_v_f16_returnas
	sp_MUL_f16:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset k_MUL
		int 21h
		jmp gauk_k_v_f16_returnas
	sp_IMUL_f16:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d
		mov dx, offset k_IMUL
		int 21h
		jmp gauk_k_v_f16_returnas
	sp_DIVarPUSH_f16:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		cmp pirmas_baitas, 11111111b
		je sp_PUSH_f16
		jne sp_DIV_f16
		
		sp_PUSH_f16:
		mov cx, 5d
		mov dx, offset k_PUSH
		int 21h
		jmp gauk_k_v_f16_returnas
		
		sp_DIV_f16:
		mov cx, 4d
		mov dx, offset k_DIV
		int 21h
		jmp gauk_k_v_f16_returnas
	sp_IDIV_f16:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d
		mov dx, offset k_IDIV
		int 21h
		jmp gauk_k_v_f16_returnas
	
	gauk_k_v_f16_returnas:
		RET
ENDP gauk_operacijos_varda_f16

PROC formuojam_pagal_septyniolikta_formata
	call po_baita
	mov laikinas_baitas, al
	shr al, 6
	and al, 00000011b
	mov modd, al
		
	mov al, laikinas_baitas
	and al, 00111000b
	shr al, 3
	mov reg, al
		
	mov al, laikinas_baitas
	and al, 00000111b
	mov rm, al
	
	call gamink_poslinki_2b
	call spausdink_eilute_ok
	call gauk_operacijos_varda_f17
	mov al, reg
	call print_reg_w1
	call spausdink_kableli
	call spausdink_poslinki_2b
	call spausdink_h_raide
	jmp returnas_f17
	
	returnas_f17:
		call spausdink_enteri
		RET
ENDP formuojam_pagal_septyniolikta_formata
	
PROC gauk_operacijos_varda_f17
	mov al, pirmas_baitas
	cmp al, 10001101b
	je sp_LEA_f17
	cmp al, 11000100b
	je sp_LES_f17
	cmp al, 11000101b
	je sp_LDS_f17
	
	sp_LEA_f17:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_LEA
		int 21h
		jmp gauk_k_v_f17_returnas
	sp_LES_f17:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_LES
		int 21h
		jmp gauk_k_v_f17_returnas
	sp_LDS_f17:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4h
		mov dx, offset k_LDS
		int 21h
		jmp gauk_k_v_f17_returnas
	
	gauk_k_v_f17_returnas:
		RET
ENDP gauk_operacijos_varda_f17

PROC formuojam_pagal_astuoniolikta_formata
	call po_baita
	mov byte ptr[laikinas_baitas], al
	
	shr al, 6
	and al, 00000011b
	mov modd, al
		
	mov al, byte ptr[laikinas_baitas]
	and al, 00111000b
	shr al, 3
	mov reg, al
		
	mov al, byte ptr[laikinas_baitas]
	and al, 00000111b
	mov rm, al
	
	cmp modd, 00000011b
	je sp_11_f18
	jne sp_00_f18
	
	sp_11_f18:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f18
		mov reg, 11110000b
		call gauk_registro_varda_11_d1
		jmp returnas_f18
		
	sp_00_f18:
	cmp modd, 00000000b
	je sp_000_f18
	cmp modd, 00000001b
	je sp_001_f18
	jne sp_010_f18
	
	sp_000_f18:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f18
		mov reg, 11110000b
		call gauk_registro_varda_00_d1
		jmp returnas_f18
	sp_001_f18:
		call gamink_poslinki_1b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f18
		mov reg, 11110000b
		call gauk_registro_varda_00_d1
		jmp returnas_f18	
	sp_010_f18:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f18
		mov reg, 11110000b
		call gauk_registro_varda_00_d1
		jmp returnas_f18
	
	returnas_f18:
		call spausdink_enteri
		RET
ENDP formuojam_pagal_astuoniolikta_formata	

PROC gauk_operacijos_varda_f18
	cmp reg, 00000010b
	je sp_CALL_f18_tarp
	cmp reg, 00000011b
	je sp_CALL_f18_tarp
	cmp reg, 00000100b
	je sp_JMP_f18_tarp
	cmp reg, 00000101b
	je sp_JMP_f18_tarp
	
	sp_CALL_f18_tarp:
	jmp sp_CALL_f18
	sp_JMP_f18_tarp:
	jmp sp_JMP_f18
	
	sp_CALL_f18:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d
		mov dx, offset k_CALL
		int 21h
		jmp gauk_k_v_f18_returnas
		
	sp_JMP_f18:
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset k_JMP
		int 21h
		jmp gauk_k_v_f18_returnas
	
	gauk_k_v_f18_returnas:
		RET
ENDP gauk_operacijos_varda_f18

PROC formuojam_pagal_devyniolikta_formata
	and al, 00000001b
	je w1_f19
	jne w0_f19
	
	w1_f19:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f19
		call spausdink_r_AX
		call spausdink_kableli
		call spausdink_poslinki_2b
		call spausdink_h_raide
		jmp returnas_f19
	w0_f19:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f19
		call spausdink_r_AL
		call spausdink_kableli
		call spausdink_poslinki_2b
		call spausdink_h_raide
		jmp returnas_f19
		
	
	returnas_f19:
		call spausdink_enteri
		RET
ENDP formuojam_pagal_devyniolikta_formata

PROC gauk_operacijos_varda_f19
	mov ah, 40h
	mov bx, duom_deskriptorius_rezultatas
	mov cx, 4d
	mov dx, offset k_MOV
	int 21h
	
	gauk_k_v_f19_returnas:
		RET
ENDP gauk_operacijos_varda_f19

PROC kviesk_pagal_moda_d1
	cmp modd, 00000000b
	je modd_00_d1_call
	cmp modd, 00000001b
	je modd_01_d1_call ; siunciu i ta pati 00, nes ten apdoroju visus 00, 01, 10
	cmp modd, 00000010b
	je modd_10_d1_call
	cmp modd, 11b
	je modd_11_d1_call
	
	modd_00_d1_call:
		cmp rm, 00000110b
		je tiesioginis_d1
		jne netiesioginis_d1
		
		tiesioginis_d1:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_00_d1
		jmp returnas_modas_d1
		
		netiesioginis_d1:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_00_d1
		jmp returnas_modas_d1
	modd_01_d1_call:
		call gamink_poslinki_1b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_00_d1
		jmp returnas_modas_d1
	modd_10_d1_call:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_00_d1
		jmp returnas_modas_d1
	modd_11_d1_call:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_11_d1
		jmp returnas_modas_d1
		
	returnas_modas_d1:
		RET
ENDP kviesk_pagal_moda_d1

PROC modd_00_d1
	call gauk_registro_varda_00_d1
	RET
ENDP modd_00_d1

PROC modd_01_d1
	call gauk_registro_varda_00_d1
	RET
ENDP modd_01_d1

PROC modd_10_d1
	call gauk_registro_varda_00_d1
	RET
ENDP modd_10_d1

PROC modd_11_d1
	call gauk_registro_varda_11_d1
	RET
ENDP modd_11_d1

PROC kviesk_pagal_moda_d0
	cmp modd, 00000000b
	je modd_00_d0_call
	cmp modd, 00000001b
	je modd_01_d0_call ; siunciu i ta pati 00, nes ten apdoroju visus 00, 01, 10
	cmp modd, 00000010b
	je modd_10_d0_call
	cmp modd, 11b
	je modd_11_d0_call
	
	modd_00_d0_call:
		cmp rm, 00000110b
		je tiesioginis_d0
		jne netiesioginis_d0
		tiesioginis_d0:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_00_d0
		jmp returnas_modas_d0
		
		netiesioginis_d0:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_00_d0
		jmp returnas_modas_d0
	modd_01_d0_call:
		call gamink_poslinki_1b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_01_d0
		jmp returnas_modas_d0
	modd_10_d0_call:
		call gamink_poslinki_2b
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_10_d0
		jmp returnas_modas_d0
	modd_11_d0_call:
		call spausdink_eilute_ok
		call gauk_operacijos_varda_f1
		call modd_11_d0
		jmp returnas_modas_d0
		
	returnas_modas_d0:
		RET
ENDP kviesk_pagal_moda_d0

PROC modd_00_d0
	call gauk_registro_varda_00_d0
	RET
ENDP modd_00_d0

PROC modd_01_d0
	call gauk_registro_varda_00_d0
	RET
ENDP modd_01_d0

PROC modd_10_d0
	call gauk_registro_varda_00_d0
	RET
ENDP modd_10_d0

PROC modd_11_d0
	call gauk_registro_varda_11_d0
	RET
ENDP modd_11_d0

PROC gauk_registro_varda_11_d1
	reg_cmp_d1: ; reg'as nusistato nrml
		cmp reg, 00000000b
		je reg_11_000_d1_tarp
		cmp reg, 00000001b
		je reg_11_001_d1_tarp
		cmp reg, 00000010b
		je reg_11_010_d1_tarp
		cmp reg, 00000011b
		je reg_11_011_d1_tarp
		cmp reg, 00000100b
		je reg_11_100_d1_tarp
		cmp reg, 00000101b
		je reg_11_101_d1_tarp
		cmp reg, 00000110b
		je reg_11_110_d1_tarp
		cmp reg, 00000111b
		je reg_11_111_d1_tarp
	
	jmp rm_cmp_d1
	
	reg_11_000_d1_tarp:
		jmp reg_11_000_d1
	reg_11_001_d1_tarp:
		jmp reg_11_001_d1
	reg_11_010_d1_tarp:
		jmp reg_11_010_d1
	reg_11_011_d1_tarp:
		jmp reg_11_011_d1
	reg_11_100_d1_tarp:
		jmp reg_11_100_d1
	reg_11_101_d1_tarp:
		jmp reg_11_101_d1
	reg_11_110_d1_tarp:
		jmp reg_11_110_d1
	reg_11_111_d1_tarp:
		jmp reg_11_111_d1
		
	rm_cmp_d1:
		cmp rm, 00000000b
		je tesk_11_000_d1_tarp
		cmp rm, 00000001b
		je tesk_11_001_d1_tarp
		cmp rm, 00000010b
		je tesk_11_010_d1_tarp
		cmp rm, 00000011b
		je tesk_11_011_d1_tarp
		cmp rm, 00000100b
		je tesk_11_100_d1_tarp
		cmp rm, 00000101b
		je tesk_11_101_d1_tarp
		cmp rm, 00000110b
		je tesk_11_110_d1_tarp
		cmp rm, 00000111b
		je tesk_11_111_d1_tarp
		
	tesk_11_000_d1_tarp:
		jmp tesk_11_000_d1
	tesk_11_001_d1_tarp:
		jmp tesk_11_001_d1
	tesk_11_010_d1_tarp:
		jmp tesk_11_010_d1
	tesk_11_011_d1_tarp:
		jmp tesk_11_011_d1
	tesk_11_100_d1_tarp:
		jmp tesk_11_100_d1
	tesk_11_101_d1_tarp:
		jmp tesk_11_101_d1
	tesk_11_110_d1_tarp:
		jmp tesk_11_110_d1
	tesk_11_111_d1_tarp:
		jmp tesk_11_111_d1
	
		reg_11_000_d1:
			cmp w, 1
			je w1_11_000_d1
			jne w0_11_000_d1
			w1_11_000_d1:
				call spausdink_r_AX
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_000_d1:
				call spausdink_r_AL
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_000_d1:
				cmp w, 1
				je w1_11_000_d1_rm
				jne w0_11_000_d1_rm
				w1_11_000_d1_rm:
					call spausdink_r_AX
					jmp returnas_vardas_11_d1
				w0_11_000_d1_rm:
					call spausdink_r_AL
					jmp returnas_vardas_11_d1
		reg_11_001_d1:
			cmp w, 1
			je w1_11_001_d1
			jne w0_11_001_d1
			w1_11_001_d1:
				call spausdink_r_CX
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_001_d1:
				call spausdink_r_CL
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_001_d1:
			cmp w, 1
				je w1_11_001_d1_rm
				jne w0_11_001_d1_rm
				w1_11_001_d1_rm:
					call spausdink_r_CX
					jmp returnas_vardas_11_d1
				w0_11_001_d1_rm:
					call spausdink_r_CL
					jmp returnas_vardas_11_d1
		reg_11_010_d1:
			cmp w, 1
			je w1_11_010_d1
			jne w0_11_010_d1
			w1_11_010_d1:
				call spausdink_r_DX
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_010_d1:
				call spausdink_r_DL
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_010_d1:
			cmp w, 1
				je w1_11_010_d1_rm
				jne w0_11_010_d1_rm
				w1_11_010_d1_rm:
					call spausdink_r_DX
					jmp returnas_vardas_11_d1
				w0_11_010_d1_rm:
					call spausdink_r_DL
					jmp returnas_vardas_11_d1
		reg_11_011_d1:
			cmp w, 1
			je w1_11_011_d1
			jne w0_11_011_d1
			w1_11_011_d1:
				call spausdink_r_BX_reg
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_011_d1:
				call spausdink_r_BL
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_011_d1:
			cmp w, 1
				je w1_11_011_d1_rm
				jne w0_11_011_d1_rm
				w1_11_011_d1_rm:
					call spausdink_r_BX_reg
					jmp returnas_vardas_11_d1
				w0_11_011_d1_rm:
					call spausdink_r_BL
					jmp returnas_vardas_11_d1
		reg_11_100_d1:
			cmp w, 1
			je w1_11_100_d1
			jne w0_11_100_d1
			w1_11_100_d1:
				call spausdink_r_SP
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_100_d1:
				call spausdink_r_AH
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_100_d1:
			cmp w, 1
				je w1_11_100_d1_rm
				jne w0_11_100_d1_rm
				w1_11_100_d1_rm:
					call spausdink_r_SP
					jmp returnas_vardas_11_d1
				w0_11_100_d1_rm:
					call spausdink_r_AH
					jmp returnas_vardas_11_d1
		reg_11_101_d1:
			cmp w, 1
			je w1_11_101_d1
			jne w0_11_101_d1
			w1_11_101_d1:
				call spausdink_r_BP_reg
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_101_d1:
				call spausdink_r_CH
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_101_d1:
			cmp w, 1
				je w1_11_101_d1_rm
				jne w0_11_101_d1_rm
				w1_11_101_d1_rm:
					call spausdink_r_BP_reg
					jmp returnas_vardas_11_d1
				w0_11_101_d1_rm:
					call spausdink_r_CH
					jmp returnas_vardas_11_d1
		reg_11_110_d1:
			cmp w, 1
			je w1_11_110_d1
			jne w0_11_110_d1
			w1_11_110_d1:
				call spausdink_r_SI_reg
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_110_d1:
				call spausdink_r_DH
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_110_d1:
			cmp w, 1
				je w1_11_110_d1_rm
				jne w0_11_110_d1_rm
				w1_11_110_d1_rm:
					call spausdink_r_SI_reg
					jmp returnas_vardas_11_d1
				w0_11_110_d1_rm:
					call spausdink_r_DH
					jmp returnas_vardas_11_d1
		reg_11_111_d1:
			cmp w, 1
			je w1_11_111_d1
			jne w0_11_111_d1
			w1_11_111_d1:
				call spausdink_r_DI_reg
				call spausdink_kableli
				jmp rm_cmp_d1
			w0_11_111_d1:
				call spausdink_r_BH
				call spausdink_kableli
				jmp rm_cmp_d1
			tesk_11_111_d1:
			cmp w, 1
				je w1_11_111_d1_rm
				jne w0_11_111_d1_rm
				w1_11_111_d1_rm:
					call spausdink_r_DI_ad
					jmp returnas_vardas_11_d1
				w0_11_111_d1_rm:
					call spausdink_r_BH
					jmp returnas_vardas_11_d1
	
	returnas_vardas_11_d1:
		RET
ENDP gauk_registro_varda_11_d1

PROC gauk_registro_varda_11_d0
	rm_cmp_d0:
		cmp rm, 00000000b
		je tesk_11_000_d0_tarp
		cmp rm, 00000001b
		je tesk_11_001_d0_tarp
		cmp rm, 00000010b
		je tesk_11_010_d0_tarp
		cmp rm, 00000011b
		je tesk_11_011_d0_tarp
		cmp rm, 00000100b
		je tesk_11_100_d0_tarp
		cmp rm, 00000101b
		je tesk_11_101_d0_tarp
		cmp rm, 00000110b
		je tesk_11_110_d0_tarp
		cmp rm, 00000111b
		je tesk_11_111_d0_tarp
		
	jmp reg_cmp_d0
	
	tesk_11_000_d0_tarp:
		jmp tesk_11_000_d0
	tesk_11_001_d0_tarp:
		jmp tesk_11_001_d0
	tesk_11_010_d0_tarp:
		jmp tesk_11_010_d0
	tesk_11_011_d0_tarp:
		jmp tesk_11_011_d0
	tesk_11_100_d0_tarp:
		jmp tesk_11_100_d0
	tesk_11_101_d0_tarp:
		jmp tesk_11_101_d0
	tesk_11_110_d0_tarp:
		jmp tesk_11_110_d0
	tesk_11_111_d0_tarp:
		jmp tesk_11_111_d0

	reg_cmp_d0: ; reg'as nusistato nrml
		cmp reg, 00000000b
		je reg_11_000_d0_tarp
		cmp reg, 00000001b
		je reg_11_001_d0_tarp
		cmp reg, 00000010b
		je reg_11_010_d0_tarp
		cmp reg, 00000011b
		je reg_11_011_d0_tarp
		cmp reg, 00000100b
		je reg_11_100_d0_tarp
		cmp reg, 00000101b
		je reg_11_101_d0_tarp
		cmp reg, 00000110b
		je reg_11_110_d0_tarp
		cmp reg, 00000111b
		je reg_11_111_d0_tarp
	
	
	reg_11_000_d0_tarp:
		jmp reg_11_000_d0
	reg_11_001_d0_tarp:
		jmp reg_11_001_d0
	reg_11_010_d0_tarp:
		jmp reg_11_010_d0
	reg_11_011_d0_tarp:
		jmp reg_11_011_d0
	reg_11_100_d0_tarp:
		jmp reg_11_100_d0
	reg_11_101_d0_tarp:
		jmp reg_11_101_d0
	reg_11_110_d0_tarp:
		jmp reg_11_110_d0
	reg_11_111_d0_tarp:
		jmp reg_11_111_d0
	
		reg_11_000_d0:
			cmp w, 1
			je w1_11_000_d0
			jne w0_11_000_d0
			w1_11_000_d0:
				call spausdink_r_AX
				jmp returnas_vardas_11_d0
			w0_11_000_d0:
				call spausdink_r_AL
				jmp returnas_vardas_11_d0
			tesk_11_000_d0:
				cmp w, 1
				je w1_11_000_d0_rm
				jne w0_11_000_d0_rm
				w1_11_000_d0_rm:
					call spausdink_r_AX
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_000_d0_rm:
					call spausdink_r_AL
					call spausdink_kableli
					jmp reg_cmp_d0
		reg_11_001_d0:
			cmp w, 1
			je w1_11_001_d0
			jne w0_11_001_d0
			w1_11_001_d0:
				call spausdink_r_CX
				jmp returnas_vardas_11_d0
			w0_11_001_d0:
				call spausdink_r_CL
				jmp returnas_vardas_11_d0
			tesk_11_001_d0:
			cmp w, 1
				je w1_11_001_d0_rm
				jne w0_11_001_d0_rm
				w1_11_001_d0_rm:
					call spausdink_r_CX
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_001_d0_rm:
					call spausdink_r_CL
					call spausdink_kableli
					jmp reg_cmp_d0
		reg_11_010_d0:
			cmp w, 1
			je w1_11_010_d0
			jne w0_11_010_d0
			w1_11_010_d0:
				call spausdink_r_DX
				jmp returnas_vardas_11_d0
			w0_11_010_d0:
				call spausdink_r_DL
				jmp returnas_vardas_11_d0
			tesk_11_010_d0:
			cmp w, 1
				je w1_11_010_d0_rm
				jne w0_11_010_d0_rm
				w1_11_010_d0_rm:
					call spausdink_r_DX
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_010_d0_rm:
					call spausdink_r_DL
					call spausdink_kableli
					jmp reg_cmp_d0
		reg_11_011_d0:
			cmp w, 1
			je w1_11_011_d0
			jne w0_11_011_d0
			w1_11_011_d0:
				call spausdink_r_BX_reg
				jmp returnas_vardas_11_d0
			w0_11_011_d0:
				call spausdink_r_BL
				jmp returnas_vardas_11_d0
			tesk_11_011_d0:
			cmp w, 1
				je w1_11_011_d0_rm
				jne w0_11_011_d0_rm
				w1_11_011_d0_rm:
					call spausdink_r_BX_reg
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_011_d0_rm:
					call spausdink_r_BL
					call spausdink_kableli
					jmp reg_cmp_d0
		reg_11_100_d0:
			cmp w, 1
			je w1_11_100_d0
			jne w0_11_100_d0
			w1_11_100_d0:
				call spausdink_r_SP
				jmp returnas_vardas_11_d0
			w0_11_100_d0:
				call spausdink_r_AH
				jmp returnas_vardas_11_d0
			tesk_11_100_d0:
			cmp w, 1
				je w1_11_100_d0_rm
				jne w0_11_100_d0_rm
				w1_11_100_d0_rm:
					call spausdink_r_SP
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_100_d0_rm:
					call spausdink_r_AH
					call spausdink_kableli
					jmp reg_cmp_d0
		reg_11_101_d0:
			cmp w, 1
			je w1_11_101_d0
			jne w0_11_101_d0
			w1_11_101_d0:
				call spausdink_r_BP_reg
				jmp returnas_vardas_11_d0
			w0_11_101_d0:
				call spausdink_r_CH
				jmp returnas_vardas_11_d0
			tesk_11_101_d0:
			cmp w, 1
				je w1_11_101_d0_rm
				jne w0_11_101_d0_rm
				w1_11_101_d0_rm:
					call spausdink_r_BP_reg
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_101_d0_rm:
					call spausdink_r_CH
					call spausdink_kableli
					jmp reg_cmp_d0
		reg_11_110_d0:
			cmp w, 1
			je w1_11_110_d0
			jne w0_11_110_d0
			w1_11_110_d0:
				call spausdink_r_SI_reg
				jmp returnas_vardas_11_d0
			w0_11_110_d0:
				call spausdink_r_DH
				jmp returnas_vardas_11_d0
			tesk_11_110_d0:
			cmp w, 1
				je w1_11_110_d0_rm
				jne w0_11_110_d0_rm
				w1_11_110_d0_rm:
					call spausdink_r_SI_reg
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_110_d0_rm:
					call spausdink_r_DH
					call spausdink_kableli
					jmp reg_cmp_d0
		reg_11_111_d0:
			cmp w, 1
			je w1_11_111_d0
			jne w0_11_111_d0
			w1_11_111_d0:
				call spausdink_r_DI_reg
				jmp returnas_vardas_11_d0
			w0_11_111_d0:
				call spausdink_r_BH
				jmp returnas_vardas_11_d0
			tesk_11_111_d0:
			cmp w, 1
				je w1_11_111_d0_rm
				jne w0_11_111_d0_rm
				w1_11_111_d0_rm:
					call spausdink_r_DI_reg
					call spausdink_kableli
					jmp reg_cmp_d0
				w0_11_111_d0_rm:
					call spausdink_r_BH
					call spausdink_kableli
					jmp reg_cmp_d0
	
	returnas_vardas_11_d0:
		RET
ENDP gauk_registro_varda_11_d0

PROC gauk_registro_varda_00_d0
	rm_cmp_00_d0:
		cmp rm, 00000000b
		je tesk_00_000_d0_tarp
		cmp rm, 00000001b
		je tesk_00_001_d0_tarp
		cmp rm, 00000010b
		je tesk_00_010_d0_tarp
		cmp rm, 00000011b
		je tesk_00_011_d0_tarp
		cmp rm, 00000100b
		je tesk_00_100_d0_tarp
		cmp rm, 00000101b
		je tesk_00_101_d0_tarp
		cmp rm, 00000110b
		je tesk_00_110_d0_tarp
		cmp rm, 00000111b
		je tesk_00_111_d0_tarp
	
	tesk_00_000_d0_tarp:
		jmp tesk_00_000_d0
	tesk_00_001_d0_tarp:
		jmp tesk_00_001_d0
	tesk_00_010_d0_tarp:
		jmp tesk_00_010_d0
	tesk_00_011_d0_tarp:
		jmp tesk_00_011_d0
	tesk_00_100_d0_tarp:
		jmp tesk_00_100_d0
	tesk_00_101_d0_tarp:
		jmp tesk_00_101_d0
	tesk_00_110_d0_tarp:
		jmp tesk_00_110_d0
	tesk_00_111_d0_tarp:
		jmp tesk_00_111_d0

	reg_cmp_00_d0: ; reg'as nusistato nrml
		cmp reg, 00000000b
		je reg_00_000_d0_tarp
		cmp reg, 00000001b
		je reg_00_001_d0_tarp
		cmp reg, 00000010b
		je reg_00_010_d0_tarp
		cmp reg, 00000011b
		je reg_00_011_d0_tarp
		cmp reg, 00000100b
		je reg_00_100_d0_tarp
		cmp reg, 00000101b
		je reg_00_101_d0_tarp
		cmp reg, 00000110b
		je reg_00_110_d0_tarp
		cmp reg, 00000111b
		je reg_00_111_d0_tarp
	
	reg_00_000_d0_tarp:
		jmp reg_00_000_d0
	reg_00_001_d0_tarp:
		jmp reg_00_001_d0
	reg_00_010_d0_tarp:
		jmp reg_00_010_d0
	reg_00_011_d0_tarp:
		jmp reg_00_011_d0
	reg_00_100_d0_tarp:
		jmp reg_00_100_d0
	reg_00_101_d0_tarp:
		jmp reg_00_101_d0
	reg_00_110_d0_tarp:
		jmp reg_00_110_d0
	reg_00_111_d0_tarp:
		jmp reg_00_111_d0
	
		reg_00_000_d0:
			cmp w, 1
			je w1_00_000_d0
			jne w0_00_000_d0
			w1_00_000_d0:
				call spausdink_r_AX
				jmp returnas_vardas_00_d0
			w0_00_000_d0:
				call spausdink_r_AL
				jmp returnas_vardas_00_d0
			tesk_00_000_d0:
				call spausdink_byte_ptr
				call spausdink_r_BXSI
				call spausdink_kableli
			jmp reg_cmp_00_d0
		reg_00_001_d0:
			cmp w, 1
			je w1_00_001_d0
			jne w0_00_001_d0
			w1_00_001_d0:
				call spausdink_r_CX
				jmp returnas_vardas_00_d0
			w0_00_001_d0:
				call spausdink_r_CL
				jmp returnas_vardas_00_d0
			tesk_00_001_d0:
			call spausdink_byte_ptr
			call spausdink_r_BXDI
			call spausdink_kableli
			jmp reg_cmp_00_d0
		reg_00_010_d0:
			cmp w, 1
			je w1_00_010_d0
			jne w0_00_010_d0
			w1_00_010_d0:
				call spausdink_r_DX
				jmp returnas_vardas_00_d0
			w0_00_010_d0:
				call spausdink_r_DL
				jmp returnas_vardas_00_d0
			tesk_00_010_d0:
			call spausdink_byte_ptr
			call spausdink_r_BPSI
			call spausdink_kableli
			jmp reg_cmp_00_d0
		reg_00_011_d0:
			cmp w, 1
			je w1_00_011_d0
			jne w0_00_011_d0
			w1_00_011_d0:
				call spausdink_r_BX_reg
				jmp returnas_vardas_00_d0
			w0_00_011_d0:
				call spausdink_r_BL
				jmp returnas_vardas_00_d0
			tesk_00_011_d0:
			call spausdink_byte_ptr
			call spausdink_r_BPDI
			call spausdink_kableli
			jmp reg_cmp_00_d0
		reg_00_100_d0:
			cmp w, 1
			je w1_00_100_d0
			jne w0_00_100_d0
			w1_00_100_d0:
				call spausdink_r_SP
				jmp returnas_vardas_00_d0
			w0_00_100_d0:
				call spausdink_r_AH
				jmp returnas_vardas_00_d0
			tesk_00_100_d0:
			call spausdink_byte_ptr
			call spausdink_r_SI_ad
			call spausdink_kableli
			jmp reg_cmp_00_d0
		reg_00_101_d0:
			cmp w, 1
			je w1_00_101_d0
			jne w0_00_101_d0
			w1_00_101_d0:
				call spausdink_r_BP_reg
				jmp returnas_vardas_00_d0
			w0_00_101_d0:
				call spausdink_r_CH
				jmp returnas_vardas_00_d0
			tesk_00_101_d0:
			call spausdink_byte_ptr
			call spausdink_r_DI_ad
			call spausdink_kableli
			jmp reg_cmp_00_d0
		reg_00_110_d0:
			cmp w, 1
			je w1_00_110_d0
			jne w0_00_110_d0
			w1_00_110_d0:
				call spausdink_r_SI_reg
				jmp returnas_vardas_00_d0
			w0_00_110_d0:
				call spausdink_r_DH
				jmp returnas_vardas_00_d0
			tesk_00_110_d0:
			call spausdink_byte_ptr
			call spausdink_lauztini_is_kaires
			call spausdink_poslinki_2b
			call spausdink_h_raide
			call spausdink_lauztini_is_desines
			call spausdink_kableli
			jmp reg_cmp_00_d0
		reg_00_111_d0:
			cmp w, 1
			je w1_00_111_d0
			jne w0_00_111_d0
			w1_00_111_d0:
				call spausdink_r_DI_reg
				jmp returnas_vardas_00_d0
			w0_00_111_d0:
				call spausdink_r_BH
				jmp returnas_vardas_00_d0
			tesk_00_111_d0:
			call spausdink_byte_ptr
			call spausdink_r_BX_ad
			call spausdink_kableli
			jmp reg_cmp_00_d0
	
	returnas_vardas_00_d0:
		RET
ENDP gauk_registro_varda_00_d0

PROC gauk_registro_varda_00_d1
	
	reg_cmp_00_d1: ; reg'as nusistato nrml
		cmp reg, 00000000b
		je reg_00_000_d1_tarp
		cmp reg, 00000001b
		je reg_00_001_d1_tarp
		cmp reg, 00000010b
		je reg_00_010_d1_tarp
		cmp reg, 00000011b
		je reg_00_011_d1_tarp
		cmp reg, 00000100b
		je reg_00_100_d1_tarp
		cmp reg, 00000101b
		je reg_00_101_d1_tarp
		cmp reg, 00000110b
		je reg_00_110_d1_tarp
		cmp reg, 00000111b
		je reg_00_111_d1_tarp
	
	jmp rm_cmp_00_d1
	
	reg_00_000_d1_tarp:
		jmp reg_00_000_d1
	reg_00_001_d1_tarp:
		jmp reg_00_001_d1
	reg_00_010_d1_tarp:
		jmp reg_00_010_d1
	reg_00_011_d1_tarp:
		jmp reg_00_011_d1
	reg_00_100_d1_tarp:
		jmp reg_00_100_d1
	reg_00_101_d1_tarp:
		jmp reg_00_101_d1
	reg_00_110_d1_tarp:
		jmp reg_00_110_d1
	reg_00_111_d1_tarp:
		jmp reg_00_111_d1
	
	rm_cmp_00_d1:
		cmp rm, 00000000b
		je tesk_00_000_d1_tarp
		cmp rm, 00000001b
		je tesk_00_001_d1_tarp
		cmp rm, 00000010b
		je tesk_00_010_d1_tarp
		cmp rm, 00000011b
		je tesk_00_011_d1_tarp
		cmp rm, 00000100b
		je tesk_00_100_d1_tarp
		cmp rm, 00000101b
		je tesk_00_101_d1_tarp
		cmp rm, 00000110b
		je tesk_00_110_d1_tarp
		cmp rm, 00000111b
		je tesk_00_111_d1_tarp
		
	tesk_00_000_d1_tarp:
		jmp tesk_00_000_d1
	tesk_00_001_d1_tarp:
		jmp tesk_00_001_d1
	tesk_00_010_d1_tarp:
		jmp tesk_00_010_d1
	tesk_00_011_d1_tarp:
		jmp tesk_00_011_d1
	tesk_00_100_d1_tarp:
		jmp tesk_00_100_d1
	tesk_00_101_d1_tarp:
		jmp tesk_00_101_d1
	tesk_00_110_d1_tarp:
		jmp tesk_00_110_d1
	tesk_00_111_d1_tarp:
		jmp tesk_00_111_d1

		reg_00_000_d1:
			cmp w, 1
			je w1_00_000_d1
			jne w0_00_000_d1
			w1_00_000_d1:
				call spausdink_r_AX
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_000_d1:
				call spausdink_r_AL
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_000_d1:
				call spausdink_byte_ptr
				call spausdink_r_BXSI
			jmp returnas_vardas_00_d1
		reg_00_001_d1:
			cmp w, 1
			je w1_00_001_d1
			jne w0_00_001_d1
			w1_00_001_d1:
				call spausdink_r_CX
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_001_d1:
				call spausdink_r_CL
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_001_d1:
			call spausdink_byte_ptr
			call spausdink_r_BXDI
			jmp returnas_vardas_00_d1
		reg_00_010_d1:
			cmp w, 1
			je w1_00_010_d1
			jne w0_00_010_d1
			w1_00_010_d1:
				call spausdink_r_DX
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_010_d1:
				call spausdink_r_DL
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_010_d1:
			call spausdink_byte_ptr
			call spausdink_r_BPSI
			jmp returnas_vardas_00_d1
		reg_00_011_d1:
			cmp w, 1
			je w1_00_011_d1
			jne w0_00_011_d1
			w1_00_011_d1:
				call spausdink_r_BX_reg
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_011_d1:
				call spausdink_r_BL
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_011_d1:
			call spausdink_byte_ptr
			call spausdink_r_BPDI
			jmp returnas_vardas_00_d1
		reg_00_100_d1:
			cmp w, 1
			je w1_00_100_d1
			jne w0_00_100_d1
			w1_00_100_d1:
				call spausdink_r_SP
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_100_d1:
				call spausdink_r_AH
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_100_d1:
			call spausdink_byte_ptr
			call spausdink_r_SI_ad
			jmp returnas_vardas_00_d1
		reg_00_101_d1:
			cmp w, 1
			je w1_00_101_d1
			jne w0_00_101_d1
			w1_00_101_d1:
				call spausdink_r_BP_reg
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_101_d1:
				call spausdink_r_CH
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_101_d1:
			call spausdink_byte_ptr
			call spausdink_r_DI_ad
			jmp returnas_vardas_00_d1
		reg_00_110_d1:
			cmp w, 1
			je w1_00_110_d1
			jne w0_00_110_d1
			w1_00_110_d1:
				call spausdink_r_SI_reg
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_110_d1:
				call spausdink_r_DH
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_110_d1:
			call spausdink_byte_ptr
			call spausdink_lauztini_is_kaires
			call spausdink_poslinki_2b
			call spausdink_h_raide
			call spausdink_lauztini_is_desines
			jmp returnas_vardas_00_d1
		reg_00_111_d1:
			cmp w, 1
			je w1_00_111_d1
			jne w0_00_111_d1
			w1_00_111_d1:
				call spausdink_r_DI_reg
				call spausdink_kableli
				jmp rm_cmp_00_d1
			w0_00_111_d1:
				call spausdink_r_BH
				call spausdink_kableli
				jmp rm_cmp_00_d1
			tesk_00_111_d1:
			call spausdink_byte_ptr
			call spausdink_r_BX_ad
			jmp returnas_vardas_00_d1
	
	returnas_vardas_00_d1:
		RET
ENDP gauk_registro_varda_00_d1

PROC print_reg_w0
    push ax
    push bx
    push cx
    push dx
    
    test al, 100b
    je pr_reg_w0_0xx
    jmp pr_reg_w0_1xx
    
        pr_reg_w0_0xx:
        test al, 10b
        je pr_reg_w1_00x_tarpinis
        jmp pr_reg_w1_01x
        
		pr_reg_w1_00x_tarpinis:
			jmp pr_reg_w1_00x
		
        pr_reg_w0_1xx:
        test al, 10b
        je pr_reg_w1_10x_tarpinis
        jmp pr_reg_w1_11x
        
            pr_reg_w0_00x:
            test al, 1b
            je pr_reg_w1_000_tarpinis
            jmp pr_reg_w1_001
            
			pr_reg_w1_10x_tarpinis:
				jmp pr_reg_w1_10x
			
            pr_reg_w0_01x:
            test al, 1b
            je pr_reg_w1_010_tarpinis
            jmp pr_reg_w1_011
            
            pr_reg_w0_10x:
            test al, 1b
            je pr_reg_w1_100_tarpinis
            jmp pr_reg_w1_101
            
            pr_reg_w0_11x:
            test al, 1b
            je pr_reg_w0_110
            jmp pr_reg_w0_111
            
			pr_reg_w1_100_tarpinis:
				jmp pr_reg_w1_100
			pr_reg_w1_010_tarpinis:
				jmp pr_reg_w1_010
			pr_reg_w1_000_tarpinis:
				jmp pr_reg_w1_000
				
                pr_reg_w0_000:
                call spausdink_r_AL
                jmp print_reg_w0_returnas
				
                pr_reg_w0_001:
                call spausdink_r_CL
                jmp print_reg_w0_returnas
                
                pr_reg_w0_010:
                call spausdink_r_DL
                jmp print_reg_w0_returnas
                
                pr_reg_w0_011:
                call spausdink_r_BL
                jmp print_reg_w0_returnas
                ;----
                pr_reg_w0_100:
                call spausdink_r_AH
                jmp print_reg_w0_returnas
                
                pr_reg_w0_101:
                call spausdink_r_CH
                jmp print_reg_w0_returnas
                
                pr_reg_w0_110:
                call spausdink_r_DH
                jmp print_reg_w0_returnas
                
                pr_reg_w0_111:
                call spausdink_r_BH
                jmp print_reg_w0_returnas
                
    print_reg_w0_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET  
ENDP print_reg_w0

PROC print_reg_w1
    push ax
    push bx
    push cx
    push dx
    
    test al, 100b
    je pr_reg_w1_0xx
    jmp pr_reg_w1_1xx
    
        pr_reg_w1_0xx:
        test al, 10b
        je pr_reg_w1_00x
        jmp pr_reg_w1_01x
        
        pr_reg_w1_1xx:
        test al, 10b
        je pr_reg_w1_10x
        jmp pr_reg_w1_11x
        
            pr_reg_w1_00x:
            test al, 1b
            je pr_reg_w1_000
            jmp pr_reg_w1_001
            
            pr_reg_w1_01x:
            test al, 1b
            je pr_reg_w1_010
            jmp pr_reg_w1_011
            
            pr_reg_w1_10x:
            test al, 1b
            je pr_reg_w1_100
            jmp pr_reg_w1_101
            
            pr_reg_w1_11x:
            test al, 1b
            je pr_reg_w1_110
            jmp pr_reg_w1_111
            
                pr_reg_w1_000:
                call spausdink_r_AX
                jmp print_reg_w1_returnas
                
                pr_reg_w1_001:
                call spausdink_r_CX
                jmp print_reg_w1_returnas
                
                pr_reg_w1_010:
                call spausdink_r_DX
                jmp print_reg_w1_returnas
                
                pr_reg_w1_011:
                call spausdink_r_BX_reg
                jmp print_reg_w1_returnas
                ;----
                pr_reg_w1_100:
                call spausdink_r_SP
                jmp print_reg_w1_returnas
                
                pr_reg_w1_101:
                call spausdink_r_BP_reg
                jmp print_reg_w1_returnas
                
                pr_reg_w1_110:
                call spausdink_r_SI_reg
                jmp print_reg_w1_returnas
                
                pr_reg_w1_111:
                call spausdink_r_DI_reg
                jmp print_reg_w1_returnas
    
    print_reg_w1_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET  
ENDP print_reg_w1
; al reg reiksme isskaido ir ideda i dx, dabar galima dx spausdinti kaip 16-taini sk
PROC padalink_al_i_dx
	push ax
		mov ah, 0
		mov dl, 10h
		div dl
		cmp al, 9
		jg raide_ale
		add al, 30h
		jmp al_baigtas
		raide_ale:
		add al, 37h
		
		al_baigtas:
		cmp ah, 9
		jg raide_ahe
		add ah, 30h
		jmp ah_baigtas
		raide_ahe:
		add ah, 37h
		
		ah_baigtas:
		mov dx, ax
	pop ax
	RET
ENDP padalink_al_i_dx
	

PROC pagamink_sesioliktaini_koda
	push ax
	push bx
	push dx
	xor bx, bx
		mov bl, dabartines_op_baitai
		mov al, byte ptr [operacijos_kodas]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_op_kodas+bx], dl
		mov byte ptr[spausdinimui_paruostas_op_kodas+bx+1], dh
		add bl, 2
		mov dabartines_op_baitai, bl

	pop dx
	pop bx
	pop ax
	RET
ENDP pagamink_sesioliktaini_koda	
	
PROC pagamink_sesioliktaini_numeri
	push ax
	push dx
		mov al, byte ptr[operacijos_numeris+1]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_op_numeris], dl
		mov byte ptr[spausdinimui_paruostas_op_numeris + 1], dh
		mov al, byte ptr[operacijos_numeris]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_op_numeris + 2], dl
		mov byte ptr[spausdinimui_paruostas_op_numeris + 3], dh
	pop dx
	pop ax
	RET
ENDP pagamink_sesioliktaini_numeri
	
PROC spausdink_eilute_ip
	push ax
	push bx
	push cx
	push dx
		call pagamink_sesioliktaini_numeri
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 8d
		mov dx, offset spausdinimui_paruostas_op_numeris
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_eilute_ip

PROC spausdink_eilute_ok
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 16d ; max 8 baitai, bet cia word'ai gali but, tai 16
		mov dx, offset spausdinimui_paruostas_op_kodas
		int 21h
		
	call isvalyk_eilute_ok
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_eilute_ok

PROC spausdink_komanda_neatpazinta
	push ax
	push bx
	push cx
	push dx
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 19d
		mov dx, offset komanda_neatpazinta
		int 21h
		call spausdink_enteri
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_komanda_neatpazinta

PROC isvalyk_eilute_ok
	push bx
	push cx
	xor bx, bx
		mov bl, byte ptr [dabartines_op_baitai]
		mov cx, bx
		inc cx
		valyk:
			mov byte ptr [spausdinimui_paruostas_op_kodas+bx], ' '
			dec bx
			loop valyk
		mov dabartines_op_baitai, 0
	pop cx
	pop bx
	RET
ENDP isvalyk_eilute_ok

PROC spausdink_enteri
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d ; enteris
		mov dx, offset ent
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_enteri

PROC spausdink_atpazinau
	push ax
	push bx
	push cx
	push dx
		call spausdink_eilute_ok
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 17d 
		mov dx, offset komanda_atpazinta
		int 21h
		call spausdink_enteri
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_atpazinau

PROC spausdink_operacija
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset dabartine_komanda
		int 21h
		
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_operacija

;REGISTRU SPAUSDINIMAS

PROC spausdink_r_AX
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_AX
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_AX

PROC spausdink_r_AL
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_AL
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_AL

PROC spausdink_r_CX
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_CX
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_CX

PROC spausdink_r_CL
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_CL
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_CL

PROC spausdink_r_DX
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_DX
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_DX

PROC spausdink_r_DL
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_DL
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_DL

PROC spausdink_r_BX_reg
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_BX
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_BX_reg

PROC spausdink_r_BL
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_BL
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_BL

PROC spausdink_r_SP
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_SP
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_SP

PROC spausdink_r_AH
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_AH
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_AH

PROC spausdink_r_BP_reg
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_BP
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_BP_reg

PROC spausdink_r_CH
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_CH
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_CH

PROC spausdink_r_SI_reg
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_SI
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_SI_reg

PROC spausdink_r_DH
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_DH
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_DH

PROC spausdink_r_DI_reg
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_DI
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_DI_reg

PROC spausdink_r_BH
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_BH
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_BH

;EFEKTYVUS ADRESAI
PROC spausdink_r_BXSI
	push ax
	push bx
	push cx
	push dx
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset r_BXSI
		int 21h
		
		cmp modd, 00000010b ; 2baitu poslinkis
		je BXSI_pos2
		cmp modd, 00000001b ; 1baito poslinkis
		je BXSI_pos1
		cmp modd, 00000000b ; be poslinkio
		je BXSI_pos0
		
		BXSI_pos0:
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_BXSI_returnas
		
		BXSI_pos1:
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BXSI_returnas
		
		BXSI_pos2:
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BXSI_returnas
	
	spausdink_BXSI_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_BXSI

PROC spausdink_r_BXDI
	push ax
	push bx
	push cx
	push dx
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset r_BXDI
		int 21h
		
		cmp modd, 00000010b ; 2baitu poslinkis
		je BXDI_pos2
		cmp modd, 00000001b ; 1baito poslinkis
		je BXDI_pos1
		cmp modd, 00000000b ; be poslinkio
		je BXDI_pos0
		
		BXDI_pos0:
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_BXDI_returnas
		
		BXDI_pos1:
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BXDI_returnas
		
		BXDI_pos2:
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BXDI_returnas
	
	spausdink_BXDI_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_BXDI

PROC spausdink_r_BPSI
	push ax
	push bx
	push cx
	push dx
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset r_BPSI
		int 21h
		
		cmp modd, 00000010b ; 2baitu poslinkis
		je BPSI_pos2
		cmp modd, 00000001b ; 1baito poslinkis
		je BPSI_pos1
		cmp modd, 00000000b ; be poslinkio
		je BPSI_pos0
		
		BPSI_pos0:
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_BPSI_returnas
		
		BPSI_pos1:
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BPSI_returnas
		
		BPSI_pos2:
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BPSI_returnas
	
	spausdink_BPSI_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_BPSI

PROC spausdink_r_BPDI
	push ax
	push bx
	push cx
	push dx
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 5d 
		mov dx, offset r_BPDI
		int 21h
		
		cmp modd, 00000010b ; 2baitu poslinkis
		je BPDI_pos2
		cmp modd, 00000001b ; 1baito poslinkis
		je BPDI_pos1
		cmp modd, 00000000b ; be poslinkio
		je BPDI_pos0
		
		BPDI_pos0:
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_BPDI_returnas
		
		BPDI_pos1:
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BPDI_returnas
		
		BPDI_pos2:
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BPDI_returnas
	
	spausdink_BPDI_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_BPDI


PROC spausdink_r_SI_ad ; SI kaip efektyvus adresas
	push ax
	push bx
	push cx
	push dx
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_SI
		int 21h
		
		cmp modd, 00000010b ; 2baitu poslinkis
		je SI_ad_pos2
		cmp modd, 00000001b ; 1baito poslinkis
		je SI_ad_pos1
		cmp modd, 00000000b ; be poslinkio
		je SI_ad_pos0
		
		SI_ad_pos0:
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_SI_ad_returnas
		
		SI_ad_pos1:
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_SI_ad_returnas
		
		SI_ad_pos2:
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_SI_ad_returnas
	
	spausdink_SI_ad_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_SI_ad

PROC spausdink_r_DI_ad
	push ax
	push bx
	push cx
	push dx
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_DI
		int 21h
		
		cmp modd, 00000010b ; 2baitu poslinkis
		je DI_ad_pos2
		cmp modd, 00000001b ; 1baito poslinkis
		je DI_ad_pos1
		cmp modd, 00000000b ; be poslinkio
		je DI_ad_pos0
		
		DI_ad_pos0:
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_DI_ad_returnas
		
		DI_ad_pos1:
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_DI_ad_returnas
		
		DI_ad_pos2:
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_DI_ad_returnas
	
	spausdink_DI_ad_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_DI_ad

PROC spausdink_r_BP_ad
	push ax
	push bx
	push cx
	push dx
		cmp modd, 00000010b ; 2baitu poslinkis
		je BP_ad_pos2_tarp
		cmp modd, 00000001b ; 1baito poslinkis
		je BP_ad_pos1_tarp
		cmp modd, 00000000b ; be poslinkio
		je BP_ad_pos0
		
		BP_ad_pos2_tarp:
			jmp BP_ad_pos2
		BP_ad_pos1_tarp:
			jmp BP_ad_pos1
		
		BP_ad_pos0: ; soausdinam tiesiogini adresa, nes modd yra 00
		call spausdink_lauztini_is_kaires ; [
		call spausdink_poslinki_2b ; dvieju baitu poslinkis bus tiesioginis adresas
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_BP_ad_returnas
		
		BP_ad_pos1:
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_BP
		int 21h
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BP_ad_returnas
		
		BP_ad_pos2:
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_BP
		int 21h
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BP_ad_returnas
	
	spausdink_BP_ad_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_BP_ad

PROC spausdink_r_BX_ad
	push ax
	push bx
	push cx
	push dx
		call spausdink_lauztini_is_kaires ; [
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_BX
		int 21h
		
		cmp modd, 00000010b ; 2baitu poslinkis
		je BX_ad_pos2
		cmp modd, 00000001b ; 1baito poslinkis
		je BX_ad_pos1
		cmp modd, 00000000b ; be poslinkio
		je BX_ad_pos0
		
		BX_ad_pos0:
		call spausdink_lauztini_is_desines ; ]
		jmp spausdink_BX_ad_returnas
		
		BX_ad_pos1:
		call spausdink_pliusa
		call spausdink_poslinki_1b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BX_ad_returnas
		
		BX_ad_pos2:
		call spausdink_pliusa
		call spausdink_poslinki_2b
		call spausdink_h_raide
		call spausdink_lauztini_is_desines
		jmp spausdink_BX_ad_returnas
	
	spausdink_BX_ad_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_r_BX_ad

;segmentiniai registrai
PROC spausdink_segmentini_reg
	push ax
	push bx
	push cx
	push dx
	xor bx, bx
	cmp r_seg, 1
	je seg_r1
	jne seg_r0
	
	seg_r1:
		cmp s_seg, 1
		je s1_r1_tarp
		jne s0_r1_tarp
	seg_r0:
		cmp s_seg, 1
		je s1_r0_tarp
		jne s0_r0_tarp
	s1_r1_tarp:
		call spausdink_r_DS
		jmp spausdink_segmentini_reg_returnas
	s1_r0_tarp:
		call spausdink_r_SS
		jmp spausdink_segmentini_reg_returnas
	s0_r1_tarp:
		call spausdink_r_CS
		jmp spausdink_segmentini_reg_returnas
	s0_r0_tarp:
		call spausdink_r_ES
		jmp spausdink_segmentini_reg_returnas
		
	spausdink_segmentini_reg_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP spausdink_segmentini_reg

PROC gauk_segmentini_reg
	push ax
	push bx
	push cx
	push dx
	xor bx, bx
	cmp r_seg, 1
	je seg_r1_gauk
	jne seg_r0_gauk
	
	seg_r1_gauk:
		cmp s_seg, 1
		je s1_r1_gauk_tarp
		jne s0_r1_gauk_tarp
	seg_r0_gauk:
		cmp s_seg, 1
		je s1_r0_gauk_tarp
		jne s0_r0_gauk_tarp
	s1_r1_gauk_tarp: ; DS
		mov al, r_DS
		mov prefixas, al 
		jmp gauk_segmentini_reg_returnas
	s1_r0_gauk_tarp: ; SS
		mov al, r_SS
		mov prefixas, al 
		jmp gauk_segmentini_reg_returnas
	s0_r1_gauk_tarp: ; CS
		mov al, r_CS
		mov prefixas, al 
		jmp gauk_segmentini_reg_returnas
	s0_r0_gauk_tarp: ; ES
		mov al, r_ES
		mov prefixas, al 
		jmp gauk_segmentini_reg_returnas
		
	gauk_segmentini_reg_returnas:
		pop dx
		pop cx
		pop bx
		pop ax
		RET
ENDP gauk_segmentini_reg

PROC spausdink_r_DS
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_DS
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_DS

PROC spausdink_r_SS
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_SS
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_SS

PROC spausdink_r_CS
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_CS
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_CS

PROC spausdink_r_ES
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset r_ES
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_r_ES

PROC gamink_poslinki_1b
	push ax
	push bx
	push cx
	push dx
	xor bx, bx
		call po_baita
		mov al, byte ptr[operacijos_kodas]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_poslinkis], dl
		mov byte ptr[spausdinimui_paruostas_poslinkis+1], dh
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP gamink_poslinki_1b

PROC gamink_poslinki_2b
	push ax
	push bx
	push cx
	push dx
	xor bx, bx
		call po_baita
		mov al, byte ptr[operacijos_kodas]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_poslinkis+2], dl
		mov byte ptr[spausdinimui_paruostas_poslinkis+3], dh

		call po_baita
		mov al, byte ptr[operacijos_kodas]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_poslinkis], dl
		mov byte ptr[spausdinimui_paruostas_poslinkis+1], dh
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP gamink_poslinki_2b

PROC spausdink_poslinki_1b
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset spausdinimui_paruostas_poslinkis
		int 21h
		
	call isvalyk_poslinki_1b
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_poslinki_1b

PROC spausdink_poslinki_2b
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset spausdinimui_paruostas_poslinkis
		int 21h
		
	call isvalyk_poslinki_2b
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_poslinki_2b

PROC isvalyk_poslinki_1b
	push bx
	push cx
	xor bx, bx
		mov bl, 2 ; 2 baitu poslinkis
		mov cx, bx
		inc cx
		valyk_1b:
			mov byte ptr [spausdinimui_paruostas_poslinkis+bx], ' '
			dec bx
			loop valyk_1b
	pop cx
	pop bx
	RET
ENDP isvalyk_poslinki_1b

PROC isvalyk_poslinki_2b
	push bx
	push cx
	xor bx, bx
		mov bl, 4 ; 2 baitu poslinkis
		mov cx, bx
		inc cx
		valyk_2b:
			mov byte ptr [spausdinimui_paruostas_poslinkis+bx], ' '
			dec bx
			loop valyk_2b
	pop cx
	pop bx
	RET
ENDP isvalyk_poslinki_2b

PROC spausdink_pliusa	
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 1d 
		mov dx, offset pliusas
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_pliusa

PROC spausdink_kableli	
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 1d 
		mov dx, offset kablelis
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_kableli

PROC spausdink_lauztini_is_kaires	
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 1d 
		mov dx, offset lauztinis_is_kaires
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_lauztini_is_kaires

PROC spausdink_lauztini_is_desines	
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 1d 
		mov dx, offset lauztinis_is_desines
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_lauztini_is_desines

PROC spausdink_h_raide
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 1d 
		mov dx, offset h_raide
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_h_raide

PROC spausdink_byte_ptr
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 8d
		mov dx, offset byte_ptr
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_byte_ptr

PROC spausdink_nuli
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 1d 
		mov dx, offset nuliukas
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_nuli

PROC pagamink_poslinki_jumpui
	push ax
	push dx
		mov al, byte ptr[laikinas_zodis+1]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_poslinkis_jumpui], dl
		mov byte ptr[spausdinimui_paruostas_poslinkis_jumpui + 1], dh
		mov al, byte ptr[laikinas_zodis]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_poslinkis_jumpui + 2], dl
		mov byte ptr[spausdinimui_paruostas_poslinkis_jumpui + 3], dh
	pop dx
	pop ax
	RET
ENDP pagamink_poslinki_jumpui

PROC spausdink_poslinki_jumpui
	push ax
	push bx
	push cx
	push dx
		call pagamink_poslinki_jumpui
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d
		mov dx, offset spausdinimui_paruostas_poslinkis_jumpui
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_poslinki_jumpui

PROC spausdink_dvitaski

ENDP spausdink_dvitaski
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d
		mov dx, offset dvitaskis
		int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	RET
PROC gamink_operanda_1b
	push ax
	push bx
	push cx
	push dx
	xor bx, bx
		cmp v, 1
		je spausdink_su_cl_1b
		jne tesk_1b
		
		spausdink_su_cl_1b:
			mov cl, 3
			mov al, cl
			call padalink_al_i_dx
			mov byte ptr[spausdinimui_paruostas_bo], dl
			mov byte ptr[spausdinimui_paruostas_bo+1], dh
			mov v, 0
			jmp returnas_1b
		
		tesk_1b:
			call po_baita
			mov al, byte ptr[operacijos_kodas]
			call padalink_al_i_dx
			mov byte ptr[spausdinimui_paruostas_bo], dl
			mov byte ptr[spausdinimui_paruostas_bo+1], dh
			jmp returnas_1b
		
	returnas_1b:
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP gamink_operanda_1b

PROC gamink_operanda_2b
	push ax
	push bx
	push cx
	push dx
	xor bx, bx
		call po_baita
		mov al, byte ptr[operacijos_kodas]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_bo+2], dl
		mov byte ptr[spausdinimui_paruostas_bo+3], dh

		call po_baita
		mov al, byte ptr[operacijos_kodas]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_bo], dl
		mov byte ptr[spausdinimui_paruostas_bo+1], dh
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP gamink_operanda_2b

PROC spausdink_operanda_1b
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 2d 
		mov dx, offset spausdinimui_paruostas_bo
		int 21h
		
	call isvalyk_operanda_1b
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_operanda_1b

PROC spausdink_operanda_2b
	push ax
	push bx
	push cx
	push dx
		mov ah, 40h
		mov bx, duom_deskriptorius_rezultatas
		mov cx, 4d 
		mov dx, offset spausdinimui_paruostas_bo
		int 21h
		
	call isvalyk_operanda_2b
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP spausdink_operanda_2b

PROC isvalyk_operanda_1b
	push bx
	push cx
	xor bx, bx
		mov bl, 2 ; 2 baitu poslinkis
		mov cx, bx
		inc cx
		valyk_op_1b:
			mov byte ptr [spausdinimui_paruostas_bo+bx], ' '
			dec bx
			loop valyk_op_1b
	pop cx
	pop bx
	RET
ENDP isvalyk_operanda_1b

PROC isvalyk_operanda_2b
	push bx
	push cx
	xor bx, bx
		mov bl, 4 ; 2 baitu poslinkis
		mov cx, bx
		inc cx
		valyk_op_2b:
			mov byte ptr [spausdinimui_paruostas_bo+bx], ' '
			dec bx
			loop valyk_op_2b
	pop cx
	pop bx
	RET
ENDP isvalyk_operanda_2b

PROC pagamink_bo_pletimui
	push ax
	push bx
	push cx
	push dx
	xor bx, bx
		call po_baita
		mov al, byte ptr[operacijos_kodas]
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_bo+2], dl
		mov byte ptr[spausdinimui_paruostas_bo+3], dh

		cmp al, 10000000b
		je pleciam_1
		jne pleciam_0
		
		pleciam_1:
		mov al, 0ffh
		pleciam_0:
		mov al, 0h
		nustatom_reiksme:
		call padalink_al_i_dx
		mov byte ptr[spausdinimui_paruostas_bo], dl
		mov byte ptr[spausdinimui_paruostas_bo+1], dh
	pop dx
	pop cx
	pop bx
	pop ax
	RET
ENDP pagamink_bo_pletimui

PROC po_baita
	push ax
	push bx
	push cx
	push dx
		mov ax, dabartine_pozicija
		mov bx, nuskaitytu_baitu_kiekis
		
		cmp ax, bx
		jb imk_is_buferio
		jmp skaityk_nauja_buferi
		
		imk_is_buferio:
			mov bx, offset buferis
			add bx, dabartine_pozicija
			
			mov al, [bx]
			mov baitukas, al
			
			inc dabartine_pozicija
		jmp baito_atidavimo_proceduros_pabaiga
		
		skaityk_nauja_buferi:
			mov ah, 3Fh
			mov bx, duom_deskriptorius_com
			mov cx, 512
			mov dx, offset buferis
			int 21h
			
			jc baito_atidavimo_proceduros_pabaiga
			mov nuskaitytu_baitu_kiekis, ax
			mov dabartine_pozicija, 0
			
			cmp nuskaitytu_baitu_kiekis, 0
			je failas_pasibaige
		jmp imk_is_buferio
		
		failas_pasibaige:
			mov ar_failas_baigesi, 1
		jmp baito_atidavimo_proceduros_pabaiga
		
		baito_atidavimo_proceduros_pabaiga:
		
		xor ax, ax
		mov ax, operacijos_numeris
		inc ax
		mov operacijos_numeris, ax
		
		xor ax, ax
		mov al, baitukas
		mov operacijos_kodas, al
		call pagamink_sesioliktaini_koda
		
		pop dx
		pop cx
		pop bx
		pop ax
			mov al, baitukas
			
		RET
	ENDP po_baita

PROC atidaryk_rezultatu_faila
	push ax
	push dx
		xor cx, cx
		mov ah, 3Ch ; create file with handle
		mov dx, offset rezultatu_failas
		int 21h
		jc failu_gedimas
		
		mov ah, 3Dh ; open file with handle
		mov al, 1 ; write only
		mov dx, offset rezultatu_failas
		int 21h
		jc failu_gedimas
		mov duom_deskriptorius_rezultatas, ax ; issaugomas file handle
			jc failu_gedimas
	pop dx
	pop ax
	RET
ENDP atidaryk_rezultatu_faila	
	
PROC uzdaryk_rezultatu_faila
	push ax
	push bx
		mov ah, 3Eh
		mov bx, duom_deskriptorius_rezultatas
		int 21h
		jc failu_gedimas
	pop bx
	pop ax
	RET
ENDP uzdaryk_rezultatu_faila	

PROC atidaryk_com_faila
	push ax
	push dx
		mov ah, 3Dh ; open file with handle
		mov al, 0 ; read only
		mov dx, offset com_failas
		int 21h
		;jc failu_gedimas
		mov duom_deskriptorius_com, ax ; issaugomas file handle
	pop dx
	pop ax
	RET
ENDP atidaryk_com_faila
	
PROC uzdaryk_com_faila
	push ax
	push bx
		mov ah, 3Eh
		mov bx, duom_deskriptorius_com
		int 21h
		;jc failu_gedimas
	pop bx
	pop ax
	RET
ENDP uzdaryk_com_faila	

PROC spausdink_pagalba
	mov ah, 9h
	mov dx, offset pagalbos_tekstas
	int 21h
	RET
	
ENDP spausdink_pagalba

failu_gedimas:
	mov ah, 9h
	mov dx, offset atidarymo_klaida
	int 21h
	jmp returnas
	
pagalbinis_isejimas:
	mov ah, 4ch
	mov al, 1
	int 21h
	
	
PROC returnas
	;retun'as i dos
	mov ah, 4ch
	mov al, 0
	int 21h	
ENDP returnas
end start
