function onEquip(cid, item, slot)
    for i, x in pairs(fotos) do
        if i == getItemAttribute(item.uid, "poke"):sub(9, findLetter(getItemAttribute(item.uid, "poke"), "'") - 1) then
            doTransformItem(getPlayerSlotItem(cid, 7).uid, fotos[i].fotopoke)
            doPokemonDropCooldown(cid, 1)
            doPokemonDropCooldown(cid, 2)
            doPokemonDropCooldown(cid, 3)
            doPokemonDropCooldown(cid, 4)
            doPokemonDropCooldown(cid, 5)
            doPokemonDropCooldown(cid, 6)
            doPokemonDropCooldown(cid, 7)
            doPokemonDropCooldown(cid, 8)
            doPokemonDropCooldown(cid, 9)
            doPokemonDropCooldown(cid, 10)
            doPokemonDropCooldown(cid, 11)
            doPokemonDropCooldown(cid, 12)
            return true
        end
    end
end
