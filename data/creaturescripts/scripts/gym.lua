function onLogout(cid)
	returnPokeNpc(cid, npc)
	return false
end


function onDeath(cid, corpse)
	npc = getPlayerStorageValue(cid, 990)
	returnPokeNpc(cid, npc)
	setPlayerStorageValue(npc, 990, 0)
	return false
end

function onThink(cid, interval)
	npc = getPlayerStorageValue(cid, 990)

	if getPlayerStorageValue(npc, 990) ~= 1 then
		returnPokeNpc(cid, npc)
	end
	return true
end
local fightconditionnn = createConditionObject(CONDITION_INFIGHT)
setConditionParam(fightconditionnn, CONDITION_PARAM_TICKS, 18 * 1000)

function onAttack(cid, target)
	npc = getPlayerStorageValue(cid, 990)

	if getPlayerStorageValue(getCreatureMaster(target), 990) ~= 1 then
		doMonsterChangeTarget(cid)
		doChangeSpeed(cid, -getCreatureSpeed(cid))
		return true
	end

	if isPlayer(target) then
		if #getCreatureSummons(target) == 0 then
			doMonsterChangeTarget(cid)
			doChangeSpeed(cid, -getCreatureSpeed(cid))
			return true
		end
		if #getCreatureSummons(target) >= 1 then
			doMonsterSetTarget(cid, getCreatureSummons(target)[1])
		end
	end

	if getCreatureSpeed(cid) == 0 then
		doChangeSpeed(cid, -getCreatureSpeed(cid))
		doChangeSpeed(cid, 200)
	end
	doAddCondition(getCreatureMaster(target), fightconditionnn)
	return true
end


function onCast(cid, target)

	if isPlayer(target) then
		return false
	end
	local targete = getCreatureTarget(cid)
	if isPlayer(getCreatureMaster(targete)) and getPlayerStorageValue(getCreatureMaster(targete), 990) ~= 1 then
		return false
	end
	return true
end

function onDirection(cid, old, current)

	if isCreature(getCreatureTarget(cid)) and not isPlayer(getCreatureTarget(cid)) and getPlayerStorageValue(getCreatureMaster(getCreatureTarget(cid)), 990) == 1 then
	return true
	end
	return false
end
