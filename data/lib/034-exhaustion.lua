exhaustion =
{
	check = function (cid, storage)
		if(getPlayerFlagValue(cid, PLAYERFLAG_HASNOEXHAUSTION)) then
			return false
		end

		return getPlayerStorageValue(cid, storage) >= os.time(t)
	end,

	get = function (cid, storage)
	    if isPlayer(cid) then
		if(getPlayerFlagValue(cid, PLAYERFLAG_HASNOEXHAUSTION)) then
			return false
		end
		end

		local exhaust = getPlayerStorageValue(cid, storage)
		if(exhaust > 0) then
			local left = exhaust - os.time(t)
			if(left >= 0) then
				return left
			end
		end

		return false
	end,

	set = function (cid, storage, time)
		setPlayerStorageValue(cid, storage, os.time(t) + time)
	end,

	make = function (cid, storage, time)
		local exhaust = exhaustion.get(cid, storage)
		if(not exhaust) then
			exhaustion.set(cid, storage, time)
			return true
		end

		return false
	end
}

function setCD(item, tipo, tempo)

	if not tempo or not tonumber(tempo) then
		doItemEraseAttribute(item, tipo)
	return true
	end

	doItemSetAttribute(item, tipo, "cd:"..(tempo + os.time()).."")
return tempo + os.time()
end

function getCD(item, tipo, limite)

	if not getItemAttribute(item, tipo) then
	return 0
	end

	local string = getItemAttribute(item, tipo):gsub("cd:", "")
	local number = tonumber(string) - os.time()

	if number <= 0 then
	return 0
	end

	if limite and limite < number then
		return 0
	end

return number
end
