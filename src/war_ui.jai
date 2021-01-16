createUIImage :: (ctx: *WarContext, name: string, spriteResourceRef: WarSpriteResourceRef, position: Vec2) -> *WarEntity {
    entity := createEntity(ctx, WarEntityType.Image);

    transform := createComponent(ctx, WarComponentType.Transform);
    transform.position = position;
    addComponent(ctx, entity, transform);

    frameIndicesCount: s32;
    frameIndices: [MAX_SPRITE_FRAME_COUNT] s32;

    sprite := createComponent(ctx, WarComponentType.Sprite);
    sprite.resourceIndex = spriteResourceRef.resourceIndex;
    sprite.frameIndex = 0;
    sprite.sprite = createSpriteFromResourceIndex(ctx, spriteResourceRef.resourceIndex);
    addComponent(ctx, entity, sprite);

    ui := createComponent(ctx, WarComponentType.UI);
    ui.name = name;
    addComponent(ctx, entity, ui);

    return entity;
}