isUnit :: inline (entity: *WarEntity) -> bool {
    return entity.type == WAR_ENTITY_TYPE_UNIT;
}

isUnitOfType :: (ctx: *WarContext, entity: *WarEntity, unitType: WarUnitType) -> bool {
    if (!isUnit(entity)) return false;
    unit := getComponent(ctx, entity, WarUnitComponent);
    return unit.type == unitType;
}
