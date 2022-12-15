function onUse(cid, item, frompos, item2, topos)
if item.uid == 2005 then
queststatus = getPlayerStorageValue(cid,2005)
if getPlayerLevel(cid) >= 25 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"You received one darkness stone.")
item_uid = doPlayerAddItem(cid,5892,1)
setPlayerStorageValue(cid,2005,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendCancel(cid,"You need level 25 or higher, is to make quest.")
end
else
return 0
end
return 1
end