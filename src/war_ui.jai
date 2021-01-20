clearUIText :: (ctx: *WarContext, entity: *WarEntity) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    free(text.text);
    text.text = "";
    text.enabled = false;
}

setUIText :: (ctx: *WarContext, entity: *WarEntity, text: string) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    clearUIText(entity);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.text = text;
    text.enabled = true;
}

setUITextFormat :: (ctx: *WarContext, entity: *WarEntity, format: string, args: ..Any) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := sprint(format, args);
    setUIText(entity, text);
}

setUIImage :: (ctx: *WarContext, entity: *WarEntity, frameIndex: s32) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Image);

    sprite := getComponent(ctx, entity, WarSpriteComponent);
    assert(sprite != null);

    sprite.frameIndex = frameIndex;
    sprite.enabled = frameIndex >= 0;
}

setUIRectWidth :: (ctx: *WarContext, entity: *WarEntity, width: s32) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Rect);

    rect := getComponent(ctx, entity, WarRectComponent);
    assert(rect != null);

    rect.size.x = width;
    rect.enabled = width > 0;
}

clearUITooltip :: (ctx: *WarContext, entity: *WarEntity) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Button);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    free(button.tooltip);
    button.tooltip = "";
}

setUITooltip :: (ctx: *WarContext, entity: *WarEntity, highlightIndex: s32, highlightCount: s32, text: string) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Button);

    clearUITooltip(uiButton);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    button.highlightIndex = highlightIndex;
    button.highlightCount = highlightCount;
    button.tooltip = text;
}

setUITextBoundings :: inline (ctx: *WarContext, entity: *WarEntity, value: Vec2) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.boundings = value;
}

setUITextHorizontalAlign :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextAlignment) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.horizontalAlign = value;
}

setUITextVerticalAlign :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextAlignment) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.verticalAlign = value;
}

setUITextLineAlign :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextAlignment) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.lineAlign = value;
}

setUITextWrapping :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextWrapping) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.wrapping = value;
}

setUITextColor :: inline (ctx: *WarContext, entity: *WarEntity, value: WarColor) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.fontColor = value;
}

setUITextHighlight :: inline (ctx: *WarContext, entity: *WarEntity, index: s32, count: s32) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.highlightIndex = index;
    text.highlightCount = count;
}

setUITextHighlightColor :: inline (ctx: *WarContext, entity: *WarEntity, color: WarColor) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.highlightColor = color;
}

setUITextMultiline :: inline (ctx: *WarContext, entity: *WarEntity, value: bool) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.multiline = value;
}

setUITextLineHeight :: inline (ctx: *WarContext, entity: *WarEntity, value: f32) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.lineHeight = value;
}

setUITextTrimming :: inline (ctx: *WarContext, entity: *WarEntity, value: WarTextTrimming) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Text);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    text.trimming = value;
}

setUIButtonInteractive :: inline (ctx: *WarContext, entity: *WarEntity, value: bool) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Button);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    button.interactive = value;
}

setUIButtonHotKey :: inline (ctx: *WarContext, entity: *WarEntity, key: WarKeys) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Button);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    button.hotKey = key;
}

setUIButtonClickHandler :: inline (ctx: *WarContext, entity: *WarEntity, handler: WarClickHandler) {
    assert(ctx != null);
    assert(entity != null);
    assert(entity.type == WarEntityType.Button);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    button.clickHandler = handler;
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
        setUIEntityStatus(ctx, enabled);
    }
}

WarEntity* createUIText(WarContext* context, char* name, s32 fontIndex, f32 fontSize, const char* text, vec2 position)
{
    WarEntity* entity = createEntity(context, WAR_ENTITY_TYPE_TEXT, true);
    addTransformComponent(context, entity, position);
    addUIComponent(context, entity, name);
    addTextComponent(context, entity, fontIndex, fontSize, text);

    return entity;
}

WarEntity* createUIRect(WarContext* context, char* name, vec2 position, vec2 size, u8Color color)
{
    WarEntity* entity = createEntity(context, WAR_ENTITY_TYPE_RECT, true);
    addTransformComponent(context, entity, position);
    addUIComponent(context, entity, name);
    addRectComponent(context, entity, size, color);

    return entity;
}

createUIImage :: (ctx: *WarContext, name: string, spriteResourceRef: WarSpriteResourceRef, position: Vec2) -> *WarEntity {
    entity := createEntity(ctx, WarEntityType.Image);

    transform := createComponent(ctx, WarTransformComponent);
    transform.position = position;
    addComponent(ctx, entity, transform);

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

WarEntity* createUICursor(WarContext* context, char* name, WarCursorType type, vec2 position)
{
    WarResource* resource = getOrCreateResource(context, type);
    assert(resource->type == WAR_RESOURCE_TYPE_CURSOR);

    WarEntity* entity = createEntity(context, WAR_ENTITY_TYPE_CURSOR, true);
    addTransformComponent(context, entity, position);
    addUIComponent(context, entity, name);
    addSpriteComponentFromResource(context, entity, imageResourceRef(type));
    addCursorComponent(context, entity, type, vec2i(resource->cursor.hotx, resource->cursor.hoty));

    return entity;
}

WarEntity* createUITextButton(WarContext* context,
                              char* name,
                              s32 fontIndex,
                              f32 fontSize,
                              const char* text,
                              WarSpriteResourceRef backgroundNormalRef,
                              WarSpriteResourceRef backgroundPressedRef,
                              WarSpriteResourceRef foregroundRef,
                              vec2 position)
{
    WarEntity* entity = createEntity(context, WAR_ENTITY_TYPE_BUTTON, true);
    addTransformComponent(context, entity, position);
    addUIComponent(context, entity, name);
    addTextComponent(context, entity, fontIndex, fontSize, text);
    addSpriteComponentFromResource(context, entity, foregroundRef);
    addButtonComponentFromResource(context, entity, backgroundNormalRef, backgroundPressedRef);

    WarSprite* normalSprite = &entity->button.normalSprite;
    vec2 backgroundSize = vec2i(normalSprite->frameWidth, normalSprite->frameHeight);

    setUITextBoundings(entity, backgroundSize);
    setUITextHorizontalAlign(entity, WAR_TEXT_ALIGN_CENTER);
    setUITextVerticalAlign(entity, WAR_TEXT_ALIGN_MIDDLE);

    return entity;
}

WarEntity* createUIImageButton(WarContext* context,
                               char* name,
                               WarSpriteResourceRef backgroundNormalRef,
                               WarSpriteResourceRef backgroundPressedRef,
                               WarSpriteResourceRef foregroundRef,
                               vec2 position)
{
    WarEntity* entity = createEntity(context, WAR_ENTITY_TYPE_BUTTON, true);
    addTransformComponent(context, entity, position);
    addUIComponent(context, entity, name);
    addSpriteComponentFromResource(context, entity, foregroundRef);
    addButtonComponentFromResource(context, entity, backgroundNormalRef, backgroundPressedRef);

    return entity;
}

void changeCursorType(WarContext* context, WarEntity* entity, WarCursorType type)
{
    assert(entity->type == WAR_ENTITY_TYPE_CURSOR);

    if (entity->cursor.type != type)
    {
        WarResource* resource = getOrCreateResource(context, type);
        assert(resource->type == WAR_RESOURCE_TYPE_CURSOR);

        removeCursorComponent(context, entity);
        addCursorComponent(context, entity, type, vec2i(resource->cursor.hotx, resource->cursor.hoty));

        removeSpriteComponent(context, entity);
        addSpriteComponentFromResource(context, entity, imageResourceRef(type));
    }
}

void updateUICursor(WarContext* context)
{
    WarInput* input = &context->input;

    WarEntity* entity = findUIEntity(context, "cursor");
    if (entity)
    {
        entity->transform.position = vec2Subv(input->pos, entity->cursor.hot);
        changeCursorType(context, entity, WAR_CURSOR_ARROW);
    }
}

void updateUIButtons(WarContext* context, bool hotKeysEnabled)
{
    WarInput* input = &context->input;

    WarEntityList* buttons = getEntitiesOfType(context, WAR_ENTITY_TYPE_BUTTON);

    // store the buttons to update in this frame first
    // because the action of some buttons is to show other buttons
    // in their same location, and if the newly shown button is
    // after in the list, then it will update in this same frame
    // which it shouldn't happen
    WarEntityIdSet buttonsToUpdate;
    WarEntityIdSetInit(&buttonsToUpdate, WarEntityIdSetDefaultOptions);

    for(s32 i = 0; i < buttons->count; i++)
    {
        WarEntity* entity = buttons->items[i];
        if (entity)
        {
            WarUIComponent* ui = &entity->ui;
            WarButtonComponent* button = &entity->button;

            if (ui->enabled && button->enabled && button->interactive)
            {
                WarEntityIdSetAdd(&buttonsToUpdate, entity->id);
            }
            else
            {
                button->hot = false;
                button->active = false;
            }
        }
    }

    for(s32 i = 0; i < buttons->count; i++)
    {
        WarEntity* entity = buttons->items[i];
        if (entity && WarEntityIdSetContains(&buttonsToUpdate, entity->id))
        {
            WarTransformComponent* transform = &entity->transform;
            WarButtonComponent* button = &entity->button;

            if (hotKeysEnabled && wasKeyPressed(input, button->hotKey))
            {
                if (button->clickHandler)
                {
                    button->hot = false;
                    button->active = false;

                    button->clickHandler(context, entity);

                    // in this case break to not allow pressing multiple keys
                    // and executing all of the command for those keys
                    break;
                }
            }

            vec2 backgroundSize = vec2i(button->normalSprite.frameWidth, button->normalSprite.frameHeight);
            rect buttonRect = rectv(transform->position, backgroundSize);
            bool pointerInside = rectContainsf(buttonRect, input->pos.x, input->pos.y);

            if (wasButtonPressed(input, WAR_MOUSE_LEFT))
            {
                if (button->active)
                {
                    if (pointerInside && button->clickHandler)
                    {
                        button->clickHandler(context, entity);
                        createAudio(context, WAR_UI_CLICK, false);
                    }

                    button->active = false;
                }

            }
            else if (isButtonPressed(input, WAR_MOUSE_LEFT))
            {
                if (button->hot)
                    button->active = true;
            }
            else if (pointerInside)
            {
                for(s32 j = 0; j < buttons->count; j++)
                {
                    WarEntity* otherButton = buttons->items[i];
                    if (otherButton)
                    {
                        otherButton->button.hot = false;
                        otherButton->button.active = false;
                    }
                }

                button->hot = true;
            }
            else
            {
                button->hot = false;
                button->active = false;
            }
        }
    }

    WarEntityIdSetFree(&buttonsToUpdate);
}

void renderUIEntities(WarContext* context)
{
    WarEntityList* entities = getUIEntities(context);
    for(s32 i = 0; i < entities->count; i++)
    {
        WarEntity *entity = entities->items[i];
        if (entity)
        {
            renderEntity(context, entity);
        }
    }
}

