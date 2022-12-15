function onSay(cid, words, param, channel)
	
	param = string.lower(param)

	if (param == "") then

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"invalid command, for more information enter !saffari info")

	elseif(param == "info") then

		doShowTextDialog(cid, 2160, "Saffari Info:\n\nLevel Minimum: "..SAFFARI_CONFIG.Level.."\nSaffari Cost: "..SAFFARI_CONFIG.Price.."\n\nThe safari is home to rare creatures, some are dangerous and others not\n[*Warning*]\nis only allowed to enter with saffari balls.\n\nTo leave enter command:\n!saffari leave")

	elseif(param == "leave") then

		if getPlayerStorageValue(cid, SAFFARI_CONFIG.Storages) >= 1 then
			
			removeItemsPlayer(cid, SAFFARI_CONFIG.AddPokeballs[1])

			doTeleportThing(cid, SAFFARI_CONFIG.Saffari_Pos.Exit)

			setPlayerStorageValue(cid, SAFFARI_CONFIG.Storages[1], -1)

			doPlayerSendTextMessage(cid,22,'you left the saffari zone.')

		else

			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"you are not in Saffari")

		end

	end
	
	return true
end
