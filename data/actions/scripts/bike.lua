function onUse(cid, item, frompos, itemEx, topos)

local bike = {lookType = 738, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0} --- Esse vai ser Homen
local bike1 = {lookType = 737, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0} --- Esse vai ser mulher
local speed = 1250 --- Velocidade que a bike terá.

if item.uid ~= getPlayerSlotItem(cid, CONST_SLOT_RING).uid then   
doPlayerSendCancel(cid, "Você deve colocar sua bike no local correto.") 
return TRUE
end

if getPlayerStorageValue(cid, 32001) == 1 then
   doRemoveCondition(cid, CONDITION_OUTFIT)
   doChangeSpeed(cid, -speed)
   doSendAnimatedText(getCreaturePosition(cid), 'Bike OFF!', 35)
   doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, 'Você desmontou da bike.')
   setPlayerStorageValue(cid, 32001, 0)

else

  if getPlayerSex(cid) == 1 then -- homem
   doChangeSpeed(cid, speed)
   doSetCreatureOutfit(cid, bike, -1)
   doSendAnimatedText(getCreaturePosition(cid), 'Bike ON!', 32)
   doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'Você montou na bike.')
   setPlayerStorageValue(cid, 32001, 1)
  elseif getPlayerSex(cid) == 0 then -- homem
   doChangeSpeed(cid, speed)
   doSetCreatureOutfit(cid, bike1, -1)
   doSendAnimatedText(getCreaturePosition(cid), 'Bike ON!', 32)
   doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'Você montou na bike.')
   setPlayerStorageValue(cid, 32001, 1)
  end
  
end
return true

end