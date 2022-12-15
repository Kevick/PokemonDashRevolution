function onSay(cid, words, param)
local ball = getPlayerSlotItem(cid, 8).uid
doItemSetAttribute(ball, "nick", param)
doPlayerSendCancel(cid, "nick adicionado")
return true
end