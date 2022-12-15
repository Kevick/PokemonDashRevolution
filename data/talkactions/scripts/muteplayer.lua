---- Comando para calar um jogador(dar muted) pelo tempo necess�rio ----
------------------------------------ by grandeyang -------------------------------------

local GMGroup = 3 -- grupo m�nimo do GM
local MutedTime = 1 -- em minutos

local condition = createConditionObject(CONDITION_MUTED)
setConditionParam(condition, CONDITION_PARAM_TICKS, MutedTime * 60 * 1000)

function onSay(cid,words,param)

local testeGroup = getPlayerGroupId(cid)
if testeGroup >= GMGroup then
if param ~= "" then

local playerMuted = getPlayerByName(param)
if isPlayer(playerMuted) == TRUE then

local GMName = getPlayerName(cid)
local playerName = getPlayerName(playerMuted)
if playerName == GMName then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_DEFAULT ,"Por que ao inv�s aplicar um muted em si mesmo voc� mesmo n�o cale a boca?")
return 0
end

local playerGroup = getPlayerGroupId(playerMuted)
if playerGroup >= testeGroup then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_DEFAULT ,"Voc� n�o pode calar um jogador que tenha um cargo maior ou igual ao seu.")
return 0
end

doAddCondition(playerMuted, condition)
doPlayerSendTextMessage(cid,MESSAGE_STATUS_DEFAULT ,"Voc� aplicou um muted de "..MutedTime.." minuto(s) no jogador "..playerName..".")
doPlayerSendTextMessage(playerMuted,MESSAGE_STATUS_DEFAULT,"Voc� foi mutado por "..MutedTime.." minuto(s) pelo "..GMName..".")
return 0
else
doPlayerSendTextMessage(cid,MESSAGE_STATUS_DEFAULT ,"O nome "..param.." est� escrito errado ou este est� offline.")
return 0
end

end
end
end