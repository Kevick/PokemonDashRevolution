function onKill(cid, target, lastHit)
	if isMonster(target) and not isSummon(target) then
		local n = string.lower(getCreatureName(target))
		for race, mob in pairs(tasktabble) do
			if getPlayerStorageValue(cid,mob .storage_start) >= 1 then
				for i = 1,#mob.monster_race do
					if n == mob.monster_race[i] then
						local contagem = getPlayerStorageValue(cid, mob.storage)
						if not tonumber(contagem) then 
						return true 
						end
						
						if (contagem == -1) then 
							contagem = 1 
						end
						
						if contagem > mob.count then 
						return true 
						end
						
						setPlayerStorageValue(cid, mob.storage, contagem+1)
						doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,""..(contagem == mob.count and "Congratulations! You finished the task of "..race.."." or "defeated. Total [" .. contagem .. "/" .. mob.count .. "] " .. race .. ".").."")
					end
				end
			end
		end
	end
return true
end