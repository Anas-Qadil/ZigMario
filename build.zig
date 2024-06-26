const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig-sdl",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const sdl_path = "C:\\lib\\SDL2-2.26.4\\";
	// const lazy_path = b.dependencyPath(sdl_path, "include");


    exe.addIncludePath(.{.cwd_relative  = sdl_path ++ "include"});
    exe.addLibraryPath(.{.cwd_relative  = sdl_path ++ "lib\\x64"});
    
	// b.installBinFile(sdl_path ++ "lib\\x64\\SDL2.dll", "SDL2.dll");
	// b.getInstallStep().dependOn(&b.addInstallBinFile(.{ .cwd_relative = sdl_path ++ "lib\\x64\\SDL2.dll" }, "SDL2.dll"),);
	b.getInstallStep().dependOn(&b.addInstallBinFile(.{ .cwd_relative = sdl_path ++ "lib\\x64\\SDL2.dll" }, "SDL2.dll").step);



    exe.linkSystemLibrary("sdl2");
    exe.linkLibC();

	b.installArtifact(exe);

	const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

	if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

}