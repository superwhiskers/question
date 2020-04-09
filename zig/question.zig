const std = @import("std");

fn question(prompt: []const u8, valid: [][]const u8) anyerror![]u8 {
    while (true) {
        std.debug.warn("{}", prompt);
        if (valid.len != 0) {
            std.debug.warn(" (");
            for (valid) |s, i| {
                // check if item is last in list and if so don't append a comma
                if (i == (valid.len - 1)) {
                    std.debug.warn("{}", s);
                } else {
                    std.debug.warn("{}, ", s);
                }
            }
            std.debug.warn("): "); 
        } else {
            std.debug.warn(": ");
        }
        
        var buffer = try std.Buffer.init(std.debug.global_allocator, "");
        var input = try std.io.readLine(&buffer);

        if (valid.len == 0) { return input; }

        for (valid) |ele, i| {
            if (std.mem.eql(u8, ele, input)) {
                return input;
            }
        }

        std.debug.warn("\"{}\" is not a valid answer\n", input);
    }
}

pub fn main() anyerror!void {
    var valid = [][]const u8{"bar", "baz"};
    const _ = try question("foo", valid[0..]);
}
