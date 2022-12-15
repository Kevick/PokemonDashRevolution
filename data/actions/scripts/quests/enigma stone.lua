function onUse(cid, item, frompos, item2, topos)
if item.uid == 2011 then
queststatus = getPlayerStorageValue(cid,2011)
if getPlayerLevel(cid) >= 65 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"You received one Enigma Stone.")
item_uid = doPlayerAddItem(cid,5903,1)
setPlayerStorageValue(cid,2011,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendCancel(cid,"You need level 65 or higher, is to make quest.")
end
else
return 0
end
return 1
end