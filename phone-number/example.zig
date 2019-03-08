pub const PhoneError = error {
    UnderLength,
    MissingStartingOne,
    TooBig,
};

pub fn clean(input: []const u8) ![]const u8 {
    var buffer = []u8{0} ** 20;
    var position: usize = 0;

    if (input.len < 10) {
        return PhoneError.UnderLength;
    }

    for (input) |c| {
        if (c == '(' or c == ')' or c == '-' or c == '.' or c == ' ') {
            continue;
        }

        buffer[position] = c;
        position += 1;

        if (position > buffer.len) {
            return PhoneError.TooBig;
        }
    }

    const output = @bytesToSlice(u8, buffer[0..position]);

    if (output.len >= 11 and output[0] != '1') {
        return PhoneError.MissingStartingOne;
    }

    return output;
}