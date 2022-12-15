function onSay(cid, words, param)
	if #getCreatureSummons(cid) == 0 then doPlayerSendCancel(cid, 'you need a summon!') return true end
	
	if words == '/statusUpdate' then
		doUpdatePokemons(cid)
		doUpdateStatusPoke(cid)
	return true
	end

	if words == '/CdsUpdate' then
		doUpdateCds(cid)
	return true
	end

return true
end