function onUse(cid, item, frompos, item2, topos)
if item.uid == 2000 then
queststatus = getPlayerStorageValue(cid,2000)
if getPlayerLevel(cid) >= 35 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"Você achou 10 Hundred Dollars")
item_uid = doPlayerAddItem(cid,2160,10)
setPlayerStorageValue(cid,2000,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendCancel(cid,"You need level 35 or higher, is to make quest.")
end
else
return 0
end
return 1
end