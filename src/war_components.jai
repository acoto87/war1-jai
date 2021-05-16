addSpriteComponentFromResource :: (entity: *Entity, spriteResourceRef: WarSpriteResourceRef) -> *SpriteComponent {
    if (spriteResourceRef.resourceIndex < 0) {
        logWarning("Trying to create a sprite component with invalid resource index: %\n", spriteResourceRef.resourceIndex);
        return null;
    }

    sprite := createSpriteFromResourceRef(spriteResourceRef);
    component := addSpriteComponent(entity, sprite);
    component.resourceIndex = spriteResourceRef.resourceIndex;
    return component;
}

addCursorComponent :: inline (entity: *Entity, cursorType: WarCursorType, hot: Vec2) -> *CursorComponent {
    return addCursorComponent(entity, cast(u16) cursorType, hot);
}

addButtonComponentFromResource :: (entity: *Entity, normalRef: WarSpriteResourceRef, pressedRef: WarSpriteResourceRef) -> *ButtonComponent {
    if (normalRef.resourceIndex < 0) {
        logWarning("Trying to create a button component with invalid resource index: %\n", normalRef.resourceIndex);
        return null;
    }

    if (pressedRef.resourceIndex < 0) {
        logWarning("Trying to create a button component with invalid resource index: %\n", pressedRef.resourceIndex);
        return null;
    }

    normalSprite := createSpriteFromResourceRef(normalRef);
    pressedSprite := createSpriteFromResourceRef(pressedRef);
    return addButtonComponent(entity, normalSprite, pressedSprite);
}
