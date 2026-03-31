const std = @import("std");

pub fn enabled() bool {
    const raw = std.c.getenv("ZLUA_PORTABLE_TRACE") orelse return false;
    const value = std.mem.sliceTo(raw, 0);
    return value.len == 0 or !std.mem.eql(u8, value, "0");
}

pub fn emitOnce(flag: *bool, comptime fmt: []const u8, args: anytype) void {
    if (flag.* or !enabled()) return;
    flag.* = true;
    std.debug.print("zlua_portable: " ++ fmt ++ "\n", args);
}
