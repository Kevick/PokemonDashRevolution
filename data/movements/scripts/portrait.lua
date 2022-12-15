function onEquip(cid, item, slot)
    for i, x in pairs(fotos) do
        if i == getItemAttribute(item.uid, "poke"):sub(9, findLetter(getItemAttribute(item.uid, "poke"), "'") - 1) then
            doTransformItem(getPlayerSlotItem(cid, 7).uid, fotos[i].fotopoke)
            return true
        end
    end
end
