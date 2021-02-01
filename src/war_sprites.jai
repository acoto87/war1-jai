WarSpriteFrame :: struct {
    dx: s32;
    dy: s32;
    w: s32;
    h: s32;
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

createSprite :: (ctx: *WarContext, width: s32, height: s32, data: *u8) -> WarSprite {
    assert(ctx != null);
    assert(width >= 0 && height >= 0);

    sprite: WarSprite;
    sprite.frameWidth = width;
    sprite.frameHeight = height;
    sprite.framesCount = 1;

    sprite.image = nvgCreateImageRGBA(ctx.gfx, width, height, .NVG_IMAGE_NEAREST, data);

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

createSpriteFromFrames :: (ctx: *WarContext, frameWidth: s32, frameHeight: s32, frames: [] WarSpriteFrame) -> WarSprite {
    assert(ctx != null);
    assert(frameWidth >= 0 && frameHeight >= 0);
    assert(frames.count > 0);

    sprite: WarSprite;
    sprite.frameWidth = frameWidth;
    sprite.frameHeight = frameHeight;
    sprite.framesCount = cast(s32) frames.count;

    sprite.image = nvgCreateImageRGBA(ctx.gfx, frameWidth, frameHeight, .NVG_IMAGE_NEAREST, null);

    for i : range(s32, 0, frames.count) {
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
            sprite = createSprite(ctx, imageResource.width, imageResource.height, imageResource.pixels);
        }
        case WarResourceType.Sprite; {
            spriteResource := cast(*WarResourceSprite) resource;

            frameWidth := spriteResource.frameWidth;
            frameHeight := spriteResource.frameHeight;
            framesCount := spriteResource.framesCount;
            frames := cast([] WarSpriteFrame) spriteResource.frames;

            if (frameIndices.count > 0) {
                allFrames := frames;

                frames = allocArray(WarSpriteFrame, frameIndices.count);
                for i : range(s32, 0, frameIndices.count) {
                    frameIndex := frameIndices[i];
                    assert(frameIndex >= 0 && frameIndex < framesCount);

                    frames[i] = allFrames[frameIndex];
                }

                framesCount = cast(u16) frameIndices.count;
            }

            sprite = createSpriteFromFrames(ctx, frameWidth, frameHeight, frames);

            if (frameIndices.count > 0) {
                free(frames);
            }
        }
        case WarResourceType.Cursor; {
            cursorResource := cast(*WarResourceCursor) resource;
            sprite = createSprite(ctx, cursorResource.width, cursorResource.height, cursorResource.pixels);
        }
        case; {
            logError("Trying to load the resource of type %d as a sprite.\n", resource.type);
            assert(false);
        }
    }

    return sprite;
}

createSpriteFromResourceRef :: (ctx: *WarContext, spriteResourceRef: WarSpriteResourceRef) -> WarSprite {
    resource := getOrCreateResource(WarResourceSprite, ctx, cast(u32) spriteResourceRef.resourceIndex);
    return createSpriteFromResource(ctx, resource, spriteResourceRef.frameIndices);
}

createSpriteResourceRef :: (resourceIndex: s32, frameIndices: [] s32) -> WarSpriteResourceRef {
    spriteResourceRef: WarSpriteResourceRef;
    spriteResourceRef.resourceIndex = resourceIndex;
    spriteResourceRef.frameIndicesCount = cast(s32) frameIndices.count;
    if (frameIndices.count > 0) {
        arrayCopy(frameIndices, spriteResourceRef.frameIndices);
    }
    return spriteResourceRef;
}

invalidResourceRef :: inline () -> WarSpriteResourceRef {
    return createSpriteResourceRef(-1, s32.[]);
}

imageResourceRef :: (resourceIndex: s32) -> WarSpriteResourceRef {
    return createSpriteResourceRef(resourceIndex, s32.[]);
}

imageResourceRefFromPlayer :: (player: *WarPlayerInfo, hIdx: s32, oIdx: s32) -> WarSpriteResourceRef {
    return imageResourceRef(ifx player.race == WarRace.Humans then hIdx else oIdx);
}

spriteResourceRef :: (resourceIndex: s32, spriteIndex: s32) -> WarSpriteResourceRef {
    frameIndices: [1] s32;
    frameIndices[0] = spriteIndex;
    return createSpriteResourceRef(resourceIndex, frameIndices);
}

spriteResourceRefFromPlayer :: (player: *WarPlayerInfo, hIdx: s32, oIdx: s32, spriteIndex: s32) -> WarSpriteResourceRef {
    frameIndices: [1] s32;
    frameIndices[0] = spriteIndex;
    resourceIndex := ifx player.race == WarRace.Humans then hIdx else oIdx;
    return createSpriteResourceRef(resourceIndex, frameIndices);
}

updateSpriteImage :: (ctx: *WarContext, sprite: WarSprite, imageData: *u8) {
    if (sprite.image == 0) {
        logWarning("Trying to update a sprite with image: %d\n", sprite.image);
        return;
    }

    nvgUpdateImage(ctx.gfx, sprite.image, imageData);
}

renderSubSprite :: (ctx: *WarContext, sprite: WarSprite, rs: Rect, rd: Rect, scale: Vec2) {
    if (sprite.image == 0) {
        logWarning("Trying to render a sprite with image: %d\n", sprite.image);
        return;
    }

    nvgRenderSubImage(ctx.gfx, sprite.image, rs, rd, scale);
}

renderSprite :: (ctx: *WarContext, sprite: WarSprite, pos: Vec2, scale: Vec2) {
    if (sprite.image == 0) {
        logWarning("Trying to render a sprite with image: %d\n", sprite.image);
        return;
    }

    frameSize := vec2(sprite.frameWidth, sprite.frameHeight);
    rs := rect(VEC2_ZERO, frameSize);
    rd := rect(pos, frameSize);
    nvgRenderSubImage(ctx.gfx, sprite.image, rs, rd, scale);
}

getSpriteFrame :: (ctx: *WarContext, sprite: WarSprite, frameIndex: s32) -> WarSpriteFrame {
    assert(sprite.image != 0);
    assert(frameIndex >= 0 && frameIndex < sprite.framesCount);
    return sprite.frames[frameIndex];
}

freeSprite :: (ctx: *WarContext, sprite: WarSprite) {
    if (sprite.image == 0) {
        logWarning("Trying to free a sprite with image: %d\n", sprite.image);
        return;
    }

    for frame : sprite.frames {
        if (frame.data) {
            free(frame.data);
        }
    }

    nvgDeleteImage(ctx.gfx, sprite.image);
}
