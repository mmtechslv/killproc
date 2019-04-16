# killproc
Windows process killer written in Microsoft Macro Assembler (MASM)

# Prerequisites
- MASM => http://www.masm32.com/
- Microsoft Visual C++ 2005 Express Edition => https://www.microsoft.com/en-us/download/details.aspx?id=804

# Notes
- Current MASM version apparently have a bug in ASCII versions of kernel32.lib entiries such as Process32First or Process32Next. Therefore, make sure that you use kernel32.lib from libraries that belong to Visual C++ not MASM.

# Assembly
    $ ml /c /coff /Cp killproc.asm
# Linkage
    $ link /SUBSYSTEM:CONSOLE /LIBPATH:c:\masm32\lib killproc.obj


# Usage
    $ killproc [ProcessName].exe
# Example
    $ killproc notepad.exe
    