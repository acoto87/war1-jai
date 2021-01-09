WarColor :: union {
    rgba: [4] u8;
    struct {
        r,g,b,a: u8;
    };
}

U8COLOR_TRANSPARENT :: WarColor.{ r = 0, g = 0, b = 0, a = 0 };
U8COLOR_WHITE       :: WarColor.{ r = 255, g = 255, b = 255, a = 255 };
U8COLOR_BLACK       :: WarColor.{ r = 0, g = 0, b = 0, a = 255 };
U8COLOR_RED         :: WarColor.{ r = 199, g = 0, b = 0, a = 255 };
U8COLOR_GREEN       :: WarColor.{ r = 0, g = 199, b = 0, a = 255 };
U8COLOR_BLUE        :: WarColor.{ r = 0, g = 0, b = 199, a = 255 };
U8COLOR_YELLOW      :: WarColor.{ r = 199, g = 199, b = 0, a = 255 };

rgbaColor :: inline (r: u8, g: u8, b: u8, a: u8) -> WarColor {
    color: WarColor;
    color.r = r;
    color.g = g;
    color.b = b;
    color.a = a;
    return color;
}

rgbColor :: inline (r: u8, g: u8, b: u8) -> WarColor {
    return rgbaColor(r, g, b, 255);
}
