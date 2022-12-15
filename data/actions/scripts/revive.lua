function onUse(cid, item, frompos, item2, topos)

	if getPlayerStorageValue(cid, 990) >= 1 then
		doPlayerSendCancel(cid, "You can't use revive during gym battles.")
	return true
	end

	if getPlayerStorageValue(cid, 52481) >= 1 then
	   return doPlayerSendCancel(cid, "You can't do that while a duel.") --alterado v1.6
    end
                 --
	if item2.itemid <= 0 or not isPokeball(item2.itemid) then
		doPlayerSendCancel(cid, "Please, use revive only on pokeballs.")
	return true
	end

	for a, b in pairs (pokeballs) do
        if item2.itemid == b.on or item2.itemid == b.off then         --edited deixei igual ao do PXG
		   local pokeballinfo = getPokeballInfo(item2.uid)
           doTransformItem(item2.uid, b.on)
		   setPokeballInfo(item2.uid, pokeballinfo.name, pokeballinfo.maxhp, pokeballinfo.maxhp)
           doSendMagicEffect(getThingPos(cid), 13)
           doRemoveItem(item.uid, 1)
		   doUpdatePokemons(cid)
	       return true
        end
	end

return true
end