const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const enable_tests = b.option(bool, "enable_tests", "Build package tests") orelse true;

    const zlua_dep = b.dependency("zlua", .{
        .target = target,
        .optimize = optimize,
    });

    const mod = b.addModule("zlua_portable", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    mod.addImport("c", zlua_dep.module("ziglua-c"));

    if (!enable_tests) return;

    const tests = b.addTest(.{
        .root_module = mod,
    });
    tests.linkLibC();
    tests.linkLibrary(zlua_dep.artifact("lua"));

    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run module tests");
    test_step.dependOn(&run_tests.step);
}
