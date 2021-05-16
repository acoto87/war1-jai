createAnimationFromResourceIndex :: (name: string,
                                     spriteResourceRef: WarSpriteResourceRef,
                                     frameDelay: f32,
                                     loop: bool) -> *SpriteAnimation
{
    sprite := createSpriteFromResourceRef(spriteResourceRef);
    return createAnimation(name, sprite, frameDelay, loop);
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
