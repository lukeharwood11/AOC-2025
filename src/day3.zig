const std = @import("std");
pub const TEST_INPUT =
    \\818181911112111
    \\987654321111111
    \\811111111111119
    \\234234234234278
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
    while (lines_iter.next()) |line| {
        var buff_nums: [12]u8 = undefined; // numbers, not strings
        var count: usize = 0; // number of elements in the buff
        numbers: for (0..line.len) |idx| {
            const dig = try std.fmt.charToDigit(line[idx], 10);
            const nums_left = line.len - idx;
            // for each number that's in the buffer
            for (0..count) |buff_idx| {
                // is it possible to even substitute this digit at this location
                if (buff_idx + nums_left < 12) {
                    // not possible, continue
                    continue;
                }
                const val = buff_nums[buff_idx];
                if (dig > val) {
                    buff_nums[buff_idx] = dig;
                    // reset the count (no need to erase, it's just garbage data)
                    count = buff_idx + 1;
                    continue :numbers; // jump to the next number
                }
            }
            // if we got here, we didn't do any substitution
            // check to see if there's enough room for the current value to be placed in the buffer
            if (count < 12) {
                buff_nums[count] = dig;
                count += 1;
            }
        }
        // convert the list of numbers to one big number
        var number: usize = 0;
        for (0..12) |idx| {
            number += std.math.pow(usize, 10, 11 - idx) * buff_nums[idx];
        }
        sum += number;
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
