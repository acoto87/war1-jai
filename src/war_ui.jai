createUIImage :: (ctx: *WarContext, name: string, spriteResourceRef: WarSpriteResourceRef, position: Vec2) -> *WarEntity {
    entity := createEntity(ctx, WarEntityType.Image);

    transform := createComponent(ctx, WarTransformComponent);
    transform.position = position;
    addComponent(ctx, entity, transform);

    frameIndicesCount: s32;
    frameIndices: [MAX_SPRITE_FRAME_COUNT] s32;

    sprite := createComponent(ctx, WarSpriteComponent);
    sprite.resourceIndex = spriteResourceRef.resourceIndex;
    sprite.frameIndex = 0;
    sprite.sprite = createSpriteFromResourceRef(ctx, spriteResourceRef);
    addComponent(ctx, entity, sprite);

    ui := createComponent(ctx, WarUIComponent);
    ui.name = name;
    addComponent(ctx, entity, ui);

    return entity;
}
