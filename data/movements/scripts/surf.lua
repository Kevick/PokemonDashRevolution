local flie = {'4820', '4821', '4822', '4823', '4824', '4825'}

function onStepIn(cid, item, position, fromPosition)
   
    if not isPlayer(cid) and not isPremium(cid) then -- tire o primeiro not, atras do isPlayer para ativar o premium
        doTeleportThing(cid, fromPosition, false)
        doPlayerSendCancel(cid, "Only premium members are allowed to surf.")
    return true
    end
	
	local pokeballInfo = getPokeballInfo(getPlayerSlotItem(cid, 8).uid)

	if getCreatureOutfit(cid).lookType == 316 then
        doSendMagicEffect(fromPosition, 136)
    end
    
	if not isPlayer(cid) then
        doTeleportThing(cid, fromPosition, false)
    return true
    end

    if getPlayerStorageValue(cid, 63215) ~= 1 and getPlayerStorageValue(cid, 17000) <= 0 then
	    if #getCreatureSummons(cid) == 0 then
	        doPlayerSendCancel(cid, "You need a pokemon to surf.")
	        doTeleportThing(cid, fromPosition, false)
	    else
	        if (not isInArray(Ability['Surf'], pokeballInfo.name)) then
	            doPlayerSendCancel(cid, "This pokemon cannot surf.")
	            doTeleportThing(cid, fromPosition, false)
	        return true
	        end
	    end
    end

	if #getCreatureSummons(cid) >= 1 and isInArray(Ability['Surf'], pokeballInfo.name) and getPlayerStorageValue(cid, 63215) ~= 1 and getPlayerStorageValue(cid, 17000) <= 0 then
        doSetCreatureOutfit(cid, surf[pokeballInfo.name], -1)
        doCreatureSay(cid, ""..pokeballInfo.nick..", lets surf!", 1)
        doChangeSpeed(cid, -(getCreatureSpeed(cid)))
        doChangeSpeed(cid, surf[pokeballInfo.name].speed)
        setPlayerStorageValue(cid, 61209, getCreatureMaxHealth(getCreatureSummons(cid)[1]))
        setPlayerStorageValue(cid, 61210, getCreatureHealth(getCreatureSummons(cid)[1]))
        doRemoveCreature(getCreatureSummons(cid)[1])
		doPlayerSendCancel(cid, "@H|Hide")
		doPlayerSendCancel(cid, "@M|hide")
        addEvent(setPlayerStorageValue, 100, cid, 63215, 1)
    end

	if getPlayerStorageValue(cid, 63215) == 1 then
        if getCreatureLookDir(cid) == 0 then
            doSendMagicEffect(fromPosition, 33)
        elseif getCreatureLookDir(cid) == 1 then
            doSendMagicEffect(fromPosition, 49)
        elseif getCreatureLookDir(cid) == 2 then
            doSendMagicEffect(fromPosition, 30)
        elseif getCreatureLookDir(cid) == 3 then
            doSendMagicEffect(fromPosition, 51)
        end
    end
	
    if getPlayerStorageValue(cid, 17000) >= 1 then
        if not isInArray(flie, getTileInfo(fromPosition).itemid) then
        return true
        end

	    if getCreatureLookDir(cid) == 0 then
            doSendMagicEffect(fromPosition, 33)
        elseif getCreatureLookDir(cid) == 1 then
            doSendMagicEffect(fromPosition, 49)
        elseif getCreatureLookDir(cid) == 2 then
            doSendMagicEffect(fromPosition, 30)
        elseif getCreatureLookDir(cid) == 3 then
            doSendMagicEffect(fromPosition, 51)
        end
    end
return true
end

function onStepOut(cid, item, position, fromPosition)
if not isInArray({4820, 4821, 4822, 4823, 4824, 4825}, getTileThingByPos(getThingPos(cid)).itemid) then
setPlayerGroupId(cid, 1)
end
return true
end