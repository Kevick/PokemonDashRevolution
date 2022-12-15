local youAre = {
[3] = "a Senior Tutor",
[4] = "a Game Master",
[5] = "a Sub",
[6] = "a GOD"
}

function onLook(cid, thing, position, lookDistance)   

	local str = ""

	if not isCreature(thing.uid) then

		local iname = getItemInfo(thing.itemid)

		if isPokeball(thing.itemid) then
			local unique = getItemAttribute(thing.uid, "unique")
			local pokename = getPokeballInfo(thing.uid).name
			local item = getItemInfo(thing.itemid)
			str = "You see "..item.article.." "..item.name.."." 
			if unique and unique == getCreatureName(cid) then
			   str = str.." It's an unique item."
            end
			str = str.."\nIt contains "..getArticle(pokename).." "..pokename..".\n" 

			local boost = getItemAttribute(thing.uid, "Boost") or 0
			local boostshow = ""
			if boost > 0 then
				str = str.."Boost level: +"..boost..".\n"
			end

			if getItemAttribute(thing.uid, "nick") then
				str = str.."It's nickname is: "..getItemAttribute(thing.uid, "nick")..".\n"
			end
			if getItemAttribute(thing.uid, "gender") == SEX_MALE then
				str = str.."It is male."
			elseif getItemAttribute(thing.uid, "gender") == SEX_FEMALE then
				str = str.."It is female."
			else
				str = str.."It is genderless."
			end
		    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, str)
		    return false
	
	    elseif string.find(iname.name, "fainted") or string.find(iname.name, "defeated") then

			str = "You see a "..string.lower(iname.name)..".\n"

			if getItemAttribute(thing.uid, "gender") == SEX_MALE then
				str = str.."It is male."
			elseif getItemAttribute(thing.uid, "gender") == SEX_FEMALE then
				str = str.."It is female."
			else
				str = str.."It is genderless."
			end
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, str)
			return false
	
		else

			return true

	    end
	end
	if not isPlayer(thing.uid) and not isMonster(thing.uid) then    
		str = "You see "..getCreatureName(thing.uid).."."
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, str)
	return false
	end

	if thing.uid == cid then  
		if getPlayerStorageValue(thing.uid, 86228) <= 0 then
			if getPlayerGroupId(thing.uid) >= 3 and getPlayerGroupId(thing.uid) <= 6 then
				pos = getCreaturePosition(thing.uid)
				ocupacao = youAre[getPlayerGroupId(thing.uid)]
				str = "You see yourself. You are "..ocupacao..".\n"
				str = str.."Pos: {x = "..pos.x..", y = "..pos.y..", z = "..pos.z.."}."
			else
				str = "You see yourself. You are a Pokemon Trainer."
			end
		end
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, str)
	return false
	end

	if isPlayer(thing.uid) and thing.uid ~= cid then
		if getPlayerStorageValue(thing.uid, 86228) <= 0 then
			promote2 = "a Pokemon Trainer"
		end

		if getPlayerSex(thing.uid) == 1 then
			artic = "He is"			
		elseif getPlayerSex(thing.uid) == 0 then
			artic = "She is"
		end	
   
		if getPlayerGroupId(thing.uid) >= 3 and getPlayerGroupId(thing.uid) <= 6 then
			pos = getCreaturePosition(thing.uid)
			ocupacao = youAre[getPlayerGroupId(thing.uid)]
			str = "You see "..getCreatureName(thing.uid)..". "..artic.." "..ocupacao.." and "..promote2..".\n"
			str = str.."Pos: {x = "..pos.x..", y = "..pos.y..", z = "..pos.z.."}."
		else
			str = "You see "..getCreatureName(thing.uid)..". "..artic.." "..promote2.."."
		end
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, str)
	return false
	end

	if getCreatureName(thing.uid) == "Evolution" then return false end	

	if not isSummon(thing.uid) then
		local str = "You see a wild "..string.lower(getCreatureName(thing.uid))..".\n"
		str = str.."Hit Points: "..getCreatureHealth(thing.uid).." / "..getCreatureMaxHealth(thing.uid)..".\n"
		str = str.."It is genderless."
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, str)
	return false

	elseif isSummon(thing.uid) and not isPlayer(thing.uid) then
	    local boostlevel = getItemAttribute(getPlayerSlotItem(getCreatureMaster(thing.uid), 8).uid, "Boost") or 0
        if getCreatureMaster(thing.uid) == cid then
			local myball = getPlayerSlotItem(cid, 8).uid
			local string = "You see your "..string.lower(getCreatureName(thing.uid)).."."
			if boostlevel > 0 then
				string = string.."\nBoost level: +"..boostlevel.."."
			end
			string = string.."\nHit points: "..getCreatureHealth(thing.uid).."/"..getCreatureMaxHealth(thing.uid).."."
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You see a "..string.lower(getCreatureName(thing.uid))..".\nIt belongs to "..getCreatureName(getCreatureMaster(thing.uid))..".")
	return false
	end
return true
end