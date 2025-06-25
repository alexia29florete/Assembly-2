%include "../include/io.mac"

; declare your structs here

struc event
   name: resb 31        ;31 bytes
   valid: resb 1	    ;1 byte
   day: resb 1		    ;1 byte
   month: resb 1	    ;1 byte
   year: resw 1		    ;2 bytes
endstruc

section .text
    global sort_events
    extern printf

sort_events:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here 

    ;implementez bubble sort
    xor esi, esi
outer_loop:
    mov ebx, [ebp + 8]  ;resetez pointerul la vector
    xor edx, edx        ;index-ul curent (bucla interioara)
inner_loop:
    mov eax, [ebp + 12]
    sub eax, esi
    dec eax
    cmp edx, eax        ;compar edx cu ecx - 1 - esi
    jge end_loop

    ;comparare valid
    mov al, [ebx + valid]
    mov ah, [ebx + 36 + valid]
    cmp al, ah
    jg nu_fac_schimbari
    jl sortare_evenimente
    jmp comparare_data

comparare_data:
    ;comparare an
    mov ax, word [ebx + year]             ;anul primului eveniment
    mov cx, word [ebx + 36 + year]        ;anul celui de-al doilea eveniment
    cmp ax, cx
    jl nu_fac_schimbari
    jg sortare_evenimente

    ;comparare luna
    mov al, byte [ebx + month]
    mov cl, byte [ebx + 36 + month]
    cmp al, cl
    jl nu_fac_schimbari
    jg sortare_evenimente

    ;comparare zi:
    mov al, byte [ebx + day]
    mov cl, byte [ebx + 36 + day]
    cmp al, cl
    jl nu_fac_schimbari
    jg sortare_evenimente
    
    xor ecx, ecx
    ;comparare nume
comparare_nume:
    mov al, [ebx + name + ecx]          ;un byte din numele primului eveniment
    mov ah, [ebx + 36 + name + ecx]     ;un byte din numele celui de al doilea eveniment
    cmp al, ah       
    jl nu_fac_schimbari
    jg sortare_evenimente
    inc ecx
    cmp ecx, 31
    jl comparare_nume            
    
sortare_evenimente:
    ;salvez pe stiva registrii pentru ca am nevoie ulterior de valori pe care le au acum
    push ebx
    push esi
    push edx
    ;trebuie facut swap intre evenimente
    mov esi, ebx        ;salvez primul eveniment
    mov edi, ebx        
    add edi, 36         ;salvez al doilea eveniment

    ;swap pentru valid
    mov al, [esi + valid]
    mov bl, [edi + valid]
    mov [esi + valid], bl
    mov [edi + valid], al

    ;swap pentru day
    mov al, [esi + day]
    mov bl, [edi + day]
    mov [esi + day], bl
    mov [edi + day], al

    ;swap pentru month
    mov al, [esi + month]
    mov bl, [edi + month]
    mov [esi + month], bl
    mov [edi + month], al  

    ;swap pentru year
    mov ax, [esi + year]
    mov bx, [edi + year]
    mov [esi + year], bx
    mov [edi + year], ax

    ;swap pentru nume 
    lea esi, [esi + name]
    lea edi, [edi + name]
    mov ecx, 31       ;dimensiunea campului nume
swap_nume:
    mov al, [esi]     ;un byte din numele primului eveniment
    mov bl, [edi]     ;un byte din numele celui de al doilea eveniment
    mov [esi], bl
    mov [edi], al
    inc esi           ;merg la urmatorul byte 
    inc edi           ;merg la urmatorul byte
    loop swap_nume    ;decrementez ecx si execut pana ecx ajunge la zero  
    pop edx
    pop esi     
    pop ebx

nu_fac_schimbari:
    add ebx, 36       ;merg la urmatorul eveniment
    add edx, 1        ;incrementez index
    jmp inner_loop
end_loop:
    add esi, 1
    mov ecx, [ebp + 12]        ;restaurez valoarea lui ecx cu lungimea 
    dec ecx
    cmp esi, ecx
    jl outer_loop
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
