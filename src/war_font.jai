DEBUG_RENDER_FONT :: false;

WarFontData :: struct {
    spriteWidth: s32;
    spriteHeight: s32;
    lineHeight: f32;
    advance: s32;
    data: [95] Rect;
}

// the fonts was created in a 64x64 (64x96 for the second font)
// sprite but for the actual game a 512x512 (512x768) was used,
// so the original dimensions of this array are actually multiplied by 8
//
fontsData: [2] WarFontData = .[
    // font 0 for in game texts
    .{
        512, 512, 48, 8,
        .[
            .{   0,   0, 24, 48 }, //
            .{  40,   0, 16, 48 }, // !
            .{  56,   0, 32, 48 }, // "
            .{  88,   0, 48, 48 }, // #
            .{ 136,   0, 40, 48 }, // $
            .{ 176,   0, 48, 48 }, // %
            .{ 224,   0, 40, 48 }, // &
            .{ 264,   0, 24, 48 }, // '
            .{ 288,   0, 24, 48 }, // (
            .{ 312,   0, 24, 48 }, // )
            .{ 336,   0, 32, 48 }, // *
            .{ 368,   0, 32, 48 }, // +
            .{ 400,   0, 24, 48 }, // '
            .{ 424,   0, 32, 48 }, // -
            .{ 456,   0, 16, 48 }, // .
            .{   0,  48, 48, 48 }, // /
            .{  48,  48, 40, 48 }, // 0
            .{  88,  48, 32, 48 }, // 1
            .{ 120,  48, 40, 48 }, // 2
            .{ 160,  48, 40, 48 }, // 3
            .{ 200,  48, 40, 48 }, // 4
            .{ 240,  48, 40, 48 }, // 5
            .{ 280,  48, 40, 48 }, // 6
            .{ 320,  48, 40, 48 }, // 7
            .{ 360,  48, 40, 48 }, // 8
            .{ 400,  48, 40, 48 }, // 9
            .{ 440,  48, 32, 48 }, // :
            .{ 472,  48, 16, 48 }, // ;
            .{   0,  96, 32, 48 }, // <
            .{  32,  96, 32, 48 }, // =
            .{  64,  96, 32, 48 }, // >
            .{  96,  96, 40, 48 }, // ?
            .{ 136,  96, 48, 48 }, // @
            .{ 184,  96, 40, 48 }, // A
            .{ 224,  96, 40, 48 }, // B
            .{ 264,  96, 40, 48 }, // C
            .{ 304,  96, 40, 48 }, // D
            .{ 344,  96, 40, 48 }, // E
            .{ 384,  96, 40, 48 }, // F
            .{ 424,  96, 40, 48 }, // G
            .{ 464,  96, 40, 48 }, // H
            .{   0, 144, 32, 48 }, // I
            .{  32, 144, 40, 48 }, // J
            .{  72, 144, 40, 48 }, // K
            .{ 112, 144, 40, 48 }, // L
            .{ 152, 144, 48, 48 }, // M
            .{ 200, 144, 48, 48 }, // N
            .{ 248, 144, 40, 48 }, // O
            .{ 288, 144, 40, 48 }, // P
            .{ 328, 144, 40, 48 }, // Q
            .{ 368, 144, 40, 48 }, // R
            .{ 408, 144, 40, 48 }, // S
            .{ 448, 144, 32, 48 }, // T
            .{   0, 192, 40, 48 }, // U
            .{  40, 192, 48, 48 }, // V
            .{  88, 192, 48, 48 }, // W
            .{ 136, 192, 48, 48 }, // X
            .{ 184, 192, 48, 48 }, // Y
            .{ 232, 192, 48, 48 }, // Z
            .{ 280, 192, 24, 48 }, // [
            .{ 304, 192, 48, 48 }, // backslash
            .{ 352, 192, 24, 48 }, // ]
            .{ 376, 192, 32, 48 }, // ^
            .{ 408, 192, 40, 48 }, // _
            .{ 448, 192, 24, 48 }, // `
            .{   0, 240, 40, 48 }, // a
            .{  40, 240, 40, 48 }, // b
            .{  80, 240, 40, 48 }, // c
            .{ 120, 240, 40, 48 }, // d
            .{ 160, 240, 40, 48 }, // e
            .{ 200, 240, 40, 48 }, // f
            .{ 240, 240, 40, 48 }, // g
            .{ 280, 240, 40, 48 }, // h
            .{ 320, 240, 32, 48 }, // i
            .{ 352, 240, 40, 48 }, // j
            .{ 392, 240, 40, 48 }, // k
            .{ 432, 240, 40, 48 }, // l
            .{   0, 288, 48, 48 }, // m
            .{  48, 288, 48, 48 }, // n
            .{  96, 288, 40, 48 }, // o
            .{ 136, 288, 40, 48 }, // p
            .{ 176, 288, 40, 48 }, // q
            .{ 216, 288, 40, 48 }, // r
            .{ 256, 288, 40, 48 }, // sFONT_HORIZONTAL_GAP_PX
            .{ 296, 288, 32, 48 }, // t
            .{ 328, 288, 40, 48 }, // u
            .{ 360, 288, 48, 48 }, // v
            .{ 408, 288, 48, 48 }, // w
            .{   0, 336, 48, 48 }, // x
            .{  48, 336, 48, 48 }, // y
            .{  96, 336, 48, 48 }, // z
            .{ 144, 336, 32, 48 }, // {
            .{ 176, 336, 16, 48 }, // |
            .{ 192, 336, 32, 48 }, // }
            .{ 224, 336, 48, 48 }, // ~
        ]
    },
    // font 1 for menu texts
    .{
        512, 768, 80, 8,
        .[
            .{   0,   0, 30, 80 }, // space
            .{  48,   0, 16, 80 }, // !
            .{  64,   0, 32, 80 }, // "
            .{  96,   0, 48, 80 }, // #
            .{ 144,   0, 48, 80 }, // $
            .{ 192,   0, 64, 80 }, // %
            .{ 256,   0, 40, 80 }, // &
            .{ 296,   0, 24, 80 }, // '
            .{ 320,   0, 32, 80 }, // (
            .{ 352,   0, 32, 80 }, // )
            .{ 384,   0, 56, 80 }, // *
            .{ 440,   0, 48, 80 }, // +
            .{ 488,   0, 24, 80 }, // '
            .{   0,  80, 32, 80 }, // -
            .{  32,  80, 24, 80 }, // .
            .{  56,  80, 56, 80 }, // /
            .{ 112,  80, 48, 80 }, // 0
            .{ 160,  80, 32, 80 }, // 1
            .{ 192,  80, 48, 80 }, // 2
            .{ 240,  80, 48, 80 }, // 3
            .{ 288,  80, 48, 80 }, // 4
            .{ 336,  80, 48, 80 }, // 5
            .{ 384,  80, 48, 80 }, // 6
            .{ 432,  80, 48, 80 }, // 7
            .{   0, 160, 48, 80 }, // 8
            .{  48, 160, 48, 80 }, // 9
            .{  96, 160, 24, 80 }, // :
            .{ 120, 160, 24, 80 }, // ;
            .{ 144, 160, 40, 80 }, // <
            .{ 184, 160, 40, 80 }, // =
            .{ 224, 160, 40, 80 }, // >
            .{ 264, 160, 40, 80 }, // ?
            .{ 304, 160, 64, 80 }, // @
            .{ 368, 160, 48, 80 }, // A
            .{ 416, 160, 48, 80 }, // B
            .{ 464, 160, 48, 80 }, // C
            .{   0, 240, 48, 80 }, // D
            .{  48, 240, 48, 80 }, // E
            .{  96, 240, 48, 80 }, // F
            .{ 144, 240, 48, 80 }, // G
            .{ 192, 240, 48, 80 }, // H
            .{ 240, 240, 32, 80 }, // I
            .{ 272, 240, 48, 80 }, // J
            .{ 320, 240, 48, 80 }, // K
            .{ 368, 240, 48, 80 }, // L
            .{ 416, 240, 64, 80 }, // M
            .{   0, 320, 56, 80 }, // N
            .{  56, 320, 48, 80 }, // O
            .{ 104, 320, 48, 80 }, // P
            .{ 152, 320, 48, 80 }, // Q
            .{ 200, 320, 48, 80 }, // R
            .{ 248, 320, 48, 80 }, // S
            .{ 296, 320, 48, 80 }, // T
            .{ 344, 320, 48, 80 }, // U
            .{ 392, 320, 48, 80 }, // V
            .{ 440, 320, 64, 80 }, // W
            .{   0, 400, 48, 80 }, // X
            .{  48, 400, 48, 80 }, // Y
            .{  96, 400, 48, 80 }, // Z
            .{ 144, 400, 32, 80 }, // [
            .{ 176, 400, 56, 80 }, // backslash
            .{ 232, 400, 32, 80 }, // ]
            .{ 264, 400, 48, 80 }, // ^
            .{ 312, 400, 48, 80 }, // _
            .{ 360, 400, 32, 80 }, // `
            .{ 392, 400, 40, 80 }, // a
            .{ 432, 400, 40, 80 }, // b
            .{ 472, 400, 40, 80 }, // c
            .{   0, 480, 40, 80 }, // d
            .{  40, 480, 40, 80 }, // e
            .{  80, 480, 32, 80 }, // f
            .{ 112, 480, 40, 80 }, // g
            .{ 152, 480, 40, 80 }, // h
            .{ 192, 480, 16, 80 }, // i
            .{ 208, 480, 24, 80 }, // j
            .{ 232, 480, 40, 80 }, // k
            .{ 272, 480, 16, 80 }, // l
            .{ 288, 480, 64, 80 }, // m
            .{ 352, 480, 40, 80 }, // n
            .{ 392, 480, 40, 80 }, // o
            .{ 432, 480, 40, 80 }, // p
            .{   0, 560, 48, 80 }, // q
            .{  48, 560, 40, 80 }, // r
            .{  88, 560, 40, 80 }, // s
            .{ 128, 560, 32, 80 }, // t
            .{ 160, 560, 40, 80 }, // u
            .{ 200, 560, 48, 80 }, // v
            .{ 248, 560, 64, 80 }, // w
            .{ 312, 560, 48, 80 }, // x
            .{ 360, 560, 40, 80 }, // y
            .{ 400, 560, 48, 80 }, // z
            .{   0, 640, 32, 80 }, // {
            .{  32, 560, 16, 80 }, // |
            .{  48, 560, 32, 80 }, // }
            .{  80, 640, 56, 80 }, // ~
        ]
    }
];

FONT_NORMAL_COLOR :: WarColor.{ r = 239, g = 255, b = 219, a = 255 };
FONT_HIGHLIGHT_COLOR :: WarColor.{ r = 255, g = 227, b = 73, a = 255 };
NO_HIGHLIGHT : s32 : -1;
ALL_HIGHLIGHT : s32 : -2;
MAX_LINES : s32 : 48;
TAB_WIDTH : s32 : 2;

colorToNVGcolor :: (color: WarColor) -> NVGcolor {
    return nvgRGBA(color.r, color.g, color.b, color.a);
}

textAlignToNVGalign :: (align: WarTextAlignment) -> NVGalign {
    if align == {
        case WarTextAlignment.Left;   return NVGalign.NVG_ALIGN_LEFT;
        case WarTextAlignment.Center; return NVGalign.NVG_ALIGN_CENTER;
        case WarTextAlignment.Right;  return NVGalign.NVG_ALIGN_RIGHT;
        case WarTextAlignment.Top;    return NVGalign.NVG_ALIGN_TOP;
        case WarTextAlignment.Middle; return NVGalign.NVG_ALIGN_MIDDLE;
        case WarTextAlignment.Bottom; return NVGalign.NVG_ALIGN_BOTTOM;
        case; {
            logError("Invalid alignment value: %. Defaulting to %\n", align, NVGalign.NVG_ALIGN_LEFT);
            return .NVG_ALIGN_LEFT;
        }
    }
}

textWrappingToNVGwrap :: (wrap: WarTextWrapping) -> NVGwrap {
    if wrap == {
        case WarTextWrapping.None; return NVGwrap.NVG_WRAP_NONE;
        case WarTextWrapping.Char; return NVGwrap.NVG_WRAP_WORD;
        case; {
            logError("Invalid wrapping value: %. Defaulting to %\n", wrap, NVGwrap.NVG_WRAP_NONE);
            return .NVG_WRAP_NONE;
        }
    }
}

textTrimmingToNVGtrim :: (trim: WarTextTrimming) -> NVGtrim {
    if trim == {
        case WarTextTrimming.None; return NVGtrim.NVG_TRIM_NONE;
        case WarTextTrimming.Spaces; return NVGtrim.NVG_TRIM_SPACES;
        case WarTextTrimming.All; return NVGtrim.NVG_TRIM_ALL;
        case; {
            logError("Invalid trimming value: %. Defaulting to %\n", trim, NVGtrim.NVG_TRIM_NONE);
            return .NVG_TRIM_NONE;
        }
    }
}

getCharIndex :: (c: u8) -> s32 {
    return cast(s32) (ifx c > 0 then c - 32 else 0);
}

loadFontSprite :: (ctx: *WarContext, fontPath: string) -> WarSprite {
    sprite: WarSprite;

    width, height, bitsPerPixel: s32;
    data := stbi_load(toCString(fontPath, tempAllocator), *width, *height, *bitsPerPixel, 0);
    if (data) {
        sprite = createSprite(ctx, width, height, data);
        stbi_image_free(data);
    }

    return sprite;
}

getAlignmentOffset :: (horizontalAlign: NVGalign, verticalAlign: NVGalign, boundings: Vec2, textSize: Vec2) -> Vec2 {
    offset := VEC2_ZERO;

    if horizontalAlign == {
        case NVGalign.NVG_ALIGN_LEFT; {
            // nothing here
        }
        case NVGalign.NVG_ALIGN_CENTER; {
            offset.x = ceilf((boundings.x - textSize.x)/2);
        }
        case NVGalign.NVG_ALIGN_RIGHT; {
            offset.x = ceilf(boundings.x - textSize.x);
        }
        case; {
            logError("Invalid horizontal alignment value: %\n", horizontalAlign);
        }
    }

    if verticalAlign == {
        case NVGalign.NVG_ALIGN_TOP; {
            // nothing here
        }
        case NVGalign.NVG_ALIGN_MIDDLE; {
            offset.y = ceilf((boundings.y/2) - (textSize.y/2));
        }
        case NVGalign.NVG_ALIGN_BOTTOM; {
            offset.y = ceilf(boundings.y - textSize.y);
        }
        case; {
            logError("Invalid vertical alignment value: %\n", verticalAlign);
        }
    }

    return offset;
}

getLineAlignmentOffset :: (lineAlign: NVGalign, width: f32, lineWidth: f32) -> f32 {
    offset: f32 = 0;

    if lineAlign == {
        case .NVG_ALIGN_LEFT; {
            // nothing here
        }
        case .NVG_ALIGN_CENTER; {
            offset = ceilf((width - lineWidth)/2);
        }
        case .NVG_ALIGN_RIGHT; {
            offset = ceilf(width - lineWidth);
        }
        case; {
            logError("Invalid horizontal alignment value: %\n", lineAlign);
        }
    }

    return offset;
}

NVGTextSpan :: struct {
    start: *u8;
    end: *u8;
    width: f32;
}

nvgSplitTextIntoLines :: (text: *u8, maxLines: s32, lines: [] NVGTextSpan, width: f32, params: NVGfontParams) -> s32 {
    scale := params.fontSize / params.fontData.lineHeight;
    wrap := params.wrapping == .NVG_WRAP_WORD;
    x: f32 = 0;
    k: s32 = 0;

    s := text;
    e := text;
    while (k < maxLines) {
        c := <<e;
        if (c == #char "\0") {
            break;
        } else if (c == #char "\n") {
            // a new line is generated for each \n
            lines[k].start = s;
            lines[k].end = e;
            lines[k].width = x;
            k += 1;

            s = e + 1;
            x = 0;
        } else if (c == #char "\t") {
            rs := params.fontData.data[getCharIndex(#char " ")];
            dx := (TAB_WIDTH * rs.w + params.fontData.advance) * scale;

            // if the current character doesn't fit in the line generate a new line
            if (x + dx > width && wrap) {
                lines[k].start = s;
                lines[k].end = e;
                lines[k].width = x;
                k += 1;

                s = e;
                x = 0;
            }

            x += dx;
        } else {
            rs := params.fontData.data[getCharIndex(c)];
            dx := (rs.w + params.fontData.advance) * scale;

            // if the current character doesn't fit in the line generate a new line
            if (x + dx > width && wrap) {
                lines[k].start = s;
                lines[k].end = e;
                lines[k].width = x;
                k += 1;

                s = e;
                x = 0;
            }

            x += dx;
        }

        e += 1;
    }

    if (s < e && k < maxLines) {
        lines[k].start = s;
        lines[k].end = e;
        lines[k].width = x;
        k += 1;
    }

    // trim start and end spaces on lines
    if (params.trimming != .NVG_TRIM_NONE) {
        whiteSpaceData := params.fontData.data[getCharIndex(#char " ")];
        whiteSpaceWidth := (whiteSpaceData.w + params.fontData.advance) * scale;

        for i : range(s32, 0, k) {
            while (true) {
                if (lines[i].start[0] == #char " " && params.trimming >= .NVG_TRIM_SPACES) {
                    lines[i].width -= whiteSpaceWidth;
                    lines[i].start += 1;
                } else if (lines[i].start[i] == #char "\t" && params.trimming >= .NVG_TRIM_ALL) {
                    lines[i].width -= TAB_WIDTH * whiteSpaceWidth;
                    lines[i].start += 1;
                } else {
                    break;
                }
            }

            while (true) {
                if (lines[i].end[-1] == #char " " && params.trimming >= .NVG_TRIM_SPACES) {
                    lines[i].width -= whiteSpaceWidth;
                    lines[i].end -= 1;
                } else if (lines[i].end[-1] == #char "\t" && params.trimming >= .NVG_TRIM_ALL) {
                    lines[i].width -= TAB_WIDTH * whiteSpaceWidth;
                    lines[i].end -= 1;
                } else {
                    break;
                }
            }
        }
    }

    return k;
}

nvgMeasureSingleSpriteText :: (text: *u8, length: s32, params: NVGfontParams) -> Vec2 {
    scale := params.fontSize / params.fontData.lineHeight;

    size := VEC2_ZERO;

    e := text;
    while (length != 0) {
        c := <<e;
        if (c == #char "\0") {
            break;
        } else if (c == #char "\n") {
            size.x += params.fontData.advance * scale;
        } else if (c == #char "\t") {
            rs := params.fontData.data[getCharIndex(#char " ")];
            size.x += (TAB_WIDTH * rs.w + params.fontData.advance) * scale;
        } else {
            rs := params.fontData.data[getCharIndex(c)];
            size.x += (rs.w + params.fontData.advance) * scale;
            size.y = max(size.y, rs.h * scale);
        }

        length -= 1;
        e += 1;
    }

    return size;
}

nvgMeasureMultiSpriteText :: (text: *u8, width: f32, params: NVGfontParams) -> Vec2 {
    scale := params.fontSize / params.fontData.lineHeight;
    lineHeight := ifx params.lineHeight > 0 then params.lineHeight else params.fontData.lineHeight;

    lines: [MAX_LINES] NVGTextSpan;
    linesCount := nvgSplitTextIntoLines(text, MAX_LINES, lines, params.boundings.x, params);

    size := VEC2_ZERO;

    for line : lines {
        size.x = max(size.x, line.width);
        size.y += lineHeight * scale;
    }

    return size;
}

nvgSingleSpriteTextSpan :: (gfx: *NVGcontext,
                            text: *u8,
                            index: s32, count: s32,
                            x: f32, y: f32,
                            fontColor: NVGcolor,
                            fontSprite: WarSprite,
                            fontData: WarFontData,
                            boundings: Vec2,
                            scale: f32) -> f32
{
    if (count > 0) {
        nvgSave(gfx);
        nvgFillColor(gfx, fontColor);

        batch := nvgBeginImageBatch(gfx, fontSprite.image, count);

        for i : range(s32, 0, count) {
            if (boundings.x > 0 && x * scale > boundings.x) {
                break;
            }

            c := text[index + i];

            if (c == #char "\n") {
                // when we are rendering a single text span, all newline characters
                // are rendered as ' ' since a single text span is considered
                // a one line of text, it won't go to the next line
                rs := fontData.data[getCharIndex(#char " ")];
                x += rs.w + fontData.advance;
            } else if (c == #char "\t") {
                rs := fontData.data[getCharIndex(#char " ")];
                x += TAB_WIDTH * rs.w + fontData.advance;
            } else {
                rs := fontData.data[getCharIndex(c)];
                rd := rect(x, y, rs.w, rs.h);

                #if DEBUG_RENDER_FONT {
                    nvgFillRect(gfx, rd, NVG_GREEN_SELECTION);
                }

                if (c != #char " ") {
                    nvgRenderBatchImage(gfx, *batch, rs, rd, VEC2_ONE);
                }

                x += rs.w + fontData.advance;
            }
        }

        nvgEndImageBatch(gfx, *batch);
        nvgRestore(gfx);
    }

    return x;
}

nvgSingleSpriteText :: (gfx: *NVGcontext, text: *u8, x: f32, y: f32, params: NVGfontParams) {
    scale := params.fontSize / params.fontData.lineHeight;
    textSize := nvgMeasureSingleSpriteText(text, -1, params);
    length := cast(s32) strlen(text);

    nvgSave(gfx);
    nvgTranslate(gfx, x, y);

    if (!isZero(params.boundings)) {
        textOffset := getAlignmentOffset(params.horizontalAlign, params.verticalAlign, params.boundings, textSize);
        nvgTranslate(gfx, textOffset.x, textOffset.y);
    }

    nvgScale(gfx, scale, scale);

    #if DEBUG_RENDER_FONT {
        outline := rect(0, 0, textSize.x / scale, 1.5);
        nvgStrokeRect(gfx, outline, NVG_GREEN_SELECTION, 3);
    }

    if (params.highlightIndex >= 0) {
        x = nvgSingleSpriteTextSpan(gfx, text,
                                    0, params.highlightIndex,
                                    0, 0,
                                    params.fontColor,
                                    params.fontSprite,
                                    params.fontData,
                                    params.boundings,
                                    scale);

        x = nvgSingleSpriteTextSpan(gfx, text,
                                    params.highlightIndex, params.highlightCount,
                                    x, 0,
                                    params.highlightColor,
                                    params.fontSprite,
                                    params.fontData,
                                    params.boundings,
                                    scale);

        x = nvgSingleSpriteTextSpan(gfx, text,
                                    params.highlightIndex + params.highlightCount,
                                    length - params.highlightIndex - params.highlightCount,
                                    x, 0,
                                    params.fontColor,
                                    params.fontSprite,
                                    params.fontData,
                                    params.boundings,
                                    scale);
    } else {
        // No highlight, highlightIndex = -1
        // All highlight, highlightIndex = -2
        fontColor := ifx params.highlightIndex == ALL_HIGHLIGHT
            then params.highlightColor else params.fontColor;

        nvgSingleSpriteTextSpan(gfx, text,
                                0, length,
                                0, 0,
                                fontColor,
                                params.fontSprite,
                                params.fontData,
                                params.boundings,
                                scale);
    }

    nvgRestore(gfx);
}

nvgMultiSpriteText :: (gfx: *NVGcontext, text: *u8, x: f32, y: f32, params: NVGfontParams) {
    scale := params.fontSize / params.fontData.lineHeight;
    lineHeight := ifx params.lineHeight > 0 then params.lineHeight else params.fontData.lineHeight;

    lines: [MAX_LINES] NVGTextSpan;
    linesCount := nvgSplitTextIntoLines(text, MAX_LINES, lines, params.boundings.x, params);

    nvgSave(gfx);
    nvgTranslate(gfx, x, y);

    textSize := nvgMeasureMultiSpriteText(text, params.boundings.x, params);

    textOffset := getAlignmentOffset(params.horizontalAlign, params.verticalAlign, params.boundings, textSize);
    nvgTranslate(gfx, textOffset.x, textOffset.y);

    #if DEBUG_RENDER_FONT {
        outline := rect(0, 0, textSize.x, textSize.y);
        nvgStrokeRect(gfx, outline, NVG_RED_SELECTION, 1);
    }

    lineStartIndex: s32 = 0;

    for line, i : lines {
        lineLength := cast(s32)(line.end - line.start);
        lineAlignOffset := getLineAlignmentOffset(params.lineAlign, textSize.x, line.width);
        lineOffset := vec2(lineAlignOffset, i * lineHeight);

        if (lineOffset.y * scale > params.boundings.y) {
            break;
        }

        nvgSave(gfx);
        nvgTranslate(gfx, lineOffset.x, 0);
        nvgScale(gfx, scale, scale);
        nvgTranslate(gfx, 0, lineOffset.y);

        #if DEBUG_RENDER_FONT {
            outline := rect(0, 0, line.width / scale, lineHeight);
            nvgStrokeRect(gfx, outline, NVG_GREEN_SELECTION, 1);
        }

        if (params.highlightIndex >= lineStartIndex && params.highlightIndex < lineStartIndex + lineLength) {
            highlightIndex := params.highlightIndex - lineStartIndex;
            highlightCount := min(params.highlightCount, lineLength - highlightIndex);

            x = nvgSingleSpriteTextSpan(gfx, line.start,
                                        0, highlightIndex,
                                        0, 0,
                                        params.fontColor,
                                        params.fontSprite,
                                        params.fontData,
                                        params.boundings,
                                        scale);

            x = nvgSingleSpriteTextSpan(gfx, line.start,
                                        highlightIndex, highlightCount,
                                        x, 0,
                                        params.highlightColor,
                                        params.fontSprite,
                                        params.fontData,
                                        params.boundings,
                                        scale);

            x = nvgSingleSpriteTextSpan(gfx, line.start,
                                        highlightIndex + highlightCount,
                                        lineLength - highlightIndex - highlightCount,
                                        x, 0,
                                        params.fontColor,
                                        params.fontSprite,
                                        params.fontData,
                                        params.boundings,
                                        scale);
        }
        else if (params.highlightIndex < lineStartIndex &&
                 params.highlightIndex + params.highlightCount >= lineStartIndex)
        {
            highlightCount := min(params.highlightIndex + params.highlightCount - lineStartIndex, lineLength);

            x = nvgSingleSpriteTextSpan(gfx, line.start,
                                        0, highlightCount,
                                        0, 0,
                                        params.highlightColor,
                                        params.fontSprite,
                                        params.fontData,
                                        params.boundings,
                                        scale);

            x = nvgSingleSpriteTextSpan(gfx, line.start,
                                        highlightCount,
                                        lineLength - highlightCount,
                                        x, 0,
                                        params.fontColor,
                                        params.fontSprite,
                                        params.fontData,
                                        params.boundings,
                                        scale);
        }
        else
        {
            // No highlight, highlightIndex = -1
            // All highlight, highlightIndex = -2
            fontColor := ifx params.highlightIndex == ALL_HIGHLIGHT
                then params.highlightColor else params.fontColor;

            nvgSingleSpriteTextSpan(gfx, line.start,
                                    0, lineLength,
                                    0, 0,
                                    fontColor,
                                    params.fontSprite,
                                    params.fontData,
                                    params.boundings,
                                    scale);
        }

        nvgRestore(gfx);

        lineStartIndex += lineLength;
    }

    nvgRestore(gfx);
}
