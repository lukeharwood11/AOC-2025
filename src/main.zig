const std = @import("std");
const utils = @import("root.zig");
// Day 1
const day1 = @import("day1.zig");
const day1_inp = std.mem.trimEnd(u8, @embedFile("data/day1.txt"), "\n");
// Day 2
const day2 = @import("day2.zig");
const day2_inp = std.mem.trimEnd(u8, @embedFile("data/day2.txt"), "\n");

// Day 3
const day3 = @import("day3.zig");
const day3_inp = std.mem.trimEnd(u8, @embedFile("data/day3.txt"), "\n");

pub fn main() !void {
    // Day 1 - - - - - -
    var start_time = std.time.microTimestamp();
    const output2 = try day1.part2(day1_inp);
    var end_time = std.time.microTimestamp();
    std.log.info("Day 1 Part 2 - Final Answer: {d}, {d}μs", .{ output2, end_time - start_time });

    start_time = std.time.milliTimestamp();
    const day2_part1_output = try day2.part2(day2_inp);
    end_time = std.time.milliTimestamp();
    std.log.info("Day 2 Part 2 - Final Answer: {d}, {d}ms", .{ day2_part1_output, end_time - start_time });

    start_time = std.time.microTimestamp();
    const day3_part1_output = try day3.part1(day3_inp);
    end_time = std.time.microTimestamp();
    std.log.info("Day 3 Part 1 - Final Answer: {d}, {d}μs", .{ day3_part1_output, end_time - start_time });
}
