function onJoinChannel(cid, channelId, users, isTv)

	if channelId == 10 then
		doShowPokemonStatistics(cid)
	return false
	end

	if channelId == 11 then
		if reloadHighscoresWhenUsingPc then
			doReloadHighscores()
		end
           doPlayerPopupFYI(cid, getHighscoreString(8))
	return false
	end

	if channelId == 12 then
		if reloadHighscoresWhenUsingPc then
			doReloadHighscores()
		end
           doPlayerPopupFYI(cid, getHighscoreString(6))
	return false
	end
	--////////////////////////////////////////////////////////////////////////////////////////--
	if channelId >= 19 and channelId <= 21 then     --alterado v1.8  \/
	   setPlayerStorageValue(cid, 52480, (channelId-18))
	   setPlayerStorageValue(cid, 52484, ((channelId-18)*2)-1)
	   doSendAnimatedText(getThingPosWithDebug(cid), (channelId-18).."x"..(channelId-18), COLOR_BURN)
	   doPlayerSetVocation(cid, 8)
       openChannelDialog(cid)
       return false
	end

	if channelId >= 13 and channelId <= 18 then
	   local sid = getPlayerByName(getPlayerStorageValue(cid, 52483):match("(.*),"))
	   ----------------  Proteçao para ter um oponente valido!
       if not isCreature(sid) then
	      doPlayerSendTextMessage(cid, 20, "The other player isn't online! Duel is canceled!")
	      doPlayerSetVocation(cid, 1)
	      for i = 1, #storagesDuel do
              setPlayerStorageValue(cid, storagesDuel[i], -1)
          end
          doCreatureSetSkullType(cid, 0)
          return false
       end
	   ----------------  Proteçao para os 2 players terem a qntdade de pokes pro duel
	   local pokes1 = getLivePokeballs(cid, getPlayerSlotItem(cid, 3).uid, true)
	   local pokes2 = getLivePokeballs(sid, getPlayerSlotItem(sid, 3).uid, true)
	   if #pokes1 < (channelId-12) or #pokes2 < (channelId-12) then
	      local tpw = getPlayerStorageValue(cid, 52480) > 1 and "ally" or "opponent"
	      doPlayerSendTextMessage(cid, 20, "You or your "..tpw.." doesn't have that amount of pokemons in their bags! Duel are canceled!")
	      doPlayerSetVocation(cid, 1)
	      for i = 1, #storagesDuel do
              setPlayerStorageValue(cid, storagesDuel[i], -1)
          end
          doCreatureSetSkullType(cid, 0)
          return false
       end
       ----------------
       if getPlayerStorageValue(cid, 52480) > 1 then
          setPlayerStorageValue(cid, 52482, getPlayerStorageValue(cid, 52482).. getCreatureName(sid)..",")
          setPlayerStorageValue(cid, 52483, "")
       end
       ----------------

	   doSendAnimatedText(getThingPos(cid), (channelId-12).." Poke"..(channelId > 13 and "s" or ""), COLOR_BURN)
	   setPlayerStorageValue(cid, 52481, (channelId-12))

          setPlayerStorageValue(sid, 52485, getCreatureName(cid))
          setPlayerStorageValue(sid, 52481, (channelId-12))

          local players, pokes = getPlayerStorageValue(cid, 52480), getPlayerStorageValue(cid, 52481)
          local str = {}                           --alterado v1.9 \/

          table.insert(str, getCreatureName(cid).." is inviting you to a duel! Use order in him to accept it!\n")
          table.insert(str, "Info Battle: Duel "..players.."x"..players.." - "..pokes.." pokes.")
          doPlayerSendTextMessage(sid, 20, table.concat(str))

	    addEvent(doSendAnimatedText, 1000, getThingPos(cid), "BATTLE", COLOR_ELECTRIC)
       doPlayerSetVocation(cid, 1)
       return false
    end
    --////////////////////////////////////////////////////////////////////////////////////////--
	if channelId >= 100 and channelId <= 10000 then

	local owner =  getPlayerByGUID(getChannelOwner(channelId))

		if isChannelTv(channelId) then
			if isCreature(owner) then
				if owner ~= cid then
					doPlayerWatchOther(cid, owner)
					local plural = #users == 1 and "" or "s"
					doPlayerSendChannelMessage(owner, "TV Channel", getCreatureName(cid)..' is now watching your channel (currently '..#users..' player'..plural..' watching this channel).', 15, channelId)
				else
					setPlayerStorageValue(cid, 99284, 1)
				end
			end
		elseif owner == cid then
			setPlayerStorageValue(cid, 99284, 2)
		end

	return true
	end

return true
end

function onLeaveChannel(cid, channelId, users)

	if channelId >= 100 and channelId <= 10000 then

	local owner =  getPlayerByGUID(getChannelOwner(channelId))

		if isChannelTv(channelId) then
			if owner ~= cid and getCreatureOutfit(cid).lookType == 814 then
				doPlayerStopWatching(cid)
				local plural = #users == 2 and "" or "s"
				doPlayerSendChannelMessage(owner, "TV Channel", getCreatureName(cid)..' is not watching your channel anymore (currently '..#users - (1)..' player'..plural..' watching this channel).', 15, channelId)
			elseif owner == cid then
				setPlayerStorageValue(cid, 99284, -1)
				doSendAnimatedText(getThingPos(cid), "CAM OFF", 180)
				for stops = 1, #users do
					if users[stops] ~= owner then
						doPlayerStopWatching(users[stops])
					end
				end
			end
		elseif owner == cid then
			setPlayerStorageValue(cid, 99284, -1)
		end

	return true
	end

return true
end

function onWalk(cid, fromPosition, toPosition)



	-- Código não é mais necessário, feito em c++
	-- Code deprecated, made in c++
	--if not canWalkOnPos(toPosition, false, false, false, true, false) and getPlayerStorageValue(cid, 17000) >= 1 then
	--	doTeleportThing(cid, fromPosition, false)
	--	doPlayerSendCancel(cid, "Sorry, not possible.")
	--end

	if getPlayerStorageValue(cid, 99284) <= 0 then return true end

	local speed = getCreatureSpeed(cid)
	local a = getWatchingPlayersFromPos(cid, fromPosition)

	for b = 1, #a do
		if getCreatureSpeed(a[b]) ~= speed then
			doChangeSpeed(a[b], - getCreatureSpeed(a[b]))
			doChangeSpeed(a[b], speed)
		end
		doTeleportThing(a[b], toPosition, true)
	end

return true
end

local permited = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
"t", "u", "v", "x", "w", ",", "'", '"',
"y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", "!", "@", "#", "$", "%", "&", "*", "(", ")",
"-", "_", "+", "/", ";", ":", "?", "^", "~", "{", "[", "}", "]", ">", "<", "£", "¢", "¬"}

function onTextEdit(cid, item, newText)

	if item.itemid == 12330 then

		if getPlayerStorageValue(cid, 99284) >= 1 then
			doPlayerSendCancel(cid, "You are already on air!")
		return false
		end

		local channelName = getCreatureName(cid).."'s TV Channel"

		if string.len(newText) <= 0 then
			doPlayerSendCancel(cid, "Your channel is going to be shown as \""..getCreatureName(cid).."'s TV Channel\".")
		elseif string.len(newText) > 25 then
			doPlayerSendCancel(cid, "Your channel name can't have more than 25 characters.")
		return false
		else
			channelName = newText
		end


		setPlayerStorageValue(cid, 99284, 1)
		setPlayerStorageValue(cid, 99285, "")
		setPlayerStorageValue(cid, 99285, channelName)
		doPlayerCreatePrivateChannel(cid, channelName)
		doSendAnimatedText(getThingPos(cid), "ON AIR!", COLOR_GRASS)

	return false
	end

return true
end
