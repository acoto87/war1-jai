WarSpriteResourceRef :: struct {
    resourceIndex: s32;
    frameIndicesCount: s32;
    frameIndices: [MAX_SPRITE_FRAME_COUNT] s32;
}

createSpriteFromResource :: (resource: *WarResource, frameIndices: [] s32) -> Sprite {
    assert(resource != null);
    assert(frameIndices.count > 0);

    sprite: Sprite = ---;

    if resource.type == {
        case WarResourceType.Image; {
            imageResource := cast(*WarResourceImage) resource;
            sprite = createSprite(imageResource.width, imageResource.height, imageResource.pixels);
        }
        case WarResourceType.Sprite; {
            spriteResource := cast(*WarResourceSprite) resource;

            frameWidth := spriteResource.frameWidth;
            frameHeight := spriteResource.frameHeight;
            framesCount := spriteResource.framesCount;

            frames: [] SpriteFrame = spriteResource.frames;

            if (frameIndices.count > 0) {
                allFrames := frames;

                frames = allocArray(SpriteFrame, frameIndices.count);
                for i : range(s32, 0, frameIndices.count) {
                    frameIndex := frameIndices[i];
                    assert(frameIndex >= 0 && frameIndex < framesCount);

                    frames[i] = allFrames[frameIndex];
                }

                framesCount = cast(u16) frameIndices.count;
            }

            sprite = createSpriteFromFrames(frameWidth, frameHeight, frames);

            if (frameIndices.count > 0) {
                free(frames);
            }
        }
        case WarResourceType.Cursor; {
            cursorResource := cast(*WarResourceCursor) resource;
            sprite = createSprite(cursorResource.width, cursorResource.height, cursorResource.pixels);
        }
        case; {
            logError("Trying to load the resource of type %d as a sprite.\n", resource.type);
            assert(false);
        }
    }

    return sprite;
}

createSpriteFromResourceRef :: (spriteResourceRef: WarSpriteResourceRef) -> Sprite {
    resource := getOrCreateResource(WarResourceSprite, cast(u32) spriteResourceRef.resourceIndex);
    return createSpriteFromResource(resource, spriteResourceRef.frameIndices);
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

imageResourceRefFromPlayer :: (player: *PlayerInfo, hIdx: s32, oIdx: s32) -> WarSpriteResourceRef {
    return imageResourceRef(ifx player.race == cast(u16) WarRace.Humans then hIdx else oIdx);
}

spriteResourceRef :: (resourceIndex: s32, spriteIndex: s32) -> WarSpriteResourceRef {
    frameIndices: [1] s32;
    frameIndices[0] = spriteIndex;
    return createSpriteResourceRef(resourceIndex, frameIndices);
}

spriteResourceRefFromPlayer :: (player: *PlayerInfo, hIdx: s32, oIdx: s32, spriteIndex: s32) -> WarSpriteResourceRef {
    frameIndices: [1] s32;
    frameIndices[0] = spriteIndex;
    resourceIndex := ifx player.race == cast(u16) WarRace.Humans then hIdx else oIdx;
    return createSpriteResourceRef(resourceIndex, frameIndices);
}
