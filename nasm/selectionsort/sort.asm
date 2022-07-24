extern printf
extern putchar

section .rodata
  unsorted   db "Default: ", 0x0
  sorted     db "Sorted:  ", 0x0
  intfmt     db "%d ", 0x0

section .data
  arr dd 0x4, 0x2, 0x9, 0x5, 0x7
  len db $ - arr

section .text
  global main

main:
  push rbp
  mov rbp, rsp

  xor rax, rax
  mov rdi, unsorted 
  mov esi, DWORD [len]
  call printf

  mov esi, DWORD [len]
  sar rsi, 0x2 ; divide by 4
  mov rdi, arr
  call print_arr

  mov rdi, arr
  mov esi, DWORD [len]
  sar esi, 0x2 ; divide by 4
  call selection_sort

  xor rax, rax
  mov rdi, sorted
  mov esi, DWORD [len]
  call printf

  mov esi, DWORD [len]
  sar esi, 0x2 ; divide by 4
  mov rdi, arr
  call print_arr

  xor rax, rax ; return 0

  leave
  ret

; Print int (4-byte) array
; @rdi address of the 4-byte array
; @rsi length of the 4-byte array
print_arr:
  push rbp
  mov rbp, rsp

  sub rsp, 0x20 ; 16-byte alignment

  mov [rbp - 0x8], rdi
  mov [rbp - 0x10], rsi

  xor rcx, rcx

  .loop:
    cmp ecx, DWORD [rbp - 0x10]
    je .endloop

    push rcx

      xor rax, rax ; no xmm
      mov rdi, intfmt

      ; take the next element
      ;
      ; size = 0x4
      ; array[rcx] = [rsi + rcx * size]
      mov rsi, QWORD [rbp - 0x8]
      lea rsi, [rsi + rcx * 0x4]
      mov esi, DWORD [rsi]
      call printf

    pop rcx

    inc ecx
    jmp .loop

  .endloop:
    mov edi, 0xA
    call putchar

  leave
  ret

; Find the smallest element
; @rdi address of the 4-byte array (int)
; @rsi length of the array
; 
; @rax index of the smallest element
smallest:
  cmp rsi, 0x0 ; bad length
  jle .endloop

  xor rax, rax ; the smallest index = 0
  xor rcx, rcx ; index starts with zero

  mov edx, DWORD [rdi] ; the smallest element

  .loop:
    inc rcx

    cmp rcx, rsi
    jg .endloop

    .if:
      mov r8d, DWORD [rdi + rcx * 0x4] ; take the next element
      cmp r8d, edx
      jg .endif

      ; if the element in r8d is less than
      ; the one in edx => (edx = r8d)
      mov edx, r8d 
      mov rax, rcx ; the smallest index

    .endif:
      jmp .loop

  .endloop:
  ret

; swap two integers (4-byte)
; @rdi address of the first int
; @rsi address of the second int
swap:
  cmp rdi, rsi ; ptrs are the same
  je .out

  mov r8d, DWORD [rdi]
  mov ecx, DWORD [rsi]

  mov DWORD [rdi], ecx
  mov DWORD [rsi], r8d

.out:
  ret

; sort array
; @rdi pointer to the array
; @rsi size of the array
; 
; @rax pointer of the sorted array
selection_sort:
  push rbp
  mov rbp, rsp

  sub rsp, 0x20 ; 16-byte alignment

  mov [rbp - 0x8], rdi ; pointer to the array
  mov [rbp - 0x10], rsi ; length of the array

  mov rdx, rsi
  xor rcx, rcx

  .loop:
    cmp rcx, rdx
    je .endloop

    push rdx
    push rcx

      mov rdi, QWORD [rbp - 0x8] ; ptr of the array 
      lea rdi, [rdi + rcx * 0x4] ; reduce the size of the array by 1
      mov esi, DWORD [rbp - 0x10] ; length of the array
      sub esi, ecx ; array is smaller by 1 so length should be as well
      call smallest

    pop rcx
    pop rdx

    add rax, rcx ; calculate absolute index

    mov rdi, QWORD [rbp - 0x8] ; ptr to array
    mov rsi, rdi

    lea rsi, [rdi + rcx * 0x4] ; first arg for swap
    lea rdi, [rdi + rax * 0x4] ; second arg for swap

    push rcx
    push rdx

      call swap

    pop rdx
    pop rcx

    inc rcx
    jmp .loop

  .endloop:
    mov rax, QWORD [rbp - 0x8] ; return the array ptr

  leave
  ret
