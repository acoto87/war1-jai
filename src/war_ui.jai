WarCursorType :: enum {
    Arrow            :: 263;
    Invalid          :: 264;
    YellowCrosshair  :: 265;
    RedCrosshair     :: 266;
    YellowCrosshair2 :: 267;
    MagnifyingGlass  :: 268;
    GreenCrosshair   :: 269;
    Watch            :: 270;
    ArrowUp          :: 271;
    ArrowUpRight     :: 272;
    ArrowRight       :: 273;
    ArrowBottomRight :: 274;
    ArrowBottom      :: 275;
    ArrowBottomLeft  :: 276;
    ArrowLeft        :: 277;
    ArrowUpLeft      :: 278;
}

createUIImage :: (name: string, spriteResourceRef: WarSpriteResourceRef, position: Vec2) -> *Entity {
    entity := createEntity(EntityType.Image);
    addTransformComponent(entity, position);
    addUIComponent(entity, name);
    addSpriteComponentFromResource(entity, spriteResourceRef);
    return entity;
}

createUITextButton :: (name: string,
                       fontIndex: s32,
                       fontSize: f32,
                       text: string,
                       backgroundNormalRef: WarSpriteResourceRef,
                       backgroundPressedRef: WarSpriteResourceRef,
                       foregroundRef: WarSpriteResourceRef,
                       position: Vec2) -> *Entity
{
    entity := createEntity(EntityType.Button);
    addTransformComponent(entity, position);
    addUIComponent(entity, name);
    addSpriteComponentFromResource(entity, foregroundRef);
    textComponent := addTextComponent(entity, fontIndex, fontSize, text);
    buttonComponent := addButtonComponentFromResource(entity, backgroundNormalRef, backgroundPressedRef);

    textComponent.boundings = vec2(buttonComponent.backgroundNormalSprite.frameWidth, buttonComponent.backgroundNormalSprite.frameHeight);
    textComponent.horizontalAlign = TextAlignment.Center;
    textComponent.verticalAlign = TextAlignment.Middle;

    return entity;
}

createUIImageButton :: (name: string,
                        backgroundNormalRef: WarSpriteResourceRef,
                        backgroundPressedRef: WarSpriteResourceRef,
                        foregroundRef: WarSpriteResourceRef,
                        position: Vec2) -> *Entity
{
    entity := createEntity(EntityType.Button);
    addTransformComponent(entity, position);
    addUIComponent(entity, name);
    addSpriteComponentFromResource(entity, foregroundRef);
    addButtonComponentFromResource(entity, backgroundNormalRef, backgroundPressedRef);
    return entity;
}

createUICursor :: (name: string, type: WarCursorType, position: Vec2) -> *Entity {
    resource := getOrCreateResource(WarResourceCursor, cast(u32) type);
    assert(resource.type == WarResourceType.Cursor);

    entity := createEntity(EntityType.Cursor);
    addTransformComponent(entity, position);
    addUIComponent(entity, name);
    addSpriteComponentFromResource(entity, imageResourceRef(cast(s32) type));
    addCursorComponent(entity, type, vec2(resource.hotx, resource.hoty));
    return entity;
}

changeCursorType :: (entity: *Entity, type: WarCursorType) {
    assert(entity != null);

    cursor := getComponent(entity, CursorComponent);
    assert(cursor != null);

    if (cursor.cursorType != cast(u16) type) {
        resource := getOrCreateResource(WarResourceCursor, cast(u32) type);
        assert(resource.type == WarResourceType.Cursor);

        removeComponent(entity, ComponentType.Cursor);
        addCursorComponent(entity, cast(u16) type, vec2(resource.hotx, resource.hoty));

        removeComponent(entity, ComponentType.Sprite);
        addSpriteComponentFromResource(entity, imageResourceRef(cast(s32) type));
    }
}

// updateUICursor :: () {
//     ctx := cast(*WarContext) context.gameContext;
//     assert(ctx != null);

//     input := *ctx.input;

//     entity := findUIEntity("cursor");
//     if (entity != null) {
//         cursor := getComponent(entity, CursorComponent);
//         assert(cursor != null);

//         transform := getComponent(entity, TransformComponent);
//         assert(transform != null);

//         transform.position = input.pos - cursor.hot;
//         changeCursorType(entity, WarCursorType.Arrow);
//     }
// }
