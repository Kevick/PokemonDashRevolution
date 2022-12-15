function onUse(cid, item, frompos, item2, topos)
local zub = {x=850,y=1077,z=5}
local odd = {x=852,y=1077,z=5}
local pid = {x=854,y=1077,z=5}
local pox = getPlayerPosition(cid)

if getPlayerStorageValue(cid, 54842) ~= 1 then
doPokemonToPlayer(cid, "Squirtle")
doPlayerAddItem(cid,2273,5)
setPlayerStorageValue(cid, 54842, 1)
else
doPlayerSendTextMessage(cid, 27, "Voce ja pegou o pokemon.")
end
return TRUE
end