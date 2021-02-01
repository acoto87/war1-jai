WarAnimationStatus :: enum {
    NotStarted;
    Running;
    Finished;
}

WarSpriteAnimation :: struct {
    name: string;
    loop: bool;
    loopDelay: f32;

    offset: Vec2;
    scale: Vec2;

    frameDelay: f32;
    frames: List(s32);
    sprite: WarSprite;

    animTime: f32;
    loopTime: f32;
    status: WarAnimationStatus;
}

equalsAnim :: inline (anim1: WarSpriteAnimation, anim2: WarSpriteAnimation) -> bool {
    return anim1.name == anim2.name;
}

equalsAnim :: inline (anim1: *WarSpriteAnimation, anim2: *WarSpriteAnimation) -> bool {
    return anim1.name == anim2.name;
}

createAnimation :: (name: string, sprite: WarSprite, frameDelay: f32, loop: bool) -> *WarSpriteAnimation {
    anim := alloc(WarSpriteAnimation);
    anim.name = allocString(name);
    anim.loop = loop;
    anim.offset = VEC2_ZERO;
    anim.scale = VEC2_ONE;
    anim.frameDelay = frameDelay;
    anim.sprite = sprite;
    anim.animTime = 0;
    anim.loopTime = 0;
    anim.status = WarAnimationStatus.NotStarted;
    init(*anim.frames);
    return anim;
}

createAnimationFromResourceIndex :: (
    ctx: *WarContext,
    name: string,
    spriteResourceRef: WarSpriteResourceRef,
    frameDelay: f32,
    loop: bool) -> *WarSpriteAnimation
{
    assert(ctx != null);

    sprite := createSpriteFromResourceRef(ctx, spriteResourceRef);
    return createAnimation(name, sprite, frameDelay, loop);
}

addAnimation :: (ctx: *WarContext, entity: *WarEntity, animation: *WarSpriteAnimation) {
    assert(ctx != null);

    animComponent := getComponent(ctx, entity, WarAnimationsComponent);
    assert(animComponent != null);

    add(*animComponent.animations, animation);
}

addAnimationFrame :: inline (animation: *WarSpriteAnimation, frameIndex: s32) {
    add(*animation.frames, frameIndex);
}

addAnimationFrames :: (animation: *WarSpriteAnimation, frameIndices: ..s32) {
    assert(animation != null);

    for index : frameIndices {
        addAnimationFrame(animation, index);
    }
}

addAnimationFramesRange :: (animation: *WarSpriteAnimation, from: s32, to: s32) {
    assert(animation != null);
    assert(from >= 0 && to >= 0);

    for i : range(s32, from, to, toInclusive=true) {
        addAnimationFrame(animation, i);
    }
}

getAnimationDuration :: inline (animation: *WarSpriteAnimation) -> f32 {
    assert(animation != null);
    return animation.frameDelay * animation.frames.count;
}

freeAnimation :: (animation: *WarSpriteAnimation) {
    assert(animation != null);

    logInfo("Freeing animation: %\n", animation.name);

    free(animation.name);

    uninit(*animation.frames);

    for frame : animation.sprite.frames {
        free(frame.data);
    }

    free(animation);
}

findAnimationIndex :: (ctx: *WarContext, entity: *WarEntity, name: string) -> s32 {
    assert(ctx != null);
    assert(entity != null);

    animComponent := getComponent(ctx, entity, WarAnimationsComponent);
    assert(animComponent != null);

    for anim, i : animComponent.animations {
        if (anim.name == name) {
            return cast(s32) i;
        }
    }

    return -1;
}

findAnimation :: (ctx: *WarContext, entity: *WarEntity, name: string) -> *WarSpriteAnimation {
    assert(ctx != null);
    assert(entity != null);

    animComponent := getComponent(ctx, entity, WarAnimationsComponent);
    assert(animComponent != null);

    for anim, i : animComponent.animations {
        if (anim.name == name) {
            return anim;
        }
    }

    return null;
}

containsAnimation :: inline (ctx: *WarContext, entity: *WarEntity, name: string) -> bool {
    return findAnimationIndex(ctx, entity, name) >= 0;
}

removeAnimation :: (ctx: *WarContext, entity: *WarEntity, name: string) {
    assert(ctx != null);
    assert(entity != null);

    logInfo("Trying to remove animation: %\n", name);

    index := findAnimationIndex(ctx, entity, name);
    if (index >= 0) {
        animComponent := getComponent(ctx, entity, WarAnimationsComponent);
        assert(animComponent != null);

        removeAt(*animComponent.animations, index);
    }
}

resetAnimation :: (animation: *WarSpriteAnimation) {
    assert(animation != null);

    animation.animTime = 0;
    animation.loopTime = 0;
    animation.status = WarAnimationStatus.NotStarted;
}

updateAnimation :: (ctx: *WarContext, entity: *WarEntity, animation: *WarSpriteAnimation) {
    assert(ctx != null);
    assert(ctx.scene != null);

    if (animation.status == WarAnimationStatus.Finished) {
        removeAnimation(ctx, entity, animation.name);
        return;
    }

    animation.status = WarAnimationStatus.Running;

    if (animation.loopTime > 0) {
        animation.loopTime -= getScaledSpeed(ctx, ctx.deltaTime);
        return;
    }

    dt := ctx.deltaTime / getAnimationDuration(animation);
    dt = getScaledSpeed(ctx, dt);

    animation.animTime += dt;

    if (animation.animTime >= 1) {
        animation.animTime = 1;
        animation.status = WarAnimationStatus.Finished;

        if(animation.loop) {
            resetAnimation(animation);
            animation.loopTime = animation.loopDelay;
            animation.status = WarAnimationStatus.Running;
        }
    }
}

updateAnimations :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;
    for * entry : entityManager.entitiesById {
        entity := entry.value;
        assert(entity != null);

        animComponent := getComponent(ctx, entity, WarAnimationsComponent);
        if (animComponent != null && animComponent.enabled) {
            for anim : animComponent.animations {
                updateAnimation(ctx, entity, anim);
            }
        }
    }
}

// WarSpriteAnimation* createDamageAnimation(WarContext* context, WarEntity* entity, char* name, int damageLevel)
// {
//     s32 resourceIndex = damageLevel == 1 ? WAR_BUILDING_DAMAGE_1_RESOURCE : WAR_BUILDING_DAMAGE_2_RESOURCE;
//     WarSpriteResourceRef spriteResourceRef = imageResourceRef(resourceIndex);
//     WarSprite sprite = createSpriteFromResourceIndex(context, spriteResourceRef);
//     WarSpriteAnimation* anim = createAnimation(name, sprite, 0.2f, true);
//     anim->offset = vec2Subv(getUnitSpriteCenter(entity), vec2i(halfi(sprite.frameWidth), sprite.frameHeight));

//     for(s32 i = 0; i < 4; i++)
//         addAnimationFrame(anim, i);

//     addAnimation(entity, anim);

//     return anim;
// }

// WarSpriteAnimation* createCollapseAnimation(WarContext* context, WarEntity* entity, const char* name)
// {
//     vec2 unitFrameSize = getUnitFrameSize(entity);
//     vec2 unitSpriteSize = getUnitSpriteSize(entity);

//     WarSpriteResourceRef spriteResourceRef = imageResourceRef(WAR_BUILDING_COLLAPSE_RESOURCE);
//     WarSprite sprite = createSpriteFromResourceIndex(context, spriteResourceRef);
//     WarSpriteAnimation* anim = createAnimation(name, sprite, 0.1f, false);

//     vec2 animFrameSize = vec2i(anim->sprite.frameWidth, anim->sprite.frameHeight);

//     // this is the scale of the explosion animation sprites with respect to the size of the building
//     f32 animScale = unitSpriteSize.x / animFrameSize.x;

//     // if the offset is based on the size of the frame, and it's scaled, then the offset must take into
//     // account the scale to make the calculations
//     f32 offsetx = halff(unitFrameSize.x - unitSpriteSize.x);
//     f32 offsety = halff(unitFrameSize.y - unitSpriteSize.y) - (animFrameSize.y * animScale - unitSpriteSize.y);

//     anim->scale = vec2f(animScale, animScale);
//     anim->offset = vec2f(offsetx, offsety);

//     for(s32 i = 0; i < 17; i++)
//         addAnimationFrame(anim, i);

//     addAnimation(entity, anim);

//     return anim;
// }

// WarSpriteAnimation* createExplosionAnimation(WarContext* context, WarEntity* entity, vec2 position)
// {
//     WarSpriteResourceRef spriteResourceRef = imageResourceRef(WAR_EXPLOSION_RESOURCE);
//     WarSprite sprite = createSpriteFromResourceIndex(context, spriteResourceRef);

//     char name[ANIM_NAME_MAX_LENGTH];
//     sprintf(name, "explosion_%.2f_%.2f", position.x, position.y);
//     WarSpriteAnimation* anim = createAnimation(name, sprite, 0.1f, false);

//     f32 offsetx = position.x - halff(sprite.frameWidth);
//     f32 offsety = position.y - halff(sprite.frameHeight);
//     anim->offset = vec2f(offsetx, offsety);

//     for(s32 i = 0; i < 6; i++)
//         addAnimationFrame(anim, i);

//     addAnimation(entity, anim);

//     return anim;
// }

// WarSpriteAnimation* createRainOfFireExplosionAnimation(WarContext* context, WarEntity* entity, vec2 position)
// {
//     WarSpriteResourceRef spriteResourceRef = imageResourceRef(WAR_RAIN_OF_FIRE_EXPLOSION_RESOURCE);
//     WarSprite sprite = createSpriteFromResourceIndex(context, spriteResourceRef);

//     char name[ANIM_NAME_MAX_LENGTH];
//     sprintf(name, "explosion_%.2f_%.2f", position.x, position.y);
//     WarSpriteAnimation* anim = createAnimation(name, sprite, 0.1f, false);

//     f32 offsetx = position.x - halff(sprite.frameWidth);
//     f32 offsety = position.y - halff(sprite.frameHeight);
//     anim->offset = vec2f(offsetx, offsety);

//     for(s32 i = 3; i < 6; i++)
//         addAnimationFrame(anim, i);

//     addAnimation(entity, anim);

//     return anim;
// }

// WarSpriteAnimation* createSpellAnimation(WarContext* context, WarEntity* entity, vec2 position)
// {
//     WarSpriteResourceRef spriteResourceRef = imageResourceRef(WAR_SPELL_RESOURCE);
//     WarSprite sprite = createSpriteFromResourceIndex(context, spriteResourceRef);

//     char name[ANIM_NAME_MAX_LENGTH];
//     sprintf(name, "spell_%.2f_%.2f", position.x, position.y);
//     WarSpriteAnimation* anim = createAnimation(name, sprite, 0.4f, false);

//     f32 offsetx = position.x - halff(sprite.frameWidth);
//     f32 offsety = position.y - halff(sprite.frameHeight);
//     anim->offset = vec2f(offsetx, offsety);

//     for(s32 i = 0; i < 6; i++)
//         addAnimationFrame(anim, i);

//     addAnimation(entity, anim);

//     return anim;
// }

// WarSpriteAnimation* createPoisonCloudAnimation(WarContext* context, WarEntity* entity, vec2 position)
// {
//     WarSpriteResourceRef spriteResourceRef = imageResourceRef(WAR_POISON_CLOUD_RESOURCE);
//     WarSprite sprite = createSpriteFromResourceIndex(context, spriteResourceRef);

//     char name[ANIM_NAME_MAX_LENGTH];
//     sprintf(name, "poison_cloud_%.2f_%.2f", position.x, position.y);
//     WarSpriteAnimation* anim = createAnimation(name, sprite, 0.5f, true);

//     f32 offsetx = position.x - halff(sprite.frameWidth);
//     f32 offsety = position.y - halff(sprite.frameHeight);
//     anim->offset = vec2f(offsetx, offsety);

//     for(s32 i = 0; i < 4; i++)
//         addAnimationFrame(anim, i);

//     addAnimation(entity, anim);

//     return anim;
// }
