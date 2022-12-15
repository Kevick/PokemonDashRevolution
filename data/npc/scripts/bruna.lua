local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
if(msgcontains(msg, 'yes') and talkState[talkUser] ~= 1 and talkState[talkUser] ~= 2) then
if getPlayerStorageValue(cid, 209910) <= 0 then
selfSay('So, i think you deserve this, would you accept my {abra} as a gift?')
talkState[talkUser] = 1
else
 selfSay('Heh, nice answer, i can teleport you to your hometown, do want me to do it?')
 talkState[talkUser] = 2
 end
elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1 ) then
selfSay('Here it is! Take this pokemon and be careful with it! I can also teleport you to your city, would you like it?')
talkState[talkUser] = 2
  local description = "Contains a Abra."
 local health = 620
        local maxhealth = 620
   	    local poke1 = "This is Abra's pokeball. HP = ["..health.."/"..maxhealth.."]"
        if getPlayerFreeCap(cid) >= 1 then
   	    item = doCreateItemEx(2219)
        doItemSetAttribute(item, "poke", poke1)
        doItemSetAttribute(item, "nome", "Abra")
        doItemSetAttribute(item, "description", description)
        doPlayerAddItemEx(cid, item, true)
        doTransformItem(item, 2222)
        doPlayerSendTextMessage(cid, 27, "Bruna has given you an abra.")
        setPlayerStorageValue(cid, 209910, 1)
        else
        item = doCreateItemEx(2221)
        doItemSetAttribute(item, "poke", poke1)
        doItemSetAttribute(item, "nome", "Abra")
        doItemSetAttribute(item, "description", description)
        setPlayerStorageValue(cid, 209910, 1)
        doPlayerSendMailByName(getCreatureName(cid), item)
        doPlayerSendTextMessage(cid, 27, "Bruna has given you an abra.")
        doPlayerSendTextMessage(cid, 27, "Since you are already holding six pokemons, this abra has been sent to your depot.")
	    end
	    elseif(msgcontains(msg, 'yes') or msgcontains(msg, 'teleport') and talkState[talkUser] == 2 ) then
selfSay('There you go! Alakazam, teleport him to his hometown!')
talkState[talkUser] =  0
if #getCreatureSummons(cid) >= 1 then
setPlayerStorageValue(cid, 2013, 1)
setPlayerStorageValue(cid, 61209, getCreatureMaxHealth(getCreatureSummons(cid)[1]))
setPlayerStorageValue(cid, 61210, getCreatureHealth(getCreatureSummons(cid)[1]))
doRemoveCreature(getCreatureSummons(cid)[1])
end
doSendMagicEffect(getThingPos(cid), 29)
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
doSendMagicEffect(getThingPos(cid), 29)
if getPlayerStorageValue(cid, 2013) >= 1 then
item = getPlayerSlotItem(cid, 8)
pk = doSummonCreature(getItemAttribute(item.uid, "poke"):match("This is (.-)'s pokeball."), getThingPos(cid))
doConvinceCreature(cid, pk)
setPlayerStorageValue(cid, 2013, 0)
registerCreatureEvent(cid, "PlayerPokeDeath")
setCreatureMaxHealth(pk, (getPlayerStorageValue(cid, 61209)))
doCreatureAddHealth(pk, (getPlayerStorageValue(cid, 61209)))
doCreatureAddHealth(pk, (getPlayerStorageValue(cid, 61210))-(getPlayerStorageValue(cid, 61209)))
end
elseif(msgcontains(msg, 'no')) then
selfSay('Alright then.')
end
return true
end
---------------------------------------------------------

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new()) 