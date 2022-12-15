function onTarget(cid, target)

	if isPlayer(target) then
		if canAttackOther(cid, target) == "Cant" then            --edited PVP system
		return false 
		elseif isPlayer(target) and #getCreatureSummons(target) >= 1 and canAttackOther(cid, target) == "Can" then
		return false
		end
	end

	if getPlayerStorageValue(target, 201) ~= -1 then
	end
	if isSummon(target) then                             --edited PVP system
		if getCreatureMaster(target) == cid then
		return false
		end
		
		if canAttackOther(cid, target) == "Cant" then
		return false
		end
	end 

	if getPlayerStorageValue(target, 17) == 4 then
		setPlayerStorageValue(target, 17, 5)
		if getPlayerStorageValue(target, 200) == -1 then
			setPlayerStorageValue(target, 200, "!, ")
		end

		setPlayerStorageValue(target, 200, getPlayerStorageValue(target, 200)..""..getCreatureName(cid)..", ")

		if #getCreatureSummons(cid) >= 1 then
			doMonsterSetTarget(target, getCreatureSummons(cid)[1])
		else
			doMonsterSetTarget(target, cid)  
		end
	end

return TRUE
end