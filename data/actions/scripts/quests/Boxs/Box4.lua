function onUse(cid, item, frompos, item2, topos)
if item.uid == 7891 then
queststatus = getPlayerStorageValue(cid,7891)
if getPlayerLevel(cid) >= 85 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"voc� recebeu a box [+4].")
item_uid = doPlayerAddItem(cid,7891,1)
setPlayerStorageValue(cid,7891,1)
else
doPlayerSendTextMessage(cid,22,"voc� j� fez essa quest.")
end
else
doPlayerSendCancel(cid,"voc� precisa ser level 85+, para abrir esse ba�.")
end
else
return 0
end
return 1
end