local keywordHandler = KeywordHandler:new()																																																	  
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local troca = {
2687,10
		  -- aqui vc edita os ID do item que tem que ter  e quantos
}
local id = 2152   --- id do item que vai ganhar dps da troca
local quant = 50 -- item que ganhar Contém quantos?
local sto = 1591 --  Storage
function onCreatureAppear(cid)													npcHandler:onCreatureAppear(cid)										end
function onCreatureDisappear(cid)																npcHandler:onCreatureDisappear(cid)   end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)				end
function onThink()																																												npcHandler:onThink()   end
function creatureSayCallback(cid, type, msg)
if msgcontains(msg, 'yes') then
status = getPlayerStorageValue(cid,sto)
if status == -1 then
if doPlayerRemoveItem(cid,troca[1],troca[2]) and doPlayerRemoveItem(cid,troca[3],troca[4])then
doPlayerAddItem(cid,id,quant)
doPlayerAddExp(cid, 4500)
setPlayerStorageValue(cid,sto,1)
selfSay('Obrigado, aqui esta a sua recompensa')   -- edita aqui
else
selfSay('Você tera que me trazer 10 remain of magikarp, quando chegar darei uma recompensa.')  -- edita aqui
end
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Concluido")
end
return TRUE
end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())