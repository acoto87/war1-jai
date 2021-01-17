NVG_WHITE :: NVGcolor.{ r = 255, g = 255, b = 255, a = 255 };
NVG_BLACK :: NVGcolor.{ r = 0, g = 0, b = 0, a = 255 };
NVG_FOG :: NVGcolor.{ r = 0, g = 0, b = 0, a = 128 };
NVG_GRAY_TRANSPARENT :: NVGcolor.{ r = 128, g = 128, b = 128, a = 128 };
NVG_RED_TRANSPARENT :: NVGcolor.{ r = 128, g = 0, b = 0, a = 128 };
NVG_GREEN_SELECTION :: NVGcolor.{ r = 0, g = 199, b = 0, a = 255 };
NVG_RED_SELECTION :: NVGcolor.{ r = 199, g = 0, b = 0, a = 255 };
NVG_WHITE_SELECTION :: NVGcolor.{ r = 199, g = 199, b = 199, a = 255 };
NVG_BLUE_INVULNERABLE :: NVGcolor.{ r = 0, g = 0, b = 199, a = 255 };

NVGimageBatch :: struct {
    image: s32;              // the id of the source image
    cimages: s32;            // how many images are going to be rendered
    iw: s32;                 // width of the source image in pixels
    ih: s32;                 // height of the source image in pixels
    nvertices: s32;          // actual count of vertices
    cvertices: s32;          // total count of vertices
    vertices: *NVGvertex;    // the vertices
}

nvgBeginImageBatch :: (gfx: *NVGcontext, image: s32, cimages: s32) -> NVGimageBatch {
    batch: NVGimageBatch;
    batch.image = image;
    batch.cimages = cimages;
    batch.nvertices = 0;
    batch.cvertices = cimages * 6;
    batch.vertices = alloc(NVGvertex, batch.cvertices);

    nvgImageSize(gfx, batch.image, *batch.iw, *batch.ih);

    return batch;
}

nvgRenderBatchImage :: (gfx: *NVGcontext, batch: *NVGimageBatch, rs: Rect, rd: Rect, scale: Vec2) {
    if (batch.nvertices + 6 > batch.cvertices) {
        logError("Can't print more images in this batch: (nvertices: %, cvertices: %)\n", batch.nvertices, batch.cvertices);
        return;
    }

    state := nvgGetState(gfx);

    // if the scale is (1.0, 1.0) then these transformations aren't necessary
    if (!isOne(scale)) {
        nvgTranslate(gfx, rd.w * 0.5, rd.h * 0.5);
        nvgScale(gfx, scale.x, scale.y);
        nvgTranslate(gfx, -rd.w * 0.5, -rd.h * 0.5);
    }

    // positions of the four vertices
    px := rd.x;
    py := rd.y;
    pw := rd.w;
    ph := rd.h;

    // tex-coords of the four vertices
    tx := rs.x / batch.iw;
    ty := rs.y / batch.ih;
    tw := rs.w / batch.iw;
    th := rs.h / batch.ih;

    pxs: [] f32 = array(f32, px, px,      px + pw, px + pw, px,      px + pw);
    pys: [] f32 = array(f32, py, py + ph, py,      py,      py + ph, py + ph);

    cxs: [] f32 = array(f32, tx, tx,      tx + tw, tx + tw, tx,      tx + tw);
    cys: [] f32 = array(f32, ty, ty + th, ty,      ty,      ty + th, ty + th);

    for i : 0..6-1 {
        x, y: f32;
        vertex := *batch.vertices[batch.nvertices];
        x, y := nvgTransformPoint(state.xform, pxs[i], pys[i]);
        nvgVset(vertex, x, y, cxs[i], cys[i]);
        batch.nvertices += 1;
    }
}

nvgEndImageBatch :: (gfx: *NVGcontext, batch: *NVGimageBatch) {
    state := nvgGetState(gfx);
    paint := state.fill;

    paint.image = batch.image;
    paint.innerColor.a *= state.alpha;
    paint.outerColor.a *= state.alpha;

	gfx.params.renderTriangles(
        gfx.params.userPtr,
        *paint,
        state.compositeOperation,
        *state.scissor,
        batch.vertices,
        batch.nvertices);

	gfx.drawCallCount += 1;
	gfx.textTriCount += batch.nvertices/3;

    free(batch.vertices);
}

nvgRenderSubImage :: (gfx: *NVGcontext, image: s32, rs: Rect, rd: Rect, scale: Vec2) {
    batch := nvgBeginImageBatch(gfx, image, 1);
    nvgRenderBatchImage(gfx, *batch, rs, rd, scale);
    nvgEndImageBatch(gfx, *batch);
}

nvgRenderImage :: (gfx: *NVGcontext, image: s32, rd: Rect, scale: Vec2) {
    rs := rect(0, 0, rd.w, rd.h);
    nvgRenderSubImage(gfx, image, rs, rd, scale);
}

nvgFillRect :: (gfx: *NVGcontext, r: Rect, color: NVGcolor) {
    nvgSave(gfx);
    nvgBeginPath(gfx);
    nvgRect(gfx, r.x, r.y, r.w, r.h);
    nvgFillColor(gfx, color);
    nvgFill(gfx);
    nvgRestore(gfx);
}

nvgFillRects :: (gfx: *NVGcontext, rects: [] Rect, color: NVGcolor) {
    nvgSave(gfx);
    nvgBeginPath(gfx);

    for r : rects {
        nvgRect(gfx, r.x, r.y, r.w, r.h);
    }

    nvgFillColor(gfx, color);
    nvgFill(gfx);
    nvgRestore(gfx);
}

nvgStrokeRect :: (gfx: *NVGcontext, r: Rect, color: NVGcolor, width: f32) {
    nvgSave(gfx);
    nvgBeginPath(gfx);
    nvgRect(gfx, r.x, r.y, r.w, r.h);
    nvgStrokeColor(gfx, color);
    nvgStrokeWidth(gfx, width);
    nvgStroke(gfx);
    nvgRestore(gfx);
}

nvgStrokeRects :: (gfx: *NVGcontext, rects: [] Rect, color: NVGcolor, width: f32) {
    nvgSave(gfx);
    nvgBeginPath(gfx);

    for r : rects {
        nvgRect(gfx, r.x, r.y, r.w, r.h);
    }

    nvgStrokeColor(gfx, color);
    nvgStrokeWidth(gfx, width);
    nvgStroke(gfx);
    nvgRestore(gfx);
}

nvgStrokeLine :: (gfx: *NVGcontext, p1: Vec2, p2: Vec2, color: NVGcolor, width: f32) {
    nvgSave(gfx);
    nvgBeginPath(gfx);
    nvgMoveTo(gfx, p1.x, p1.y);
    nvgLineTo(gfx, p2.x, p2.y);
    nvgStrokeColor(gfx, color);
    nvgStrokeWidth(gfx, width);
    nvgStroke(gfx);
    nvgRestore(gfx);
}

nvgStrokePolyline :: (gfx: *NVGcontext, points: [] Vec2, color: NVGcolor, width: f32) {
    if (points.count <= 1) {
        return;
    }

    nvgSave(gfx);
    nvgBeginPath(gfx);

    nvgMoveTo(gfx, points[0].x, points[0].y);
    for i : 1..points.count-1 {
        nvgLineTo(gfx, points[i].x, points[i].y);
    }

    nvgStrokeColor(gfx, color);
    nvgStrokeWidth(gfx, width);
    nvgStroke(gfx);
    nvgRestore(gfx);
}

NVGwrap :: enum {
	NVG_WRAP_NONE :: 1<<0;
	NVG_WRAP_WORD :: 1<<1;
}

NVGtrim :: enum {
    NVG_TRIM_NONE :: 1<<0;
    NVG_TRIM_SPACES :: 1<<1;
    NVG_TRIM_ALL :: 1<<2;
}

NVGfontParams :: struct {
    fontIndex: s32;
    fontSize: f32;
    lineHeight: f32;
    fontColor: NVGcolor;
    highlightColor: NVGcolor;
    highlightIndex: s32;
    highlightCount: s32;
    boundings: Vec2;
    horizontalAlign: NVGalign;
    verticalAlign: NVGalign;
    lineAlign: NVGalign;
    wrapping: NVGwrap;
    trimming: NVGtrim;

    fontSprite: WarSprite;
    fontData: WarFontData;
}

getColorFromList :: (index: s32) -> NVGcolor {
    rgb := colors[index % colors.count];

    color: NVGcolor;
	color.r = ((rgb >> 16) & 0xFF) / 255.0;
	color.g = ((rgb >>  8) & 0xFF) / 255.0;
	color.b = ((rgb >>  0) & 0xFF) / 255.0;
	color.a = 1.0;
	return color;
}

#scope_file

colors := u32.[
    0xE52B50, // Amaranth
    0xFFBF00, // Amber
    0x9966CC, // Amethyst
    0xFBCEB1, // Apricot
    0x7FFFD4, // Aquamarine
    0x007FFF, // Azure
    0x89CFF0, // Baby blue
    0xF5F5DC, // Beige
    0x000000, // Black
    0x0000FF, // Blue
    0x0095B6, // Blue-green
    0x8A2BE2, // Blue-violet
    0xDE5D83, // Blush
    0xCD7F32, // Bronze
    0x964B00, // Brown
    0x800020, // Burgundy
    0x702963, // Byzantium
    0x960018, // Carmine
    0xDE3163, // Cerise
    0x007BA7, // Cerulean
    0xF7E7CE, // Champagne
    0x7FFF00, // Chartreuse green
    0x7B3F00, // Chocolate
    0x0047AB, // Cobalt blue
    0x6F4E37, // Coffee
    0xB87333, // Copper
    0xF88379, // Coral
    0xDC143C, // Crimson
    0x00FFFF, // Cyan
    0xEDC9AF, // Desert sand
    0x7DF9FF, // Electric blue
    0x50C878, // Emerald
    0x00FF3F, // Erin
    0xFFD700, // Gold
    0x808080, // Gray
    0x00FF00, // Green
    0x3FFF00, // Harlequin
    0x4B0082, // Indigo
    0xFFFFF0, // Ivory
    0x00A86B, // Jade
    0x29AB87, // Jungle green
    0xB57EDC, // Lavender
    0xFFF700, // Lemon
    0xC8A2C8, // Lilac
    0xBFFF00, // Lime
    0xFF00FF, // Magenta
    0xFF00AF, // Magenta rose
    0x800000, // Maroon
    0xE0B0FF, // Mauve
    0x000080, // Navy blue
    0xCC7722, // Ocher
    0x808000, // Olive
    0xFFA500, // Orange
    0xFF4500, // Orange-red
    0xDA70D6, // Orchid
    0xFFE5B4, // Peach
    0xD1E231, // Pear
    0xCCCCFF, // Periwinkle
    0x1C39BB, // Persian blue
    0xFFC0CB, // Pink
    0x8E4585, // Plum
    0x003153, // Prussian blue
    0xCC8899, // Puce
    0x800080, // Purple
    0xE30B5C, // Raspberry
    0xFF0000, // Red
    0xC71585, // Red-violet
    0xFF007F, // Rose
    0xE0115F, // Ruby
    0xFA8072, // Salmon
    0x92000A, // Sangria
    0x0F52BA, // Sapphire
    0xFF2400, // Scarlet
    0xC0C0C0, // Silver
    0x708090, // Slate gray
    0xA7FC00, // Spring bud
    0x00FF7F, // Spring green
    0xD2B48C, // Tan
    0x483C32, // Taupe
    0x008080, // Teal
    0x40E0D0, // Turquoise
    0xEE82EE, // Violet
    0x40826D, // Viridian
    0xFFFFFF, // White
    0xFFFF00, // Yellow
];
