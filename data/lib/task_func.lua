tasktabble = {
["Magikarp"] = {monster_race={"magikarp"}, storage_start = 200201, storage = 91001,count = 150,exp = 18000,money = 0},
}

configbosses_task = {
{race = "Magikarp",Playerpos = {x = 189, y = 57, z = 7}, FromPosToPos = {{x = 186, y = 54, z = 7},{x = 193, y = 60, z = 7}},time = 5},
}

function CheckTask(cid)
	for k, v in pairs(tasktabble) do
		if getPlayerStorageValue(cid,v.storage_start) >= 1 then 
		return true 
		end
	end
return false
end

function finisheAllTask(cid)
local config = {
exp = {true,100000},
money = {true,200000},
items ={false,{{2124,2},{2173,1}}},
premium ={true,5}
}
	local x = true
	for k, v in pairs(tasktabble) do
		if tonumber(getPlayerStorageValue(cid,v.storage)) then
			x = false
		end
	end
	if x == true then
		setPlayerStorageValue(cid, 521456, 0)
		local b = getGlobalStorageValue(63005) if b == -1 then b = 1 end
		if b < 11 then
			setGlobalStorageValue(63005,b+1)
			doBroadcastMessage('[Task Mission Complete] '..getCreatureName(cid)..' was the '..b..' to finish the task!.')
			doPlayerAddPremiumDays(cid, config.premium[1] == true and config.premium[2] or 0)
			doPlayerAddExp(cid, config.exp[1] == true and config.exp[2] or 0)
			doPlayerAddMoney(cid, config.money[1] == true and config.money[2] or 0)
			if config.items[1] == true then doAddItemsFromList(cid,config.items[2]) end
			doItemSetAttribute(doPlayerAddItem(cid, 7369), "name", "trophy "..getCreatureName(cid).." completed all the task.")
		end
	end
end

function HavePlayerPosition(cid, from, to)
	return isInRange(getPlayerPosition(cid), from, to) and true or false
end

function getRankStorage(cid, value, max, RankName) -- by vodka
	local str =""
	str = "--[".. (RankName == nil and "RANK STORAGE" or ""..RankName.."") .."]--\n\n"
	local query = db.getResult("SELECT `player_id`, `value` FROM `player_storage` WHERE `key` = "..value.." ORDER BY cast(value as INTEGER) DESC;")
	if (query:getID() ~= -1) then k = 1 repeat if k > max then break end
	str = str .. "\n " .. k .. ". "..getPlayerNameByGUID(query:getDataString("player_id")).." - [" .. query:getDataInt("value") .. "]"
	k = k + 1 until not query:next() end return doShowTextDialog(cid, 2529, str)
end
