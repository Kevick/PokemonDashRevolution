local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

local var_city = {
["saffron"] = 5,
["cerulean"] = 4,
["fuchsia"] = 9,
["viridian"] = 2,
["lavender"] = 7,
["pewter"] = 3,
["vermilion"] = 8,
["cinnabar"] = 10,
["celadon"] = 6
}

local ret_pokes = {"Bulbasaur", "Charmander", "Squirtle"}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
	return false
	end
	
	local talkUser, msg  = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid, msg:lower()
	if isInArray({'yes', 'sim', 'si'}, msg) then
		if getPlayerStorageValue(cid, 157171) == 2 then
			selfSay("Desculpe, mas só pode fazer uma escolha.", cid)
		elseif getPlayerStorageValue(cid, 157171) == 1 then
			selfSay('Agora escolha seu Pokemon Inicial? {Bulbasaur}, {Charmander} ou {Squirtle} ?', cid)
			talkState[talkUser] = 2
		else
			selfSay("Muito Bom! Agora me Fale qual sua cidade natal? {saffron}, {cerulean}, {fuchsia}, {viridian}, {lavender}, {pewter}, {vermilion}, {cinnabar} ou {celadon}?", cid)
			talkState[talkUser] = 1
		end
	elseif talkState[talkUser] == 1 then
		if var_city[msg] then
			doPlayerSetTown(cid, var_city[msg])
			setPlayerStorageValue(cid, 157171, 1)
			selfSay('Agora escolha seu Pokemon Inicial? {Bulbasaur}, {Charmander} ou {Squirtle} ?', cid)
			talkState[talkUser] = 2
		else
			selfSay("está cidade não está disponivel.", cid)
		end
	elseif talkState[talkUser] == 2 then
		if isInArray(ret_pokes, msg) then
			doPokemonToPlayer(cid, doCorrectPokemonName(msg))
			--doPlayerAddLevel(cid, 20)
			setPlayerStorageValue(cid, 157171, 2)
			selfSay('Agora voce tem um pokemon e pode seguir  sua Jornada, Ate Ate logo!', cid) 
			talkState[talkUser] = 0
			doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)), false)
		else
			selfSay('você só pode escolher {Bulbasaur}, {Charmander} ou {Squirtle}!', cid) 
		end
	elseif msg == "no" and talkState[talkUser] >= 1 then
		selfSay("tudo bem então.", cid)
		talkState[talkUser] = 0
		npcHandler:releaseFocus(cid)
	end  
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())