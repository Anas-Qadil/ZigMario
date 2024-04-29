const std = @import("std");
const c = @cImport({
    @cInclude("SDL.h");
});

pub fn main() !void {
    if (c.SDL_Init(c.SDL_INIT_VIDEO) != 0) {
        c.SDL_Log("Unable to initialize SDL: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    }
	std.debug.print("asdasda", .{});

	// create a windw
	const window = c.SDL_CreateWindow("Hello World", c.SDL_WINDOWPOS_CENTERED, c.SDL_WINDOWPOS_CENTERED, 640, 480, c.SDL_WINDOW_SHOWN);
	if (window == null) {
		c.SDL_Log("Unable to create window: %s", c.SDL_GetError());
		return error.SDLWindowCreationFailed;
	}

	// write a hello world on the window and keep it open
	const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_ACCELERATED);
	if (renderer == null) {
		c.SDL_Log("Unable to create renderer: %s", c.SDL_GetError());
		return error.SDLRendererCreationFailed;
	}

	const font = c.TTF_OpenFont("arial.ttf", 24);
	if (font == null) {
		c.SDL_Log("Unable to load font: %s", c.SDL_GetError());
		return error.SDLFontLoadFailed;
	}

	const color = c.SDL_Color{ .r = 255, .g = 255, .b = 255, .a = 255 };
	const surface = c.TTF_RenderText_Solid(font, "Hello, World!", color);
	const texture = c.SDL_CreateTextureFromSurface(renderer, surface);
	const rect = c.SDL_Rect{ .x = 0, .y = 0, .w = 640, .h = 480 };
	c.SDL_RenderCopy(renderer, texture, null, rect);
	c.SDL_RenderPresent(renderer);

	var running = true;
	while (running) {
		var event = c.SDL_Event{};
		while (c.SDL_PollEvent(&event) != 0) {
			if (event.type == c.SDL_QUIT) {
				running = false;
			}
		}
	}

	c.SDL_DestroyTexture(texture);
	c.SDL_FreeSurface(surface);
	c.TTF_CloseFont(font);
	c.SDL_DestroyRenderer(renderer);
	c.SDL_DestroyWindow(window);
	c.SDL_Quit();

	std.debug.print("Hello, World!\n", .{});
}

// build-exe -lsdl2 -ODebug -I C:\lib\SDL2-2.26.4\include -L C:\lib\SDL2-2.26.4\lib\x64 -Mroot=D:\code\ZigMario\src\main.zig -lc --name zig-sdl 

// build
// ..\zig-windows-x86-0.13.0-dev.46+3648d7df1\zig.exe build-exe -lsdl2 -ODebug -I C:\lib\SDL2-2.26.4\include -L C:\lib\SDL2-2.26.4\lib\x64 -Mroot=D:\code\ZigMario\src\main.zig -lc  --name zig-sdl

// run
// D:\code\ZigMario\zig-cache\o\f4f851cb6ff59e7e244e4afecaa4486f\build.exe ..\zig-windows-x86-0.13.0-dev.46+3648d7df1\zig.exe build-exe D:\code\ZigMario D:\code\ZigMario\zig-cache run 