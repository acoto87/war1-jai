setUIEntityStatus :: inline (ctx: *WarContext, entity: *WarEntity, enabled: bool) {
    setComponentStatus(ctx, entity, WarComponentType.UI, enabled);
}

clearUIText :: (ctx: *WarContext, entity: *WarEntity) {
    assert(ctx != null);
    assert(entity != null);

    textComponent := getComponent(ctx, entity, WarTextComponent);
    assert(textComponent != null);

    free(textComponent.text);

    textComponent.text = "";
    textComponent.enabled = false;
}

setUIText :: (ctx: *WarContext, entity: *WarEntity, text: string) {
    assert(ctx != null);
    assert(entity != null);

    textComponent := getComponent(ctx, entity, WarTextComponent);
    assert(textComponent != null);

    free(textComponent.text);

    textComponent.text = allocString(text);
    textComponent.enabled = true;
}

setUITextFormat :: (ctx: *WarContext, entity: *WarEntity, format: string, args: ..Any) {
    assert(ctx != null);
    assert(entity != null);

    text := tprint(format, args);
    setUIText(ctx, entity, text);
}

setUIImage :: (ctx: *WarContext, entity: *WarEntity, frameIndex: s32) {
    assert(ctx != null);
    assert(entity != null);

    sprite := getComponent(ctx, entity, WarSpriteComponent);
    assert(sprite != null);

    sprite.frameIndex = frameIndex;
    sprite.enabled = frameIndex >= 0;
}

setUIRectWidth :: (ctx: *WarContext, entity: *WarEntity, width: s32) {
    assert(ctx != null);
    assert(entity != null);

    rect := getComponent(ctx, entity, WarRectComponent);
    assert(rect != null);

    rect.size.x = cast(f32) width;
    rect.enabled = width > 0;
}

clearUITooltip :: (ctx: *WarContext, entity: *WarEntity) {
    assert(ctx != null);
    assert(entity != null);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    free(button.tooltip);
    button.tooltip = "";
}

setUITooltip :: (ctx: *WarContext, entity: *WarEntity, highlightIndex: s32, highlightCount: s32, text: string) {
    assert(ctx != null);
    assert(entity != null);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    free(button.tooltip);

    button.highlightIndex = highlightIndex;
    button.highlightCount = highlightCount;
    button.tooltip = text;
}

setUITextBoundings :: inline (ctx: *WarContext, entity: *WarEntity, value: Vec2) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.boundings = value;
}

setUITextHorizontalAlign :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextAlignment) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.horizontalAlign = value;
}

setUITextVerticalAlign :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextAlignment) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.verticalAlign = value;
}

setUITextLineAlign :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextAlignment) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.lineAlign = value;
}

setUITextWrapping :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextWrapping) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.wrapping = value;
}

setUITextColor :: inline (ctx: *WarContext, entity: *WarEntity, value: WarColor) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.fontColor = value;
}

setUITextHighlight :: inline (ctx: *WarContext, entity: *WarEntity, index: s32, count: s32) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.highlightIndex = index;
    text.highlightCount = count;
}

setUITextHighlightColor :: inline (ctx: *WarContext, entity: *WarEntity, color: WarColor) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.highlightColor = color;
}

setUITextMultiline :: inline (ctx: *WarContext, entity: *WarEntity, value: bool) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.multiline = value;
}

setUITextLineHeight :: inline (ctx: *WarContext, entity: *WarEntity, value: f32) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.lineHeight = value;
}

setUITextTrimming :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextTrimming) {
    assert(ctx != null);
    assert(entity != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.trimming = value;
}

setUIButtonInteractive :: inline (ctx: *WarContext, entity: *WarEntity, value: bool) {
    assert(ctx != null);
    assert(entity != null);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    button.interactive = value;
}

setUIButtonHotKey :: inline (ctx: *WarContext, entity: *WarEntity, key: WarKeys) {
    assert(ctx != null);
    assert(entity != null);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    button.hotKey = key;
}

setUIButtonClickHandler :: inline (ctx: *WarContext, entity: *WarEntity, handler: WarClickHandler) {
    assert(ctx != null);
    assert(entity != null);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    button.clickHandler = handler;
}

setUIButtonStatus :: inline (ctx: *WarContext, entity: *WarEntity, enabled: bool) {
    setComponentStatus(ctx, entity, WarComponentType.Button, enabled);
}

setUIButtonStatusByName :: (ctx: *WarContext, name: string, enabled: bool) {
    entity := findUIEntity(ctx, name);
    if (entity) {
        setUIButtonStatus(ctx, entity, enabled);
    }
}

setUIButtonInteractiveByName :: (ctx: *WarContext, name: string, interactive: bool) {
    entity := findUIEntity(ctx, name);
    if (entity) {
        setUIButtonInteractive(ctx, entity, interactive);
    }
}

setUIButtonHotKeyByName :: (ctx: *WarContext, name: string, key: WarKeys) {
    entity := findUIEntity(ctx, name);
    if (entity) {
        setUIButtonHotKey(ctx, entity, key);
    }
}

setUIEntityStatusByName :: (ctx: *WarContext, name: string, enabled: bool) {
    entity := findUIEntity(ctx, name);
    if (entity) {
        setUIEntityStatus(ctx, entity, enabled);
    }
}

createUIText :: (ctx: *WarContext, name: string, fontIndex: s32, fontSize: f32, text: string, position: Vec2) -> *WarEntity {
    entity := createEntity(ctx, WarEntityType.Text);
    addTransformComponent(ctx, entity, position);
    addUIComponent(ctx, entity, name);
    addTextComponent(ctx, entity, fontIndex, fontSize, text);
    return entity;
}

createUIRect :: (ctx: *WarContext, name: string, position: Vec2, size: Vec2, color: WarColor) -> *WarEntity {
    entity := createEntity(ctx, WarEntityType.Rect);
    addTransformComponent(ctx, entity, position);
    addUIComponent(ctx, entity, name);
    addRectComponent(ctx, entity, size, color);
    return entity;
}

createUIImage :: (ctx: *WarContext, name: string, spriteResourceRef: WarSpriteResourceRef, position: Vec2) -> *WarEntity {
    entity := createEntity(ctx, WarEntityType.Image);
    addTransformComponent(ctx, entity, position);
    addUIComponent(ctx, entity, name);
    addSpriteComponentFromResource(ctx, entity, spriteResourceRef);
    return entity;
}

createUICursor :: (ctx: *WarContext, name: string, type: WarCursorType, position: Vec2) -> *WarEntity {
    resource := getOrCreateResource(WarResourceCursor, ctx, cast(u32) type);
    assert(resource.type == WarResourceType.Cursor);

    entity := createEntity(ctx, WarEntityType.Cursor);
    addTransformComponent(ctx, entity, position);
    addUIComponent(ctx, entity, name);
    addSpriteComponentFromResource(ctx, entity, imageResourceRef(cast(s32) type));
    addCursorComponent(ctx, entity, type, vec2(resource.hotx, resource.hoty));
    return entity;
}

createUITextButton :: (ctx: *WarContext,
                       name: string,
                       fontIndex: s32,
                       fontSize: f32,
                       text: string,
                       backgroundNormalRef: WarSpriteResourceRef,
                       backgroundPressedRef: WarSpriteResourceRef,
                       foregroundRef: WarSpriteResourceRef,
                       position: Vec2) -> *WarEntity
{
    entity := createEntity(ctx, WarEntityType.Button);
    addTransformComponent(ctx, entity, position);
    addUIComponent(ctx, entity, name);
    addSpriteComponentFromResource(ctx, entity, foregroundRef);
    textComponent := addTextComponent(ctx, entity, fontIndex, fontSize, text);
    buttonComponent := addButtonComponentFromResource(ctx, entity, backgroundNormalRef, backgroundPressedRef);

    textComponent.boundings = vec2(buttonComponent.normalSprite.frameWidth, buttonComponent.normalSprite.frameHeight);
    textComponent.horizontalAlign = WarTextAlignment.Center;
    textComponent.verticalAlign = WarTextAlignment.Middle;

    return entity;
}

createUIImageButton :: (ctx: *WarContext,
                        name: string,
                        backgroundNormalRef: WarSpriteResourceRef,
                        backgroundPressedRef: WarSpriteResourceRef,
                        foregroundRef: WarSpriteResourceRef,
                        position: Vec2) -> *WarEntity
{
    entity := createEntity(ctx, WarEntityType.Button);
    addTransformComponent(ctx, entity, position);
    addUIComponent(ctx, entity, name);
    addSpriteComponentFromResource(ctx, entity, foregroundRef);
    addButtonComponentFromResource(ctx, entity, backgroundNormalRef, backgroundPressedRef);
    return entity;
}

changeCursorType :: (ctx: *WarContext, entity: *WarEntity, type: WarCursorType) {
    assert(entity != null);

    cursor := getComponent(ctx, entity, WarCursorComponent);
    assert(cursor != null);

    if (cursor.cursorType != type) {
        resource := getOrCreateResource(WarResourceCursor, ctx, cast(u32) type);
        assert(resource.type == WarResourceType.Cursor);

        removeComponent(ctx, entity, WarComponentType.Cursor);
        addCursorComponent(ctx, entity, type, vec2(resource.hotx, resource.hoty));

        removeComponent(ctx, entity, WarComponentType.Sprite);
        addSpriteComponentFromResource(ctx, entity, imageResourceRef(cast(s32) type));
    }
}

updateUICursor :: (ctx: *WarContext) {
    input := *ctx.input;

    entity := findUIEntity(ctx, "cursor");
    if (entity != null) {
        cursor := getComponent(ctx, entity, WarCursorComponent);
        transform := getComponent(ctx, entity, WarTransformComponent);
        transform.position = input.pos - cursor.hot;
        changeCursorType(ctx, entity, WarCursorType.Arrow);
    }
}

updateUIButtons :: (ctx: *WarContext, hotKeysEnabled: bool) {
    input := *ctx.input;

    buttons := getEntitiesOfType(ctx, WarEntityType.Button);

    // store the buttons to update in this frame first
    // because the action of some buttons is to show other buttons
    // in their same location, and if the newly shown button is
    // after in the list, then it will update in this same frame
    // which it shouldn't happen
    buttonsToUpdate := createHashSet(WarEntityId, HashSetOptions(WarEntityId).{
        hashFn = hashEntityId
    });
    defer uninit(*buttonsToUpdate);

    for entity : buttons {
        ui := getComponent(ctx, entity, WarUIComponent);
        button := getComponent(ctx, entity, WarButtonComponent);

        if (ui.enabled && button.enabled && button.interactive) {
            add(*buttonsToUpdate, entity.id);
        } else {
            button.hot = false;
            button.active = false;
        }
    }

    for entity : buttons {
        if (contains(*buttonsToUpdate, entity.id)) {
            transform := getComponent(ctx, entity, WarTransformComponent);
            button := getComponent(ctx, entity, WarButtonComponent);

            if (hotKeysEnabled && wasKeyPressed(input, button.hotKey)) {
                if (button.clickHandler) {
                    button.hot = false;
                    button.active = false;

                    button.clickHandler(ctx, entity);

                    // in this case break to not allow pressing multiple keys
                    // and executing all of the command for those keys
                    break;
                }
            }

            backgroundSize := vec2(button.normalSprite.frameWidth, button.normalSprite.frameHeight);
            buttonRect := rect(transform.position, backgroundSize);
            pointerInside := contains(buttonRect, input.pos.x, input.pos.y);

            if (wasButtonPressed(input, WarMouseButtons.Left)) {
                if (button.active) {
                    if (pointerInside && button.clickHandler) {
                        button.clickHandler(ctx, entity);
                        // createAudio(ctx, WAR_UI_CLICK, false);
                    }

                    button.active = false;
                }
            } else if (isButtonPressed(input, WarMouseButtons.Left)) {
                if (button.hot) {
                    button.active = true;
                }
            } else if (pointerInside) {
                for other : buttons {
                    otherButton := getComponent(ctx, other, WarButtonComponent);
                    otherButton.hot = false;
                    otherButton.active = false;
                }

                button.hot = true;
                button.active = false;
            } else {
                button.hot = false;
                button.active = false;
            }
        }
    }
}

renderUIEntities :: (ctx: *WarContext) {
    entities := getUIEntities(ctx);
    for entity : entities {
        renderEntity(ctx, entity);
    }
}
