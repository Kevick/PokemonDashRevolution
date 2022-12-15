function getMasterTarget(cid)
	if isCreature(cid) and getPlayerStorageValue(cid, 21101) ~= -1 then
	return getPlayerStorageValue(cid, 21101)     --alterado v1.6
	end
    if isSummon(cid) then
	    return getCreatureTarget(getCreatureMaster(cid))
	else
	    return getCreatureTarget(cid)
    end
end

function doPokemonUseSpell(pk, spell, min, max, element)

	local SPELL_OUT = true
	local owner = getCreatureMaster(pk)
	local snorlax = {lookType = 258}
	local scyther = {lookType = 15}
	local golem = {lookType = 288}
	local sandslash = {lookType = 285}
	local sandshrew = {lookType = 284}
	local electrode = {lookType = 286}
	local voltorb = {lookType = 287}
	local miltank = {lookType = 675}
	local donphan = {lookType = 664}
	local hrew = {lookType = 284}
	
	if not isSummon(pk) then
	    if isPlayer(getCreatureTarget(pk)) then
			lvl = ((getPlayerLevel(getCreatureTarget(pk))) / 1.5)
		else
			lvl = ((getPlayerLevel(getCreatureMaster(getCreatureTarget(pk)))) / 1.5)
		end
		min  = getPokemonSpellInfo(pk, spell, lvl).min
		max = getPokemonSpellInfo(pk, spell,lvl).max
		element = getPokemonSpellInfo(pk, spell, lvl).element
	end

	--- FOCUS           
	if getPlayerStorageValue(pk, 253) >= 0  then   --alterado v1.6
		min = min * 2
		max = max * 2
		setPlayerStorageValue(pk, 253, -1)
	end
	
	if spell == "Rock Throw" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 11)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
	elseif spell == "Headbutt" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
	elseif spell == "Healera" then
		doCreatureAddHealth(pk, max)
		doAreaCombatHealth(pk, element, getThingPos(pk), hl, min, max, CONST_ME_MAGIC_BLUE)
        doSendAnimatedText(getThingPos(pk), "+"..max.."", 35)
    elseif spell == "Agility" then
		local pos = getThingPos(getMasterTarget(pk))
		local pos2 = getThingPos(getMasterTarget(pk))
		local pos3 = getThingPos(pk)
		pos.x = pos.x + math.random(-1,1)
		pos.y = pos.y + math.random(-1,1)
		if hasSqm(pos)  then
			if getTileThingByPos(pos) and getTileThingByPos(pos).itemid >= 1 and not isInArray({919, 460, 4820, 4821, 4822, 4823, 4824, 4825}, getTileThingByPos(pos).itemid) and isWalkable(pos) then
				pos = getClosestFreeTile(getMasterTarget(pk), pos)
				doSendMagicEffect(pos3, 211)
				doTeleportThing(pk, pos, false)
				doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 159)
			else
				local newpos = getClosestFreeTile(getMasterTarget(pk), pos)
				doSendMagicEffect(pos3, 211)
				doTeleportThing(pk, newpos, false)
				doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 159)
			end
		else
			doSendMagicEffect(pos3, 211)
			doTeleportThing(pk, pos3, false)
			doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 159)
		end
	elseif spell == "String Shot" then
		setPlayerStorageValue(getMasterTarget(pk), 3, 1)
		local alvo = getMasterTarget(pk)
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 23)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 137)
		local function string(params)
			if isCreature(params.alvo) then
				if getPlayerStorageValue(params.alvo, 3) >= 1 then
					doSendMagicEffect(getThingPos(params.alvo), 137)
				end
			end
		end
		local function normalstr(params)
			if isCreature(params.alvo) then
				if getPlayerStorageValue(params.alvo, 3) >= 1 then
					setPlayerStorageValue(params.alvo, 3, -1)
				end
			end
		end
		addEvent(string, 250, {alvo = alvo})
		addEvent(string, 500, {alvo = alvo})
		addEvent(string, 750, {alvo = alvo})
		addEvent(string, 1000, {alvo = alvo})
		addEvent(string, 1250, {alvo = alvo})
		addEvent(string, 1500, {alvo = alvo})
		addEvent(string, 1750, {alvo = alvo})
		addEvent(string, 2000, {alvo = alvo})
		addEvent(string, 2250, {alvo = alvo})
		addEvent(string, 2500, {alvo = alvo})
		addEvent(string, 2750, {alvo = alvo})
		addEvent(string, 3000, {alvo = alvo})
		addEvent(normalstr, 3050, {alvo = alvo})
	elseif spell == "Aowner" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 14)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 20)
	elseif spell == "Water Gun" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1n, -min, -max, 74)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2n, -min, -max, 75)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3n, -min, -max, 76)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1s, -min, -max, 77)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2s, -min, -max, 75)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3s, -min, -max, 78)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1e, -min, -max, 69)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2e, -min, -max, 70)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3e, -min, -max, 71)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1w, -min, -max, 72)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2w, -min, -max, 70)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3w, -min, -max, 73)
		end
	elseif spell == "Slam" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
	elseif spell == "Rapid Hit" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
		local hitalvo = getMasterTarget(pk)
		local function hit(params)
			if isCreature(pk) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(pk, NORMALDAMAGE, getThingPos(getMasterTarget(params.pid)), 0, -0, -0, 3)
					end
				end
			end
		end
		addEvent(hit, 80, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 280, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 480, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 680, {pid = pk, hitalvo = hitalvo})
 --------------------NORMAL
	elseif spell == "Aqua Tail" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 68)
	elseif spell == "Lovely Kiss" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 147)	
	elseif spell == "Lick" then
				
		 doConfusion(getMasterTarget(pk))
		--doAreaCombatCondition(pk, getThingPos(pk), confusion, sleepcondition, 255)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 145)
	elseif spell == "Roar" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 2)
	elseif spell == "Iron Tail" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 160)		
	elseif spell == "Hypnosis" then
		setPlayerStorageValue(getMasterTarget(pk), 3, 1)
		local alvo = getMasterTarget(pk)
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 24)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 136)
		local function string(params)
			if isCreature(params.alvo) then
				if getPlayerStorageValue(params.alvo, 3) >= 1 then
					doSendMagicEffect(getThingPos(params.alvo), 136)
				end
			end
		end
		local function normalstr(params)
			if isCreature(params.alvo) then
				if getPlayerStorageValue(params.alvo, 3) >= 1 then
					setPlayerStorageValue(params.alvo, 3, -1)
				end
			end
		end
		addEvent(string, 250, {alvo = alvo})
		addEvent(string, 500, {alvo = alvo})
		addEvent(string, 750, {alvo = alvo})
		addEvent(string, 1000, {alvo = alvo})
		addEvent(string, 1250, {alvo = alvo})
		addEvent(string, 1500, {alvo = alvo})
		addEvent(string, 1750, {alvo = alvo})
		addEvent(string, 2000, {alvo = alvo})
		addEvent(string, 2250, {alvo = alvo})
		addEvent(string, 2500, {alvo = alvo})
		addEvent(string, 2750, {alvo = alvo})
		addEvent(string, 3000, {alvo = alvo})
		addEvent(normalstr, 3050, {alvo = alvo})
    elseif spell == "Triple Kick" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)	
    elseif spell == "Triple Punch" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 113)
 	elseif spell == "Shadow Ball" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 18)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 140)
	elseif spell == "Swift" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 47)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 148)
   -------------------------------------------------------------ADICIONADOS------------------------------------------------------------------
   ------------------------------------------------------------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------------------------------------------------------------
	elseif spell == "Thunder Shock" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 40)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 48)
	elseif spell == "Razor Leaf" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				if not isCreature(pk) then return true end
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 8)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				if not isCreature(pk) then return true end
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 79)
			else
			end
		end
		addEvent(damage, 100, {pid = pk})
		addEvent(damage, 600, {pid = pk})
		addEvent(throw, 0, {pid = pk})
		addEvent(throw, 550, {pid = pk})
	elseif spell == "Sand Attack" then
		posit = getThingPos(pk)
		local function sandattack(params)
			if not isCreature(params.pid) then return true end
			doAreaCombatHealth(pk, element, params.ar, sand1, -min, -max, params.ef)
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}, ef = 120})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}, ef = 120})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}, ef = 120})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}, ef = 122})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}, ef = 122})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}, ef = 122})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}, ef = 121})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}, ef = 121})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}, ef = 121})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}, ef = 119})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}, ef = 119})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}, ef = 119})
		end
	elseif spell == "Bite" then
		if not isCreature(getMasterTarget(pk)) or isCreature(pk) then return true end
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 146)
	elseif spell == "Slash" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 160)
	elseif spell == "Splash" then
		doSendMagicEffect(getThingPos(pk), 53)
	elseif spell == "Doubleslap" then
		local function slap(params)
			if isMonster(getMasterTarget(params.pid)) then
				if not isCreature(getMasterTarget(params.pid)) or isCreature(params.pid) then return true end
				doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 3)
			else
			end
		end
		addEvent(slap, 0, {pid = pk})
		addEvent(slap, 600, {pid = pk})
	elseif spell == "Mega Punch" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 112)
	elseif spell == "Scratch" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 142)	
	elseif spell == "Confusion" then
		doAreaCombatHealth(pk, element, getThingPos(pk), confusion, -min, -max, 133)	
	elseif spell == "Psychic" then
		doAreaCombatHealth(pk, element, getThingPos(pk), psychic, -min, -max, 136)
	elseif spell == "Absorb" then
		local life = getCreatureHealth(getMasterTarget(pk))
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 14)
		local newlife = life - getCreatureHealth(getMasterTarget(pk))
		doSendMagicEffect(getThingPos(pk), 14)
		doCreatureAddHealth(pk, newlife)
		doSendAnimatedText(getThingPos(pk), "+"..newlife.."", 35)
	elseif spell == "Water Pulse" then

		posit = getThingPos(pk)
		local function gust(params)
		if not isCreature(params.pid) then return true end
			doAreaCombatHealth(params.pid, element, params.ar, sand1, -min, -max, 68)
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}})
		end
	elseif spell == "Mud Shot" then
		setPlayerStorageValue(getMasterTarget(pk), 3, 1)
		local mudalvo = getMasterTarget(pk)
		local function ver(params)
			if isCreature(params.mudalvo) then
				if getPlayerStorageValue(params.mudalvo, 3) >= 1 then
					setPlayerStorageValue(params.mudalvo, 3, -1)
				end
			end
		end
		addEvent(ver, 4500, {mudalvo = mudalvo})
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 1)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 34)
	elseif spell == "Bubbles" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 2)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 25)
			else
			end
		end
		addEvent(throw, 0, {pid = pk})
		addEvent(damage, 0, {pid = pk})
	elseif spell == "Water Spout" then
		doSendDistanceShoot(getThingPos(pk), {x=getThingPos(pk).x, y=getThingPos(pk).y-5, z=getThingPos(pk).z}, 2)
		local function spout(params)
			if isCreature(params.pid) then
				for x = -2,2 do
					for y = -2,2 do
						local newpos = getThingPos(params.pid)
						newpos.x = newpos.x+x
						newpos.y = newpos.y+y
						doSendDistanceShoot({x=getThingPos(params.pid).x, y=getThingPos(params.pid).y-5, z=getThingPos(params.pid).z}, newpos, 2)
					end
				end
			end
		end
		local function spdmg(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(params.pid), waterspout, -min, -max, 68)
			end
		end
		addEvent(spout, 300, {pid = pk})
		addEvent(spdmg, 450, {pid = pk})
	elseif spell == "Horn Attack" then
		if not isCreature(getMasterTarget(pk)) or isCreature(pk) then return true end
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 15)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
	elseif spell == "Super Sonic" then
		local t = getMasterTarget(pk)
		setPlayerStorageValue(t, 5, 1)
		local function confd(params)
			if isCreature(params.t) then
				local spdc = getCreatureSpeed(params.t)
				if getCreatureLookDir(params.t) == 0 then
					confs = math.random(1,3)
				elseif getCreatureLookDir(params.t) == 1 then
					confurandom = math.random(1,99)
					if confurandom <= 33 then
						confs = 0
					elseif confurandom >= 67 then
						confs = 2
					else
						confs = 3
					end
				elseif getCreatureLookDir(params.t) == 2 then
					confurandom = math.random(1,99)
					if confurandom <= 33 then
						confs = 3
					elseif confurandom >= 67 then
						confs = 0
					else
						confs = 1
					end
				elseif getCreatureLookDir(params.t) == 3 then
					confs = math.random(0,2)
				end
				doPushCreature(params.t, confs, 1, 0)
				doSendMagicEffect(getThingPos(params.t), 31)
			end
		end
		local function nonc(params)
			if isCreature(params.t) then
				doChangeSpeed(params.t, -getCreatureSpeed(params.t))
				doChangeSpeed(params.t, getCreatureBaseSpeed(params.t))
				setPlayerStorageValue(params.t, 5, -1)
			end
		end
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 32)
		doChangeSpeed(t, -( getCreatureSpeed(t)/3))
		doSendMagicEffect(getThingPos(t), 31)
		for i = 1, math.random(6,7) do
			addEvent(confd, 1000*i, {pid = pk, t = t})
		end
		addEvent(nonc, 7100, {pid = pk, t = t})
	elseif spell == "Fury Attack" then
		local namezito = getCreatureName(pk)
		local namezin = getCreatureName(getMasterTarget(pk))
		local function pee(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getCreatureName(params.pid) == namezito then
						if getCreatureName(getMasterTarget(params.pid)) == namezin then
							doSendDistanceShoot(getThingPos(params.pid), getThingPos(params.pid), 15)
							doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 3)
						end
					end
				end
			end
		end
		local delay = 200
		randnee = math.random(1,100)
		if randnee >= 1 and randnee <= 37 then
			a = 2
		elseif randnee >= 38 and randnee <= 74 then
			a = 3
		elseif randnee >= 75 and randnee <= 88 then
			a = 4
		else
			a = 5
		end
		local times = a
		for i = 1,a do
			addEvent(pee, delay, {pid = pk})
			delay = delay + 600
		end
		local function msg(params)
			if isCreature(params.pid) then
				doSendAnimatedText(getThingPos(params.pid), ""..times.." HITS", 35)
			end
		end
		addEvent(msg, 580*a, {pid = pk})
    elseif spell == "Peck" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
    elseif spell == "Vine Whip" then
		if getCreatureLookDir(pk) == 0 then
			area = vinen
			dano = whipn
			effect = 80
		elseif getCreatureLookDir(pk) == 1 then
			area = vinee
			dano = whipe
			effect = 83
		elseif getCreatureLookDir(pk) == 2 then
			area = vines
			dano = whips
			effect = 81
		elseif getCreatureLookDir(pk) == 3 then
			area = vinew
			dano = whipw
			effect = 82
		end
		doAreaCombatHealth(pk, null, getThingPos(pk), area, -min, -min, effect)
		doAreaCombatHealth(pk, element, getThingPos(pk), dano, -min, -max, 255)
    elseif spell == "Psywave" then 

		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tsn, -min, -max, 133)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tse, -min, -max, 133)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tss, -min, -max, 133)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tsw, -min, -max, 133)
		end
	elseif spell == "Dizzy Punch" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
		local t = getMasterTarget(pk)
		setPlayerStorageValue(t, 5, 1)
		local function confd(params)
			if isCreature(params.t) then
				local spdc = getCreatureSpeed(params.t)
				if getCreatureLookDir(params.t) == 0 then
					confs = math.random(1,3)
				elseif getCreatureLookDir(params.t) == 1 then
					confurandom = math.random(1,99)
					if confurandom <= 33 then
						confs = 0
					elseif confurandom >= 67 then
						confs = 2
					else
						confs = 3
					end
				elseif getCreatureLookDir(params.t) == 2 then
					confurandom = math.random(1,99)
					if confurandom <= 33 then
						confs = 3
					elseif confurandom >= 67 then
						confs = 0
					else
						confs = 1
					end
				elseif getCreatureLookDir(params.t) == 3 then
					confs = math.random(0,2)
				end
				doPushCreature(params.t, confs, 1, 0)
				doSendMagicEffect(getThingPos(params.t), 31)
			end
		end
		local function nonc(params)
			if isCreature(params.t) then
				doChangeSpeed(params.t, -getCreatureSpeed(params.t))
				doChangeSpeed(params.t, getCreatureBaseSpeed(params.t))
				setPlayerStorageValue(params.t, 5, -1)
			end
		end
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 26)
		doChangeSpeed(t, -( getCreatureSpeed(t)/3))
		doSendMagicEffect(getThingPos(t), 31)
		for i = 1, math.random(6,7) do
			addEvent(confd, 1000*i, {pid = pk, t = t})
		end
		addEvent(nonc, 7100, {pid = pk, t = t})
	elseif spell == "Leech Seed" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 5)
		local alvo = getMasterTarget(pk)
		local leecher = pk
		local function suck(params)
			if isCreature(params.pid) then
				if isCreature(params.alvo) then
					if pk == leecher then
						doSendMagicEffect(getThingPos(params.pid), 14)
						local life = getCreatureHealth(alvo)
						doAreaCombatHealth(params.pid, element, getThingPos(params.alvo), 0, -min, -max, 45)
						local newlife = life - getCreatureHealth(alvo)
						if newlife >= 1 then
							doCreatureAddHealth(params.pid, newlife)
							doSendAnimatedText(getThingPos(params.pid), "+"..newlife.."", 35)
						end
					end
				end
			end
		end
		addEvent(suck, 2000, {pid = pk, alvo = alvo})
		addEvent(suck, 4000, {pid = pk, alvo = alvo})
		addEvent(suck, 6000, {pid = pk, alvo = alvo})
		addEvent(suck, 8000, {pid = pk, alvo = alvo})
		addEvent(suck, 10000, {pid = pk, alvo = alvo})
	elseif spell == "Psy Pulse" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 24)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 136)
	elseif spell == "Thunder Wave" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatCondition(pk, getThingPos(pk), tsn, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), tsn, -min, -max, 48)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatCondition(pk, getThingPos(pk), tse, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), tse, -min, -max, 48)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatCondition(pk, getThingPos(pk), tss, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), tss, -min, -max, 48)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatCondition(pk, getThingPos(pk), tsw, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), tsw, -min, -max, 48)
		end
	elseif spell == "Psybeam" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bmn, -min, -max, 108)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bms, -min, -max, 109)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bme, -min, -max, 107)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bmw, -min, -max, 106)
		end
	elseif spell == "Ice Beam" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1n, -min, -max, 99)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2n, -min, -max, 105)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3n, -min, -max, 103)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1s, -min, -max, 98)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2s, -min, -max, 105)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3s, -min, -max, 102)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1e, -min, -max, 96)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2e, -min, -max, 104)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3e, -min, -max, 100)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1w, -min, -max, 97)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2w, -min, -max, 104)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3w, -min, -max, 101)
		end
    elseif spell == "Thunder Punch" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 40)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 112)
	elseif spell == "Fire Punch" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 5)
	elseif spell == "Bug Bite" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 20)
	elseif spell == "Hyper Beam" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1n, -min, -max, 152)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2n, -min, -max, 158)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3n, -min, -max, 156)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1s, -min, -max, 151)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2s, -min, -max, 158)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3s, -min, -max, 155)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1e, -min, -max, 149)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2e, -min, -max, 157)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3e, -min, -max, 153)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1w, -min, -max, 150)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2w, -min, -max, 157)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3w, -min, -max, 154)
		end

	elseif spell == "EggBomb" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 12)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 5)
	elseif spell == "Quick Attack" then
	if min == nil or max == nil then print(getCreatureName(pk).."ERRO QUICK") return true end
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
	elseif spell == "Mega Kick" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 113)
	elseif spell == "Poison Fang" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 159)
        doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 114)
	elseif spell == "Pluck" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), pluck, -min, -max, 2)
	elseif spell == "Psy Wave" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatCondition(pk, getThingPos(pk), tsn, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wsn, -min, -max, 133)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatCondition(pk, getThingPos(pk), tse, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wse, -min, -max, 133)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatCondition(pk, getThingPos(pk), tss, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wss, -min, -max, 133)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatCondition(pk, getThingPos(pk), tsw, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wsw, -min, -max, 133)
		end
	elseif spell == "Spark" then
		local function spark(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					doSendDistanceShoot(getThingPos(params.pid), params.ownerpos, 40)
					doAreaCombatHealth(pk, element, params.ownerpos, 0, -min, -max, 48)
				end
			end
		end
		for a = -1, 1 do
			for b = -1, 1 do
				ownerpos = getThingPos(pk)
				ownerpos.x = ownerpos.x+a
				ownerpos.y = ownerpos.y+b
				addEvent(spark, math.abs(a)*350 + math.abs(b)*650, {pid = pk, ownerpos = ownerpos})
			end
		end		
	elseif spell == "Waterball" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 2)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(pk)), waba, -min, -max, 68)
			else
			end
		end
		addEvent(damage, 100, {pid = pk})
		addEvent(throw, 0, {pid = pk})
	elseif spell == "Restore" then
		doSendMagicEffect(getThingPos(pk), 14)
		doCreatureAddHealth(pk, max)
		doSendAnimatedText(getThingPos(pk), "+"..max.."", 35)
	elseif spell == "Poison Sting" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 15)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 8)
	elseif spell == "Ember" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 3)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 15)
	elseif spell == "Thundershock" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 40)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 48)
	elseif spell == "Drill Peck" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 110)
		local hitalvo = getMasterTarget(pk)
		local function hit(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(params.pid, FLYDAMAGE, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 110)
					end
				end
			end
		end
		addEvent(hit, 480, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 880, {pid = pk, hitalvo = hitalvo})
	elseif spell == "Fire Fang" then
		doSendMagicEffect(getThingPos(getMasterTarget(pk)), 146)
		local function damage(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 5)
				end
			end
		end
		addEvent(damage, 200, {pid = pk})
	elseif spell == "Metronome" then
		doSendMagicEffect(getThingPos(pk), 161)
		local function variavel(pk, elemento, defec, mefec)
			if isCreature(pk) then
				if isCreature(pk) then
					local pos = getThingPos(pk)
					pos.x = pos.x + math.random(-4,4)
					pos.y = pos.y + math.random(-4,4)
					local frompos = getThingPos(pk)
					frompos.x = pos.x - 7
					frompos.y = pos.y - 6
					doSendDistanceShoot(frompos, pos, defec)
					doAreaCombatHealth(pk, elemento, pos, 0, -min, -max, mefec)
				end
			end
		end
		local function leaf(params)
		lugar = getThingPos(pk)
			for x= -7,7 do
				for y= -6,6 do
					topos = {x=lugar.x+x, y=lugar.y+y, z=lugar.z}
					doSendDistanceShoot(getThingPos(params.pid), topos, 8)
				end
			end
		end
		posit = getThingPos(pk)
        local function fogo(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		local function sortear()
        local magias = math.random(1,7)
			if magias == 1 then
				for r = 1, 72 do
					addEvent(variavel, r*35, pk,ELECTRICDAMAGE,41,48)
				end
			elseif magias == 2 then
				for r = 1, 72 do
					addEvent(variavel, r*35,pk,ICEDAMAGE,42,52)
				end
			elseif magias == 3 then
				for r = 1, 72 do
					addEvent(variavel, r*35,pk,GHOSTDAMAGE,18,140)
				end
			elseif magias == 4 then
				for r = 1, 72 do
					addEvent(variavel, r*35,pk,WATERDAMAGE,2,53)
				end
			elseif magias == 5 then
				for r = 1, 72 do
					addEvent(variavel, r*35,pk,ROCKDAMAGE,11,44)
				end
			elseif magias == 6 then
				addEvent(leaf, 0, {pid = pk})
				addEvent(doAreaCombatHealth, 0, pk, GRASSDAMAGE, getThingPos(pk), grassarea, -min, -max, 255)
			elseif magias == 7 then
				addEvent(fogo, 0, {pid = pk, el = element, ar = magma1, ef = 6})
				addEvent(fogo, 100, {pid = pk, el = element, ar = magma1, ef = 35})
				addEvent(fogo, 400, {pid = pk, el = element, ar = magma2, ef = 6})
				addEvent(fogo, 500, {pid = pk, el = element, ar = magma2, ef = 35})
				addEvent(fogo, 800, {pid = pk, el = element, ar = magma3, ef = 6})
			end
        end
        addEvent(sortear, 1000)
	elseif spell == "Wing Attack" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingn, -min, -max, 128)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingdn, -min, -max, CONST_ME_NONE)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), winge, -min, -max, 129)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingde, -min, -max, CONST_ME_NONE)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wings, -min, -max, 131)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingds, -min, -max, CONST_ME_NONE)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingw, -min, -max, 130)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingdw, -min, -max, CONST_ME_NONE)
		end
	elseif spell == "Poison Powder" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), confusion, -min, -max, 84)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), confusion, -min, -max, 84)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), confusion, -min, -max, 84)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), confusion, -min, -max, 84)
		end
	elseif spell == "Fury Cutter" then

        local function attaque(params)
			if getCreatureLookDir(pk) == 0 then
				doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingn, -min, -max, 128)
				doAreaCombatHealth(pk, element, getThingPos(pk), wingdn, -min, -max, CONST_ME_NONE)
			elseif getCreatureLookDir(pk) == 1 then
				doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), winge, -min, -max, 129)
				doAreaCombatHealth(pk, element, getThingPos(pk), wingde, -min, -max, CONST_ME_NONE)
			elseif getCreatureLookDir(pk) == 2 then
				doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wings, -min, -max, 131)
				doAreaCombatHealth(pk, element, getThingPos(pk), wingds, -min, -max, CONST_ME_NONE)
			elseif getCreatureLookDir(pk) == 3 then
				doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingw, -min, -max, 130)
				doAreaCombatHealth(pk, element, getThingPos(pk), wingdw, -min, -max, CONST_ME_NONE)
			end
        end
		addEvent(attaque, 0, {owner = owner})
		addEvent(attaque, 500, {owner = owner})
	elseif spell == "Great Love" then
		doAreaCombatHealth(pk, element, getThingPos(pk), glv, -min, -max, 147)
	elseif spell == "Stomp" then
		doAreaCombatHealth(pk, element, getThingPos(pk), stomp, -min, -max, 118)
	elseif spell == "Night Shade" then
		doAreaCombatHealth(pk, element, getThingPos(pk), ns, -min, -max, 208)
	elseif spell == "Cyber Pulse" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bmn, -min, -max, 108)
        elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bms, -min, -max, 109)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bme, -min, -max, 107)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), bmw, -min, -max, 106)
		end
	elseif spell == "Shadow Punch" then
		if getCreatureLookDir(pk) == 0 then
			area = vinen
			dano = whipn
			effect = 217
		elseif getCreatureLookDir(pk) == 1 then
			area = vinee
			dano = whipe
			effect = 215
		elseif getCreatureLookDir(pk) == 2 then
			area = vines
			dano = whips
			effect = 218
		elseif getCreatureLookDir(pk) == 3 then
			area = vinew
			dano = whipw
			effect = 216
		end
		doAreaCombatHealth(pk, null, getThingPos(pk), area, -min, -min, effect)
		doAreaCombatHealth(pk, element, getThingPos(pk), dano, -min, -max, 255)
	elseif spell == "Flamethrower" then
		if getCreatureLookDir(pk) == 0 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+1
			flamepos.y = flamepos.y-1
			doSendMagicEffect(flamepos, 55)
			doAreaCombatHealth(pk, element, getThingPos(pk), flamen, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 1 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+3
			flamepos.y = flamepos.y+1
			doSendMagicEffect(flamepos, 58)
			doAreaCombatHealth(pk, element, getThingPos(pk), flamee, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 2 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+1
			flamepos.y = flamepos.y+3
			doSendMagicEffect(flamepos, 56)
			doAreaCombatHealth(pk, element, getThingPos(pk), flames, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 3 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x-1
			flamepos.y = flamepos.y+1
			doSendMagicEffect(flamepos, 57)
			doAreaCombatHealth(pk, element, getThingPos(pk), flamew, -min, -max, 255)
		end
	elseif spell == "Ice Wave" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatCondition(pk, getThingPos(pk), tsn, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wsn, -min, -max, 43)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatCondition(pk, getThingPos(pk), tse, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wse, -min, -max, 43)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatCondition(pk, getThingPos(pk), tss, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wss, -min, -max, 43)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatCondition(pk, getThingPos(pk), tsw, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wsw, -min, -max, 43)
		end
	elseif spell == "Fire Wave" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatCondition(pk, getThingPos(pk), tsn, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wsn, -min, -max, 6)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatCondition(pk, getThingPos(pk), tse, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wse, -min, -max, 6)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatCondition(pk, getThingPos(pk), tss, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wss, -min, -max, 6)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatCondition(pk, getThingPos(pk), tsw, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), wsw, -min, -max, 6)
		end
	elseif spell == "Bubble Beam" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatCondition(pk, getThingPos(pk), tsn, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbn, -min, -max, 68)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatCondition(pk, getThingPos(pk), tse, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbe, -min, -max, 68)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatCondition(pk, getThingPos(pk), tss, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbs, -min, -max, 68)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatCondition(pk, getThingPos(pk), tsw, thunderwavecondition, 255)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbw, -min, -max, 68)
		end
	elseif spell == "Gust" then
		posit = getThingPos(pk)
		local function gust(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, params.ar, sand1, -min, -max, 42)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}})
		end
	elseif spell == "Harden" then
		local hardname = getCreatureName(pk)
		setPlayerStorageValue(pk, 4, 1)
		local oldpos = getThingPos(pk)
		local function efect(params)
			if isCreature(params.pid) then
				if getPlayerStorageValue(params.pid, 4) >= 1 then
					doSendMagicEffect(getThingPos(params.pid), 144)
				end
			end
		end
		local function chard(params)
			if isCreature(params.pid) then
				if getPlayerStorageValue(params.pid, 4) >= 1 then
					setPlayerStorageValue(params.pid, 4, -1)
				end
			end
		end
		addEvent(efect, 100, {pid = pk, hardname = hardname})
		addEvent(efect, 1600, {pid = pk, hardname = hardname})
		addEvent(efect, 3100, {pid = pk, hardname = hardname})
		addEvent(efect, 4600, {pid = pk, hardname = hardname})
		addEvent(efect, 6100, {pid = pk, hardname = hardname})
		addEvent(efect, 7600, {pid = pk, hardname = hardname})
		addEvent(efect, 9100, {pid = pk, hardname = hardname})
		addEvent(efect, 10600, {pid = pk, hardname = hardname})
		addEvent(chard, 11000, {pid = pk})
	elseif spell == "Clamp" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
	elseif spell == "Sing" then
		setPlayerStorageValue(getMasterTarget(pk), 3, 1)
		local mudalvo = getMasterTarget(pk)
		local function ver(params)
			if isCreature(params.mudalvo) then
				if getPlayerStorageValue(params.mudalvo, 3) >= 1 then
					setPlayerStorageValue(params.mudalvo, 3, -1)
					doChangeSpeed(mudalvo, -(getCreatureSpeed(mudalvo)/3))
					doSendMagicEffect(getThingPos(mudalvo), 31)
				end
			end
		end
		local function voltar(params)
			if isCreature(params.mudalvo) then
				doChangeSpeed(params.mudalvo, -getCreatureSpeed(params.mudalvo))
				doChangeSpeed(params.mudalvo, getCreatureBaseSpeed(params.mudalvo))
			end
		end
		addEvent(ver, 5000, {mudalvo = mudalvo})
		addEvent(voltar, 10000, {mudalvo = mudalvo})
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 3)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 19)
	elseif spell == "Thunderbolt" then
		local posalvo = getThingPos(getMasterTarget(pk))
		local boltalvo = getMasterTarget(pk)
		posalvo.x = posalvo.x-2
		posalvo.y = posalvo.y-6
		doSendDistanceShoot(posalvo, getThingPos(getMasterTarget(pk)), 41)
		local function bolt(params)
			if isCreature(params.owner) then
				if isCreature(getMasterTarget(pk)) then
					if getMasterTarget(params.pid) == params.boltalvo then
						doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 48)
					end
				end
			end
		end
		addEvent(bolt, 200, {pid = pk, boltalvo = boltalvo})
	elseif spell == "Karate Chop" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 42)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 112)
	elseif spell == "Bone Club" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 7)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 117)
      elseif spell == "Whirlwind" then


		posit = getThingPos(pk)
		local function gust(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, params.ar, params.br, -min, -max, 42)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}, br = sand1})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}, br = whirl3})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}, br = whirl5})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}, br = whirl5})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}, br = sand1})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}, br = whirl3})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}, br = whirl5})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}, br = whirl5})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}, br = sand1})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}, br = whirl32})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}, br = whirl52})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}, br = whirl52})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}, br = sand1})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}, br = whirl32})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}, br = whirl52})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}, br = whirl52})
		end
	elseif spell == "Sludge" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 6)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 116)
	elseif spell == "Pin Missile" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 13)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 3)
	elseif spell == "Rock Slide" then
		local posalvo = getThingPos(getMasterTarget(pk))
		local boltalvo = getMasterTarget(pk)
		posalvo.x = posalvo.x-2
		posalvo.y = posalvo.y-6
		doSendDistanceShoot(posalvo, getThingPos(getMasterTarget(pk)), 11)
		local function bolt(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(pk)) then
					if getMasterTarget(params.pid) == params.boltalvo then
						doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 44)
					end
				end
			end
		end
		addEvent(bolt, 200, {pid = pk, boltalvo = boltalvo})
	elseif spell == "X-Scissor" then
        local function attaque(params)
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingn, -min, -max, 128)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingdn, -min, -max, CONST_ME_NONE)
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), winge, -min, -max, 129)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingde, -min, -max, CONST_ME_NONE)
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wings, -min, -max, 131)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingds, -min, -max, CONST_ME_NONE)
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingw, -min, -max, 130)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingdw, -min, -max, CONST_ME_NONE)
		end
		addEvent(attaque, 0, {owner = owner})
		addEvent(attaque, 500, {owner = owner})
	elseif spell == "Mass Kick" then
		if getCreatureName(pk) == "Hitmonlee" then
			doSetCreatureOutfit(pk, {lookType = 301}, 8300)
			doChangeSpeed(pk, 100)
		end
		setPlayerStorageValue(pk, 4, 1)
		local function roll(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getCreatureCondition(params.pid, CONDITION_OUTFIT) == true then
						doAreaCombatHealth(pk, element, getThingPos(pk), rollout, -min, -min, 255)
					end
				end
			end
		end
		for r = 1, 8 do
			addEvent(roll, 1000*r, {pid = pk})
		end

		local function stoproll(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					doChangeSpeed(params.pid, -101)
					if getPlayerStorageValue(params.pid, 5) >= 1 then
						setPlayerStorageValue(params.pid, 4, 1)
					end
				end
			end
		end
		addEvent(stoproll, 8300, {pid = pk})
    elseif spell == "Redemoinho" then
		if getCreatureName(pk) == "Hitmontop" then
			doSetCreatureOutfit(pk, {lookType = 668}, 8300)
			doChangeSpeed(pk, 100)
		end
		setPlayerStorageValue(pk, 4, 1)
		local function roll(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getCreatureCondition(params.pid, CONDITION_OUTFIT) == true then
						doAreaCombatHealth(pk, element, getThingPos(pk), rollout, -min, -min, 255)
					end
				end
			end
		end
		for r = 1, 8 do
			addEvent(roll, 1000*r, {pid = pk})
		end

		local function stoproll(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					doChangeSpeed(params.pid, -101)
					if getPlayerStorageValue(params.pid, 5) >= 1 then
						setPlayerStorageValue(params.pid, 4, 1)
					end
				end
			end
		end
		addEvent(stoproll, 8300, {pid = pk})

    elseif spell == "Iceball" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 28)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), waba, -min, -max, 43)
			else
			end
		end
		addEvent(damage, 100, {pid = pk})
		addEvent(throw, 0, {pid = pk})
	elseif spell == "Bubblebeam" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1n, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2n, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3n, -min, -max, 25)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1s, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2s, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3s, -min, -max, 25)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1e, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2e, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3e, -min, -max, 25)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1w, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2w, -min, -max, 25)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3w, -min, -max, 25)
		end
	elseif spell == "Ground Chop" then
		posit = getThingPos(pk)
		local function gust(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, params.ar, sand1, -min, -max, 111)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
            addEvent(gust, 2000, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}})
            addEvent(gust, 2000, {pid = pk, ar = {x=posicao.x, y=posicao.y+5, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}})
            addEvent(gust, 2000, {pid = pk, ar = {x=posicao.x+5, y=posicao.y, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}})
            addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x-5, y=posicao.y, z=posicao.z}})
		end
	elseif spell == "Stickmerang" then
		posit = getThingPos(pk)
		local function bonemerang(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, params.ar, sand1, -min, -max, 212)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(bonemerang, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}})
			addEvent(bonemerang, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}})
			addEvent(bonemerang, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}})
			addEvent(bonemerang, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(bonemerang, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}})
			addEvent(bonemerang, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}})
			addEvent(bonemerang, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}})
			addEvent(bonemerang, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(bonemerang, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}})
			addEvent(bonemerang, 500, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}})
			addEvent(bonemerang, 1000, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}})
			addEvent(bonemerang, 1500, {pid = pk, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(bonemerang, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}})
			addEvent(bonemerang, 500, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}})
			addEvent(bonemerang, 1000, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}})
			addEvent(bonemerang, 1500, {pid = pk, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}})
		end
	elseif spell == "Hyper Fang" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -min, 159)
	elseif spell == "Super Fang" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -min, 146)
    elseif spell == "Fireball" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 3)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(pk)), waba, -min, -max, 15)
			else
			end
		end
		addEvent(damage, 100, {pid = pk})
		addEvent(throw, 0, {pid = pk})
    elseif spell == "Cross Chop" then
		doSendMagicEffect(getThingPos(getMasterTarget(pk)), 112)
		local function damage(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 113)
				end
			end
		end
		addEvent(damage, 200, {pid = pk})
	elseif spell == "Selfheal" then
		doSendMagicEffect(getThingPos(pk), 132)
		doCreatureAddHealth(pk, max)
		doSendAnimatedText(getThingPos(pk), "+"..max.."", 132)
    elseif spell == "Rollout" then
		if getCreatureName(pk) == "Voltorb" then
			doSetCreatureOutfit(pk, voltorb, 8300)
			doChangeSpeed(pk, 85)
		elseif getCreatureName(pk) == "Electrode" then
			doSetCreatureOutfit(pk, electrode, 8300)
			doChangeSpeed(pk, 101)
		elseif getCreatureName(pk) == "Golem" then
			doSetCreatureOutfit(pk, golem, 8300)
			doChangeSpeed(pk, 160)
		elseif getCreatureName(pk) == "Sandshrew" then
			doSetCreatureOutfit(pk, sandshrew, 8300)
			doChangeSpeed(pk, 160)
		elseif getCreatureName(pk) == "Sandslash" then
			doSetCreatureOutfit(pk, sandslash, 8300)
			doChangeSpeed(pk, 143)
		elseif getCreatureName(pk) == "Donphan" then
			doSetCreatureOutfit(pk, donphan, 8300)
			doChangeSpeed(pk, 143)
		elseif getCreatureName(pk) == "Miltank" then
			doSetCreatureOutfit(pk, miltank, 8300)
			doChangeSpeed(pk, 143)
		end
		setPlayerStorageValue(pk, 4, 1)
		local function roll(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getCreatureCondition(params.pid, CONDITION_OUTFIT) == true then
						doAreaCombatHealth(params.pid, element, getThingPos(params.pid), rollout, -min, -min, 255)
					end
				end
			end
		end
		for r = 1, 8 do
			addEvent(roll, 1000*r, {pid = pk})
		end
		local function stoproll(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					doChangeSpeed(params.pid, -101)
					if getPlayerStorageValue(params.pid, 5) >= 1 then
						setPlayerStorageValue(params.pid, 4, 1)
					end
				end
			end
		end
		addEvent(stoproll, 8300, {pid = pk})
	elseif spell == "Mud Slap" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 6)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 116)
			else
			end
		end
		addEvent(damage, 100, {pid = pk})
	 elseif spell == "Psycho Shift" then
		local pos = getThingPos(getMasterTarget(pk))
		local pos2 = getThingPos(getMasterTarget(pk))
		pos.x = pos.x + math.random(-4,4)
		pos.y = pos.y + math.random(-4,4)
		if hasSqm(pos) and isSightClear(getThingPos(pk), pos, false) then
			if getTileThingByPos(pos) and getTileThingByPos(pos).itemid >= 1 and not isInArray({919, 460, 4820, 4821, 4822, 4823, 4824, 4825}, getTileThingByPos(pos).itemid) and isWalkable(pos) then
				pos = getClosestFreeTile(getMasterTarget(pk), pos)
				doSendDistanceShoot(pos2, pos, 39)
				doTeleportThing(getMasterTarget(pk), pos, false)
				doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 134)
				doSendMagicEffect(pos2, 12)
			else
				local newpos = getClosestFreeTile(getMasterTarget(pk), pos)
				doSendDistanceShoot(pos2, newpos, 39)
				doTeleportThing(getMasterTarget(pk), newpos, false)
				doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 134)
				doSendMagicEffect(pos2, 12)
			end
		else
			doSendDistanceShoot(pos2, getThingPos(getMasterTarget(pk)), 39)
			doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 134)
			doSendMagicEffect(pos2, 12)
		end	
	elseif spell == "Crabhammer" then
        doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 1)
	elseif spell == "Poison Bomb" then
		addEvent(doAreaCombatHealth, 100, pk, element, getThingPos(getMasterTarget(pk)), bomb, -min, -max, 114)
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 14)
	elseif spell == "Stun Spore" then
		local d = getCreaturesInRange(getThingPos(pk), 4, 4, 1, 0)
		doAreaCombatHealth(pk, element, getThingPos(pk), confusion, -min, -max, 85)	
		for _,pid in pairs(d) do
		if isCreature(pk) and isCreature(pid) and pid ~= pk then
				if isPlayer(pid) and #getCreatureSummons(pid) >= 1 or canAttackOther(pk, pid) == "Cant" then return false end					
				doConfusion(pid)
			end
		end
	elseif spell == "Sleep Powder" then
		local d = getCreaturesInRange(getThingPos(pk), 4, 4, 1, 0)
		doAreaCombatHealth(pk, element, getThingPos(pk), confusion, -min, -max, 27)	
		for _,pid in pairs(d) do
			if isCreature(pk) and isCreature(pid) and pid ~= pk then
				if isPlayer(pid) and #getCreatureSummons(pid) >= 1 or canAttackOther(pk, pid) == "Cant" then return false end						
				doSleep(pid)
			end
		end
	elseif spell == "Super Vines" then
		if getCreatureLookDir(pk) == 0 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+1
			flamepos.y = flamepos.y+1
			doSendMagicEffect(flamepos, 213)
			doAreaCombatHealth(pk, element, getThingPos(pk), rollout, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 1 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+1
			flamepos.y = flamepos.y+1
			doSendMagicEffect(flamepos, 213)
			doAreaCombatHealth(pk, element, getThingPos(pk), rollout, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 2 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+1
			flamepos.y = flamepos.y+1
			doSendMagicEffect(flamepos, 213)
			doAreaCombatHealth(pk, element, getThingPos(pk), rollout, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 3 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+1
			flamepos.y = flamepos.y+1
			doSendMagicEffect(flamepos, 213)
			doAreaCombatHealth(pk, element, getThingPos(pk), rollout, -min, -max, 255)		
        end
	elseif spell == "Toxic Needle" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 15)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 8)
	elseif spell == "Shadow Storm" then
		local function fall(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					local pos = getThingPos(params.pid)
					pos.x = pos.x + math.random(-4,4)
					pos.y = pos.y + math.random(-4,4)
					local frompos = getThingPos(params.pid)
					frompos.x = pos.x - 7
					frompos.y = pos.y - 6
					doSendDistanceShoot(frompos, pos, 18)
					doAreaCombatHealth(params.pid, element, pos, 0, -min, -max, 140)
				end
			end
		end
        for rocks = 1, 72 do
			addEvent(fall, rocks*35, {pid = pk})
        end
	elseif spell == "Invisible" then
		doDisapear(pk)
		doSendMagicEffect(getThingPosWithDebug(pk), 134)
		if isMonster(pk) then
			local pos = getThingPosWithDebug(pk)                           --alterei!
			doTeleportThing(pk, {x=4, y=3, z=10}, false)
			doTeleportThing(pk, pos, false)
		end
		addEvent(doAppear, 4000, pk)
		
	 elseif spell == "Ice Punch" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 28)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 43)
			else
			end
		end
		addEvent(damage, 0, {pid = pk})
		addEvent(throw, 0, {pid = pk})
	elseif spell == "Psyusion" then 
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = pu1, ef = 136})
		addEvent(storm, 500, {pid = pk, el = element, ar = pu2, ef = 133})
		addEvent(storm, 1000, {pid = pk, el = element, ar = pu3, ef = 136})
		addEvent(storm, 1500, {pid = pk, el = element, ar = pu4, ef = 137})
	elseif spell == "Horn Drill" then
		local function throw(params)
			if not isCreature(params.pid) then return true end
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 25)
			else
			end
		end
		local function damage(params)
			if not isCreature(params.pid) then return true end
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 9)
			else
			end
		end
		addEvent(damage, 0, {pid = pk})
		addEvent(throw, 0, {pid = pk})
	elseif spell == "Dragon Breath" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tsn, -min, -max, 143)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tse, -min, -max, 143)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tss, -min, -max, 143)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tsw, -min, -max, 143)
		end
	elseif spell == "Calm Mind" then
		doSendMagicEffect(getThingPos(pk), 37)
		setPlayerStorageValue(pk, 254, 1)
		local function quiet(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getPlayerStorageValue(params.pid, 254) >= 1 then
						doSendMagicEffect(getThingPos(params.pid), 220)
					end
				end
			end
		end
		local function desc(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getPlayerStorageValue(params.pid, 254) >= 1 then
						setPlayerStorageValue(params.pid, 254, 0)
					end
				end
			end
		end
		for calm = 1, 12 do
			addEvent(quiet, calm*500, {pid = pk})
		end
		addEvent(desc, 12*500, {pid = pk})
	elseif spell == "Hyper Voice" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tsn, -min, -max, 19)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tse, -min, -max, 19)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tss, -min, -max, 19)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tsw, -min, -max, 19)
		end
    elseif spell == "Bone Slash" then
		posit = getThingPos(pk)
		local function slash(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(slash, 0, {pid = pk, el = element, ar = bs1, ef = 117})
		addEvent(slash, 500, {pid = pk, el = element, ar = bs2, ef = 117})
		addEvent(slash, 1000, {pid = pk, el = element, ar = bs3, ef = 117})
		addEvent(slash, 1500, {pid = pk, el = element, ar = bs4, ef = 117})
        addEvent(slash, 2000, {pid = pk, el = element, ar = bs5, ef = 117})
		addEvent(slash, 2500, {pid = pk, el = element, ar = bs6, ef = 117})
		addEvent(slash, 3000, {pid = pk, el = element, ar = bs7, ef = 117})
		addEvent(slash, 3500, {pid = pk, el = element, ar = bs8, ef = 117})
	elseif spell == "Multi-Slap" then
        local function slap(params)
            if isMonster(getMasterTarget(params.pid)) then
                doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 110)
            else
            end
        end
        addEvent(slap, 0, {pid = pk})
        addEvent(slap, 400, {pid = pk})
        addEvent(slap, 800, {pid = pk})
	elseif spell == "Pay Day" then
        local function slap(params)
            if isMonster(getMasterTarget(params.pid)) then
                doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 110)
            else
            end
         end
        addEvent(slap, 0, {pid = pk})
        addEvent(slap, 300, {pid = pk})
	elseif spell == "Earthshock" then
	    doAreaCombatHealth(pk, GROUNDDAMAGE, getThingPos(pk), rollout, -min, -max, 255)
	    local sps = getThingPos(pk)
	    sps.x = sps.x+1
	    sps.y = sps.y+1
	    doSendMagicEffect(sps, 127)
    elseif spell == "Thunder Fang" then
		doSendMagicEffect(getThingPos(getMasterTarget(pk)), 146)
		local function damage(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 48)
				end
			end
		end
		addEvent(damage, 200, {pid = pk})
	elseif spell == "Rage" then
		if not getMasterTarget(pk) then print("Move Prescisa de Target")return end
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 110)
		local hitalvo = getMasterTarget(pk)
		local function hit(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(params.pid, FLYDAMAGE, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 110)
						doSendMagicEffect(getThingPos(params.pid), CONST_ME_MAGIC_RED)
					end
				end
			end
		end
		addEvent(hit, 1000, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 2000, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 3000, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 4000, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 5000, {pid = pk, hitalvo = hitalvo})
		addEvent(hit, 6000, {pid = pk, hitalvo = hitalvo})
	elseif spell == "Poisonous Wing" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingn, -min, -max, 128)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingdn, -min, -max, 114)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), winge, -min, -max, 129)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingde, -min, -max, 114)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wings, -min, -max, 131)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingds, -min, -max, 114)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, COMBAT_PDAMAGE, getThingPos(pk), wingw, -min, -max, 130)
			doAreaCombatHealth(pk, element, getThingPos(pk), wingdw, -min, -max, 114)
		end
	elseif spell == "Body Slam" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 110)
		local hitalvo = getMasterTarget(pk)
		local function hit(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(params.pid, FLYDAMAGE, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 110)
					end
				end
			end
		end
		addEvent(hit, 480, {pid = pk, hitalvo = hitalvo})
	elseif spell == "Mud Bomb" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 38)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), bomb, -min, -max, 116)
		doAreaCombatHealth(pk, null, getThingPos(getMasterTarget(pk)), bomb, 0, 0, 34)
	elseif spell == "Sonicboom" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 33)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 1)
	elseif spell == "Selfdestruct" then
		addEvent(doCreatureAddHealth, 250, pk, -getCreatureHealth(pk))
		doAreaCombatHealth(pk, element, getThingPos(pk), destruct1, -min, -max, 5)
		addEvent(doAreaCombatHealth, 150, pk, element, getThingPos(pk), destruct2, -(min*0.7), -(max*0.8), 5)
		addEvent(doAreaCombatHealth, 250, pk, element, getThingPos(pk), destruct3, -(min*0.4), -(max*0.5), 5)
		setPlayerStorageValue(pk, 33, 1)
	elseif spell == "Flame Wheel" then
        doAreaCombatHealth(pk, element, getThingPos(pk), charge, -min, -max, 6)
	elseif spell == "Icy Wind" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), iwn, -min, -max, 41)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), iwe, -min, -max, 41)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), iws, -min, -max, 41)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), iww, -min, -max, 41)
		end
	elseif spell == "Fear" then
        local t = getMasterTarget(pk)
        setPlayerStorageValue(t, 5, 1)
        local function confused(params)
            if isCreature(params.t) then
				local spdc = getCreatureSpeed(params.t)
                if getCreatureLookDir(params.t) == 0 then
					confs = math.random(1,3)
                elseif getCreatureLookDir(params.t) == 1 then
					confurandom = math.random(1,99)
					if confurandom <= 33 then
						confs = 0
					elseif confurandom >= 67 then
						confs = 2
					else
						confs = 3
					end
                elseif getCreatureLookDir(params.t) == 2 then
					confurandom = math.random(1,99)
					if confurandom <= 33 then
						confs = 3
					elseif confurandom >= 67 then
						confs = 0
					else
						confs = 1
					end
                elseif getCreatureLookDir(params.t) == 3 then
					confs = math.random(0,2)
                end
                doPushCreature(params.t, confs, 1, 0)
                doSendMagicEffect(getThingPos(params.t), 214)
            end
        end
        local function nonc(params)
            if isCreature(params.t) then
                doChangeSpeed(params.t, -getCreatureSpeed(params.t))
                doChangeSpeed(params.t, getCreatureBaseSpeed(params.t))
                setPlayerStorageValue(params.t, 5, -1)
            end
        end
        doChangeSpeed(t, -( getCreatureSpeed(t)/3))
        doSendMagicEffect(getThingPos(t), 214)
        for i = 1, math.random(6,7) do
            addEvent(confused, 1000*i, {owner = owner, t = t})
        end
        addEvent(nonc, 7100, {owner - owner, t = t})
	elseif spell == "Strafe" then
		doAreaCombatHealth(pk, element, getThingPos(pk), 0, 0, 0, 255)
		doChangeSpeed(pk,50)
        local function haste(params)
		if not isCreature(params.pid) then return true end
			if isCreature(params.pid) then
				doSendMagicEffect(getThingPos(params.pid), 14)
			end
		end
		local function volta()
		if not isCreature(pk) then return true end
			if pk >= 1 then
				doChangeSpeed(pk,-50)
			end
		end
		for r = 1, 6 do
			addEvent(haste, 1000*r, {pid = pk})
		end
		addEvent(volta, 6000)
	elseif spell == "Hydro Cannon" then
		posit = getThingPos(pk)
		local function gust(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, null, params.ar, sand1, -min, -max, params.eee)
				doAreaCombatHealth(params.pid, element, params.ar, whirl3, -min, -max, 68)
				doAreaCombatHealth(params.pid, null, params.arr, whirl3, -min, -max, 68)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(gust, 0, {pid = pk, eee = 66, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 66, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-1, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 66, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-2, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 66, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-3, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 66, ar = {x=posicao.x, y=posicao.y-5, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 66, ar = {x=posicao.x, y=posicao.y-6, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-5, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(gust, 0, {pid = pk, eee = 64, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 64, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+1, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 64, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+2, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 64, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+3, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 64, ar = {x=posicao.x, y=posicao.y+5, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+4, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 64, ar = {x=posicao.x, y=posicao.y+6, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+5, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(gust, 0, {pid = pk, eee = 67, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 67, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 67, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 67, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 67, ar = {x=posicao.x+5, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+4, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 67, ar = {x=posicao.x+6, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+5, y=posicao.y, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(gust, 0, {pid = pk, eee = 65, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 65, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 65, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 65, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 65, ar = {x=posicao.x-5, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-4, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 65, ar = {x=posicao.x-6, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-5, y=posicao.y, z=posicao.z}})
		end
    elseif spell == "Zap Cannon" then
		alvo = getCreatureName(getMasterTarget(pk))
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1n, -min, -max, 94)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2n, -min, -max, 93)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3n, -min, -max, 95)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1s, -min, -max, 91)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2s, -min, -max, 93)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3s, -min, -max, 92)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1e, -min, -max, 86)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2e, -min, -max, 88)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3e, -min, -max, 87)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1w, -min, -max, 89)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2w, -min, -max, 88)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3w, -min, -max, 90)
		end
    elseif spell == "Shockwave" then
		posit = getThingPos(pk)
		local function sandattack(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, null, params.ar, 0, -min, -max, params.ef)
				doAreaCombatHealth(params.pid, element, params.ar, params.wave, -min, -max, 255)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-1, z=posicao.z}, ef = 126, wave = swaven})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-2, z=posicao.z}, ef = 126, wave = swaven})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-3, z=posicao.z}, ef = 126, wave = swaven})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-4, z=posicao.z}, ef = 126, wave = swaven})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-5, z=posicao.z}, ef = 126, wave = swaven})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+2, z=posicao.z}, ef = 125, wave = swaves})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+3, z=posicao.z}, ef = 125, wave = swaves})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+4, z=posicao.z}, ef = 125, wave = swaves})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+5, z=posicao.z}, ef = 125, wave = swaves})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+6, z=posicao.z}, ef = 125, wave = swaves})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+2, y=posicao.y+1, z=posicao.z}, ef = 124, wave = swavee})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+3, y=posicao.y+1, z=posicao.z}, ef = 124, wave = swavee})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+4, y=posicao.y+1, z=posicao.z}, ef = 124, wave = swavee})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+5, y=posicao.y+1, z=posicao.z}, ef = 124, wave = swavee})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+6, y=posicao.y+1, z=posicao.z}, ef = 124, wave = swavee})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y+1, z=posicao.z}, ef = 123, wave = swavew})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x-2, y=posicao.y+1, z=posicao.z}, ef = 123, wave = swavew})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x-3, y=posicao.y+1, z=posicao.z}, ef = 123, wave = swavew})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x-4, y=posicao.y+1, z=posicao.z}, ef = 123, wave = swavew})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x-5, y=posicao.y+1, z=posicao.z}, ef = 123, wave = swavew})
		end
    elseif spell == "Healarea" then
        doAreaCombatHealth(pk, element, getThingPos(pk), healarea, min, max, 12)
        doCreatureAddHealth(pk, max)
        doSendAnimatedText(getThingPos(pk), "+"..max.."", 12)
    elseif spell == "Thunder" then
        doAreaCombatHealth(pk, element, getThingPos(pk), thunder1, -min, -max, 48)
	elseif spell == "Shredder Team" then
		if getCreatureName(pk) == "Scyther" then
			doSetCreatureOutfit(pk, scyther, 8300)
			doChangeSpeed(pk, 145)
		end
		setPlayerStorageValue(pk, 4, 1)
		local function team(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getCreatureCondition(params.pid, CONDITION_OUTFIT) == true then
						doSendAnimatedText(getThingPos(params.pid), "+"..max.."", 15)
					end
				end
			end
		end
		for r = 1, 8 do
		    addEvent(team, 1000*r, {pid = pk})
		end
		local function stopteam(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					doChangeSpeed(params.pid, -145)
					if getPlayerStorageValue(params.pid, 4) >= 1 then
						setPlayerStorageValue(params.pid, 4, 0)
					end
				end
			end
		end
		addEvent(stopteam, 8300, {pid = pk})
	elseif spell == "Bubble Blast" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 2)
			else
			end
		end
		local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 68)
			else
			end
		end
		addEvent(throw, 0, {pid = pk})
		addEvent(damage, 0, {pid = pk})
        addEvent(throw, 400, {pid = pk})
		addEvent(damage, 400, {pid = pk})
        addEvent(throw, 800, {pid = pk})
		addEvent(damage, 800, {pid = pk})
        addEvent(throw, 1200, {pid = pk})
		addEvent(damage, 1200, {pid = pk})
	elseif spell == "Reflect" then
		doSendMagicEffect(getThingPos(pk), 135)
		setPlayerStorageValue(pk, 34, 1)
	elseif spell == "Tri Flames" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tfn, -min, -max, 6)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tfe, -min, -max, 6)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tfs, -min, -max, 6)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), tfw, -min, -max, 6)
		end
	elseif spell == "Poison Gas" then
        local function gas(params)
	        if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(params.pid), confusion, -min, -max, 114)
	        end
	    end
        addEvent(gas, 000, {pid = pk, cb = cb})
        addEvent(gas, 500, {pid = pk, cb = cb})
        addEvent(gas, 1000, {pid = pk, cb = cb})
        addEvent(gas, 1500, {pid = pk, cb = cb})
        addEvent(gas, 2200, {pid = pk, cb = cb})
        addEvent(gas, 2700, {pid = pk, cb = cb})
        addEvent(gas, 3200, {pid = pk, cb = cb})
        addEvent(gas, 3900, {pid = pk, cb = cb})
        addEvent(gas, 4400, {pid = pk, cb = cb})
        addEvent(gas, 4900, {pid = pk, cb = cb})
    elseif spell == "Falling Rocks" then
		local function fall(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					local pos = getThingPos(params.pid)
					pos.x = pos.x + math.random(-4,4)
					pos.y = pos.y + math.random(-4,4)
					local frompos = getThingPos(params.pid)
					frompos.x = pos.x - 7
					frompos.y = pos.y - 6
					doSendDistanceShoot(frompos, pos, 11)
					doAreaCombatHealth(params.pid, element, pos, 0, -min, -max, 44)
				end
			end
		end	
        for rocks = 1, 72 do
            addEvent(fall, rocks*35, {pid = pk})
        end
	elseif spell == "Twister" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 36)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 42)
	 elseif spell == "Rock Tomb" then
		if getCreatureLookDir(pk) == 0 then
			rock1 = {x=getThingPos(pk).x+1, y=getThingPos(pk).y-1, z=getThingPos(pk).z}
			rock2 = {x=getThingPos(pk).x+0, y=getThingPos(pk).y-1, z=getThingPos(pk).z}
			rock3 = {x=getThingPos(pk).x-1, y=getThingPos(pk).y-1, z=getThingPos(pk).z}
			doAreaCombatHealth(pk, element, getThingPos(pk), tombn, -min, -max, 118)
		elseif getCreatureLookDir(pk) == 2 then
			rock1 = {x=getThingPos(pk).x+1, y=getThingPos(pk).y+1, z=getThingPos(pk).z}
			rock2 = {x=getThingPos(pk).x+0, y=getThingPos(pk).y+1, z=getThingPos(pk).z}
			rock3 = {x=getThingPos(pk).x-1, y=getThingPos(pk).y+1, z=getThingPos(pk).z}
			doAreaCombatHealth(pk, element, getThingPos(pk), tombs, -min, -max, 118)
		elseif getCreatureLookDir(pk) == 3 then
			rock1 = {x=getThingPos(pk).x-1, y=getThingPos(pk).y+1, z=getThingPos(pk).z}
			rock2 = {x=getThingPos(pk).x-1, y=getThingPos(pk).y+0, z=getThingPos(pk).z}
			rock3 = {x=getThingPos(pk).x-1, y=getThingPos(pk).y-1, z=getThingPos(pk).z}
			doAreaCombatHealth(pk, element, getThingPos(pk), tombw, -min, -max, 118)
		elseif getCreatureLookDir(pk) == 1 then
			rock1 = {x=getThingPos(pk).x+1, y=getThingPos(pk).y+1, z=getThingPos(pk).z}
			rock2 = {x=getThingPos(pk).x+1, y=getThingPos(pk).y+0, z=getThingPos(pk).z}
			rock3 = {x=getThingPos(pk).x+1, y=getThingPos(pk).y-1, z=getThingPos(pk).z}
			doAreaCombatHealth(pk, element, getThingPos(pk), tombe, -min, -max, 118)
		end
			doSendDistanceShoot(getThingPos(pk), rock1, 11)
			doSendDistanceShoot(getThingPos(pk), rock2, 11)
			doSendDistanceShoot(getThingPos(pk), rock3, 11)
	elseif spell == "Guillotine" then
		local function slap(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 148)
			else
			end
		end
		addEvent(slap, 0, {pid = pk})
		addEvent(slap, 300, {pid = pk})
		addEvent(slap, 600, {pid = pk})
	elseif spell == "Discharge" then
		setPlayerStorageValue(pk, 15, 0)
		local chac = pk
		local function discharge(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if params.pid == chac then
						if getPlayerStorageValue(params.pid, 15) >= 1 then
						return true
						end
						if math.random(1,100) >= 75 then
							doAreaCombatHealth(pk, element, getThingPos(params.pid), charge, -(min*(params.charges)), -(max*(params.charges)), 48)
							setPlayerStorageValue(params.pid, 15, 1)
						else
							if params.charges == 5 then
								doSendAnimatedText(getThingPos(params.pid), "FAIL", 215)
							else
								doSendAnimatedText(getThingPos(params.pid), "CHARGING", 210)
								doSendMagicEffect(getThingPos(params.pid), 48)
							end
						end
					end
				end
			end
		end
		doSendMagicEffect(getThingPos(pk), 48)
		doSendAnimatedText(getThingPos(pk), "CHARGING", 210)
		for charges = 1, 5 do
			addEvent(discharge, charges*1000, {pid = pk, charges = charges})
		end
	elseif spell == "Toxic" then
		if getCreatureLookDir(pk) == 0 then
			area = toxicn
		elseif getCreatureLookDir(pk) == 1 then
			area = toxice
		elseif getCreatureLookDir(pk) == 2 then
			area = toxics
		elseif getCreatureLookDir(pk) == 3 then
			area = toxicw
		end
		doAreaCombatHealth(pk, element, getThingPos(pk), area, -min, -max, 114)
	elseif spell == "Gunk Shot" then
		local alvinho = getMasterTarget(pk)
		local function rocksup(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) ~= params.alvinho then
					return true
					end
					jus = getThingPos(params.pid)
					jusa = getThingPos(getMasterTarget(params.pid))
					if jusa.x > jus.x then
						xx = 0
					elseif jusa.x < jus.x then
						xx = -1
					else
						xx = 0
					end
					local newpos = {x = getThingPos(params.pid).x+(xx), y = jusa.y - 3, z = getThingPos(params.pid).z}
					doSendDistanceShoot(getThingPos(params.pid), newpos, 6)
				end
			end
		end

		local function rocksdown(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) ~= params.alvinho then
					return true
					end
					jus = getThingPos(params.pid)
					jusa = getThingPos(getMasterTarget(params.pid))
					if jusa.x > jus.x then
						xx = 0
					elseif jusa.x < jus.x then
						xx = -1
					else
						xx = 0
					end
					local newpos = {x = getThingPos(params.pid).x+(xx), y = jusa.y - 3, z = getThingPos(params.pid).z}
					doSendDistanceShoot(newpos, getThingPos(getMasterTarget(params.pid)), 6)
					doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), bomb, -min, -max, 116)
				end
			end
		end
		addEvent(rocksup, 0, {pid = pk, alvinho = alvinho})
		addEvent(rocksdown, 300, {pid = pk, alvinho = alvinho})
	elseif spell == "Tornado" then
		posit = getThingPos(pk)
		local function tornado(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(tornado, 0, {pid = pk, ef = 42, ar = tor1, el = element})
		addEvent(tornado, 500, {pid = pk, ef = 42, ar = tor2, el = element})
		addEvent(tornado, 1000, {pid = pk, ef = 42, ar = tor3, el = element})
		addEvent(tornado, 500, {pid = pk, ef = CONST_ME_POFF, ar = tor1, el = null})
		addEvent(tornado, 1200, {pid = pk, ef = CONST_ME_POFF, ar = tor2, el = null})
		addEvent(tornado, 1900, {pid = pk, ef = CONST_ME_POFF, ar = tor2, el = null})
		addEvent(tornado, 1900, {pid = pk, ef = CONST_ME_POFF, ar = tor3, el = null})
	elseif spell == "Leaf Storm" then
		addEvent(doAreaCombatHealth, 0, pk, element, getThingPos(pk), grassarea, -min, -max, 255)
		local function shoot(params)
			lugar = getThingPos(params.pid)
			for x= -7,7 do
				for y= -6,6 do
				topos = {x=lugar.x+x, y=lugar.y+y, z=lugar.z}
				doSendDistanceShoot(getThingPos(params.pid), topos, 8)
				end
			end
		end
		addEvent(shoot, 0, {pid = pk})
	elseif spell == "Dynamic Punch" then
		doAreaCombatHealth(owner, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 112)
		local function punch(params)
			if isMonster(getMasterTarget(params.pid)) then
				if isCreature(params.pid) then
					doAreaCombatHealth(params.pid, null, getThingPos(getMasterTarget(params.pid)), params.ar, 0, 0, 17)
				else
				end
			else
			end
		end
		addEvent(punch, 50, {pid = pk, ar = dynpun1})
		addEvent(punch, 150, {pid = pk, ar = dynpun2})
		addEvent(punch, 450, {pid = pk, ar = dynpun3})
		addEvent(punch, 550, {pid = pk, ar = dynpun4})
		addEvent(punch, 750, {pid = pk, ar = dynpun5})
	elseif spell == "Tri-attack" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 15)
		local hitalvo = getMasterTarget(pk)
		local function hit(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(params.pid, NORMALDAMAGE, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 48)
					end
				end
			end
		end
		local function hitdois(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(params.pid, NORMALDAMAGE, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 43)
					end
				end
			end
		end
		addEvent(hit, 480, {pid = pk, hitalvo = hitalvo})
		addEvent(hitdois, 1050, {pid = pk, hitalvo = hitalvo})
    elseif spell == "Fist Machine" then
		if getCreatureLookDir(pk) == 0 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+0
			flamepos.y = flamepos.y-1
			doSendMagicEffect(flamepos, 217)
			doAreaCombatHealth(pk, element, getThingPos(pk), flamen, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 1 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x+2
			flamepos.y = flamepos.y+0
			doSendMagicEffect(flamepos, 215)
			doAreaCombatHealth(pk, element, getThingPos(pk), flamee, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 2 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x-0
			flamepos.y = flamepos.y+2
			doSendMagicEffect(flamepos, 218)
			doAreaCombatHealth(pk, element, getThingPos(pk), flames, -min, -max, 255)
		elseif getCreatureLookDir(pk) == 3 then
			local flamepos = getThingPos(pk)
			flamepos.x = flamepos.x-1
			flamepos.y = flamepos.y+0
			doSendMagicEffect(flamepos, 216)
			doAreaCombatHealth(pk, element, getThingPos(pk), flamew, -min, -max, 255)		
        end
	elseif spell == "Squishy Licking" then
		posit = getThingPos(pk)
		local function gust(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, params.ar, params.br, -min, -max, 145)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}, br = whirl3})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}, br = whirl3})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}, br = whirl3})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}, br = whirl3})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}, br = whirl3})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}, br = whirl3})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}, br = whirl3})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}, br = whirl3})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}, br = whirl3})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}, br = whirl3})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}, br = whirl3})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}, br = whirl3})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(gust, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}, br = whirl3})
			addEvent(gust, 500, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}, br = whirl3})
			addEvent(gust, 1000, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}, br = whirl3})
			addEvent(gust, 1500, {pid = pk, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}, br = whirl3})
		end
	elseif spell == "Fire Blast" then
		posit = getThingPos(pk)
		local function gust(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, null, params.ar, sand1, -min, -max, params.eee)
				doAreaCombatHealth(params.pid, element, params.ar, whirl3, -min, -max, 35)
				doAreaCombatHealth(params.pid, null, params.arr, whirl3, -min, -max, 35)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(gust, 0, {pid = pk, eee = 60, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 60, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-1, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 60, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-2, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 60, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-3, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 60, ar = {x=posicao.x, y=posicao.y-5, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 60, ar = {x=posicao.x, y=posicao.y-6, z=posicao.z}, arr = {x=posicao.x, y=posicao.y-5, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(gust, 0, {pid = pk, eee = 62, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 62, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+1, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 62, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+2, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 62, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+3, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 62, ar = {x=posicao.x, y=posicao.y+5, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+4, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 62, ar = {x=posicao.x, y=posicao.y+6, z=posicao.z}, arr = {x=posicao.x, y=posicao.y+5, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(gust, 0, {pid = pk, eee = 61, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 61, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 61, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 61, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 61, ar = {x=posicao.x+5, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+4, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 61, ar = {x=posicao.x+6, y=posicao.y, z=posicao.z}, arr = {x=posicao.x+5, y=posicao.y, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(gust, 0, {pid = pk, eee = 63, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}, arr = posicao})
			addEvent(gust, 300, {pid = pk, eee = 63, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-1, y=posicao.y, z=posicao.z}})
			addEvent(gust, 600, {pid = pk, eee = 63, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-2, y=posicao.y, z=posicao.z}})
			addEvent(gust, 900, {pid = pk, eee = 63, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-3, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1200, {pid = pk, eee = 63, ar = {x=posicao.x-5, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-4, y=posicao.y, z=posicao.z}})
			addEvent(gust, 1500, {pid = pk, eee = 63, ar = {x=posicao.x-6, y=posicao.y, z=posicao.z}, arr = {x=posicao.x-5, y=posicao.y, z=posicao.z}})
		end
    elseif spell == "Try Atake" then
        doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 15)
        local hitalvo = getMasterTarget(pk)
        local function hit(params)
            if isCreature(params.pid) then
                if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(params.pid, NORMALDAMAGE, getThingPos(getCreatureTarget(params.owner)), 0, -min, -max, 42)
					end
                end
            end
        end
        local function hitdois(params)
            if isCreature(params.pid) then
                if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.hitalvo then
						doAreaCombatHealth(params.pid, ICEDAMAGE, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 52)
					end
                end
            end
        end
        addEvent(hit, 480, {pid = pk, hitalvo = hitalvo})
        addEvent(hitdois, 1050, {pid = pk, hitalvo = hitalvo})
	elseif spell == "Healeara" then
		doCreatureAddHealth(pk, max)
		doAreaCombatHealth(pk, element, getThingPos(pk), grassarea, min, max, CONST_ME_MAGIC_BLUE)
        doSendAnimatedText(getThingPos(pk), "+"..max.."", 35)
	elseif spell == "Magma Storm" then
		local function fall(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					local pos = getThingPos(params.pid)
					pos.x = pos.x + math.random(-4,4)
					pos.y = pos.y + math.random(-4,4)
					local frompos = getThingPos(params.pid)
					frompos.x = pos.x - 7
					frompos.y = pos.y - 6
					doSendDistanceShoot(frompos, pos, 6)
					doAreaCombatHealth(params.pid, element, pos, 0, -min, -max, 15)
				end
			end
		end
        for rocks = 1, 72 do
            addEvent(fall, rocks*35, {pid = pk})
        end
	elseif spell == "Dream Eater" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 214)
	elseif spell == "Bullet Seed" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatCondition(pk, getThingPos(pk), tsn, thunderwavecondition, 1)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbn, -min, -max, 54)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatCondition(pk, getThingPos(pk), tse, thunderwavecondition, 1)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbe, -min, -max, 54)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatCondition(pk, getThingPos(pk), tss, thunderwavecondition, 1)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbs, -min, -max, 54)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatCondition(pk, getThingPos(pk), tsw, thunderwavecondition, 1)
			doAreaCombatHealth(pk, element, getThingPos(pk), bbw, -min, -max, 54)
		end
	elseif spell == "Petal Dance" then
		addEvent(doAreaCombatHealth, 0, pk, element, getThingPos(pk), grassarea, -min, -max, 255)
		local function shoot(params)
			lugar = getThingPos(params.pid)
			for x= -7,7 do
				for y= -6,6 do
				topos = {x=lugar.x+x, y=lugar.y+y, z=lugar.z}
				doSendDistanceShoot(getThingPos(params.pid), topos, 21)
				end
			end
		end
		addEvent(shoot, 0, {pid = pk})
	elseif spell == "Dragon Pulse" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 24)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 136)
	elseif spell == "Electric Storm" then
		local function fall(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					local pos = getThingPos(params.pid)
					pos.x = pos.x + math.random(-4,4)
					pos.y = pos.y + math.random(-4,4)
					local frompos = getThingPos(params.pid)
					frompos.x = pos.x - 7
					frompos.y = pos.y - 6
					doSendDistanceShoot(frompos, pos, 41)
					doAreaCombatHealth(params.pid, element, pos, 0, -min, -max, 48)
				end
			end
		end
        for rocks = 1, 72 do
            addEvent(fall, rocks*35, {pid = pk})
        end
	elseif spell == "Blizzard" then
		local function fall(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					local pos = getThingPos(params.pid)
					pos.x = pos.x + math.random(-4,4)
					pos.y = pos.y + math.random(-4,4)
					local frompos = getThingPos(params.pid)
					frompos.x = pos.x - 7
					frompos.y = pos.y - 6
					doSendDistanceShoot(frompos, pos, 35)
					doAreaCombatHealth(params.pid, element, pos, 0, -min, -max, 52)
				end
			end
		end
        for rocks = 1, 72 do
            addEvent(fall, rocks*35, {pid = pk})
        end
	elseif spell == "Dragon Claw" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 141)
	elseif spell == "Charge Beam" then
		for pa = -1, 1 do
			for pb = -1, 1 do
				local sumpos = getThingPos(pk)
				sumpos.x = sumpos.x+pa
				sumpos.y = sumpos.y+pb
				if sumpos ~= getThingPos(pk) then
					doSendDistanceShoot(sumpos, getThingPos(pk), 40)
				end
			end
		end
		local function dmgbeam(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getCreatureLookDir(params.pid) == 0 then
						doAreaCombatHealth(params.pid, element, getThingPos(params.pid), beamn, -min, -max, 48)
					elseif getCreatureLookDir(params.pid) == 1 then
						doAreaCombatHealth(params.pid, element, getThingPos(params.pid), beame, -min, -max, 48)
					elseif getCreatureLookDir(params.pid) == 2 then
						doAreaCombatHealth(params.pid, element, getThingPos(params.pid), beams, -min, -max, 48)
					elseif getCreatureLookDir(params.pid) == 3 then
						doAreaCombatHealth(params.pid, element, getThingPos(params.pid), beamw, -min, -max, 48)
					end
				end
			end
		end
		addEvent(dmgbeam, 500, {pid = pk})
	elseif spell == "Slime Wave" then
		local function slime(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, params.ar, wave, -min, -max, 116)
				doAreaCombatHealth(params.pid, null, params.ar, wave, -min, -max, 114)
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(slime, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y-1, z=posicao.z}})
			addEvent(slime, 150, {pid = pk, ar = {x=posicao.x, y=posicao.y-2, z=posicao.z}})
			addEvent(slime, 300, {pid = pk, ar = {x=posicao.x, y=posicao.y-3, z=posicao.z}})
			addEvent(slime, 450, {pid = pk, ar = {x=posicao.x, y=posicao.y-4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(slime, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y, z=posicao.z}})
			addEvent(slime, 150, {pid = pk, ar = {x=posicao.x+2, y=posicao.y, z=posicao.z}})
			addEvent(slime, 300, {pid = pk, ar = {x=posicao.x+3, y=posicao.y, z=posicao.z}})
			addEvent(slime, 450, {pid = pk, ar = {x=posicao.x+4, y=posicao.y, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(slime, 0, {pid = pk, ar = {x=posicao.x, y=posicao.y+1, z=posicao.z}})
			addEvent(slime, 150, {pid = pk, ar = {x=posicao.x, y=posicao.y+2, z=posicao.z}})
			addEvent(slime, 300, {pid = pk, ar = {x=posicao.x, y=posicao.y+3, z=posicao.z}})
			addEvent(slime, 450, {pid = pk, ar = {x=posicao.x, y=posicao.y+4, z=posicao.z}})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(slime, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y, z=posicao.z}})
			addEvent(slime, 150, {pid = pk, ar = {x=posicao.x-2, y=posicao.y, z=posicao.z}})
			addEvent(slime, 300, {pid = pk, ar = {x=posicao.x-3, y=posicao.y, z=posicao.z}})
			addEvent(slime, 450, {pid = pk, ar = {x=posicao.x-4, y=posicao.y, z=posicao.z}})
		end
	elseif spell == "Aurora Beam" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1n, -min, -max, 109)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2n, -min, -max, 108)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3n, -min, -max, 109)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1s, -min, -max, 108)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2s, -min, -max, 109)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3s, -min, -max, 108)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1e, -min, -max, 106)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2e, -min, -max, 107)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3e, -min, -max, 106)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1w, -min, -max, 107)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2w, -min, -max, 106)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3w, -min, -max, 107)
		end
	elseif spell == "Solar Beam" then
		if getCreatureLookDir(pk) == 0 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1n, -min, -max, 94)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2n, -min, -max, 93)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3n, -min, -max, 95)
		elseif getCreatureLookDir(pk) == 2 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1s, -min, -max, 91)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2s, -min, -max, 93)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3s, -min, -max, 92)
		elseif getCreatureLookDir(pk) == 1 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1e, -min, -max, 86)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2e, -min, -max, 88)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3e, -min, -max, 87)
		elseif getCreatureLookDir(pk) == 3 then
			doAreaCombatHealth(pk, element, getThingPos(pk), wg1w, -min, -max, 89)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg2w, -min, -max, 88)
			doAreaCombatHealth(pk, element, getThingPos(pk), wg3w, -min, -max, 90)
		end
	elseif spell == "Windstorm" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = ws1, ef = 42})
		addEvent(storm, 500, {pid = pk, el = element, ar = ws2, ef = 42})
		addEvent(storm, 1000, {pid = pk, el = element, ar = ws3, ef = 42})
		addEvent(storm, 1500, {pid = pk, el = element, ar = ws4, ef = 42})
		addEvent(storm, 700, {pid = pk, el = null, ar = ws4, ef = CONST_ME_POFF})
		addEvent(storm, 1200, {pid = pk, el = null, ar = ws1, ef = CONST_ME_POFF})
		addEvent(storm, 1800, {pid = pk, el = null, ar = ws3, ef = CONST_ME_POFF})
    elseif spell == "Epicenter" then
		local function ep1(params)
	        if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(pk), epi1, -min, -max, 127)
	        end
	    end
	    local function ep2(params)
	        if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(pk), epi2, -min, -max, 127)
	        end
	    end
	    local function ep3(params)
	        if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(pk), epi3, -min, -max, 127)
	        end
	    end
        addEvent(ep1, 000, {pid = pk, cb = cb})
        addEvent(ep2, 500, {pid = pk, cb = cb})
        addEvent(ep3, 1000, {pid = pk, cb = cb})
	elseif spell == "Mortal Gas" then
		local function gas(params)
	        if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(pk), confusion, -min, -max, 114)
	        end
	    end
	    local function gas2(params)
	        if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(pk), hl, -min, -max, 114)
	        end
	    end
        addEvent(gas, 000, {pid = pk, cb = cb})
        addEvent(gas2, 500, {pid = pk, cb = cb})
        addEvent(gas, 1000, {pid = pk, cb = cb})
        addEvent(gas2, 1500, {pid = pk, cb = cb})
        addEvent(gas, 2200, {pid = pk, cb = cb})
        addEvent(gas2, 2700, {pid = pk, cb = cb})
        addEvent(gas, 3200, {pid = pk, cb = cb})
        addEvent(gas2, 3900, {pid = pk, cb = cb})
        addEvent(gas, 4400, {pid = pk, cb = cb})
        addEvent(gas2, 4900, {pid = pk, cb = cb})
	elseif spell == "Multi Punch" then
		if not getMasterTarget(pk) then print("Move Prescisa de Target") return end
		local function slap(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 112)
			else
			end
		end
		addEvent(slap, 0, {pid = pk})
		addEvent(slap, 350, {pid = pk})
		addEvent(slap, 700, {pid = pk})
		addEvent(slap, 950, {pid = pk})
	elseif spell == "Crusher Stomp" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = cstomp, ef = 118})
		addEvent(storm, 500, {pid = pk, el = element, ar = cstomp, ef = 118})
		addEvent(storm, 1000, {pid = pk, el = element, ar = cstomp, ef = 118})
		addEvent(storm, 1500, {pid = pk, el = element, ar = cstomp, ef = 118})
        addEvent(storm, 2000, {pid = pk, el = element, ar = cstomp, ef = 118})
        addEvent(storm, 2500, {pid = pk, el = element, ar = cstomp, ef = 118})
        addEvent(storm, 3000, {pid = pk, el = element, ar = cstomp, ef = 118})
	elseif spell == "Earthquake" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 200, {pid = pk, el = element, ar = gl1, ef = 3})
		addEvent(storm, 0, {pid = pk, el = element, ar = gl1, ef = 127})
		addEvent(storm, 800, {pid = pk, el = element, ar = gl1, ef = 3})
		addEvent(storm, 600, {pid = pk, el = element, ar = gl2, ef = 127})
	elseif spell == "Focus" then
		doSendMagicEffect(getThingPos(pk), CONST_ME_MAGIC_RED)
		setPlayerStorageValue(pk, 254, 1)
		local function quiet(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getPlayerStorageValue(params.pid, 254) >= 1 then
						doSendMagicEffect(getThingPos(params.pid), 132)
					end
				end
			end
		end
		local function desc(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getPlayerStorageValue(params.pid, 254) >= 1 then
						setPlayerStorageValue(params.pid, 254, 0)
					end
				end
			end
		end
		for calm = 1, 12 do
			addEvent(quiet, calm*500, {pid = pk})
		end
		addEvent(desc, 12*500, {pid = pk})
	elseif spell == "Ancient Power" then
		posit = getThingPos(pk)
		local function sandattack(params)
			if #getCreatureSummons(params.pid) >= 1 then
				doAreaCombatHealth(params.pid, null, params.ar, 0, -min, -max, params.ef)
				doAreaCombatHealth(params.pid, element, params.ar, params.wave, -min, -max, 255)
			else
			end
		end
		local posicao = getThingPos(pk)
		if getCreatureLookDir(pk) == 0 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-2, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-3, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-4, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+1, y=posicao.y-5, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x-1, y=posicao.y-2, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x-1, y=posicao.y-3, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x-1, y=posicao.y-4, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x-1, y=posicao.y-5, z=posicao.z}, ef = 137, wave = ap1})
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+0, y=posicao.y-1, z=posicao.z}, ef = 18, wave = ap2})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+0, y=posicao.y-2, z=posicao.z}, ef = 18, wave = ap2})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+0, y=posicao.y-3, z=posicao.z}, ef = 18, wave = ap2})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+0, y=posicao.y-4, z=posicao.z}, ef = 18, wave = ap2})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+0, y=posicao.y-5, z=posicao.z}, ef = 18, wave = ap2})
		elseif getCreatureLookDir(pk) == 2 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+2, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+3, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+4, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+1, y=posicao.y+5, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x-1, y=posicao.y+2, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x-1, y=posicao.y+3, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x-1, y=posicao.y+4, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x-1, y=posicao.y+5, z=posicao.z}, ef = 137, wave = ap3})
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+0, y=posicao.y+1, z=posicao.z}, ef = 18, wave = ap4})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+0, y=posicao.y+2, z=posicao.z}, ef = 18, wave = ap4})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+0, y=posicao.y+3, z=posicao.z}, ef = 18, wave = ap4})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+0, y=posicao.y+4, z=posicao.z}, ef = 18, wave = ap4})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+0, y=posicao.y+5, z=posicao.z}, ef = 18, wave = ap4})
		elseif getCreatureLookDir(pk) == 1 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+2, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+3, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+4, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+5, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+6, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+2, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+3, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+4, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+5, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 1600, {pid =pk, ar = {x=posicao.x+6, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap5})
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x+2, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap6})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x+3, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap6})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x+4, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap6})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x+5, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap6})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x+6, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap6})
		elseif getCreatureLookDir(pk) == 3 then
			addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x-2, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x-3, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x-4, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x-5, y=posicao.y+1, z=posicao.z}, ef = 137, wave = ap7})
	        addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x-2, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x-3, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x-4, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap7})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x-5, y=posicao.y-1, z=posicao.z}, ef = 137, wave = ap7})
	        addEvent(sandattack, 0, {pid = pk, ar = {x=posicao.x-1, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap8})
			addEvent(sandattack, 400, {pid = pk, ar = {x=posicao.x-2, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap8})
			addEvent(sandattack, 800, {pid = pk, ar = {x=posicao.x-3, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap8})
			addEvent(sandattack, 1200, {pid = pk, ar = {x=posicao.x-4, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap8})
			addEvent(sandattack, 1600, {pid = pk, ar = {x=posicao.x-5, y=posicao.y-0, z=posicao.z}, ef = 18, wave = ap8})
        end
	elseif spell == "Toxic Spikes" then
		local function slap(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 15)
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 8)
			else
			end
		end
		addEvent(slap, 0, {pid = pk})
		addEvent(slap, 500, {pid = pk})
		addEvent(slap, 1000, {pid = pk})
	elseif spell == "Destroyer Hand" then
	    doAreaCombatHealth(pk, GROUNDDAMAGE, getThingPos(pk), eshock, -min, -max, 255)
	    local sps = getThingPos(pk)
	    sps.x = sps.x+1
	    sps.y = sps.y+1
	    doSendMagicEffect(sps, 127)
	elseif spell == "Leaf Blade" then
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 54)
	elseif spell == "Gastro Aowner" then
		target = getMasterTarget(pk)
		pos1 = getThingPos(target)
		posa = getThingPos(target)
		pos2 = getThingPos(target)
		pos3 = getThingPos(target)
		posb = getThingPos(target)
		pos1.x = pos1.x-2
		pos2.x = pos2.x+2
		pos1.y = pos1.y-4
		pos2.y = pos2.y-4
		pos3.y = pos3.y-4
		posa.x = posa.x-1
		posb.x = posb.x+1
		doSendDistanceShoot(pos1, posa, 14)
		doSendDistanceShoot(pos3, getThingPos(target), 14)
		doSendDistanceShoot(pos2, posb, 14)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), aowner, -min, -max, 143)
	elseif spell == "Water Oath" then
		addEvent(doAreaCombatHealth, 0, pk, element, getThingPos(pk), oatharea, -min, -max, 255)
		local function shoot(params)
			lugar = getThingPos(params.pid)
			for x= -3,3 do
				for y= -3,3 do
					topos = {x=lugar.x+x, y=lugar.y+y, z=lugar.z}
					doSendDistanceShoot(getThingPos(params.pid), topos, 2)
				end
			end
		end
		addEvent(shoot, 0, {pid = pk})

	elseif spell == "Mega Horn" then
		local function throw(params)
			if isMonster(getMasterTarget(params.pid)) then
				doSendDistanceShoot(getThingPos(params.pid), getThingPos(getMasterTarget(params.pid)), 25)
			else
			end
		end
        local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 15)
			else
			end
		end
		addEvent(damage, 0, {pid = pk})
		addEvent(throw, 0, {pid = pk})
	elseif spell == "Skull Bash" then
        doAreaCombatHealth(pk, element, getThingPos(pk), skullb, -min, -max, 208)
	elseif spell == "Hydropump" then
		posit = getThingPos(pk)
		local function tornado(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(tornado, 0, {pid = pk, ef = 53, ar = pump1, el = element})
		addEvent(tornado, 500, {pid = pk, ef = 53, ar = pump2, el = element})
	elseif spell == "Rest" then
		if getCreatureName(pk) == "Snorlax" then
			doSetCreatureOutfit(pk, snorlax, 5000)
			doChangeSpeed(pk, -getCreatureSpeed(pk))
		end
		setPlayerStorageValue(pk, 4, 1)
		setPlayerStorageValue(pk, 169157, 1)
		local function rest(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getCreatureCondition(params.pid, CONDITION_OUTFIT) == true then
						doCreatureAddHealth(params.pid, max)
						doSendAnimatedText(getThingPos(params.pid), "+"..max.."", 32)
						doChangeSpeed(params.pid, -getCreatureSpeed(params.pid))
					end
				end
			end
		end
		for r = 1, 4 do
		    addEvent(rest, 1000*r, {pid = pk})
		end
		local function stoprest(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					doChangeSpeed(params.pid, getCreatureBaseSpeed(params.pid))
					if getPlayerStorageValue(params.pid, 4) >= 1 then
						setPlayerStorageValue(params.pid, 4, 0)
						setPlayerStorageValue(params.pid, 169157, 0)
					end
				end
			end
		end
		addEvent(stoprest, 4300, {pid = pk})
	elseif spell == "Future Sight" then
		doSendMagicEffect(getThingPos(pk), 132)
		local seusummon = pk
		local function normal(params)
			if isCreature(params.pid) then
				if isCreature(params.pid) then
					if getPlayerStorageValue(params.pid, 35) >= 1 and params.pid == seusummon then
						setPlayerStorageValue(params.pid, 35, 0)
						doSendMagicEffect(getThingPos(params.pid), 3)
					end
				end
			end
		end
		setPlayerStorageValue(pk, 35, 1)
		addEvent(normal, 8000, {pid = pk})
	elseif spell == "Wardog" then
        local function damage(params)
			if isMonster(getMasterTarget(params.pid)) then
				doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 146)
			else
			end
		end
		addEvent(damage, 0, {pid = pk})
		addEvent(damage, 400, {pid = pk})
		addEvent(damage, 800, {pid = pk})
		addEvent(damage, 1200, {pid = pk})
		addEvent(damage, 1500, {pid = pk})
	elseif spell == "Psychicmew" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = ps1, ef = 133})
		addEvent(storm, 500, {pid = pk, el = element, ar = ps2, ef = 133})
		addEvent(storm, 700, {pid = pk, el = null, ar = ps2, ef = CONST_ME_POFF})
		addEvent(storm, 1000, {pid = pk, el = element, ar = ps1, ef = 133})
		addEvent(storm, 1200, {pid = pk, el = element, ar = ps1, ef = CONST_ME_POFF})
	elseif spell == "Psychicmewtwo" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = ps1, ef = 136})
		addEvent(storm, 500, {pid = pk, el = element, ar = ps2, ef = 136})
		addEvent(storm, 700, {pid = pk, el = null, ar = ps1, ef = CONST_ME_POFF})
		addEvent(storm, 1000, {pid = pk, el = element, ar = ps1, ef = 136})
		addEvent(storm, 1200, {pid = pk, el = element, ar = ps2, ef = 136})
		addEvent(storm, 1500, {pid = pk, el = null, ar = ps2, ef = CONST_ME_POFF})
		addEvent(storm, 0, {pid = pk, el = null, ar = self, ef = 208})
		addEvent(storm, 300, {pid = pk, el = null, ar = self, ef = 208})
		addEvent(storm, 600, {pid = pk, el = null, ar = self, ef = 208})
		addEvent(storm, 900, {pid = pk, el = null, ar = self, ef = 208})
		addEvent(storm, 1200, {pid = pk, el = null, ar = self, ef = 208})
		addEvent(storm, 1500, {pid = pk, el = null, ar = self, ef = 208})
	elseif spell == "Shadowstorm" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = ws1, ef = 140})
		addEvent(storm, 500, {pid = pk, el = element, ar = ws2, ef = 140})
		addEvent(storm, 1000, {pid = pk, el = element, ar = ws3, ef = 140})
		addEvent(storm, 1500, {pid = pk, el = element, ar = ws4, ef = 140})
		addEvent(storm, 150, {pid = pk, el = null, ar = ws5, ef = 208})
		addEvent(storm, 450, {pid = pk, el = null, ar = ws5, ef = 208})
		addEvent(storm, 750, {pid = pk, el = null, ar = ws5, ef = 208})
		addEvent(storm, 900, {pid = pk, el = null, ar = ws5, ef = 208})
		addEvent(storm, 1250, {pid = pk, el = null, ar = ws5, ef = 208})
		addEvent(storm, 1550, {pid = pk, el = null, ar = ws5, ef = 208})
	elseif spell == "Psychicmew" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = ps1, ef = 133})
		addEvent(storm, 500, {pid = pk, el = element, ar = ps2, ef = 133})
		addEvent(storm, 700, {pid = pk, el = null, ar = ps1, ef = CONST_ME_POFF})
		addEvent(storm, 1000, {pid = pk, el = element, ar = ps1, ef = 133})
		addEvent(storm, 1200, {pid = pk, el = element, ar = ps2, ef = 133})
		addEvent(storm, 1500, {pid = pk, el = null, ar = ps2, ef = CONST_ME_POFF})
	elseif spell == "Psychicmewtwo" then
		posit = getThingPos(pk)
		local function storm(params)
			if isCreature(params.pid) >= 1 then
				doAreaCombatHealth(params.pid, params.el, posit, params.ar, -min, -max, params.ef)
			else
			end
		end
		addEvent(storm, 0, {pid = pk, el = element, ar = ps1, ef = 136})
		addEvent(storm, 500, {pid = pk, el = element, ar = ps2, ef = 136})
		addEvent(storm, 700, {pid = pk, el = null, ar = ps1, ef = CONST_ME_POFF})
		addEvent(storm, 1000, {pid = pk, el = element, ar = ps1, ef = 136})
		addEvent(storm, 1200, {pid = pk, el = element, ar = ps2, ef = 136})
		addEvent(storm, 1500, {pid = pk, el = null, ar = ps2, ef = CONST_ME_POFF})
	elseif spell == "Raging Blast" then
		doAreaCombatHealth(pk, element, getThingPos(pk), rageblast1, -min, -max, 6)
		local function damage(params)
			if isCreature(params.pid) then
				doAreaCombatHealth(params.pid, element, getThingPos(params.pid), params.x, -min, -max, 6)
			end
		end
		addEvent(damage, 200, {pid = pk, x = rageblast2})
		addEvent(damage, 400, {pid = pk, x = rageblast3})
		addEvent(damage, 600, {pid = pk, x = rageblast4})
	elseif spell == "Aowner" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 14)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 20)
    elseif spell == "Thunder Bolt" then
		local posalvo = getThingPos(getMasterTarget(pk))
		local boltalvo = getMasterTarget(pk)
		posalvo.x = posalvo.x-2
		posalvo.y = posalvo.y-6
		doSendDistanceShoot(posalvo, getThingPos(getMasterTarget(pk)), 41)
		local function bolt(params)
			if isCreature(params.pid) then
				if isCreature(getMasterTarget(params.pid)) then
					if getMasterTarget(params.pid) == params.boltalvo then
						doAreaCombatHealth(params.pid, element, getThingPos(getMasterTarget(params.pid)), 0, -min, -max, 48)
					end
				end
			end
		end
		addEvent(bolt, 200, {pid = pk, boltalvo = boltalvo})
	elseif spell == "Ice Shards" then
		doAreaCombatHealth(pk, element, getThingPos(pk), is, -min, -max, 52)	
	elseif spell == "Acid" then
		doSendDistanceShoot(getThingPos(pk), getThingPos(getMasterTarget(pk)), 14)
		doAreaCombatHealth(pk, element, getThingPos(getMasterTarget(pk)), 0, -min, -max, 20)
	elseif spell == "Mega Drain" then

		local uid = checkAreaUid(getThingPos(pk), checkMega, 1, 1)
		for _,pid in pairs(uid) do
			if isCreature(pk) and isCreature(pid) and pid ~= pk then
				if isPlayer(pid) and #getCreatureSummons(pid) >= 1 then return false end
		
				local life = getCreatureHealth(pid)

				doAreaCombatHealth(pk, GRASSDAMAGE, getThingPos(pid), 0, -min, -max, 14)

				local newlife = life - getCreatureHealth(pid)

				doSendMagicEffect(getThingPos(pk), 14)
				if newlife >= 1 then
					doCreatureAddHealth(pk, newlife)
					doSendAnimatedText(getThingPos(pk), "+"..newlife.."", 32)
				end  
			end
		end
	elseif spell == "Electric Charge" then
	
		if getPlayerStorageValue(pk, 253) >= 1 then
		return true
		end
   
		setPlayerStorageValue(pk, 253, 1)
		doSendMagicEffect(getThingPos(pk), 207)
		doSendAnimatedText(getThingPos(pk), "FOCUS", 144)

	elseif spell == "Electric" then
		function rodar(param)
			if not isCreature(pk) then return true end
			doAreaCombatHealth(pk, param.dem, getThingPos(pk), param.area, -min, -max, 207)
		end
		
		addEvent(rodar, 200, {dem = ELECTRICDAMAGE, area = eleps1})
		addEvent(rodar, 400, {dem = ELECTRICDAMAGE, area = eleps2})
		addEvent(rodar, 600, {dem = ELECTRICDAMAGE, area = eleps3})
		addEvent(rodar, 800, {dem = ELECTRICDAMAGE, area = eleps4})
		if getCreatureName(pk) == "Electabuzz" then
			outch = {lookType = 739}
		elseif getCreatureName(pk) == "Shiny Electabuzz" then
			outch = {lookType = 741}
		end
		doSetCreatureOutfit(pk, outch, 800)
		SPELL_OUT = false
		
	elseif spell == "Lava Counter" then
		function counterLav(param)
			if not isCreature(pk) then return true end
			doAreaCombatHealth(pk, param.dem, getThingPos(pk), param.area, -min, -max, 6)
		end
		
		addEvent(counterLav, 200, {dem = FIREDAMAGE, area = lavaps1})
		addEvent(counterLav, 400, {dem = FIREDAMAGE, area = lavaps2})
		addEvent(counterLav, 600, {dem = FIREDAMAGE, area = lavaps3})
		addEvent(counterLav, 800, {dem = FIREDAMAGE, area = lavaps4})
		outch = {lookType = 742}
		doSetCreatureOutfit(pk, outch, 800)
		SPELL_OUT = false
		
	elseif spell == "Helix" then
		function rotHelix(param)
			if not isCreature(pk) then return true end
			doAreaCombatHealth(pk, param.dem, getThingPos(pk), param.area, -min, -max, param.effect)
		end
		outch = {lookType = 740}
		doSetCreatureOutfit(pk, outch, 800)
		addEvent(rotHelix, 200, {dem = BUGDAMAGE, area = helixs1, effect = 128})
		addEvent(rotHelix, 400, {dem = BUGDAMAGE, area = helixs2, effect = 129})
		addEvent(rotHelix, 600, {dem = BUGDAMAGE, area = helixs3, effect = 131})
		addEvent(rotHelix, 800, {dem = BUGDAMAGE, area = helixs4, effect = 130})
		SPELL_OUT = false
		
	elseif spell == "Melody" then
		
		local uid = checkAreaUid(getThingPos(pk), checkMelody, 1, 1)
		for _,pid in pairs(uid) do
			if isCreature(pk) and isCreature(pid) and pid ~= pk then
				if isPlayer(pid) and #getCreatureSummons(pid) >= 1 then return false end
				doAreaCombatHealth(pk, NORMALDAMAGE, getThingPos(pk), checkMelodyCombat, -min, -max, 22)					
				doSleep(pid)
			end
		end
		SPELL_OUT = false
	else
	    SPELL_OUT = false
	    print("a spell "..spell.." nao existe!")
	end
	
	if SPELL_OUT then
		doCreatureSay(pk, ""..string.upper(spell).."!", TALKTYPE_MONSTER)
	end
return true
end