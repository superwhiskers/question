const builtin = @import("builtin");
const std = @import("std");
const io = std.io;
const mem = std.mem;
const heap = std.heap;

const ArrayList = std.ArrayList;
const Allocator = mem.Allocator;

fn question(allocator: Allocator, prompt: []const u8, valid: []const []const u8) ![]const u8 {
    const joined_valid = mem.join(allocator, ", ", valid);

    const stdout = io.getStdOut().writer();
    const stdin = io.getStdIn().reader();

    while (true) {
        try stdout.print("{s}\n", .{prompt});
        if (valid.len > 0) try stdout.print("({s})", .{joined_valid});
        try stdout.print(": ", .{});

        var line = ArrayList(u8).init(allocator);
        defer line.deinit();
        try stdin.readUntilDelimiterArrayList(&line, '\n', std.math.maxInt(u64));
        const input = mem.trimRight(u8, line.items, "\r");

        if (valid.len == 0) return input;

        for (valid) |elem| {
            if (mem.eql(u8, elem, input)) {
                return input;
            }
        }

        try stdout.print("\"{s}\" is not a valid answer\n", .{input});
    }

    return "";
}

pub fn main() !void {
    var arena_instance = heap.ArenaAllocator.init(heap.page_allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();

    _ = try question(arena, "foo", &[_][]const u8{ "bar", "baz" });
}
