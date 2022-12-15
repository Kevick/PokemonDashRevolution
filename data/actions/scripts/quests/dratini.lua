function onUse(cid, item, frompos, item2, topos)
if item.uid == 2030 then
queststatus = getPlayerStorageValue(cid,2030)
if getPlayerLevel(cid) >= 62 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"You received one Dratini Pokeball.")
item_uid = doPlayerAddItem(cid,2511,1)
setPlayerStorageValue(cid,2030,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendCancel(cid,"You need level 62 or higher, is to make quest.")
end
else
return 0
end
return 1
end