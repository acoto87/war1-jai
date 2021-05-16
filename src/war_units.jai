isUnit :: inline (entity: *WarEntity) -> bool {
    return entity.type == EntityType.Unit;
}

isUnitOfType :: (entity: *WarEntity, unitType: WarUnitType) -> bool {
    if (!isUnit(entity)) return false;
    unit := getComponent(entity, WarUnitComponent);
    return unit.unitType == unitType;
}
