function onLogout(cid)
    if getPlayerStorageValue(cid, 888) >= 1 then
        doPlayerSendCancel(cid, "You cant logout during control mind.")
    return false
    end
	
	if getPlayerStorageValue(cid, 990) >= 1 then
        doCreatureSay(cid, "bye", TALKTYPE_SAY)
    end

    if #getCreatureSummons(cid) > 1 and getPlayerStorageValue(cid, 212124) <= 0 then    --alterado v1.6
       if getPlayerStorageValue(cid, 637501) == -2 or getPlayerStorageValue(cid, 637501) >= 1 then
          BackTeam(cid)
       end
    end
	
	if getPlayerStorageValue(cid, 6598754) >= 1 then
		setPlayerStorageValue(cid, 6598754, -1) 
	end
	
	if getPlayerStorageValue(cid, 6598755) >= 1 then
		setPlayerStorageValue(cid, 6598755, -1) 
	end

    --////////////////////////////////////////////////////////////////////////////////////////--
    if getPlayerStorageValue(cid, 52480) >= 1 and getPlayerStorageValue(cid, 52481) >= 0 then
       doPlayerSendCancel(cid, "Você cancelou o duelo.")
	   doEndDuel(cid)
	   return false
    end
	
    if #getCreatureSummons(cid) == 1 then
        if getPlayerStorageValue(cid, 61204) >= 1 and getPlayerStorageValue(cid, 63215) <= 0 and getPlayerStorageValue(cid, 62314) <= 0 then
            local owner = getCreatureMaster(cid)
			local pokeballinfo = getPokeballInfo(getPlayerSlotItem(owner, 8).uid)
			local summom = getCreatureSummons(cid)
            local maxh = (pokes[pokeballinfo.name].vida)
            local pct2 = ((getCreatureHealth(summom[1])) / (getCreatureMaxHealth(summom[1])))
            local vids = ((getCreatureHealth(summom[1])) - 2)
            doCreatureAddHealth(summom[1], -vids)
            setCreatureMaxHealth(summom[1], maxh)
            doCreatureAddHealth(summom[1], ((maxh) * (pct2)))
			
            local health = getCreatureHealth(summom[1])
            local maxhealth = getCreatureMaxHealth(summom[1])
            setPlayerStorageValue(cid, 61205, health)
            setPlayerStorageValue(cid, 61206, maxhealth)
            setPlayerStorageValue(cid, 61204, 0)
            setPlayerStorageValue(cid, 61207, 1)
            setPlayerStorageValue(cid, 1, 0)
            if getPlayerGroupId(cid) == 8 then
                setPlayerGroupId(cid, 1)
            end
        end
    end
return TRUE
end

function onDeath(cid, deathList)	
    local owner = getCreatureMaster(cid)
    local ball  = getPokeballType(getPlayerSlotItem(owner, 8).itemid)
	if getItemAttribute(getPlayerSlotItem(owner, 8).uid, "iconsystem") == "on" then ball = getPokeballInfo(getPlayerSlotItem(owner, 8).uid).name end
    local pokeball = pokeballs[ball]
    if getPlayerSlotItem(owner, 8).itemid == pokeball.on or pokeball.use then
        sendBallEffect(owner)
    end
	
    doPlayerSendTextMessage(owner, 22, "Your pokemon fainted.")
	
	
    if getPlayerSlotItem(owner, 8).itemid == pokeball.on or pokeball.use then
        doTransformItem(getPlayerSlotItem(owner, 8).uid, pokeball.off)
    end
	
    local item = getPlayerSlotItem(owner, 8)
    doItemSetAttribute(item.uid, "poke", getItemAttribute(item.uid, "poke"):sub(1, findLetter(getItemAttribute(item.uid, "poke"), ".")) .. " HP = [0/"..getCreatureMaxHealth(cid).."]")
    setPlayerStorageValue(owner, 61207, 0)
    setPlayerStorageValue(owner, 61204, 0)
	
    if getPlayerGroupId(owner) == 8 then
        setPlayerGroupId(owner, 1)
    end
	doItemSetAttribute(item.uid, "php", 0)
	local felicidade = getPlayerStorageValue(cid, 66604)
	if felicidade <= 10 then
		doItemSetAttribute(getPlayerSlotItem(owner, 8).uid, "happy", 0)
	else
		doItemSetAttribute(getPlayerSlotItem(owner, 8).uid, "happy", felicidade-10)
	end
	doItemSetAttribute(getPlayerSlotItem(owner, 8).uid, "isSleep", false)
	doItemSetAttribute(getPlayerSlotItem(owner, 8).uid, "isConfusion", false)
	doPlayerSendCancel(owner, "@H|Hide")
	doPlayerSendCancel(owner, "@M|hide")
    doRemoveCreature(cid)
return FALSE
end