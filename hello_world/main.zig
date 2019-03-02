const std = @import("std");

pub fn helloWorld() [14]u8 {
    return "Hello, World!\n";
}

pub fn main() !void {
    const stdout_file = try std.io.getStdOut();

    try stdout_file.write(helloWorld());
}