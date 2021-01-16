WarSpriteFrame :: struct {
    dx: u8;
    dy: u8;
    w: u8;
    h: u8;
    off: u32;
    data: *u8;
}

WarSprite :: struct {
    image: s32;
    frameWidth: s32;
    frameHeight: s32;
    framesCount: s32;
    frames: [MAX_SPRITE_FRAME_COUNT] WarSpriteFrame;
}

WarSpriteResourceRef :: struct {
    resourceIndex: s32;
    frameIndicesCount: s32;
    frameIndices: [MAX_SPRITE_FRAME_COUNT] s32;
}

createSprite :: (ctx: *WarContext, width: u32, height: u32, data: [] u8) -> WarSprite {
    assert(ctx != null);
    assert(width >= 0 && height >= 0);

    sprite: WarSprite;
    sprite.frameWidth = width;
    sprite.frameHeight = height;
    sprite.framesCount = 1;

    sprite.image = nvgCreateImageRGBA(ctx.gfx, width, height, NVG_IMAGE_NEAREST, data);

    sprite.frames[0].dx = 0;
    sprite.frames[0].dy = 0;
    sprite.frames[0].w = width;
    sprite.frames[0].h = height;
    sprite.frames[0].off = 0;
    sprite.frames[0].data = alloc(u8, width * height * 4);

    if (data) {
        memoryCopy(sprite.frames[0].data, data, width * height * 4);
    }

    return sprite;
}

createSpriteFromFrames :: (ctx: *WarContext, frameWidth: u32, frameHeight: u32, frames: [] WarSpriteFrame) -> WarSprite {
    assert(ctx != null);
    assert(frameWidth >= 0 && frameHeight >= 0);
    assert(frames.count > 0);

    sprite: WarSprite;
    sprite.frameWidth = frameWidth;
    sprite.frameHeight = frameHeight;
    sprite.framesCount = frames.count;

    sprite.image = nvgCreateImageRGBA(ctx.gfx, frameWidth, frameHeight, NVG_IMAGE_NEAREST, null);

    for i : 0..frames.count-1 {
        sprite.frames[i].dx = frames[i].dx;
        sprite.frames[i].dy = frames[i].dy;
        sprite.frames[i].w = frames[i].w;
        sprite.frames[i].h = frames[i].h;
        sprite.frames[i].off = 0;
        sprite.frames[i].data = alloc(u8, frameWidth * frameHeight * 4);

        if (frames[i].data) {
            memoryCopy(sprite.frames[i].data, frames[i].data, frameWidth * frameHeight * 4);
        }
    }

    return sprite;
}

createSpriteFromResource :: (ctx: *WarContext, resource: *WarResource, frameIndices: [] s32) -> WarSprite {
    assert(ctx != null);
    assert(resource != null);
    assert(frameIndices.count > 0);

    sprite: WarSprite;

    if resource.type == {
        case WarResourceType.Image; {
            imageResource := cast(*WarResourceImage) resource;
            sprite = createSprite(ctx, imageResource.width, imageResource.height, imageResource.data);
        }
        case WarResourceType.Sprite; {
            spriteResource := cast(*WarResourceSprite) resource;

            frameWidth := spriteResource.frameWidth;
            frameHeight := spriteResource.frameHeight;
            framesCount := spriteResource.framesCount;
            frames := spriteResource.frames;

            if (frameIndices.count > 0) {
                allFrames := frames;

                frames = allocArray(WarSpriteFrame, frameIndices.count);
                for frameIndex : frameIndices {
                    assert(frameIndex >= 0 && frameIndex < framesCount);
                    frames[i] = allFrames[frameIndex];
                }

                framesCount = frameIndices.count;
            }

            sprite = createSpriteFromFrames(ctx, frameWidth, frameHeight, frames);

            if (frameIndices.count > 0) {
                freeArray(frames);
            }
        }
        case WarResourceType.Cursor; {
            cursorResource := cast(*WarResource) resource;
            sprite = createSprite(ctx, cursorResource.width, cursorResource.height, cursorResource.data);
        }
        case; {
            logError("Trying to load the resource of type %d as a sprite.\n", resource.type);
            assert(false);
            break;
        }
    }

    return sprite;
}

createSpriteFromResourceIndex :: (ctx: *WarContext, spriteResourceRef: WarSpriteResourceRef) -> WarSprite {
    resource := getOrCreateResource(WarResourceSprite, ctx, spriteResourceRef.resourceIndex);
    return createSpriteFromResource(ctx, resource, spriteResourceRef.frameIndices);
}

updateSpriteImage :: (ctx: *WarContext, sprite: WarSprite, data: [] u8) {
    if (!sprite.image) {
        logWarning("Trying to update a sprite with image: %d\n", sprite.image);
        return;
    }

    nvgUpdateImage(ctx.gfx, sprite.image, data);
}

renderSubSprite :: (ctx: *WarContext, sprite: WarSprite, rs: Rect, rd: Rect, scale: Vec2) {
    if (!sprite.image) {
        logWarning("Trying to render a sprite with image: %d\n", sprite.image);
        return;
    }

    nvgRenderSubImage(ctx.gfx, sprite.image, rs, rd, scale);
}

renderSprite :: (ctx: *WarContext, sprite: WarSprite, pos: Vec2, scale: Vec2) {
    if (!sprite.image) {
        logWarning("Trying to render a sprite with image: %d\n", sprite.image);
        return;
    }

    frameSize := vec2(sprite.frameWidth, sprite.frameHeight);
    rs := rectv(VEC2_ZERO, frameSize);
    rd := rectv(pos, frameSize);
    nvgRenderSubImage(ctx.gfx, sprite.image, rs, rd, scale);
}

getSpriteFrame :: (ctx: *WarContext, sprite: WarSprite, frameIndex: s32) -> WarSpriteFrame {
    assert(sprite.image);
    assert(frameIndex >= 0 && frameIndex < sprite.framesCount);
    return sprite.frames[frameIndex];
}

freeSprite :: (ctx: *WarContext, sprite: WarSprite) {
    if (!sprite.image) {
        logWarning("Trying to free a sprite with image: %d\n", sprite.image);
        return;
    }

    for frame : sprite.frames {
        if (sprite.frames[i].data) {
            free(sprite.frames[i].data);
        }
    }

    nvgDeleteImage(ctx.gfx, sprite.image);
}
