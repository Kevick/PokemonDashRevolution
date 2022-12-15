SAFFARI_CONFIG = {

	Price = 10000, -- qnto vai custar
	
	Premium = false, -- se precisa ser premium
	
	Level = 50, -- level minimo para entrar
	
	Saffari_Pos = {Enter = {x = 1049, y = 1490, z = 7}, Exit = {x = 1051, y = 1490, z = 7}}, -- pos da safari, e pos pra onde ele vai dps que acaba o tempo
	
	AddPokeballs = {2644, 100}, -- id da saffari ball e quantidade
	
	Blocked_pokeballs = {2645, 2147, 2146, 2642}, -- pokeballs q ele n pode estar na bag
	
	Storages = {874547}, 
	
}

function removeItemsPlayer(cid, itemid)

	if getPlayerItemCount(cid, itemid) ~= 0 then
					
		doPlayerRemoveItem(cid, itemid, getPlayerItemCount(cid, itemid))
								
	end
	
	return true
end

function saffariBallsEnd(cid, storage, exit)

		doTeleportThing(cid, exit)

		setPlayerStorageValue(cid, storage, -1)
			
		doPlayerSendTextMessage(cid, 22, 'you left the saffari zone.')
			
	return true
end