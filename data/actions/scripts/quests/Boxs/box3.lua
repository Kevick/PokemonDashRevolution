function onUse(cid, item, frompos, item2, topos)
if item.uid == 7886 then
queststatus = getPlayerStorageValue(cid,7886)
if getPlayerLevel(cid) >= 60 then
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"voc� recebeu a Box [+3].")
item_uid = doPlayerAddItem(cid,7886,1)
setPlayerStorageValue(cid,7886,1)
else
doPlayerSendTextMessage(cid,22,"voc� j� fez essa quest.")
end
else
doPlayerSendCancel(cid,"voc� precisa ter level 60+ para abrir esse ba�.")
end
else
return 0
end
return 1
end