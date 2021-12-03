const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

pub fn main() !void {
    var file = try std.fs.cwd().openFile("data/day02.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    try partOne(&in_stream);
    // Seek back to the start if the file since the stream will be
    // at the end after partOne runs
    try file.seekTo(0);
    try partTwo(&in_stream);
}

fn partOne(reader: anytype) !void {
    var horizontal_position: i32 = 0;
    var depth: i32 = 0;
    var value: i32 = undefined;
    var buf: [1024]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var index: usize = 0;
        while (line[index] != ' ') : (index+=1) {}
        value = try parseInt(i32, line[index+1..line.len], 10);
        _ = switch (line[0]) {
            'f' => horizontal_position += value,
            'd' => depth += value,
            'u' => depth -= value,
            else => unreachable,
        };
    }
    print("{}\n", .{horizontal_position*depth});
}

fn partTwo(reader: anytype) !void {
    var horizontal_position: i32 = 0;
    var depth: i32 = 0;
    var aim: i32 = 0;
    var value: i32 = undefined;
    var buf: [1024]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var index: usize = 0;
        while (line[index] != ' ') : (index+=1) {}
        value = try parseInt(i32, line[index+1..line.len], 10);
        _ = switch (line[0]) {
            'f' => {
                horizontal_position += value;
                depth += (aim * value);
            },
            'd' => aim += value,
            'u' => aim -= value,
            else => unreachable,
        };
    }
    print("{}\n", .{horizontal_position*depth});
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
