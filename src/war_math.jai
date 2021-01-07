rad2Deg :: inline (x: f32) -> f32 {
    return (x * 180 / PI);
}

deg2Rad :: inline (x: f32) -> f32 {
    return (x * PI / 180);
}

Vec2 :: struct {
    x, y: f32;
}

VEC2_ZERO :: Vec2.{};
VEC2_ONE :: Vec2.{ x = 1.0, y = 1.0 };
VEC2_LEFT :: Vec2.{ x = -1.0, y = 0.0 };
VEC2_UP :: Vec2.{ x = 0.0, x = -1.0 };
VEC2_RIGHT :: Vec2.{ x = 1.0, y = 0.0 };
VEC2_DOWN :: Vec2.{ x = 0.0, y = 1.0 };

vec2 :: inline (x: f32, y: f32) -> Vec2 {
    r: Vec2 = ---;
    r.y = y;
    r.x = x;
    return r;
}

isZero :: inline (v: Vec2) -> bool {
    return v == VEC2_ZERO;
}

lengthSqr :: inline (v: Vec2) -> f32 {
    return v.x * v.x + v.y * v.y;
}

length :: inline (v: Vec2) -> f32 {
    return sqrtf(lengthSqr(v));
}

distanceSqr :: inline (v1: Vec2, v2: Vec2) -> f32 {
    dx := v1.x - v2.x;
    dy := v1.y - v2.y;
    return dx * dx + dy * dy;
}

distance :: inline (v1: Vec2, v2: Vec2) -> f32 {
    return sqrtf(distanceSqr(v1, v2));
}

distanceInTiles :: inline (v1: Vec2, v2: Vec2) -> s32 {
    dx := v1.x - v2.x;
    dy := v1.y - v2.y;
    return cast(s32) max(abs(dx), abs(dy));
}

normalize :: inline (v: Vec2) -> Vec2 {
    len := length(v);
    return ifx len != 0 then (v / len) else VEC2_ZERO;
}

dot :: inline (v1: Vec2, v2: Vec2) -> f32 {
    return v1.x * v2.x + v1.y * v2.y;
}

operator == :: (v1: Vec2, v2: Vec2) -> bool {
    return v1.x == v2.x && v1.y == v2.y;
}

operator + :: (v1: Vec2, v2: Vec2) -> Vec2 {
    r: Vec2 = ---;
    r.x = v1.x + v2.x;
    r.y = v1.y + v2.y;
    return r;
}

operator + :: (v: Vec2, x: s32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x + x;
    r.y = v.y + x;
    return r;
}

operator + :: (v: Vec2, x: f32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x + x;
    r.y = v.y + x;
    return r;
}

operator - :: (v1: Vec2, v2: Vec2) -> Vec2 {
    r: Vec2 = ---;
    r.x = v1.x - v2.x;
    r.y = v1.y - v2.y;
    return r;
}

operator - :: (v: Vec2, x: s32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x - x;
    r.y = v.y - x;
    return r;
}

operator - :: (v: Vec2, x: f32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x - x;
    r.y = v.y - x;
    return r;
}

operator * :: (v1: Vec2, v2: Vec2) -> Vec2 {
    r: Vec2 = ---;
    r.x = v1.x * v2.x;
    r.y = v1.y * v2.y;
    return r;
}

operator * :: (v: Vec2, x: s32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x * x;
    r.y = v.y * x;
    return r;
}

operator * :: (v: Vec2, x: f32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x * x;
    r.y = v.y * x;
    return r;
}

operator / :: (v: Vec2, x: s32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x / x;
    r.y = v.y / x;
    return r;
}

operator / :: (v: Vec2, x: f32) -> Vec2 {
    r: Vec2 = ---;
    r.x = v.x / x;
    r.y = v.y / x;
    return r;
}

// Rect
Rect :: struct {
    x, y: f32;
    w, h: f32;
}

RECT_EMPTY :: Rect.{};

topLeft :: inline (r: Rect) -> Vec2 { return vec2(r.x, r.y); }
topRight :: inline (r: Rect) -> Vec2 { return vec2(r.x + r.w, r.y); }
bottomLeft :: inline (r: Rect) -> Vec2 { return vec2(r.x, r.y + r.h); }
bottomRight :: inline (r: Rect) -> Vec2 { return vec2(r.x + r.w, r.y + r.h); }
size :: inline (r: Rect) -> Vec2 { return vec2(r.w, r.h); }

rectf :: inline (x: f32, y: f32, w: f32, h: f32) -> Rect {
    r: Rect = ---;
    r.x = x;
    r.y = y;
    r.w = w;
    r.h = h;
    return r;
}

recti :: inline (x: s32, y: s32, w: s32, h: s32) -> Rect {
    r: Rect = ---;
    r.x = cast(f32) x;
    r.y = cast(f32) y;
    r.w = cast(f32) w;
    r.h = cast(f32) h;
    return r;
}

rectpf :: inline (x1: f32, y1: f32, x2: f32, y2: f32) -> Rect {
    return rectf(min(x1, x2), min(y1, y2), abs(x1 - x2), abs(y1 - y2));
}

rectv :: inline (pos: Vec2, size: Vec2) -> Rect {
    return rectf(pos.x, pos.y, size.x, size.y);
}

rects :: inline (size: Vec2) -> Rect {
    return rectf(0.0, 0.0, size.x, size.y);
}

contains :: inline (r: Rect, x: f32, y: f32) -> bool {
    return x >= r.x && x <= r.x + r.w &&
           y >= r.y && y <= r.y + r.h;
}

intersects :: inline (r1: Rect, r2: Rect) -> bool {
    return !(r1.x + r1.w < r2.x || r1.x > r2.x + r2.w ||
             r1.y + r1.h < r2.y || r1.y > r2.y + r2.h);
}

scale :: inline (r: Rect, s: f32) -> Rect {
    return rectf(
        r.x * s,
        r.y * s,
        r.w * s,
        r.h * s
    );
}

translate :: inline (r: Rect, x: f32, y: f32) -> Rect {
    return rectf(
        r.x + x,
        r.y + y,
        r.w,
        r.h
    );
}

center :: inline (r: Rect) -> Vec2 {
    return vec2(r.x + r.w * 0.5, r.y + r.h * 0.5);
}

expand :: inline (r: Rect, dx: f32, dy: f32) -> Rect {
    return rectf(
        r.x - dx,
        r.y - dy,
        r.w + dx * 2,
        r.h + dy * 2
    );
}

getClosestPointOnRect :: (p: Vec2, r: Rect) -> Vec2 {
    left := r.x;
    top := r.y;
    right := r.x + r.w - 1;
    bottom := r.y + r.h - 1;

    // top-left
    if (p.x < left && p.y < top)
        return vec2(left, top);

    // top-center
    if (p.x >= left && p.x <= right && p.y < top)
        return vec2(p.x, top);

    // top-right
    if (p.x > right && p.y < top)
        return vec2(right, top);

    // middle-right
    if (p.x > right && p.y >= top && p.y <= bottom)
        return vec2(right, p.y);

    // bottom-right
    if (p.x > right && p.y > bottom)
        return vec2(right, bottom);

    // bottom-center
    if (p.x >= left && p.x <= right && p.y > bottom)
        return vec2(p.x, bottom);

    // bottom-left
    if (p.x < left && p.y > bottom)
        return vec2(left, bottom);

    // middle-left
    if (p.x < left && p.y >= top && p.y <= bottom)
        return vec2(left, p.y);

    // the point is inside the rect
    return p;
}

#scope_file

#import "utils";
