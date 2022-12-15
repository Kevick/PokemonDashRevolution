local fishing = {
["Magikarp"] = {skill = 0, level = 1},
["Gyarados"] = {skill = 75, level = 75},
["Staryu"] = {skill = 22, level = 6},
["Starmie"] = {skill = 49, level = 20},
["Tentacool"] = {skill = 20, level = 7},
["Tentacruel"] = {skill = 60, level = 75},
["Goldeen"] = {skill = 17, level = 5},
["Seaking"] = {skill = 28, level = 11},
["Krabby"] = {skill = 14, level = 2},
["Kingler"] = {skill = 35, level = 14},
["Horsea"] = {skill = 16, level = 3},
["Seadra"] = {skill = 41, level = 15},
["Poliwag"] = {skill = 15, level = 2},
["Poliwhirl"] = {skill = 27, level = 9},
["Squirtle"] = {skill = 25, level = 25},
["Wartortle"] = {skill = 45, level = 44},
["Blastoise"] = {skill = 75, level = 75},
["Lapras"] = {skill = 85, level = 85},

}

local storage = 15458
local bonus = 1
local limite = 100


local function doFish(cid, pos, ppos, chance, interval, number)
      if not isCreature(cid) then return false end
      if getThingPos(cid).x ~= ppos.x or getThingPos(cid).y ~= ppos.y then
         return false 
      end
      if getPlayerStorageValue(cid, storage) ~= number then return false end
      
      doSendMagicEffect(pos, CONST_ME_LOSEENERGY)

      local peixe = 0
      local playerpos = getClosestFreeTile(cid, getThingPos(cid))
      local fishes = {}
      local randomfish = ""
      
      if getPlayerSkillLevel(cid, 6) < limite then 
	     doPlayerAddSkillTry(cid, 6, bonus)
      end

      for a, b in pairs (fishing) do
	      if getPlayerSkillLevel(cid, 6) >= b.skill then
		     table.insert(fishes, a)
          end
      end

	  if math.random(1, 100) <= chance then
         if getPlayerSkillLevel(cid, 6) < limite then 
		    doPlayerAddSkillTry(cid, 6, bonus)
         end
		 randomfish = fishes[math.random(#fishes)]
	     peixe = doSummonCreature(randomfish, playerpos)
		 if not isCreature(peixe) then
            addEvent(doFish, interval, cid, pos, ppos, chance, interval, number)
		    return true
		 end

	     doCreatureSetLookDir(cid, getDirectionTo(getThingPos(cid), getThingPos(peixe)))  --alterado ver depois
		 if #getCreatureSummons(cid) >= 1 then
 		    doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 173)
			doChallengeCreature(getCreatureSummons(cid)[1], peixe)
  	     else
            doSendMagicEffect(getThingPos(cid), 173)
			doChallengeCreature(cid, peixe)
  	     end
	     return true
      end
      addEvent(doFish, interval, cid, pos, ppos, chance, interval, number)
return true
end

local waters = {4614, 4615, 4616, 4617, 4618, 4619, 4608, 4609, 4610, 4611, 4612, 4613, 7236, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 4665, 4666, 4820, 4821, 4822, 4823, 4824, 4825}

function onUse(cid, item, fromPos, itemEx, toPos)

if getPlayerGroupId(cid) == 11 then
return true
end

local checkPos = toPos
checkPos.stackpos = 0

if getTileThingByPos(checkPos).itemid <= 0 then
   doPlayerSendCancel(cid, '!')
   return true
end

if not isInArray(waters, getTileInfo(toPos).itemid) then
   return true
end

if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 63215) >= 1 then
   doPlayerSendCancel(cid, "You can't fish while surfing/flying.")
   return true
end

if isInArray(waters, getTileInfo(getThingPos(cid)).itemid) then
   doPlayerSendCancel(cid, "You can\'t fish while surfing neither flying above water.")
   return true
end

if getTileInfo(getThingPos(getCreatureSummons(cid)[1] or cid)).protection then
	doPlayerSendCancel(cid, "You can't fish pokémons if you or your pokémon is in protection zone.")
return true
end



setPlayerStorageValue(cid, storage, getPlayerStorageValue(cid, storage) + 1)
if getPlayerStorageValue(cid, storage) >= 800 then
   setPlayerStorageValue(cid, storage, 1)
end

local delay = 3500 - getPlayerSkillLevel(cid, 6) * 25
local chance = 100

doFish(cid, toPos, getThingPos(cid), chance, delay, getPlayerStorageValue(cid, storage))

return true
end