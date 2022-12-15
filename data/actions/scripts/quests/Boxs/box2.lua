function onUse(cid, item, frompos, item2, topos)
if item.uid == 2019 then
queststatus = getPlayerStorageValue(cid,2019)
if getPlayerLevel(cid) >= 30 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"You received an box [+2].")
item_uid = doPlayerAddItem(cid,7887,1)
setPlayerStorageValue(cid,2019,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendCancel(cid,"You need level 30 or higher, to make this quest.")
end
else
return 0
end
return 1
end