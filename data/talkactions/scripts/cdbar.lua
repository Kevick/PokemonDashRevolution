local function ChangeBalls(cid, param, cancelequal)
	local balls = getPlayerPokeballs(cid)
	for a = 1, #balls do
		local item = balls[a]
		if not getItemAttribute(item.uid, "order") then return doPlayerSendTextMessage(cid, 27, "Do update your pokemon bar!") end --alterado v1.6
        local name = getPokeballInfo(item.uid).name .. getItemAttribute(item.uid, "order")
		if name == param then
			if cancelequal and item.uid == getPlayerSlotItem(cid, 8).uid then return true end
			doChangeBalls(cid, getPlayerSlotItem(cid, 8), item)
			return 0
		end
	end
end

function onSay(cid, words, param)
	if (getPlayerSlotItem(cid, 8).itemid == 0 )then doUpdatePokemons(cid) return true end

	local pokeball = getPokeballInfo(getPlayerSlotItem(cid, 8).uid)

	if words == "/pokemon" then
		if param == "null" then return 0 end
		if exhaustion.get(cid, 6666) and exhaustion.get(cid, 6666) > 0 then return true end
		if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 or getPlayerStorageValue(cid, 63215) >= 1 then return true end
        if getPlayerLevel(cid) < pokes[pokeball.name].level then doPlayerSendCancel(cid, "You need level "..pokes[pokeball.name].level.." or higher to use this pokemon.") return true end
		if #getCreatureSummons(cid) >= 1 then
			if not getItemAttribute(getPlayerSlotItem(cid, 8).uid, "order") then return doPlayerSendTextMessage(cid, 27, "Do update your pokemon bar!") end 
            --alterado v1.6
            addEvent(doReturnPokemon, 100, cid, getPlayerSlotItem(cid, 8))
			if param ~= pokeball.name .. getItemAttribute(getPlayerSlotItem(cid, 8).uid, "order") then
				addEvent(ChangeBalls, 1200, cid, param, true)
			end
		else
			addEvent(ChangeBalls, 100, cid, param)
		end
		exhaustion.set(cid, 6666, 2)
	return 0
	end
	
	if words == "/reloadCDs" then   --alterado v1.7
	   doUpdateCds(cid)
	   return true
    end

return 0
end