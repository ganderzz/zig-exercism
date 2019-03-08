const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const main = @import("./main.zig");

const clean = main.clean;
const PhoneError = main.PhoneError;

test "Cleans the number" {
    const result = try clean("(223) 456-7890");

    const expected = @bytesToSlice(u8, "2234567890");

    assert(mem.eql(u8, result, expected));
}

test "Cleans number with dots" {
    const result = try clean("223.456.7890");

    assert(mem.eql(u8, result, "2234567890"));
}

test "Cleans numbers with multiple spaces" {
    const result = try clean("223 456   7890   ");

    assert(mem.eql(u8, result, "2234567890"));
}

test "Invalid when 9 digits" {
    if (clean("123456789")) {
        assert(false);
    } else |e| switch (e) {
        PhoneError.UnderLength => assert(true),
        else => assert(false),
    }
}

test "Invalid when 11 digits does not start with a 1" {
    if (clean("32342223456789056789")) {
        assert(false);
    } else |e| switch (e) {
        PhoneError.MissingStartingOne => assert(true),
        else => assert(false),
    }
}

test "Valid when 11 digits and starting with 1" {
    const result = try clean("12234567890");

    assert(mem.eql(u8, result, "12234567890"));
}