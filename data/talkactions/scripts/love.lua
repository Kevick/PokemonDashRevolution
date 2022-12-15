function onSay(cid,param,words)
	if #getCreatureSummons(cid) == 0 then
		doPlayerSendCancel(cid, "Você precisa de um pokémon ativo pra fazer carinho.")
		return true
	end

	if exhaustion.check(cid, 25680) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have to wait ".. exhaustion.get(cid, 25680) .." seconds.")
		return true
	end
	

	hapy = getPlayerStorageValue(cid,66604)
	if hapy <= 250 then
		doSendMagicEffect(getThingPos(cid), 180)
		doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 180)
		setPlayerStorageValue(cid, 66605, (hapy + 10))
		exhaustion.make(cid, 25680, 300)
	else
		doPlayerSendCancel(cid, "Seu pokémon não precisa de carinho.")
	end
return true
end