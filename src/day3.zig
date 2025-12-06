const std = @import("std");
pub const TEST_INPUT =
    \\987654321111111
    \\811111111111119
    \\234234234234278
    \\818181911112111
;

pub fn part1(input: []const u8) !usize {
    var lines_iter = std.mem.splitScalar(u8, input, '\n');
    var sum: usize = 0;
    while (lines_iter.next()) |full_line| {
        const line = std.mem.trim(u8, full_line, "\n");
        var buff: [2]u8 = undefined;
        var max1: ?u8 = null;
        var max2: ?u8 = null;
        for (0..line.len) |idx| {
            const dig = try std.fmt.charToDigit(line[idx], 10);
            if (max2 == null or dig > max2.?) {
                max2 = dig;
            }
            if (idx != line.len - 1 and (max1 == null or dig > max1.?)) {
                max1 = dig;
                max2 = null; // reset this guy
            }
        }
        buff[0] = std.fmt.digitToChar(max1.?, .lower);
        buff[1] = std.fmt.digitToChar(max2.?, .lower);
        sum += try std.fmt.parseInt(usize, &buff, 10);
    }
    return sum;
}

pub fn part2(input: []const u8) !usize {
    var lines_iter = std.mem.splitScalar(u8, input, '\n');
    var sum: usize = 0;
    while (lines_iter.next()) |full_line| {
        const line = std.mem.trim(u8, full_line, "\n");
        var buff: [2]u8 = undefined;
        var max1: ?u8 = null;
        var max2: ?u8 = null;
        for (0..line.len) |idx| {
            const dig = try std.fmt.charToDigit(line[idx], 10);
            if (max2 == null or dig > max2.?) {
                max2 = dig;
            }
            if (idx != line.len - 1 and (max1 == null or dig > max1.?)) {
                max1 = dig;
                max2 = null; // reset this guy
            }
        }
        buff[0] = std.fmt.digitToChar(max1.?, .lower);
        buff[1] = std.fmt.digitToChar(max2.?, .lower);
        sum += try std.fmt.parseInt(usize, &buff, 10);
    }
    return sum;
}

test "day 3 part 1" {
    const output = try part1(TEST_INPUT);
    try std.testing.expectEqual(357, output);
}

test "day 3 part 2" {
    const output = try part2(TEST_INPUT);
    try std.testing.expectEqual(3121910778619, output);
}
