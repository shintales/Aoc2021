const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day01.txt");

pub fn main() !void {
    try partOne();
    try partTwo();
}

/// Iterate through the tokens and compare the previous value with the
/// current value
pub fn partOne() !void {
    var tokens = tokenize(u8, data, "\n");
    var total_increases: u32 = 0;
    var previous: u32 = undefined;

    while (try getNextInt(&tokens)) |token| {
        if (previous != 0 and previous < token) {
            total_increases += 1;
        }
        previous = token;
    }
    std.log.info("Total is {}", .{total_increases});
}

/// Iterate through the tokens as a "sliding window"
/// where we sum up every three tokens
/// I use a buffer to store the three values to add
/// After each loop iteration, the oldest value in the buffer
/// is replaced with the newest one by using the modulus
pub fn partTwo() !void {
    var tokens = tokenize(u8, data, "\n");
    var buffer = [_]u32{
        (try getNextInt(&tokens)).?,
        (try getNextInt(&tokens)).?,
        (try getNextInt(&tokens)).?,
    };
    var previous_sum = sum(&buffer);
    var next: usize = 0;
    var total_increases: u32 = 0;
    while (try getNextInt(&tokens)) |token| {
        buffer[next] = token;
        next += 1;
        next %= buffer.len;
        var new_sum = sum(&buffer);
        if (previous_sum < new_sum) {
            total_increases += 1;
        }
        previous_sum = new_sum;
    }
    std.log.info("Total is {}", .{total_increases});
}

fn getNextInt(tokens: *std.mem.TokenIterator(u8)) !?u32 {
    if (tokens.next()) |value| {
        return try parseInt(u32, value, 10);
    }
    return null;
}

fn sum(buffer: []u32) u32 {
    var total: u32 = 0;
    for (buffer) |value| {
        total += value;
    }
    return total;
}

// Useful stdlib functions
const tokenize = std.mem.tokenize;
const split = std.mem.split;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const min = std.math.min;
const min3 = std.math.min3;
const max = std.math.max;
const max3 = std.math.max3;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;
