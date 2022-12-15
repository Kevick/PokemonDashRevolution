local description = "Contains a %pokename."

local genderFixo = {

	["Nidoran Male"] = {gender = 4},
	
	["Nidoran Female"] = {gender = 3},
	
	["Dragonite"] = {gender = 0},
	
	["Magneton"] = {gender = 0},

}

function onUse(cid, item, frompos, item2, topos)
	if not getTopCorpse(topos) then
		return true
	end	
local name = getItemNameById(item2.itemid)
local pokeball = pokeballCatch[item.itemid]
local rate = pokeball.rate
local catch = pokeball.catch
local fail = pokeball.fail
local newid = pokeball.ball
local send = pokeball.send - 1

local corpse = getTopCorpse(topos).uid
local statusgender = getItemAttribute(corpse, "gender")


    for i,x in pairs(pokesCatch) do
        if getItemNameById(item2.itemid):find(i:lower()) then
            if getItemIdByName(name) == pokesCatch[i].corpse then
                if cid ~= getItemAttribute(item2.uid, "corpseowner") and isInArray({1,8}, getPlayerGroupId(cid)) then
                    doPlayerSendCancel(cid, "You are not allowed to catch this pokemon.")
                return true
                end
				
				if getPlayerStorageValue(cid, SAFFARI_CONFIG.Storages) >= 1 and item.itemid ~= SAFFARI_CONFIG.AddPokeballs[1] then
					return true
				end
        
                
                doRemoveItem(item2.uid, 1)
				
                local pegar = math.random(1, x.chance)
                if pegar <= 1*(rate) then
                    doSendMagicEffect(topos, catch)
					doSendDistanceShoot(getThingPos(cid), topos, send)
                    local nas = {
                    ["%%pokename"] = i
                    }
					
                    for i,x in pairs(nas) do
                        if description:find(i) then
                            description = description:gsub(i, x)
                        end
                    end

                    local function capturou(params)
                        if not isCreature(params.cid) then
                        return true
                        end
						
                        if not string.find(getPlayerStorageValue(cid, 54842), ""..i..",") then
                            doPlayerAddSoul(cid, 1)
                            setPlayerStorageValue(cid, 54842, getPlayerStorageValue(cid, 54842)..""..i..", ")
                        end
						
						local ballName = getItemNameById(item.itemid)
						
						if genderFixo[doCorrectPokemonName(params.nome)] == doCorrectPokemonName(params.nome) then
				
							statusgender = genderFixo[doCorrectPokemonName(params.nome)].gender
				
						end
						
						icon_on  = false
						if icons[doCorrectPokemonName(i)] then
							newid = icons[doCorrectPokemonName(i)].on
							icon_on  = true
						else
							newid = newid
							icon_on  = false
						end
						
						if #getPlayerPokeballs(cid) >= 6 or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
							item = doCreateItemEx(newid-1)
						else
							item = addItemInFreeBag(getPlayerSlotItem(cid, 3).uid, newid, 1)
						end
						
						setPokeballInfo(item, i)
						doItemSetAttribute(item, "gender", statusgender)
						doItemSetAttribute(item, "happy", 250)
						doItemSetAttribute(item, "php", 1)
						doItemSetAttribute(item, "ball", ballName)
						print(ballName)
						if (icon_on == true) then
							doItemSetAttribute(item, "iconsystem", "on")
						else
							doItemSetAttribute(item, "iconsystem", "off")
						end
						
                        if #getPlayerPokeballs(cid) >= 6 or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
                            doPlayerSendMailByName(getCreatureName(params.cid), item, 1)
                            doPlayerSendTextMessage(cid, 27, "Congratulations, you won a "..i.." ("..GenderTable[statusgender]..") !")
                            doPlayerSendTextMessage(cid, 27, "Since you are already holding six pokemons, this pokeball has been sent to your depot.")
                        else
                            doPlayerSendTextMessage(cid, 27, "Congratulations, you won a "..i.." ("..GenderTable[statusgender]..") !")
                        end
						
						doUpdatePokemons(cid)
						
                        if #getCreatureSummons(cid) >= 1 then
                            doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 178)
                        else
                            doSendMagicEffect(getThingPos(cid), 178)
                        end
                    end

                    local description = "Contains a "..i.."."
                    addEvent(capturou, 4000, {cid = cid, poke = i, nome = i, description = description, ball = newid, letter = 2597})
                else
				
                    function ruim(params)
                        if not isCreature(params.cid) then
                        return true
                        end
						
                        doPlayerSendTextMessage(params.cid, 27, "Sorry, you didn\'t catch that pokemon.")
						
                        if #getCreatureSummons(params.cid) >= 1 then
                            doSendMagicEffect(getThingPos(getCreatureSummons(params.cid)[1]), 166)
                        else
                            doSendMagicEffect(getThingPos(params.cid), 166)
                        end
                    end
					
                    addEvent(ruim, 4000, {cid = cid})
                    doSendMagicEffect(topos, fail)
					doSendDistanceShoot(getThingPos(cid), topos, send)
					
                end
				
				if getPlayerStorageValue(cid, SAFFARI_CONFIG.Storages) >= 1 and getPlayerItemCount(cid, SAFFARI_CONFIG.AddPokeballs[1]) == 1 then
		
					if #getCreatureSummons(cid) >= 1 then
			
						local feet = getPlayerSlotItem(cid, CONST_SLOT_FEET)
			
						doTransformItem(feet.uid, pokeballs[doCorrectPokemonName(i)].on)
			
					end
					
					addEvent(saffariBallsEnd, 4007, cid, SAFFARI_CONFIG.Storages, SAFFARI_CONFIG.Saffari_Pos.Exit)
			
				end
				doRemoveItem(item.uid, 1)
				
            end
        end
    end
return TRUE
end