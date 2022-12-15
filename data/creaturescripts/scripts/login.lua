local config = {
	loginMessage = getConfigValue('loginMessage'),
	useFragHandler = getBooleanFromString(getConfigValue('useFragHandler'))
}

function onLogin(cid)
    registerCreatureEvent(cid, "PlayerAttack")
	doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, 0)
	doCreatureSetDropLoot(cid, false)
	
	local accountManager = getPlayerAccountManager(cid)
	if(accountManager == MANAGER_NONE) then
		local lastLogin, str = getPlayerLastLoginSaved(cid), config.loginMessage
		if(lastLogin > 0) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
			str = "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. "."
		else
			str = str .. " Have fun! "
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
	elseif(accountManager == MANAGER_NAMELOCK) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, it appears that your character has been namelocked, what would you like as your new name?")
	elseif(accountManager == MANAGER_ACCOUNT) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to manage your account and if you want to start over then type 'cancel'.")
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to create an account or type 'recover' to recover an account.")
	end
	
	if getCreatureName(cid) == "account manager" then
	return true 
	end

	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
	end

	registerCreatureEvent(cid, "WatchTv")
	registerCreatureEvent(cid, "StopWatchingTv")
	registerCreatureEvent(cid, "RecordTv")
	registerCreatureEvent(cid, "GuildMotd")
	registerCreatureEvent(cid, "PlayerPokeDeath")
	registerCreatureEvent(cid, "LogoutPoke")
	registerCreatureEvent(cid, "WildAttack")
	registerCreatureEvent(cid, "Idle")
	registerCreatureEvent(cid, "Tele")
	registerCreatureEvent(cid, "Exp")
	registerCreatureEvent(cid, "Alook")
	registerCreatureEvent(cid, "KillTask")
	registerCreatureEvent(cid, "kill")
	registerCreatureEvent(cid, "SaffariDeath")

	if getPlayerStorageValue(cid, 61207) >= 1 then
	    setPlayerStorageValue(cid, 61207, 0)
		if (getPlayerSlotItem(cid, 8).itemid ~= 0) then
			local ball  = getPokeballType(getPlayerSlotItem(cid, 8).itemid)
			local pokeball = pokeballs[ball]
			if getPlayerSlotItem(cid, 8).itemid == pokeball.on or pokeball.use then
				doTransformItem(getPlayerSlotItem(cid, 8).uid, pokeball.on)
			end
	
			local item = getPlayerSlotItem(cid, 8)
			setPokeballInfo(item.uid, getPokeballInfo(getPlayerSlotItem(cid, 8).uid).name, getPlayerStorageValue(cid, 61205), getPlayerStorageValue(cid, 61206))
		end
	end

	if (getPlayerSlotItem(cid, 8).itemid ~= 0) then
		local ball  = getPokeballType(getPlayerSlotItem(cid, 8).itemid)
		local pokeball = pokeballs[ball]
		if getPlayerItemCount(cid, pokeball.use) >= 1 and getPlayerStorageValue(cid, 61207) <= 0 and getPlayerStorageValue(cid, 17001) <= 0 and getPlayerStorageValue(cid, 17000) <= 0 and getPlayerStorageValue(cid, 63215) <= 0 then
			local item = getPlayerItemById(cid, TRUE, pokeball.on)
			doTransformItem(item.uid, pokeball.on)
			setPokeballInfo(item.uid, getPokeballInfo(getPlayerSlotItem(cid, 8).uid).name, getPlayerStorageValue(cid, 61205), getPlayerStorageValue(cid, 61206))
		end
	end
	
	doChangeSpeed(cid, -(getCreatureSpeed(cid)))
	
	if getPlayerStorageValue(cid, 17000) >= 1 then
	    item = getPlayerSlotItem(cid, 8)
	    poke = getPokeballInfo(getPlayerSlotItem(cid, 8).uid).name
	    doChangeSpeed(cid, flys[poke][2])
	    registerCreatureEvent(cid, "Flying")
	    doRemoveCondition(cid, CONDITION_OUTFIT)
	    doSetCreatureOutfit(cid, {lookType = flys[poke][1], lookHead = 0, lookAddons = 0, lookLegs = 0, lookBody = 0, lookFeet = 0}, -1)
	elseif getPlayerStorageValue(cid, 63215) >= 1 then
	    item = getPlayerSlotItem(cid, 8)
	    poke = getPokeballInfo(getPlayerSlotItem(cid, 8).uid).name
	    doSetCreatureOutfit(cid, surf[poke], -1)
	    doChangeSpeed(cid, surf[poke].speed)
	elseif getPlayerStorageValue(cid, 17001) >= 1 then
	    item = getPlayerSlotItem(cid, 8)
	    poke = getPokeballInfo(getPlayerSlotItem(cid, 8).uid).name
	    doChangeSpeed(cid, rides[poke][2])
	    doRemoveCondition(cid, CONDITION_OUTFIT)
	    doSetCreatureOutfit(cid, {lookType = rides[poke][1], lookHead = 0, lookAddons = 0, lookLegs = 0, lookBody = 0, lookFeet = 0}, -1)
	else
	    if getPlayerGroupId(cid) >= 2 and getPlayerGroupId(cid) <= 7 then
	        doChangeSpeed(cid, 400*getPlayerGroupId(cid))
	    else
	        doChangeSpeed(cid, 250)
	    end
	end
	
	if getPlayerVocation(cid) == 0 then
		doPlayerSetVocation(cid, 1)
		setCreatureMaxMana(cid, 6)
		doPlayerAddSoul(cid, -getPlayerSoul(cid))
		setPlayerStorageValue(cid, 19898, 0)
	end
	
	if getCreatureOutfit(cid).lookType == 128 then
	    outfit = {lookType = 159}
	    doCreatureChangeOutfit(cid, outfit)
	elseif getCreatureOutfit(cid).lookType == 136 then
	    outfit = {lookType = 160}
	    doCreatureChangeOutfit(cid, outfit)
	end
	
	if isPlayer(cid) then
		doUpdatePokemons(cid)
		if #getCreatureSummons(cid) >= 1 then
			doUpdateStatusPoke(cid)
		end
	end
	
	registerCreatureEvent(cid, "ReportBug")
	registerCreatureEvent(cid, "AdvanceSave")
	return true
end