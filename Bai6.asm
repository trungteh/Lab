section .data

	mse db 'Even Number',0xa
	mso db 'Odd Number',0xa
	section .bss
	num resb 1
	len1 resb 1
	section .text
	global _start
_start:
	mov eax,3
	mov ebx,0
	mov ecx,num
	mov edx,20
	int 0x80
	mov eax,num
	mov ebx,num

nextchar:
	cmp byte [eax], 0xa
	je finish
	inc eax
	jmp nextchar

finish:
	sub eax,ebx
	
	dec eax
	add ebx,eax
	mov ebx,[ebx]
	mov [len1],ebx
	
	mov eax,len1 
	mov eax,[eax]
	sub eax,'0'
	mov ebx,eax
	and ebx,1
	jz even
	mov eax,4
	mov ebx,1
	mov ecx,mso
	mov edx,11
	int 0x80
	jmp exit

even:

	mov eax, 4
	mov ebx, 1
	mov ecx,mse
	mov edx,12
	int 0x80

exit:
	mov eax,1
	int 0x80
