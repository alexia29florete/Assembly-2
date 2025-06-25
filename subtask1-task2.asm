%include "../include/io.mac"

; declare your structs here

struc event
   name: resb 31        ;31 bytes
   valid: resb 1	;1 byte
   day: resb 1		;1 byte
   month: resb 1	;1 byte
   year: resw 1		;2 bytes
endstruc

section .data

section .text
    global check_events
    extern printf

check_events:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    xor edx, edx
start_loop:  
    cmp edx, ecx
    jge end_loop

     mov ax, word [ebx + year]
     ;verific daca anul este intre 1990 si 2030
     cmp ax, 1990
     jl not_valid
     cmp ax, 2030
     jg not_valid
     ;mov byte [ebx + valid], 1

     mov al, byte [ebx + month]
     ;verific daca luna este intre 1 si 12
     cmp al, 1
     jl not_valid
     cmp al, 12
     jg not_valid
     ;mov byte [ebx + valid], 1

     mov cl, byte [ebx + day]
     ;verific daca ziua corespunde lunii
     cmp al, 1
     je luna_cu_31
     cmp al, 3
     je luna_cu_31
     cmp al, 5
     je luna_cu_31
     cmp al, 7
     je luna_cu_31
     cmp al, 8
     je luna_cu_31
     cmp al, 10
     je luna_cu_31
     cmp al, 12
     je luna_cu_31
     cmp al, 4
     je luna_cu_30
     cmp al, 6
     je luna_cu_30
     cmp al, 9
     je luna_cu_30
     cmp al, 11
     je luna_cu_30
     cmp al, 2
     je luna_cu_28

luna_cu_31:
     cmp cl, 1
     jl not_valid
     cmp cl, 31
     jg not_valid
     jmp validare_eveniment

luna_cu_30:
     cmp cl, 1
     jl not_valid
     cmp cl, 30
     jg not_valid
     jmp validare_eveniment

luna_cu_28:
     cmp cl, 1
     jl not_valid
     cmp cl, 28
     jg not_valid
     jmp validare_eveniment

validare_eveniment:
     mov byte [ebx + valid], 1
     jmp continue
     
not_valid:
     mov byte [ebx + valid], 0
continue:
     add ebx, 36
     add edx, 1
     mov ecx, [ebp + 12]
     jmp start_loop
end_loop:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
