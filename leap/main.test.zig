const assert = @import("std").debug.assert;
const isLeapYear = @import("./main.zig").isLeapYear;

test "Year divisble by 4, and not divisible by 100 it is a leap year" {
    assert(isLeapYear(1996));
}

test "Year divisible by 400 is leap year" {
    assert(isLeapYear(2000));
}

test "Year is not divisible by 4" {
    assert(isLeapYear(2015) == false);
}

test "Year divisible by 100 not divisible by 400 is not leap year" {
    assert(isLeapYear(2100) == false);
}
