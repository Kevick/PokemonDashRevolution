function setSpeed(cid)
	if not isCreature(cid) then return true end
	local speed = 200
	
	if isMonster(cid) then
		speed = getMonsterInfo(getCreatureName(cid)).speed
	end
	doChangeSpeed(cid, -getCreatureSpeed(cid))
	if getCreatureCondition(cid, CONDITION_PARALYZE) == true then
		doRemoveCondition(cid, CONDITION_PARALYZE)
		addEvent(doAddCondition, 10, cid, paralizeArea2)             
	end
	doChangeSpeed(cid, speed)
end

function stopNow(cid, time) 
	if not isCreature(cid) then return true end

	local speed = getCreatureSpeed(cid)

	if isPlayer(cid) then
		mayNotMove(cid, true)
		addEvent(mayNotMove, time, cid, false)
	else
		setPlayerStorageValue(cid, 77415, getCreatureSpeed(cid))
		doChangeSpeed(cid, -speed)
		addEvent(setSpeed, time, cid)
	end
end

function isSleep(cid)
    if not isCreature(cid) then return false end
    if getPlayerStorageValue(cid, 1996) >= 1 then return true end
return false
end

function isConfusion(cid)
    if not isCreature(cid) then return false end
    if getPlayerStorageValue(cid, 1995) >= 1 then return true end
return false
end

function doSleepOutfit(pid)   
	if isPlayer(pid) then return true end
	if isSleep(pid) then return true end
	local Info = getMonsterInfo(getCreatureName(pid)).lookCorpse  
	local look = getCreatureOutfit(pid) 
	local dittoStg = getPlayerStorageValue(pid, 1010) 
	if getCreatureName(pid) == "Ditto" and isSummon(pid) and tostring(dittoStg) and dittoStg ~= "Ditto" then
		local InfoDitto = getMonsterInfo(tostring(dittoStg)).lookCorpse
		if InfoDitto ~= 0 and look.lookType ~= 0 then             
			doSetCreatureOutfit(pid, {lookType = 0, lookTypeEx = getMonsterInfo(tostring(dittoStg)).lookCorpse}, 4000)
		end 
	else 
		if Info ~= 0 and look.lookType ~= 0 then
			doSetCreatureOutfit(pid, {lookType = 0, lookTypeEx = getMonsterInfo(getCreatureName(pid)).lookCorpse}, 4000)	
		end
	end
end

function doSleep(cid)
	if (hasCondition(cid, CONDITION_PARALYZE)) then
		doRemoveCondition(cid, CONDITION_PARALYZE)
	end
	
	if (hasCondition(cid, CONDITION_HASTE)) then
		doRemoveCondition(cid, CONDITION_HASTE)
	end
	
	doAddCondition(cid , sleepp)
	
	
	local Info = getMonsterInfo(getCreatureName(cid)).lookCorpse  
	local look = getCreatureOutfit(cid) 
	local dittoStg = getPlayerStorageValue(cid, 1010) 
	if getCreatureName(cid) == "Ditto" and isSummon(cid) and tostring(dittoStg) and dittoStg ~= "Ditto" then
		local InfoDitto = getMonsterInfo(tostring(dittoStg)).lookCorpse
		if InfoDitto ~= 0 and look.lookType ~= 0 then             
			doSetCreatureOutfit(cid, {lookType = 0, lookTypeEx = getMonsterInfo(tostring(dittoStg)).lookCorpse}, 5000)
		end 
	else 
		if Info ~= 0 and look.lookType ~= 0 then
			doSetCreatureOutfit(cid, {lookType = 0, lookTypeEx = getMonsterInfo(getCreatureName(cid)).lookCorpse}, 5000)	
		end
	end
	
	p = getCreaturePosition(cid)
	doSendAnimatedText(p, "Sleep", 154)
	local function stopsleep(params)
		if isMonster(cid) then
			if not (hasCondition(cid, CONDITION_PARALYZE)) then
				if isSummon(cid) or isMonster(cid) then
					doChangeSpeed(cid, -getCreatureSpeed(cid))
					doChangeSpeed(cid, getPlayerStorageValue(cid, 77415))
				end
				setPlayerStorageValue(cid, 1996, 0)
			end
		else
		return True
		end
	end
	
	addEvent(stopsleep, 5500)
	setPlayerStorageValue(cid, 1996, 1)
	
	local function sleepxx(params)
		if isMonster(cid) then
			doSendMagicEffect(getCreaturePosition(cid), 32)
		else
		return True
		end
	end
	
	if isSummon(cid) or isMonster(cid) then
		setPlayerStorageValue(cid, 77415, getCreatureSpeed(cid))
		doChangeSpeed(cid, -getCreatureSpeed(cid))
	end
	
	addEvent(sleepxx, 1000)
	addEvent(sleepxx, 2000)
	addEvent(sleepxx, 3000)
	addEvent(sleepxx, 4000)
end

function doConfusion(cid)
	if not isCreature(cid) then return true end
	p = getCreaturePosition(cid)
	doSendMagicEffect(p, 31)
	
	local function sleepxxxx(params)
		if isMonster(cid) then
			if params.st and params.st == true then
				setPlayerStorageValue(cid, 1995, 0)
			end
			doSendMagicEffect(getCreaturePosition(cid), 31)
		else
		return True
		end
	end
	setPlayerStorageValue(cid, 1995, 1)
	addEvent(sleepxxxx, 100, {st = false})
	addEvent(sleepxxxx, 2000, {st = false})
	addEvent(sleepxxxx, 3000, {st = false})
	addEvent(sleepxxxx, 4000, {st = true})
	
	doSendAnimatedText(getCreaturePosition(cid), "X.X", 210)

	if (hasCondition(cid, CONDITION_DRUNK)) then
		doRemoveCondition(cid, CONDITION_DRUNK)
	end   
	
	doAddCondition(cid , tonto)    
end