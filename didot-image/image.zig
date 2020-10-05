pub const bmp = @import("bmp.zig");
const Allocator = @import("std").mem.Allocator;

pub const ImageFormat = enum {
    /// 8-bit red, green and blue samples in that order.
    RGB24,
    /// 8-bit blue, green and red samples in that order.
    BGR24,
    /// 8-bit red, green, blue and alpha samples in that order.
    RGBA32,
    /// 8-bit gray sample.
    GRAY8
};

pub const Image = struct {
    allocator: ?*Allocator = null,
    /// The image data, in linear 8-bit RGB format.
    data: []u8,
    width: usize,
    height: usize,
    format: ImageFormat,

    pub fn deinit(self: *Image) void {
        if (self.allocator) |allocator| {
            allocator.free(self.data);
        }
    }
};

test "" {
    comptime {
        @import("std").meta.refAllDecls(bmp);
    }
}