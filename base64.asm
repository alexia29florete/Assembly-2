%include "../include/io.mac"

extern printf
global base64

section .data
	alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
	fmt db "%d", 10, 0

section .text

base64:
	;; DO NOT MODIFY

    push ebp
    mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; source array
	mov ebx, [ebp + 12] ; n
	mov edi, [ebp + 16] ; dest array
	mov edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	; -- Your code starts here --
	;calulez lungime output (n / 3) * 4
	mov eax, ebx   ;eax = n
	xor edx, edx
	mov ecx, 3
	div ecx        ;eax = n / 3
	mov ecx, 4
	mul ecx        ;eax = (n / 3) * 4
	mov ecx, [ebp + 20]
	mov [ecx], eax       ;stochez lungimea outputului de iesire

	;resetez valorile
	xor ecx, ecx

start_loop:
	cmp ecx, ebx
	jge end_loop

	;pun primii 24 de biti
	xor eax, eax
	mov al, [esi + ecx]   ;pun primii 8 biti
	shl eax, 8
	mov al, [esi + ecx + 1]   ;pun al doilea grup de 8 biti
	shl eax, 8
	mov al, [esi + ecx + 2]   ;pun al treilea grup de 8 biti

	;procesez primii 6 biti (de la 18 la 23)
	mov edx, eax
	shr edx, 18
	;numarul obtinut din cei 6 biti indica pozitia din vectorul alphabet pe care se afla litera
	and edx, 00111111b      ;masca pentru 6 biti
	mov dl, [alphabet + edx]
	mov [edi], dl
	add edi, 1

	;procesez urmatorii 6 biti (de la 12 la 17)
	mov edx, eax
	shr edx, 12
	;numarul obtinut din cei 6 biti indica pozitia din vectorul alphabet pe care se afla litera
	and edx, 00111111b      ;masca pentru 6 biti
	mov dl, [alphabet + edx]
	mov [edi], dl
	add edi, 1

	;procesez urmatorii 6 biti (de la 6 la 11)
	mov edx, eax
	shr edx, 6
	;numarul obtinut din cei 6 biti indica pozitia din vectorul alphabet pe care se afla litera
	and edx, 00111111b      ;masca pentru 6 biti
	mov dl, [alphabet + edx]
	mov [edi], dl
	add edi, 1

	;procesez ultimii 6 biti (de la 0 la 5)
	mov edx, eax
	;numarul obtinut din cei 6 biti indica pozitia din vectorul alphabet pe care se afla litera
	and edx, 00111111b      ;masca pentru 6 biti
	mov dl, [alphabet + edx]
	mov [edi], dl
	add edi, 1

	add ecx, 3         ;ma duc la urmatorul grup de 3 bytes (urmatorul grup de 24 de biti)
	jmp start_loop
end_loop:

	; -- Your code ends here --


	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY
