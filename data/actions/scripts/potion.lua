function doHealOverTime(cid, heal, turn, effect)                     --alterado v1.6 peguem o script todo!!
if not isCreature(cid) then return true end

if turn <= 0 or (getCreatureHealth(cid) == getCreatureMaxHealth(cid)) or getPlayerStorageValue(cid, 173) <= 0 then
   setPlayerStorageValue(cid, 173, -1)
   return 
elseif getCreatureHealth(cid) + heal/10 >= getCreatureMaxHealth(cid) then
   doSendAnimatedText(getThingPos(cid), "+"..getCreatureMaxHealth(cid) - getCreatureHealth(cid), 65)
   doCreatureAddHealth(cid, getCreatureMaxHealth(cid) - getCreatureHealth(cid))
   doSendMagicEffect(getThingPos(cid), 12)
   return 
end

doSendAnimatedText(getThingPos(cid), "+"..heal/10, 65)
doCreatureAddHealth(cid, heal/10)
doSendMagicEffect(getThingPos(cid), 12)
addEvent(doHealOverTime, 1000, cid, heal, turn - 1, effect)
addEvent(doUpdateStatusPoke, 1100, getCreatureMaster(cid))
end

local potions = {
[2273] = {health = 400, animate = "SMALL POT", collor = 140},
[2272] = {health = 1500, animate = "GREAT POT", collor = 140},
[2271] = {health = 4000, animate = "MEGA POT", collor = 140},
[2275] = {health = 10000, animate = "HYPER POT", collor = 140},
[2274] = {health = 30000, animate = "SUPER POT", collor = 140},
}

function onUse(cid, item, frompos, item2, topos)

local pid = getThingFromPosWithProtect(topos)
local pokeballInfo = getPokeballInfo(getPlayerSlotItem(cid, 8).uid)

if not isCreature(pid) or not isSummon(pid) then
return doPlayerSendCancel(cid, "You can only use potions on your own Pokemons!")
end

if getCreatureMaster(pid) ~= cid then
return doPlayerSendCancel(cid, "You can only use potions on your own Pokemons!")
end

if getCreatureHealth(pid) == getCreatureMaxHealth(pid) then
return doPlayerSendCancel(cid, "This pokemon is already at full health.")
end

if getPlayerStorageValue(pid, 173) >= 1 then
return doPlayerSendCancel(cid, "This pokemon is already under effects of potions.")
end

if getPlayerStorageValue(cid, 52481) >= 1 then
return doPlayerSendCancel(cid, "You can't do that while a duel.")
end

doCreatureSay(cid, "".. pokeballInfo.nick..", take this potion!", TALKTYPE_SAY)
doSendAnimatedText(getThingPos(pid), potions[item.itemid].animate, potions[item.itemid].collor)
setPlayerStorageValue(pid, 173, 1)
doRemoveItem(item.uid, 1)

doHealOverTime(pid, potions[item.itemid].health, 10, 12)

return true
end
