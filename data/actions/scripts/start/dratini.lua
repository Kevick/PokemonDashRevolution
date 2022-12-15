function onUse(cid, item, fromPosition, itemEx, toPosition)
function getPokemonMaxLife(name)
		local file = io.open('data/monster/monsters.xml','r')
		local arquivo = file:read(-1):lower():match('<monster name="'..name:lower()..'" file="(.-)"/>')
		file:close()
		local data = io.open('data/monster/'..(arquivo or ''),'r')
		if not data then
			return 100
		end
		local maximo = data:read(-1):match('max%s*=%s*"(%d+)"')
		data:close()
		return maximo
end
----- Config -----
local MaximoSummon = 1
local lvl = 1
local nome = getItemName(item.uid)
local poke_name = nome:match('(.-) Pokeball')
local storage = 9393
local exhaust = 3
local time = 3
local summons = getCreatureSummons(cid)
local action_id = getItemAttribute(item.uid, "aid")
----- Config -----

	if getPlayerStorageValue(cid, 24000) == 5 then
	return doPlayerSendCancel(cid, "You are riding.")
	end
	if getPlayerStorageValue(cid, 23000) == 5 then
	return doPlayerSendCancel(cid, "You are flying.")
	end
local summons = getCreatureSummons(cid)
if item.uid ~= getPlayerSlotItem(cid, CONST_SLOT_FEET).uid then
doPlayerSendCancel(cid, "Sorry, you must put your pokeball in the pokeball place.")
return TRUE
end
if (getPlayerStorageValue(cid, storage) <= os.time()) then
if(table.maxn(summons) < MaximoSummon) then -- no summons
creature = doSummonCreature(poke_name, getCreaturePosition(cid))
doConvinceCreature(cid, creature)
registerCreatureEvent(creature, "DiePoke")
registerCreatureEvent(cid, "PlayerPokeDeath")
registerCreatureEvent(cid, "LogoutPoke")
doPlayerSay(cid, poke_name .. " eu escolho você!!", TALKTYPE_ORANGE_1)
doSendMagicEffect(getCreaturePosition(creature), 188)
doTransformItem(getPlayerSlotItem(cid,8).uid, 2531, 1)
doItemSetAttribute(getPlayerSlotItem(cid,8).uid,"name", poke_name .." Pokeball")
		if action_id ~= 0 then
doCreatureAddHealth(creature, -(tonumber(getPokemonMaxLife(poke_name) - action_id)))
		else
		doCreatureAddHealth(creature, getPokemonMaxLife(poke_name))
		end

setPlayerStorageValue(cid, storage, os.time()+exhaust)
else
for _, pid in ipairs(summons) do
if (table.maxn(summons) >= 1) then
setPlayerStorageValue(cid, storage, os.time()+exhaust)
doItemSetAttribute(item.uid, "aid", getCreatureHealth(summons[1]))
doSendMagicEffect(getCreaturePosition(creature), 188)
doPlayerSay(cid,"Back, "..poke_name.."", TALKTYPE_ORANGE_1)
doRemoveCreature(pid)
doTransformItem(getPlayerSlotItem(cid,8).uid, 2532, 1)
doItemSetAttribute(getPlayerSlotItem(cid,8).uid,"name", poke_name .." Pokeball")
end
end
end
end
return true
end