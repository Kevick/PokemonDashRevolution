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
 
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid  
 
-- Conversa Jogador/NPC  
if(msgcontains(msg, 'offer') or msgcontains(msg, 'Offer')) then
selfSay('I sell Diamond accounts.', cid) 
elseif(msgcontains(msg, 'diamond account') or msgcontains(msg, 'Diamond Account')) then
selfSay('Diamond account users are able to use ride, teleport, surf and fly. They can also wear all clothes, rent houses and costumize poké balls. Finally, diamond account users have access to the saffari zone and are free of taxes in the casino! If you would like to upgrade your account for a month you will have to pay me 10 diamonds. Would you like to upgrade it?', cid) 
talkState[talkUser] = 1 
elseif(msgcontains(msg, 'bless') or msgcontains(msg, 'Bless')) then
selfSay('To be blessed 3 diamonds are necessary, would you like to go on?', cid) 
talkState[talkUser] = 2 
elseif(msgcontains(msg, 'Change Sex') or msgcontains(msg, 'change sex')) then
selfSay('To change sex 5 diamonds are necessary, would you like to go on?', cid) 
talkState[talkUser] = 3 
elseif(msgcontains(msg, 'Change Hometown') or msgcontains(msg, 'change hometown')) then
selfSay('To change your hometown five diamonds are needed, what the city wants to choose?', cid) 
talkState[talkUser] = 4  
 
-- Confirmação da Compra  
elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then  
if(doPlayerRemoveItem(cid, 2145, 10) == true) then  
selfSay('Thanks!', cid) 
doPlayerAddPremiumDays(cid, 31)
talkState[talkUser] = 0 
else  
selfSay('You do not have enough diamonds.', cid) 
talkState[talkUser] = 0  
end  
elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 2) then  
if getPlayerBlessing(cid, 1) and getPlayerBlessing(cid, 2) and getPlayerBlessing(cid, 3) and getPlayerBlessing(cid, 4) and getPlayerBlessing(cid, 5) then
selfSay('You have already got one or more blessings!', cid) 
else
if(doPlayerRemoveItem(cid, 2145, 3) == true) then
selfSay('Thanks!', cid) 
doPlayerAddBlessing(cid, 1)
doPlayerAddBlessing(cid, 2)
doPlayerAddBlessing(cid, 3)
doPlayerAddBlessing(cid, 4)
doPlayerAddBlessing(cid, 5)
talkState[talkUser] = 0
else
selfSay('You do not have enough diamonds.', cid) 
talkState[talkUser] = 0  
end
end
elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 3) then  
if(doPlayerRemoveItem(cid, 2145, 5) == true) then  
selfSay('Thanks!', cid) 
if(getPlayerSex(cid) == PLAYERSEX_FEMALE) then
doPlayerSetSex(cid, PLAYERSEX_MALE)
else
doPlayerSetSex(cid, PLAYERSEX_FEMALE)
end
talkState[talkUser] = 0 
else  
selfSay('You do not have enough diamonds.', cid) 
talkState[talkUser] = 0  
end 
elseif(msgcontains(msg, 'sendas') and talkState[talkUser] == 4) then  
if(doPlayerRemoveItem(cid, 2145, 5) == true) then  
selfSay('Thanks!', cid) 
doPlayerSetTown(cid, 2)
talkState[talkUser] = 0 
else  
selfSay('You do not have enough diamonds.', cid) 
talkState[talkUser] = 0  
end  
elseif(msgcontains(msg, 'falador') and talkState[talkUser] == 4) then  
if(doPlayerRemoveItem(cid, 2145, 5) == true) then  
selfSay('Thanks!', cid) 
doPlayerSetTown(cid, 1)
talkState[talkUser] = 0 
else  
selfSay('You do not have enough diamonds.', cid) 
talkState[talkUser] = 0  
end  
end
return TRUE
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback) 
npcHandler:addModule(FocusModule:new())