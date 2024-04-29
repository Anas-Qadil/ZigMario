

all:
	..\zig-windows-x86-0.13.0-dev.46+3648d7df1\zig.exe build-exe -lsdl2 -ODebug -I C:\lib\SDL2-2.26.4\include -L C:\lib\SDL2-2.26.4\lib\x64 -Mroot=D:\code\ZigMario\src\main.zig -lc  --name zig-sdl
	