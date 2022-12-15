function onUse(cid, item, fromPosition, itemEx, toPosition)
if item.uid == 6000 then
queststatus = getPlayerStorageValue(cid,6000)
if queststatus == -1 then
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Você escolheu 5 Leaf Stones.")
doPlayerAddItem(cid,2276,1)
doPlayerAddItem(cid,2276,1)
doPlayerAddItem(cid,2276,1)
doPlayerAddItem(cid,2276,1)
doPlayerAddItem(cid,2276,1)
setPlayerStorageValue(cid,6000,1)
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 27, "Parabéns você terminou a Cerulean Quest!")
else
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Você já escolheu seu premio.")
end
elseif item.uid == 6001 then
queststatus = getPlayerStorageValue(cid,6000)
if queststatus == -1 then
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Você escolheu 5 Fire Stones")
doPlayerAddItem(cid,2283,1)
doPlayerAddItem(cid,2283,1)
doPlayerAddItem(cid,2283,1)
doPlayerAddItem(cid,2283,1)
doPlayerAddItem(cid,2283,1)
setPlayerStorageValue(cid,6000,1)
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 27, "Parabéns você terminou a Cerulean Quest!")
else
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Você já escolheu seu premio.")
end
elseif item.uid == 6002 then
queststatus = getPlayerStorageValue(cid, 6000)
if queststatus == -1 then
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Você escolheu 5 Water Stones.")
doPlayerAddItem(cid,2277,1)
doPlayerAddItem(cid,2277,1)
doPlayerAddItem(cid,2277,1)
doPlayerAddItem(cid,2277,1)
doPlayerAddItem(cid,2277,1)
setPlayerStorageValue(cid,6000,1)
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 27, "Parabéns você terminou a Cerulean Quest!")
else
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Você já escolheu seu premio.")
end
else
return 0
end

return 1
end