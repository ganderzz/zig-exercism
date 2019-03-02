const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const hw = @import("./main.zig");

test "testing hello world" {
    const x = hw.helloWorld();  // another comment
    assert(mem.eql(u8, x, "Hello, World!\n"));
}