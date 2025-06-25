%include "../include/io.mac"

extern printf
global remove_numbers

section .data
	fmt db "%d", 10, 0

section .text

; function signature:
; void remove_numbers(int *a, int n, int *target, int *ptr_len);

remove_numbers:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     esi, [ebp + 8] ; source array
	mov     ebx, [ebp + 12] ; n
	mov     edi, [ebp + 16] ; dest array
	mov     edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	;; Your code starts here
	xor ecx, ecx
	mov dword [edx], 0             ;initializez lungimea cu 0
start_loop:
    cmp ecx, ebx
    jge end_loop
    mov eax, [esi + ecx * 4]        ;aici fac eax = a[i]
    ;verific daca numarul e impar - daca ultimul bit din reprezentarea binara este 1
    test eax, 1       ;cu ajutorul lui test pot face eax & 1
    jnz continue_loop

    ;verific daca e putere a lui 2 - daca exista un singur 1 in reprezentarea binara
    test eax, eax   ;daca valoarea curenta e 0
    jz continue_loop

    mov ebx, eax    ;pastrez o copie a lui eax in ebx
    dec eax
    test eax, ebx    ;fac x & (x-1)
    jz continue_loop

    ;adaug element in dest
    mov eax, [esi + ecx * 4] ;reinitializez valoarea lui eax pentru a il adauga in edi pt ca a fost stricat
    mov [edi], eax
    add edi, 4
    inc dword [edx]

continue_loop:
    mov ebx, [ebp + 12] ;restaurez valoarea lui ebx, regsitru folosit temporar pentru verificare putere 2
    add ecx, 1
    jmp start_loop
end_loop:
	;; Your code ends here

	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY
