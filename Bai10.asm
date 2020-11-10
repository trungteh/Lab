section .data
	file_name db 'demo.txt'
	msg db 'Hom nay toi hoc lap trinh assembly'
	len equ $-msg
section .bss
	fd_out resb 1
	fd_int resb 1
section .text
	global _start
_start:

	mov eax,8
	mov ebx,file_name
	mov ecx,0777
	mov edx,8
	int 0x80
	mov [fd_out],eax

	mov edx,len
	mov ecx,msg
	mov ebx,[fd_out]
	mov eax,4
	int 0x80

	mov eax, 6
	mov ebx,[fd_out]
	
	
	mov eax,1
	int 0x80
