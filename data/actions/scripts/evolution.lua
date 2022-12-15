local types = {
["Leaf"] = {itemid = 2276, "Bulbasaur", "Ivysaur", "Oddish", "Gloom", "Bellsprout", "Weepinbell", "Exeggcute"},
["Water"] = {itemid = 2277, "Squirtle", "Wartortle", "Horsea", "Goldeen", "Magikarp", "ShinyMagikarp", "Psyduck", "Poliwag", "Poliwhirl", "Tentacool", "Krabby", "Staryu", "Omanyte", "Eevee"},
["Venom"] = {itemid = 2278, "Zubat", "Ekans", "Nidoran male", "Nidoran female", "Nidorino", "Nidorina", "Gloom", "Venonat", "Tentacool", "Grimer", "Koffing"},
["Thunder"] = {itemid = 2279, "Magnemite", "Pikachu", "Voltorb", "Eevee", "Elekid"},
["Rock"] = {itemid = 2280, "Geodude", "Graveler", "Rhyhorn", "Kabuto"},
["Punch"] = {itemid = 2281, "Machop", "Machoke", "Mankey", "Poliwhirl", "Hitmonlee", "Hitmonchan"},
["Fire"] = {itemid = 2283, "Charmander", "Charmeleon", "Vulpix", "Growlithe", "Ponyta", "Eevee"},
["Coccon"] = {itemid = 2284, "Caterpie", "Metapod", "Weedle", "Kakuna", "Paras", "Venonat", "Dragon Lord"},
["Crystal"] = {itemid = 2285, "Dratini", "Dragonair", "Magikarp", "ShinyMagikarp", "Omanyte", "Kabuto"},
["Darkness"] = {itemid = 2286, "Gastly", "Haunter"},
["Earth"] = {itemid = 2287, "Cubone", "Sandshrew", "Nidorino", "Nidorina", "Diglett"},
["Enigma"] = {itemid = 2288, "Abra", "Kadabra", "Psyduck", "Slowpoke", "Drowzee"},
["Heart"] = {itemid = 2289, "Rattata", "Pidgey", "Pidgeotto", "Spearow", "Clefairy", "Jigglypuff", "Meowth", "Doduo", "ShinyRattata"},
["Ice"] = {itemid = 2290, "Seel", "Shellder"},
}
local eevee = {'2277', '2279', '2283'}

function onUse(cid, item, frompos, item2, topos)
    if not isMonster(item2.uid) then
    return true
    end

	if not isPlayer(getCreatureMaster(item2.uid)) or getCreatureMaster(item2.uid) ~= cid then
        doPlayerSendCancel(cid, "You can only use stones on pokemons you own.")
    return true
    end

	for i,x in pairs(types) do
        if getPlayerSlotItem(cid, 7).itemid ~= fotos[getCreatureName(item2.uid)].fotopoke then
        return doPlayerSendCancel(cid, "Plase, keep your pokemon's ball at the right place during evolution!")
        end

		if item.itemid == x.itemid then
            if isPlayerSummon(cid, item2.uid) then
                if table.find(x, getCreatureName(item2.uid)) then
                    if getCreatureName(item2.uid) == "Eevee" then
                        if item.itemid == 2279 then
                            if getPlayerLevel(cid) < 55 then
                            return doPlayerSendCancel(cid, "Sorry, you don't have the required level to evolve this pokemon (55).")
                            end
                
				            local pokeball = getPlayerSlotItem(cid, 8)
							setPokeballInfo(pokeball.uid, "Jolteon")
                            doItemSetAttribute(pokeball.uid, "description", "Contains a Jolteon.")
							doItemSetAttribute(pokeball.uid, "happy", 250)
                            doPlayerSendTextMessage(cid, 27, "Congratulations! Your "..getCreatureName(item2.uid).." evolved into a Jolteon!")
                            doSendMagicEffect(topos, 18)
                            doTransformItem(getPlayerSlotItem(cid, 7).uid, 2511)
							doTransformItem(getPlayerSlotItem(cid, 8).uid, icons["Jolteon"].use)
                            doSendMagicEffect(getThingPos(cid), 173)
                    
					        local oldpos = getThingPos(item2.uid)
                            doRemoveCreature(item2.uid)
                            doSummonMonster(cid, "Jolteon")
                 
				            local pk = getCreatureSummons(cid)[1]
                            registerCreatureEvent(pk, "DiePoke")
							doCreatureSetNick(pk, getPokeballInfo(getPlayerSlotItem(cid, 8).uid).nick)
                            registerCreatureEvent(pk, "Exp")
                            doTeleportThing(pk, oldpos, false)
                            doCreatureSetLookDir(pk, 2)
                            setCreatureMaxHealth(pk, getCreatureMaxHealth(pk) + (pokes[getCreatureName(pk)].cons * ((getPlayerLevel(cid)) / 1.5))) 
                            doCreatureAddHealth(pk, getCreatureMaxHealth(pk))
                            setPlayerStorageValue(cid, 2, 0)
							setPlayerStorageValue(pk, 66604, 250)
                            doPlayerRemoveItem(cid, item.itemid, 1)  
							doUpdateCds(cid)
							doUpdatePokemons(cid)
							doUpdateStatusPoke(cid)
							
    	                elseif item.itemid == 2277 then
                            if getPlayerLevel(cid) < 55 then
                            return doPlayerSendCancel(cid, "Sorry, you don't have the required level to evolve this pokemon (55).")
                            end
                
				            local pokeball = getPlayerSlotItem(cid, 8)
							setPokeballInfo(pokeball.uid, "Vaporeon")
                            doItemSetAttribute(pokeball.uid, "description", "Contains a Vaporeon.")
							doItemSetAttribute(pokeball.uid, "happy", 250)
                            doPlayerSendTextMessage(cid, 27, "Congratulations! Your "..getCreatureName(item2.uid).." evolved into a Vaporeon!")
                            doSendMagicEffect(topos, 18)
                            doTransformItem(getPlayerSlotItem(cid, 7).uid, 2510)
							doTransformItem(getPlayerSlotItem(cid, 8).uid, icons["Vaporeon"].use)
                            doSendMagicEffect(getThingPos(cid), 173)
                
				            local oldpos = getThingPos(item2.uid)
                            doRemoveCreature(item2.uid)
                            doSummonMonster(cid, "Vaporeon")
                            
							local pk = getCreatureSummons(cid)[1]
                            registerCreatureEvent(pk, "DiePoke")
                            registerCreatureEvent(pk, "Exp")
							doCreatureSetNick(pk, getPokeballInfo(getPlayerSlotItem(cid, 8).uid).nick)
                            doTeleportThing(pk, oldpos, false)
                            doCreatureSetLookDir(pk, 2)
                            setCreatureMaxHealth(pk, getCreatureMaxHealth(pk) + (pokes[getCreatureName(pk)].cons * ((getPlayerLevel(cid)) / 1.5)))
                            doCreatureAddHealth(pk, getCreatureMaxHealth(pk))
                            setPlayerStorageValue(cid, 2, 0)
							setPlayerStorageValue(pk, 66604, 250)
                            doPlayerRemoveItem(cid, item.itemid, 1)
							doUpdateCds(cid)
							doUpdatePokemons(cid)
							doUpdateStatusPoke(cid)
        
		                elseif item.itemid == 2283 then
                            if getPlayerLevel(cid) < 55 then
                            return doPlayerSendCancel(cid, "Sorry, you don't have the required level to evolve this pokemon (55).")
                            end
                
				            local pokeball = getPlayerSlotItem(cid, 8)
							setPokeballInfo(pokeball.uid, "Flareon")
                            doItemSetAttribute(pokeball.uid, "description", "Contains a Flareon.")
							doItemSetAttribute(pokeball.uid, "happy", 250)
                            doPlayerSendTextMessage(cid, 27, "Congratulations! Your "..getCreatureName(item2.uid).." evolved into a Flareon!")
                            doSendMagicEffect(topos, 18)
                            doTransformItem(getPlayerSlotItem(cid, 7).uid, 2512)
							doTransformItem(getPlayerSlotItem(cid, 8).uid, icons["Flareon"].use)
                            doSendMagicEffect(getThingPos(cid), 173)
                
				            local oldpos = getThingPos(item2.uid)
                            doRemoveCreature(item2.uid)
                            doSummonMonster(cid, "Flareon")
                
				            local pk = getCreatureSummons(cid)[1]
                            registerCreatureEvent(pk, "DiePoke")
                            registerCreatureEvent(pk, "Exp")
							doCreatureSetNick(pk, getPokeballInfo(getPlayerSlotItem(cid, 8).uid).nick)
                            doTeleportThing(pk, oldpos, false)
                            doCreatureSetLookDir(pk, 2)
                            setCreatureMaxHealth(pk, getCreatureMaxHealth(pk) + (pokes[getCreatureName(pk)].cons * ((getPlayerLevel(cid)) / 1.5)))
                            doCreatureAddHealth(pk, getCreatureMaxHealth(pk))
                            setPlayerStorageValue(cid, 2, 0)
							setPlayerStorageValue(pk, 66604, 250)
                            doPlayerRemoveItem(cid, item.itemid, 1)
							doUpdateCds(cid)
							doUpdatePokemons(cid)
							doUpdateStatusPoke(cid)
                        end

						local i = getCreatureName(getCreatureSummons(cid)[1])
                        if not string.find(getPlayerStorageValue(cid, 54842), ""..i..",") then
                            doPlayerAddSoul(cid, 1)
                            setPlayerStorageValue(cid, 54842, getPlayerStorageValue(cid, 54842)..""..i..", ")
                        end
                    return true
                    end

                    local count = pokesEvo[getCreatureName(item2.uid)].count
                    local stnid = pokesEvo[getCreatureName(item2.uid)].stoneid
                    local stnid2 = pokesEvo[getCreatureName(item2.uid)].stoneid2
                    local evo = pokesEvo[getCreatureName(item2.uid)].evolution
                    local levell = pokesEvo[getCreatureName(item2.uid)].level
                    
					if stnid2 > 1 and getPlayerItemCount(cid, stnid2) < count then
                    return doPlayerSendCancel(cid, "You need at least one "..getItemNameById(stnid).." and one "..getItemNameById(stnid2).." to evolve this pokemon!")
                    end

					if stnid2 > 1 and getPlayerItemCount(cid, stnid) < count then
                    return doPlayerSendCancel(cid, "You need at least one "..getItemNameById(stnid).." and one "..getItemNameById(stnid2).." to evolve this pokemon!")
                    end

					if getPlayerItemCount(cid, stnid) < count then
                    return doPlayerSendCancel(cid, "You need at least "..count.." "..getItemNameById(stnid).."s to evolve this pokemon!")
                    end

					if getPlayerLevel(cid) < pokesEvo[getCreatureName(item2.uid)].level then
                    return doPlayerSendCancel(cid, "Sorry, you don't have the required level to evolve this pokemon ("..levell..").")
                    end

					local owner = getCreatureMaster(item2.uid)
                    local pokeball = getPlayerSlotItem(cid, 8)
                    local description = "Contains a "..evo.."."

                    local nas = {
                    ["%%pokename"] = pokesEvo[getCreatureName(item2.uid)].evolution
                    }

					for i,x in pairs(nas) do
                        if description:find(i) then
                            description = description:gsub(i, x)
                        end
                    end

					local slo = pokesEvo[getCreatureName(item2.uid)].maxh
                    local sle = pokesEvo[getCreatureName(item2.uid)].evolution

                    setPokeballInfo(pokeball.uid, evo, pokesEvo[getCreatureName(item2.uid)].maxh, pokesEvo[getCreatureName(item2.uid)].maxh)
				    doItemSetAttribute(pokeball.uid, "description", description)
					doItemSetAttribute(pokeball.uid, "happy", 250)
                    doPlayerSendTextMessage(cid, 27, "Congratulations! Your "..getCreatureName(item2.uid).." evolved into a "..evo.."!")
                    doSendMagicEffect(topos, 18)
                    doTransformItem(getPlayerSlotItem(cid, 7).uid, fotos[sle].fotopoke)
					doTransformItem(getPlayerSlotItem(cid, 8).uid, icons[sle].use)
                    doSendMagicEffect(getThingPos(cid), 173)
                   
				    local oldpos = getThingPos(item2.uid)
                    doRemoveCreature(item2.uid)
                    doSummonMonster(cid, sle)

					local pk = getCreatureSummons(cid)[1]
                    registerCreatureEvent(pk, "DiePoke")
                    registerCreatureEvent(pk, "Exp")
					doCreatureSetNick(pk, getPokeballInfo(getPlayerSlotItem(cid, 8).uid).nick)
                    doTeleportThing(pk, oldpos, false)
                    doCreatureSetLookDir(pk, 2)
                    setCreatureMaxHealth(pk, slo)
                    doCreatureAddHealth(pk, slo)
                    setCreatureMaxHealth(pk, getCreatureMaxHealth(pk) + (pokes[getCreatureName(pk)].cons * ((getPlayerLevel(cid)) / 1.5)))
                    doCreatureAddHealth(pk, getCreatureMaxHealth(pk))
                    doPlayerRemoveItem(cid, stnid, count)
                    doPlayerRemoveItem(cid, stnid2, count)
                    setPlayerStorageValue(cid, 2, 0)
					setPlayerStorageValue(pk, 66604, 250)
					doUpdateCds(cid)
					doUpdatePokemons(cid)
					doUpdateStatusPoke(cid)
  
					local i = getCreatureName(getCreatureSummons(cid)[1])
                    if not string.find(getPlayerStorageValue(cid, 54842), ""..i..",") then
                        doPlayerAddSoul(cid, 1)
                        setPlayerStorageValue(cid, 54842, getPlayerStorageValue(cid, 54842)..""..i..", ")
                    end
					
                break
                else
                return doPlayerSendCancel(cid, "Sorry, this is not the required stone to evolve this pokemon!")
                end
            end
        end
    end
return TRUE
end