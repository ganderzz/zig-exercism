const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const clean = @import("./main.zig").clean;

test "Cleans the number" {
    const result = clean("(223) 456-7890") catch |e| {
        assert(false);
        return e;
    };

    const expected = @bytesToSlice(u8, "2234567890");

    assert(mem.eql(u8, result, expected));
}

test "Cleans number with dots" {
    const result = clean("223.456.7890") catch |e| {
        assert(false);
        return e;
    };

    assert(mem.eql(u8, result, "2234567890"));
}

test "Cleans numbers with multiple spaces" {
    const result = clean("223 456   7890   ") catch |e| {
        assert(false);
        return e;
    };

    assert(mem.eql(u8, result, "2234567890"));
}

test "Invalid when 9 digits" {
    const result = clean("123456789") catch |e| {
        assert(true);
        return e;
    };

    assert(false);
}

test "Invalid when 11 digits does not start with a 1" {
    const result = clean("22234567890") catch |e| {
        assert(true);
        return e;
    };

    assert(false);
}

test "Valid when 11 digits and starting with 1" {
    const result = clean("12234567890") catch |e| {
        assert(false);
        return e;
    };

    assert(mem.eql(u8, result, "12234567890"));
}