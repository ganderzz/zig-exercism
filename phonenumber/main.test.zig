const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const clean = @import("./main.zig").clean;

test "Cleans the number" {
    assert(mem.eql(u8, clean("(223) 456-7890") catch "0", "2234567890"));
}

test "Cleans number with dots" {
    assert(mem.eql(u8, clean("223.456.7890") catch "0", "2234567890"));
}

test "Cleans numbers with multiple spaces" {
    assert(mem.eql(u8, clean("223 456   7890   ") catch "0", "2234567890"));
}

test "Invalid when 9 digits" {
    const result: []const u8 = clean("123456789") catch "-1";

    assert(mem.eql(u8, result, "-1"));
}

test "Invalid when 11 digits does not start with a 1" {
    const result: []const u8 = clean("22234567890") catch "-1";

    assert(mem.eql(u8, result, "-1"));
}

test "Valid when 11 digits and starting with 1" {
    const result: []const u8 = clean("12234567890") catch "-1";

    assert(mem.eql(u8, result, "12234567890"));
}