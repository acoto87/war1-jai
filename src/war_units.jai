isUnit :: inline (entity: *WarEntity) -> bool {
    return entity.type == WarEntityType.Unit;
}

isUnitOfType :: (ctx: *WarContext, entity: *WarEntity, unitType: WarUnitType) -> bool {
    if (!isUnit(entity)) return false;
    unit := getComponent(ctx, entity, WarUnitComponent);
    return unit.unitType == unitType;
}
