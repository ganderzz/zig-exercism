const warn = @import("std").debug.warn;
const math = @import("std").math;
const mem = @import("std").mem;

const PhoneError = error {
    UnderLength,
    MissingStartingOne,
};

pub fn clean(input: []const u8) ![]const u8 {
    var output = []u8{0} ** 14;
    var position: u8 = 0;

    if (input.len < 10) {
        return PhoneError.UnderLength;
    }

    if (input.len == 11 and input[0] != 1) {
        return PhoneError.MissingStartingOne;
    }

    for (input) |c| {
        if (c == '(' or c == ')' or c == '-' or c == '.' or c == ' ') {
            continue;
        } else {
            output[position] = c;
            position += 1;
        }
    }

    return @bytesToSlice(u8, output[0..position]);
}