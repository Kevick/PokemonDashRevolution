local keywordHandler = KeywordHandler:new()

local npcHandler = NpcHandler:new(keywordHandler)

NpcSystem.parseParameters(npcHandler)

local talkState = {}

function onCreatureAppear(cid) 

	npcHandler:onCreatureAppear(cid) 
	
end

function onCreatureDisappear(cid) 

	npcHandler:onCreatureDisappear(cid) 

end

function onCreatureSay(cid, type, msg) 

	npcHandler:onCreatureSay(cid, type, msg) 
	
end

function onThink() 

	npcHandler:onThink() 
	
end

function creatureSayCallback(cid, type, msg)

	if(not npcHandler:isFocused(cid)) then
	
	return false
end

local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid

local msg = string.lower(msg)

if isInArray({"saffari","enter","entrar"}, msg) then

	selfSay('you can stay in the Saffari zone , the price is '..SAFFARI_CONFIG.Price..' hd(s), You want enter? {yes}', cid)

	talkState[talkUser] = 1
	
elseif msgcontains(msg, 'yes') and talkState[talkUser] == 1 then

	for i = 1, #SAFFARI_CONFIG.Blocked_pokeballs do

		if getPlayerItemCount(cid, SAFFARI_CONFIG.Blocked_pokeballs[i]) >= 1 then

			selfSay('Keep your PokeBalls!', cid) 
			
			talkState[talkUser] = 0
	
			npcHandler:releaseFocus(cid)
			
			return true
		end

	end
	
if SAFFARI_CONFIG.Premium == true and not isPremium(cid) then

	nselfSay('Sorry, you need to be premium!', cid) 
	
	talkState[talkUser] = 0
	
	npcHandler:releaseFocus(cid)
	
	return true
	
elseif getPlayerLevel(cid) < SAFFARI_CONFIG.Level then

	selfSay('Sorry, you must be at least level '..SAFFARI_CONFIG.Level..' to enter the Saffari zone!', cid) 
	
	talkState[talkUser] = 0
	
	npcHandler:releaseFocus(cid)
	
	return true
	
elseif not doPlayerRemoveMoney(cid, SAFFARI_CONFIG.Price) then

	selfSay('Sorry, you do not have enough money!', cid)

	talkState[talkUser] = 0
	
	npcHandler:releaseFocus(cid)
	
	return true
end

doPlayerAddItem(cid, SAFFARI_CONFIG.AddPokeballs[1], SAFFARI_CONFIG.AddPokeballs[2])

selfSay("Thanks, you've been teleported to the Saffari, if you want to leave enter {!saffari leave}.", cid)

doTeleportThing(cid, SAFFARI_CONFIG.Saffari_Pos.Enter)

setPlayerStorageValue(cid, SAFFARI_CONFIG.Storages, 1)

talkState[talkUser] = 0
	
npcHandler:releaseFocus(cid)

elseif msg == "no" and talkState[talkUser] >= 1 then

	selfSay("tudo bem então.", cid)
	
	talkState[talkUser] = 0
	
	npcHandler:releaseFocus(cid)
	
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())