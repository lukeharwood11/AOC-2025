const std = @import("std");
pub const TEST_INPUT: []const u8 = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124";

pub fn parseLine(input: []const u8) ![2]usize {
    var iter = std.mem.tokenizeScalar(u8, input, '-');
    return [2]usize{
        try std.fmt.parseInt(usize, iter.next().?, 10),
        try std.fmt.parseInt(usize, iter.next().?, 10),
    };
}

pub fn part1(input: []const u8) !usize {
    var iter = std.mem.tokenizeScalar(u8, input, ',');
    var sum: usize = 0;
    while (iter.next()) |range| {
        // const stripped = std.mem.trimEnd(u8, range, "\n");
        const arr = parseLine(range) catch |err| {
            std.log.info("'{s}'", .{range});
            return err;
        };

        for (arr[0]..(arr[1] + 1)) |id| {
            var buff: [30]u8 = undefined;
            const str = try std.fmt.bufPrint(&buff, "{}", .{id});
            const size = str.len;
            if (size & 1 == 1) {
                // odd numbers can't be invalid
                continue;
            }
            const mid_idx = size / 2;
            // std.log.info("ID: {d}, mid_idx: {d}, size: {d}", .{ id, mid_idx, size });
            const val1 = str[0..mid_idx];
            const val2 = str[mid_idx..];
            if (std.mem.eql(u8, val1, val2)) {
                sum += id;
            }
        }
    }
    return sum;
}

pub fn isFactor(length: usize, number: usize) bool {
    return (length % number) == 0;
}

pub fn part2(input: []const u8) !usize {
    var iter = std.mem.tokenizeScalar(u8, input, ',');
    var sum: usize = 0;
    while (iter.next()) |range| {
        // const stripped = std.mem.trimEnd(u8, range, "\n");
        const arr = parseLine(range) catch |err| {
            std.log.info("'{s}'", .{range});
            return err;
        };

        ids: for (arr[0]..(arr[1] + 1)) |id| {
            var buff: [30]u8 = undefined;
            const str = try std.fmt.bufPrint(&buff, "{}", .{id});
            const size = str.len;
            // get the factors given the length
            outer: for (1..size) |num| {
                if (isFactor(size, num)) {
                    // divide into num sections
                    var prev: ?[]const u8 = null;
                    for (0..(size / num)) |i| {
                        // ensure they're all the same
                        const curr = str[(num * i) .. (num * i) + num];
                        if (prev == null) {
                            prev = curr;
                        } else if (!std.mem.eql(u8, prev.?, curr)) {
                            continue :outer;
                        }
                    }
                    sum += id;
                    continue :ids;
                }
            }
        }
    }
    return sum;
}

test "day 2 part 1" {
    const output = try part1(TEST_INPUT);
    try std.testing.expectEqual(1227775554, output);
}

test "day 2 part 2" {
    const output = try part2(TEST_INPUT);
    try std.testing.expectEqual(4174379265, output);
}
