local msgs = {"use ", ""}
local boost = {
[0] = {0},
[1] = {2},
[2] = {3},
[3] = {4},
[4] = {5},
[5] = {6},
[6] = {7},
[7] = {8},
[8] = {9},
[9] = {10},
[10] = {11},
[11] = {12},
[12] = {13},
[13] = {14},
[14] = {15},
[15] = {16},
[16] = {17},
[17] = {18},
[18] = {19},
[19] = {20},
[20] = {22},
[21] = {23},
[22] = {24},
[23] = {25},
[24] = {26},
[25] = {27},
[26] = {28},
[27] = {29},
[28] = {30},
[29] = {31},
[30] = {33},
[31] = {35}
}

function onSay(cid, words, param, channel)
	if param ~= "" then return true end
	if string.len(words) > 3 then return true end

	if #getCreatureSummons(cid) == 0 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need a pokemon to use moves.")
	return 0
	end

	local mypoke = getCreatureSummons(cid)[1]

	if getCreatureCondition(cid, CONDITION_EXHAUST) then return true end
	if getCreatureName(mypoke) == "Evolution" then return true end
    if getCreatureName(mypoke) == "Ditto" or getCreatureName(mypoke) == "Shiny Ditto" then
       name = getPlayerStorageValue(mypoke, 1010)   --edited
    else
       name = getCreatureName(mypoke)
    end  

	if not PokeMoves[name] then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your pokemon doesn't recognize this move.")
	return true
	end

	local it = string.sub(words, 2, 3)
	local move = PokeMoves[name].move1
	if getPlayerStorageValue(mypoke, 212123) >= 1 then
		cdzin = "cm_move"..it..""
	else
		cdzin = "move"..it..""       --alterado v1.5
	end

	if it == "2" then
		move = PokeMoves[name].move2
	elseif it == "3" then
		move = PokeMoves[name].move3
	elseif it == "4" then
		move = PokeMoves[name].move4
	elseif it == "5" then
		move = PokeMoves[name].move5
	elseif it == "6" then
		move = PokeMoves[name].move6
	elseif it == "7" then
		move = PokeMoves[name].move7
	elseif it == "8" then
		move = PokeMoves[name].move8
	elseif it == "9" then
		move = PokeMoves[name].move9
	elseif it == "10" then
		move = PokeMoves[name].move10
	elseif it == "11" then
		move = PokeMoves[name].move11
	elseif it == "12" then
		move = PokeMoves[name].move12
	elseif it == "13" then
		move = PokeMoves[name].move13
	end

	if not move then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your pokemon doesn't recognize this move.")
	return true
	end
	
	if getPlayerLevel(cid) < move.minLv then
	   doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need be atleast level "..move.minLv.." to use this move.")
	   return true
    end

	if getCD(getPlayerSlotItem(cid, 8).uid, cdzin) > 0 and getCD(getPlayerSlotItem(cid, 8).uid, cdzin) < (move.cd + 2) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have to wait "..getCD(getPlayerSlotItem(cid, 8).uid, cdzin).." seconds to use "..move.spell.." again.")
	return true
	end
	
	if getTileInfo(getThingPos(mypoke)).protection then
		doPlayerSendCancel(cid, "Your pokemon cannot use moves while in protection zone.")
	return true
	end
	
	if isSleep(mypoke) or isConfusion(mypoke) then
		doPlayerSendCancel(cid, "Seu Pokemon Esta Dormindo ou Confuso!")
	return true
	end
	
	if getPlayerStorageValue(mypoke, 169157) >= 1 then
		doPlayerSendCancel(cid, "Aguarde, Seu pokemon esta executando o Rest!")
	return true
	end
	
	if getPlayerStorageValue(mypoke, 3) >= 1 then
		doSendAnimatedText(getThingPos(mypoke), "MISS", 215)
		setPlayerStorageValue(mypoke, 3, -1)
		setCD(getPlayerSlotItem(cid, 8).uid, cdzin, move.cd)
		setPokemonCooldown(cid,1,move.cd) 
		doPokemonDropCooldown(cid,1) 
		getMoveLevel(cid,1,move.minLv) 
		getMoveName(cid,1,move.spell)
	return true
	end
	if getPlayerStorageValue(mypoke, 5) >= 1 then
		if math.random(1,100) <= 33 then
			doSendAnimatedText(getThingPos(mypoke), "SELF HIT", 180)
			local levels = getPlayerLevel(cid)
			doTargetCombatHealth(cid, mypoke, COMBAT_PHYSICALDAMAGE, -(math.random((levels*3),(levels*5))), -((math.random((levels*3),(levels*5))+10)), 3)
		return true
		end
	end

	if move.target ~= "no" then
		if not isMonster(getCreatureTarget(cid)) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don\'t have any targets.")
		return 0
		end
		if getDistanceBetween(getThingPos(mypoke), getThingPos(getCreatureTarget(cid))) > move.dista then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Get closer to the target to  this move.")
		return 0
		end
		if not isSightClear(getThingPos(mypoke), getThingPos(getCreatureTarget(cid)), false) then
		return 0
		end
	end
	
	if move.type == "flying" then
		elementa = FLYDAMAGE
	elseif move.type == "ground" then
		elementa = GROUNDDAMAGE
	elseif move.type == "electric" then
		elementa = ELECTRICDAMAGE
	elseif move.type == "ghost" then
		elementa = GHOSTDAMAGE
	elseif move.type == "normal" then
		elementa = NORMALDAMAGE
	elseif move.type == "fighting" then
		elementa = FIGHTINGDAMAGE
	elseif move.type == "poison" then
		elementa = POISONDAMAGE
	elseif move.type == "rock" then
		elementa = ROCKDAMAGE
	elseif move.type == "bug" then
		elementa = BUGDAMAGE
	elseif move.type == "fire" then
		elementa = FIREDAMAGE
	elseif move.type == "water" then
		elementa = WATERDAMAGE
	elseif move.type == "grass" then
		elementa = GRASSDAMAGE
	elseif move.type == "psychic" then
		elementa = PSYCHICDAMAGE
	elseif move.type == "ice" then
		elementa = ICEDAMAGE
	elseif move.type == "dragon" then
		elementa = DRAGONDAMAGE
	end
	
	local element = elementa

	local booster = boost[getBoost(cid)]
	local num1 = (move.base1 + booster[1] / 5)
	local num2 = (move.base2 + booster[1] / 5)
	local num3 = (move.bonus + booster[1] / 5)
	if getPlayerStorageValue(mypoke, 254) >= 1 then
		num3 = num3 * 1.8
		setPlayerStorageValue(mypoke, 254, 0)
	end
	setPlayerStorageValue(mypoke, 1000, ((num1)+(getPlayerLevel(cid)*(num3))))

	newid = setCD(getPlayerSlotItem(cid, 8).uid, cdzin, move.cd)
		setPokemonCooldown(cid,1,move.cd) 
		doPokemonDropCooldown(cid,1) 
		getMoveLevel(cid,1,move.minLv) 
		getMoveName(cid,1,move.spell)
	
	doCreatureSay(cid, ""..getCreatureName(mypoke)..", "..msgs[math.random(#msgs)]..""..move.spell.."!", TALKTYPE_MONSTER)
	
	local Gstr = 0
	if getItemAttribute(getPlayerSlotItem(cid, 8).uid, "gender") == SEX_MALE then
		Gstr = 2
	else
		Gstr = Gstr
	end 
	
	local min = ((num1)+((((getPlayerLevel(cid)) / 1.5)+(getBoost(cid)+Gstr))*(num3)))
	local max = ((num2)+((((getPlayerLevel(cid)) / 1.5) + (getBoost(cid)+Gstr))*(num3)))

	local felicidade = getPlayerStorageValue(cid, 66604)
	if felicidade >= 150 then
		min = (min/1)
		max = (max/1)
	else
		if felicidade <= 60 and  felicidade >= 20 then
			min = (min/1.25)
			max = (max/1.25)
		else
			if felicidade <= 20 then
				min = (min/1.50)
				max = (max/1.50)
			end
		end
	end
    doPokemonUseSpell(mypoke, move.spell, min, max, element)
	doUpdateCds(cid)
	doUpdateCooldowns(cid)
	getHappinesStatus(mypoke, false)
	setPokemonCooldown(cid,1,move.cd) 
		doPokemonDropCooldown(cid,1) 
		getMoveLevel(cid,1,move.minLv) 
		getMoveName(cid,1,move.spell)
return 0
end