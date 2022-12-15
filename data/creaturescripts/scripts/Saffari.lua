function onDeath(cid, corpse, deathList)

	if isPlayer(cid) and getPlayerStorageValue(cid, SAFFARI_CONFIG.Storages) >= 1 then
	
		removeItemsPlayer(cid, SAFFARI_CONFIG.AddPokeballs[1])
	
		setPlayerStorageValue(cid, SAFFARI_CONFIG.Storages, -1)

	end
	
	return true
end