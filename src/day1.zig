const std = @import("std");

pub fn parseLine(input: []const u8) !i32 {
    const dir: i32 = if (input[0] == 'R') 1 else -1;
    return (try std.fmt.parseInt(i32, input[1..], 10)) * dir;
}

pub fn part1(input: []const u8) !usize {
    var val: i32 = 50;
    var counter: usize = 0;
    var iter = std.mem.tokenizeScalar(u8, input, '\n');
    while (iter.next()) |line| {
        const output: i32 = try parseLine(line);
        const sum = val + output;
        val = @rem(sum, 100);
        if (val < 0) {
            val = 100 + val;
        }
        if (val == 0) {
            counter += 1;
        }
        std.log.info("After '{s}' the value is {d} (count: {d}", .{ line, val, counter });
    }
    return counter;
}

pub fn part2(input: []const u8) !usize {
    var val: i32 = 50;
    var counter: usize = 0;
    var iter = std.mem.tokenizeScalar(u8, input, '\n');
    while (iter.next()) |line| {
        const output: i32 = try parseLine(line);
        const sum = val + output;
        const rem = @rem(sum, 100);
        const distance = if (output > 0 or val == 0) 100 - val else val;
        var clicks: usize = 0;
        const abs_output: i32 = @intCast(@abs(output));
        if (abs_output >= distance) {
            const diff = @abs(distance - abs_output);
            clicks = @as(usize, @intCast(@divTrunc(diff, 100))) + 1;
        }
        val = rem;
        if (val < 0) {
            val = 100 + val;
        }
        counter += clicks;
    }
    return counter;
}

test "given test part 1" {
    const day1_input =
        \\L68
        \\L30
        \\R48
        \\L5
        \\R60
        \\L55
        \\L1
        \\L99
        \\R14
        \\L82
    ;
    const output = try part1(day1_input);
    try std.testing.expectEqual(3, output);
}

test "given test part 2" {
    const day1_input =
        \\L68
        \\L30
        \\R48
        \\L5
        \\R60
        \\L55
        \\L1
        \\L99
        \\R14
        \\L82
    ;
    const output = try part2(day1_input);
    try std.testing.expectEqual(6, output);
}
