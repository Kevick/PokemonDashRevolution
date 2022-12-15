function onStepIn(cid, item, position, fromPosition)
local player = getCreatureMaster(cid)    
	if getPlayerStorageValue(cid, 17000) >= 1 then
    return true
    end

	if getPlayerStorageValue(cid, 63215) >= 1 then
        doChangeSpeed(cid, -(getCreatureSpeed(cid)))
        doChangeSpeed(cid, 250)
        doRemoveCondition(cid, CONDITION_OUTFIT)
        setPlayerStorageValue(cid, 63215, 0)
 
        local item = getPlayerSlotItem(cid, 8)
        doCreatureSay(cid, "" .. getPokeballInfo(getPlayerSlotItem(player, 8).uid).nick..", Im tired of surfing!", 1)
        pk = doSummonCreature(getPokeballInfo(getPlayerSlotItem(player, 8).uid).name, getThingPos(cid))
        if getPokeballInfo(getPlayerSlotItem(player, 8).uid).nick then
			doCreatureSetNick(pk, getPokeballInfo(getPlayerSlotItem(cid, 8).uid).nick)
        end
		
		local gender = getItemAttribute(item.uid, "gender") or 0
		doCreatureSetSkullType(pk, gender)
		
		if getItemAttribute(item.uid, "happy") then
			setPlayerStorageValue(pk, 66604, (getItemAttribute(item.uid, "happy") or 0))
		end

		doUpdateCreature(pk)
        doConvinceCreature(cid, pk)
        registerCreatureEvent(pk, "DiePoke")
        registerCreatureEvent(pk, "Exp")
        setCreatureMaxHealth(pk, (getPlayerStorageValue(cid, 61209)))
        doCreatureAddHealth(pk, (getPlayerStorageValue(cid, 61209)))
        doCreatureAddHealth(pk, (getPlayerStorageValue(cid, 61210))-(getPlayerStorageValue(cid, 61209)))
		doUpdateCds(cid)
    return true
    end
end