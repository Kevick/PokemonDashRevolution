local shinys = {
"Venusaur", "Blastoise", "Butterfree", "Beedrill", "Rattata", "Raticate", "Raichu", "Zubat", "Paras", "Parasect", 
"Venonat", "Venomoth", "Growlithe", "Arcanine", "Tentacool",  "Grimer", "Muk",  "Kingler", "Voltorb", "Electrode", "Horsea", "Seadra", "Scyther", "Electabuzz",  "Gyarados",   "Dratini", "Oddish"}
local raros = {"Magikarp"}    

function isNpcSummon(cid)
return isNpc(getCreatureMaster(cid))
end

local function doShiny(cid)
if isCreature(cid) then
   if isSummon(cid) then return true end
   if isNpcSummon(cid) then return true end
   
if isInArray(shinys, getCreatureName(cid)) then
   chance = 3    --1% chance        
elseif isInArray(raros, getCreatureName(cid)) then 
   chance = 1   --1% chance       
else
   return true
end    
    if math.random(1, 1000) <= chance*10 then  
      doSendMagicEffect(getThingPos(cid), 18)               
      local name, pos = "Shiny ".. getCreatureName(cid), getThingPos(cid)
      doRemoveCreature(cid)
      local shi = doCreateMonster(name, pos, false)
      setPlayerStorageValue(shi, 74469, 1)      
   else
       setPlayerStorageValue(cid, 74469, 1)
   end                                        --/\
else                                                            
return true
end
end

local function doSetRandomGender(cid)
	if not isCreature(cid) then return true end
	if isSummon(cid) then return true end
	local gender = 0
	local rate = 70
		if getCreatureName(cid) == "Nidoran Male" then
			gender = 4
		elseif getCreatureName(cid) == "Nidoran Female" then
			gender = 3
		elseif getCreatureName(cid) == "Dragonite" then
		    gender = 0
		elseif getCreatureName(cid) == "Magneton" then
			gender = 0
		else
			if rate == 0 then
				gender = 3
			elseif rate == 100 then
				gender = 4
			elseif rate == -1 then
				gender = 0
			elseif math.random(1, 100) <= rate then
				gender = 4
			else
				gender = 3
			end
		end
	doCreatureSetSkullType(cid, gender)
end

function setPokemonWildStatus(cid)
	if isMonster(cid) and pokes[getCreatureName(cid)] then
		local plvl = 0
	    local b = getCreatureOutfit(cid).lookBody
		local lvl = pokes[getCreatureName(cid)].level
		local maxh = (pokes[getCreatureName(cid)].cons * lvl)
		setCreatureMaxHealth(cid, (maxh +pokes[getCreatureName(cid)].vida))
		doCreatureAddHealth(cid,  getCreatureMaxHealth(cid))
	end
return true
end

function onSpawn(cid)
    registerCreatureEvent(cid, "Exp")

	if isSummon(cid) then
		registerCreatureEvent(cid, "DiePoke")
		if not getItemAttribute(getPlayerSlotItem(getCreatureMaster(cid), CONST_SLOT_FEET).uid, "ExpLevel") then
			doItemSetAttribute(getPlayerSlotItem(getCreatureMaster(cid), CONST_SLOT_FEET).uid, "ExpLevel", 1)
		end
	return true
	end
	
	if not isPlayer(cid) and not isSummon(cid) then
        registerCreatureEvent(cid, "Aloot")
		if pokes[getCreatureName(cid)] then
			setPlayerStorageValue(cid, 993615, pokes[getCreatureName(cid)].level)
		end
		--addEvent(setPokemonWildStatus, 5, cid)
    end
	
	addEvent(doSetRandomGender, 5, cid)
	addEvent(doShiny, 10, cid)
	
return true
end
