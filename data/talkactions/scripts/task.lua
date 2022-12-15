function onSay(cid, words, param, channel)
	local param = string.lower(param)
	if param == "rank" then
		getRankStorage(cid, 521456, 20, "Task Rank Finalizadas") return true
	end

	local str = ""
	str = str .. "Task Completed :\n\n"
	for k, v in pairsByKeys(tasktabble) do
		local contagem = getPlayerStorageValue(cid, v.storage)
		if (contagem == -1) then 
			contagem = 1 
		end
		
		str = str..k.." = ".. (not tonumber(contagem) and "["..contagem.."]" or "["..((contagem)-1).."/"..v.count.."]") .."\n"
	end
	
	str = str .. ""
	doShowTextDialog(cid, 8983, str)
return true
end
