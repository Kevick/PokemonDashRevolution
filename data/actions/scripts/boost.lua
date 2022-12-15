function onUse(cid, item, topos, item2, frompos)
local myball = getPlayerSlotItem(cid, 8)
local boost = getItemAttribute(myball.uid, "Boost") or 0
local boosts = 0
if boost == 50 then
return doPlayerSendCancel(cid, "Sorry, is not possible.")
end

if #getCreatureSummons(cid) >= 1 then
return doPlayerSendCancel(cid, "Retorne o pokemon para a ball.")
end
if getPlayerAccess(cid) == 6 then
boosts = 50
end
boosts = boosts + 1
local pokemon = getPokeballInfo(myball.uid).nick
doItemSetAttribute(myball.uid, "Boost", boost + boosts)
doRemoveItem(item.uid)
doSendMagicEffect(getThingPos(item2.uid), 133)
doPlayerSendTextMessage(cid, 27, "Congrulations, your "..pokemon..", as beem boosted +1.")
doPlayerSendTextMessage(cid, 27, "Now your "..pokemon.." have a boost +"..boosts + boost..".")
doSendAnimatedText(getThingPos(item2.uid), "BOOST!", 17)
doPlayerSetVocation(cid,4)
return true
end