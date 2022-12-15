--
function onUse(cid, item, frompos, item2, topos)
 
if item.uid ==1515 then
queststatus = getPlayerStorageValue(cid,1515)
if queststatus == 1 then
doPlayerSendTextMessage(cid,22,"This Chest is empty.")
 
else
doPlayerSendTextMessage(cid,22,"Congratulations!")
doSendMagicEffect(topos,12)
coins_uid = doPlayerAddItem(cid,2146,20)
coins_uid = doPlayerAddItem(cid,2271,25)
coins_uid = doPlayerAddItem(cid,2269,10)
coins_uid = doPlayerAddItem(cid,2157,5)
setPlayerStorageValue(cid,1515,1)
end
return 0
end
return 1
end
