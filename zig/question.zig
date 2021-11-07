const builtin = @import("builtin");
const std = @import("std");
const io = std.io;
const mem = std.mem;
const heap = std.heap;

const Allocator = mem.Allocator;

fn question(comptime T: u32, prompt: []const u8, valid: []const []const u8, allocator: *Allocator) ![]const u8 {
    const joined_valid = mem.join(allocator, ", ", valid);

    const stdout = io.getStdOut().writer();
    const stdin = io.getStdIn().reader();

    while (true) {
        try stdout.print("{s}", .{prompt});
        if (valid.len > 0) try stdout.print("({s})", .{joined_valid});
        try stdout.print(": ", .{});

        const line = try stdin.readUntilDelimiterAlloc(allocator, '\n', T);
        const input = mem.trimRight(u8, line, "\r\n");
        defer allocator.free(input);

        if (valid.len == 0) return input;

        for (valid) |elem, i| {
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
    const arena = &arena_instance.allocator;

    // 512 should be plenty
    // TODO: change the way the alloator works to not need set alloc amounts.
    _ = try question(512, "foo", &[_][]const u8{ "bar", "baz" }, arena);
    _ = try question(512, "foo", &[_][]const u8{}, arena);
}
