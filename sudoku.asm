%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box
; you can declare any helper variables in .data or .bss
section .data
    frecventa times 9 db 0

section .text


; int check_row(char* sudoku, int row);
check_row:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int row 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    xor ecx, ecx     ;i = 0
    
outer_loop:
    cmp ecx, 8
    jge verifica

    mov ebx, ecx
    add ebx, 1    ;j = i + 1
inner_loop:
    cmp ebx, 9
    jge end_inner_loop

    ;sudoku[9 * linie + i]
    mov eax, edx
    imul eax, 9
    add eax, ecx
    ;mov al, [esi + eax]
    movzx edi, byte [esi + eax]

    ;sudoku[9 * linie + j]
    mov eax, edx
    imul eax, 9
    add eax, ebx
    ;mov bl, [esi + eax]
    movzx eax, byte [esi + eax]

    ;verifica daca numarul se afla intre 1 si 9
    cmp edi, 1
    jl nu_verifica
    cmp edi, 9
    jg nu_verifica
    cmp eax, 1
    jl nu_verifica
    cmp eax, 9
    jg nu_verifica
        
    ;verific ca doua elemente de pe aceeasi linie sa nu fie la fel
    cmp edi, eax
    je nu_verifica

    add ebx, 1
    jmp inner_loop
end_inner_loop:
    add ecx, 1
    jmp outer_loop

verifica:
    mov eax, 1
    jmp end_loop

nu_verifica:
    mov eax, 2
    jmp end_loop    
end_loop:

    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this row is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_row:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY

; int check_column(char* sudoku, int column);
check_column:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int column 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    xor ecx, ecx     ;i = 0
    
outer_loop_coloana:
    cmp ecx, 8
    jge verifica_coloana

    mov ebx, ecx
    add ebx, 1    ;j = i + 1
inner_loop_coloana:
    cmp ebx, 9
    jge end_inner_loop_coloana

    ;sudoku[9 * i + coloana]
    mov eax, ecx
    imul eax, 9
    add eax, edx
    ;mov al, [esi + eax]
    movzx edi, byte [esi + eax]

    ;sudoku[9 * j + coloana]
    mov eax, ebx
    imul eax, 9
    add eax, edx
    ;mov bl, [esi + eax]
    movzx eax, byte [esi + eax]

    ;verifica daca numarul se afla intre 1 si 9
    cmp edi, 1
    jl nu_verifica_coloana
    cmp edi, 9
    jg nu_verifica_coloana
    cmp eax, 1
    jl nu_verifica_coloana
    cmp eax, 9
    jg nu_verifica_coloana
        
    ;verific ca doua elemente de pe aceeasi coloana sa nu fie la fel
    cmp edi, eax
    je nu_verifica_coloana

    add ebx, 1
    jmp inner_loop_coloana
end_inner_loop_coloana:
    add ecx, 1
    jmp outer_loop_coloana

verifica_coloana:
    mov eax, 1
    jmp end_loop_coloana

nu_verifica_coloana:
    mov eax, 2
    jmp end_loop_coloana    
end_loop_coloana: 

    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this column is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_column:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY


; int check_box(char* sudoku, int box);
check_box:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int box 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    mov ecx, 9
    xor eax, eax
    lea edi, [frecventa]
loop_curatare:
    mov byte [edi], al
    inc edi
    loop loop_curatare

    xor ecx, ecx
    xor edi, edi   ;j=0

    mov al, dl
    mov cl, 3
    div cl         ;eax % 3
    mov al, ah
    mov ah, 0
    xor ecx, ecx

    cmp eax, 0     ;cutiile divizibile cu 3 (0, 3, 6)
    je coloana_0

    cmp eax, 1     ;cutiile (1, 4, 7) cu rest 1
    je coloana_3

    cmp eax, 2     ;cutiile (2, 5, 8) cu rest 2
    je coloana_6

coloana_0:
    mov ecx, 0
    jmp calcul_linie

coloana_3:
    mov ecx, 3
    jmp calcul_linie

coloana_6:
    mov ecx, 6
    jmp calcul_linie

calcul_linie:
    xor ebx, ebx
    mov eax, edx

    cmp eax, 3     ;cutiile (0, 1, 2) < 3 
    jl linia_0

    cmp eax, 6     ;cutiile 3 <= (3, 4, 5) < 6
    jl linia_3
    jge linia_6    ;cutiile (6, 7, 8) >= 6

linia_0:
    mov ebx, 0
    jmp end_calcule

linia_3:
    mov ebx, 3
    jmp end_calcule

linia_6:
    mov ebx, 6
    jmp end_calcule

end_calcule:
    xor edx, edx     ;i=0

outer_loop_cutie:
    cmp edx, 3
    jge verifica_cutie

    xor edi, edi
inner_loop_cutie:
    cmp edi, 3
    jge end_inner_loop_cutie

    ;9 * (linia + i) + (coloana +j)
    mov eax, ebx
    add eax, edx
    imul eax, 9
    add eax, ecx
    add eax, edi
    movzx eax, byte [esi + eax]      

    ;verifica daca numarul se afla intre 1 si 9
    cmp eax, 1
    jl nu_verifica_cutie
    cmp eax, 9
    jg nu_verifica_cutie
      
    ;verific ca daca numarul a mai fost intalnit
    sub eax, 1             ;pentru a putea incepe de la 0 la 9
    cmp byte [frecventa + eax], 1
    je nu_verifica_cutie

    ;a fost vazut
    mov byte [frecventa + eax], 1

    add edi, 1
    jmp inner_loop_cutie
end_inner_loop_cutie:
    add edx, 1
    jmp outer_loop_cutie    

verifica_cutie:
    mov eax, 1
    jmp end_loop_cutie

nu_verifica_cutie:
    mov eax, 2
    jmp end_loop_cutie

end_loop_cutie:



    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this box is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_box:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY
