function onUse(cid, item, frompos, item2, topos)
if item.uid == 2003 then
queststatus = getPlayerStorageValue(cid,2003)
if getPlayerLevel(cid) >= 40 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"You received one Thunder Stone.")
item_uid = doPlayerAddItem(cid,5928,1)
setPlayerStorageValue(cid,2003,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendCancel(cid,"You need level 40 or higher, is to make quest.")
end
else
return 0
end
return 1
end