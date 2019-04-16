
.386
.model flat,stdcall
option casemap:none


includelib "C:\Program Files (x86)\Microsoft Visual Studio 8\VC\lib\kernel32.lib"
include /masm32/include/windows.inc
includelib /masm32/lib/user32.lib"
.data
hps HANDLE  NULL
oph HANDLE  NULL
p32 PROCESSENTRY32 <0>
.data?
cmdline LPSTR ?
clg WORD ?
.code 
start:

Process32First PROTO :DWORD,:DWORD
Process32Next PROTO :DWORD,:DWORD
ExitProcess PROTO STDCALL :DWORD
OpenProcess PROTO STDCALL :DWORD,:DWORD,:DWORD
GetCommandLineA PROTO STDCALL
lstrlenA PROTO STDCALL :DWORD
CreateToolhelp32Snapshot PROTO STDCALL :DWORD,:DWORD
lstrcmpA PROTO STDCALL :DWORD,:DWORD
TerminateProcess PROTO STDCALL :DWORD,:DWORD

xor ebx,ebx
invoke GetCommandLineA
mov cmdline, eax
invoke lstrlenA, cmdline
add eax,cmdline
looper:
mov bl, BYTE PTR DS:[eax]
cmp eax,cmdline
je exit
cmp bl, 20h
je doit
dec eax
jmp looper
doit:
inc eax
mov cmdline, eax
xor eax,eax
invoke CreateToolhelp32Snapshot, TH32CS_SNAPALL, NULL
mov hps,eax
cmp eax,INVALID_HANDLE_VALUE
je exit
mov p32.dwSize, sizeof PROCESSENTRY32
xor eax,eax
invoke Process32First, hps, offset p32
cmp eax,FALSE
je exit
xor eax,eax
invoke lstrcmpA,cmdline,offset p32.szExeFile
cmp eax,0
jnz nextone
call killproc
jmp exit

nextone:
mov p32.dwSize, sizeof PROCESSENTRY32
xor eax,eax
invoke Process32Next,hps,offset p32
cmp eax, FALSE
je exit
invoke lstrcmpA,cmdline, offset p32.szExeFile
cmp eax,0
jnz nextone
call killproc
jmp exit
exit:
invoke ExitProcess,NULL

killproc proc 
invoke OpenProcess,PROCESS_TERMINATE,FALSE,p32.th32ProcessID 
mov oph,eax
invoke TerminateProcess, oph,NULL


ret
killproc endp
end start
