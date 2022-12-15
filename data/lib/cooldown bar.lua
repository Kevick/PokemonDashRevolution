useOTClient = true
useKpdoDlls = true -- coloque true pra usar as barras de cooldown.

function doUpdateMoves(cid)
if not isCreature(cid) then return true end
local summon = getCreatureSummons(cid)[1]
local ret = {}
table.insert(ret, "12&,")
if not summon then
   for a = 1, 12 do
       table.insert(ret, "n/n,")
   end
   doPlayerSendCancel(cid, table.concat(ret))
   addEvent(doUpdateCooldowns, 100, cid)
return true
end
if isTransformed(summon) then  --alterado v1.9
   moves = PokeMoves[getPlayerStorageValue(summon, 1010)]
else                                                       
   moves = PokeMoves[getCreatureName(summon)]
end

for a = 1, 12 do
    local b = getNewMoveTable(moves, a)
    if b then
       table.insert(ret, b.spell..",")
    else
       table.insert(ret, "n/n,")
    end
end
doPlayerSendCancel(cid, table.concat(ret))
addEvent(doUpdateCooldowns, 100, cid)
end

function doUpdateCooldowns(cid)
if not isCreature(cid) then return true end
doPlayerSendCancel(cid, '12|,'..getPokemonCooldown(cid, 1)..'|0,'..getPokemonCooldown(cid, 2)..'|0,'..getPokemonCooldown(cid, 3)..'|0,'..getPokemonCooldown(cid, 4)..'|0,'..getPokemonCooldown(cid, 5)..'|0,'..getPokemonCooldown(cid, 6)..'|0,'..getPokemonCooldown(cid, 7)..'|0,'..getPokemonCooldown(cid, 8)..'|0,'..getPokemonCooldown(cid, 9)..'|0,'..getPokemonCooldown(cid, 10)..'|0,'..getPokemonCooldown(cid, 11)..'|0,'..getPokemonCooldown(cid, 12))                                             
end

function getPokemonCooldown(cid, move) -- Checa o cooldown do move prédefinido  
return getItemAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown"..move.."") or 0
end
------------------------- Por slot ------------------------- 
function getPokemonCooldownn(slot, move) -- Checa o cooldown do move prédefinido
return getItemAttribute(slot, "cooldown"..move.."") or 0
end
------------------------- Por slot -------------------------

function setPokemonCooldown(uidd, move, time) -- Troca o cooldown do move prédefinido
if getPlayerSlotItem(uidd, 8).uid > 0 then
   doItemSetAttribute(getPlayerSlotItem(uidd, 8).uid, "cooldown"..move.."", ""..time.."")
end
end

function setPokemonCooldownn(uid, move, time) -- Troca o cooldown do move prédefinido
   doItemSetAttribute(uid, "cooldown"..move.."", ""..time.."")
end

function doPokemonDropCooldown(cid, move) -- Faz abaixar o cooldown prédefinedo, (3,2,1).
if not isPlayer(cid) then return false end
if getPlayerSlotItem(cid,8).uid == 0 then return false end
if getPokemonCooldown(cid, move) == "Don't have this move." then return false end
if getPokemonCooldown(cid, move) > 0 then
   doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown"..move.."", ""..math.floor(getPokemonCooldownn(getPlayerSlotItem(cid,8).uid, move)-1).."") 
   addEvent(doPokemonDropCooldown, 1300, cid, move)
end
end

function getMoveLevel(cid, move, level) -- Checa o level do move usado.
   return doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move"..move.."Level", ""..level.."")
end

function getMoveName(cid, move, name) -- Checa o nome do move usado.
   return doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move"..move.."Name", ""..name.."")
end

function setHealCooldown(slot, move, time)
doItemSetAttribute(slot, "cooldown"..move.."", ""..time.."") 
end
----------------------------------
function getMoveLevell(cid, move)
   return getItemAttribute(getPlayerSlotItem(cid, 8).uid, "move"..move.."Level") 
end

function getMoveNamee(cid, move)
   return getItemAttribute(getPlayerSlotItem(cid, 8).uid, "spell"..move)
   
end 
----------------------------------

function doGoBackSetCooldown(cid, moves)

local summon = getCreatureSummons(cid)[1]
local tungs_moves = PokeMoves[getCreatureName(summon)]
local m1 = getNewMoveTable(tungs_moves, 1)
local m2 = getNewMoveTable(tungs_moves, 2)
local m3 = getNewMoveTable(tungs_moves, 3)
local m4 = getNewMoveTable(tungs_moves, 4)
local m5 = getNewMoveTable(tungs_moves, 5)
local m6 = getNewMoveTable(tungs_moves, 6)
local m7 = getNewMoveTable(tungs_moves, 7)
local m8 = getNewMoveTable(tungs_moves, 8)
local m9 = getNewMoveTable(tungs_moves, 9)
local m10 = getNewMoveTable(tungs_moves, 10)
local m11 = getNewMoveTable(tungs_moves, 11)
local m12 = getNewMoveTable(tungs_moves, 12)

if not getMoveNamee(cid, 1) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move1Name", ""..m1.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move1Level", ""..m1.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown1", ""..m1.cd.."")
         doPokemonDropCooldown(cid, 1)		 
end
if not getMoveNamee(cid, 2) then         
if isInArray(poke2, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move2Name", ""..m2.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move2Level", ""..m2.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown2", ""..m2.cd.."")
         doPokemonDropCooldown(cid, 2)
else
         setPokemonCooldown(cid, 2, "Don't have this move.")
end
end
if not getMoveNamee(cid, 3) then
if isInArray(poke3, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move3Name", ""..m3.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move3Level", ""..m3.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown3", ""..m3.cd.."")
         doPokemonDropCooldown(cid, 3)
else
         setPokemonCooldown(cid, 3, "Don't have this move.")
end
end
if not getMoveNamee(cid, 4) then
if isInArray(poke4, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move4Name", ""..m4.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move4Level", ""..m4.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown4", ""..m4.cd.."")
         doPokemonDropCooldown(cid, 4)
else
         setPokemonCooldown(cid, 4, "Don't have this move.")
end
end
if not getMoveNamee(cid, 5) then
if isInArray(poke5, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move5Name", ""..m5.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move5Level", ""..m5.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown5", ""..m5.cd.."")
         doPokemonDropCooldown(cid, 5)
else
         setPokemonCooldown(cid, 5, "Don't have this move.")
end
end
if not getMoveNamee(cid, 6) then
if isInArray(poke6, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move6Name", ""..m6.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move6Level", ""..m6.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown6", ""..m6.cd.."")
         doPokemonDropCooldown(cid, 6)
else
         setPokemonCooldown(cid, 6, "Don't have this move.")
end
end
if not getMoveNamee(cid, 7) then
if isInArray(poke7, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move7Name", ""..m7.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move7Level", ""..m7.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown7", ""..m7.cd.."")
         doPokemonDropCooldown(cid, 7)
else
         setPokemonCooldown(cid, 7, "Don't have this move.")
end
end
if not getMoveNamee(cid, 8) then
if isInArray(poke8, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move8Name", ""..m8.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move8Level", ""..m8.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown8", ""..m8.cd.."")
         doPokemonDropCooldown(cid, 8)
else
         setPokemonCooldown(cid, 8, "Don't have this move.")
end
end
if not getMoveNamee(cid, 9) then
if isInArray(poke9, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move9Name", ""..m9.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move9Level", ""..m9.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown9", ""..m9.cd.."")
         doPokemonDropCooldown(cid, 9)
else
         setPokemonCooldown(cid, 9, "Don't have this move.")
end
end
if not getMoveNamee(cid, 10) then
if isInArray(poke10, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move10Name", ""..m10.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move10Level", ""..m10.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown10", ""..m10.cd.."")
         doPokemonDropCooldown(cid, 10)
else
         setPokemonCooldown(cid, 10, "Don't have this move.")
end
end
if not getMoveNamee(cid, 11) then
if isInArray(poke11, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move11Name", ""..m11.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move11Level", ""..m11.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown11", ""..m11.cd.."")
         doPokemonDropCooldown(cid,11)
else
         setPokemonCooldown(cid, 11, "Don't have this move.")
end
end
if not getMoveNamee(cid, 12) then
if isInArray(poke12, getCreatureName(getCreatureSummons(cid)[1])) then
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move12Name", ""..m12.spell.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "move12Level", ""..m12.minLv.."")
         doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "cooldown12", ""..m12.cd.."")
         doPokemonDropCooldown(cid, 12)
else
         setPokemonCooldown(cid, 12, "Don't have this move.")
end
end
end  
------------------------------------------------------------------------------------

function doGoBackSetCooldownInCatch(uid, name)
         doItemSetAttribute(uid, "move1Name", ""..PokeMoves[name].move1.spell.."")
         doItemSetAttribute(uid, "move1Level", ""..PokeMoves[name].move1.minLv.."")
         doItemSetAttribute(uid, "cooldown1", ""..PokeMoves[name].move1.cd.."")      
if PokeMoves[name].move2 then
         doItemSetAttribute(uid, "move2Name", ""..PokeMoves[name].move2.spell.."")
         doItemSetAttribute(uid, "move2Level", ""..PokeMoves[name].move2.minLv.."")
         doItemSetAttribute(uid, "cooldown2", ""..PokeMoves[name].move2.cd.."")
else
         setPokemonCooldownn(uid, 2, "Don't have this move.")
end
if PokeMoves[name].move3 then
         doItemSetAttribute(uid, "move3Name", ""..PokeMoves[name].move3.spell.."")
         doItemSetAttribute(uid, "move3Level", ""..PokeMoves[name].move3.minLv.."")
         doItemSetAttribute(uid, "cooldown3", ""..PokeMoves[name].move3.cd.."")
else
         setPokemonCooldownn(uid,3, "Don't have this move.")
end
if PokeMoves[name].move4 then
         doItemSetAttribute(uid, "move4Name", ""..PokeMoves[name].move4.spell.."")
         doItemSetAttribute(uid, "move4Level", ""..PokeMoves[name].move4.minLv.."")
         doItemSetAttribute(uid, "cooldown4", ""..PokeMoves[name].move4.cd.."")
else
         setPokemonCooldownn(uid,4, "Don't have this move.")
end
if PokeMoves[name].move5 then
         doItemSetAttribute(uid, "move5Name", ""..PokeMoves[name].move5.spell.."")
         doItemSetAttribute(uid, "move5Level", ""..PokeMoves[name].move5.minLv.."")
         doItemSetAttribute(uid, "cooldown5", ""..PokeMoves[name].move5.cd.."")
else
         setPokemonCooldownn(uid,5, "Don't have this move.")
end
if PokeMoves[name].move6 then
         doItemSetAttribute(uid, "move6Name", ""..PokeMoves[name].move6.spell.."")
         doItemSetAttribute(uid, "move6Level", ""..PokeMoves[name].move6.minLv.."")
         doItemSetAttribute(uid, "cooldown6", ""..PokeMoves[name].move6.cd.."")
else
         setPokemonCooldownn(uid,6, "Don't have this move.")
end
if PokeMoves[name].move7 then
         doItemSetAttribute(uid, "move7Name", ""..PokeMoves[name].move7.spell.."")
         doItemSetAttribute(uid, "move7Level", ""..PokeMoves[name].move7.minLv.."")
         doItemSetAttribute(uid, "cooldown7", ""..PokeMoves[name].move7.cd.."")
else
         setPokemonCooldownn(uid,7, "Don't have this move.")
end
if PokeMoves[name].move8 then
         doItemSetAttribute(uid, "move8Name", ""..PokeMoves[name].move8.spell.."")
         doItemSetAttribute(uid, "move8Level", ""..PokeMoves[name].move8.minLv.."")
         doItemSetAttribute(uid, "cooldown8", ""..PokeMoves[name].move8.cd.."")
else
         setPokemonCooldownn(uid,8, "Don't have this move.")
end
if PokeMoves[name].move9 then
         doItemSetAttribute(uid, "move9Name", ""..PokeMoves[name].move9.spell.."")
         doItemSetAttribute(uid, "move9Level", ""..PokeMoves[name].move9.minLv.."")
         doItemSetAttribute(uid, "cooldown9", ""..PokeMoves[name].move9.cd.."")
else
         setPokemonCooldownn(uid,9, "Don't have this move.")
end
if PokeMoves[name].move10 then
         doItemSetAttribute(uid, "move10Name", ""..PokeMoves[name].move10.spell.."")
         doItemSetAttribute(uid, "move10Level", ""..PokeMoves[name].move10.minLv.."")
         doItemSetAttribute(uid, "cooldown10", ""..PokeMoves[name].move10.cd.."")
else
         setPokemonCooldownn(uid,10, "Don't have this move.")
end
if PokeMoves[name].move11 then
         doItemSetAttribute(uid, "move11Name", ""..PokeMoves[name].move11.spell.."")
         doItemSetAttribute(uid, "move11Level", ""..PokeMoves[name].move11.minLv.."")
         doItemSetAttribute(uid, "cooldown11", ""..PokeMoves[name].move11.cd.."")
else
         setPokemonCooldownn(uid,11, "Don't have this move.")
end
if PokeMoves[name].move12 then
         doItemSetAttribute(uid, "move12Name", ""..PokeMoves[name].move12.spell.."")
         doItemSetAttribute(uid, "move12Level", ""..PokeMoves[name].move12.minLv.."")
         doItemSetAttribute(uid, "cooldown12", ""..PokeMoves[name].move12.cd.."")
else
         setPokemonCooldownn(uid,12, "Don't have this move.")
end
end   
---------------------------------------------------------------------------------
function doCureAllStatus(slot)
if getPokemonCooldownn(slot,1) == "Don't have this move." or not getPokemonCooldownn(slot,1) then
doItemSetAttribute(slot, "cooldown1", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown1", 0)
end
if getPokemonCooldownn(slot,2) == "Don't have this move." or not getPokemonCooldownn(slot,2) then
doItemSetAttribute(slot, "cooldown2", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown2", 0)
end
if getPokemonCooldownn(slot,3) == "Don't have this move." or not getPokemonCooldownn(slot,3) then
doItemSetAttribute(slot, "cooldown3", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown3", 0)
end
if getPokemonCooldownn(slot,4) == "Don't have this move." or not getPokemonCooldownn(slot,4) then
doItemSetAttribute(slot, "cooldown4", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown4", 0)
end
if getPokemonCooldownn(slot,5) == "Don't have this move." or not getPokemonCooldownn(slot,5) then
doItemSetAttribute(slot, "cooldown5", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown5", 0)
end
if getPokemonCooldownn(slot,6) == "Don't have this move." or not getPokemonCooldownn(slot,6) then
doItemSetAttribute(slot, "cooldown6", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown6", 0)
end
if getPokemonCooldownn(slot,7) == "Don't have this move." or not getPokemonCooldownn(slot,7) then
doItemSetAttribute(slot, "cooldown7", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown7", 0)
end
if getPokemonCooldownn(slot,8) == "Don't have this move." or not getPokemonCooldownn(slot,8) then
doItemSetAttribute(slot, "cooldown8", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown8", 0)
end
if getPokemonCooldownn(slot,9) == "Don't have this move." or not getPokemonCooldownn(slot,9) then
doItemSetAttribute(slot, "cooldown9", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown9", 0)
end
if getPokemonCooldownn(slot,10) == "Don't have this move." or not getPokemonCooldownn(slot,10) then
doItemSetAttribute(slot, "cooldown10", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown10", 0)
end
if getPokemonCooldownn(slot,11) == "Don't have this move." or not getPokemonCooldownn(slot,11) then
doItemSetAttribute(slot, "cooldown11", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown11", 0)
end
if getPokemonCooldownn(slot,12) == "Don't have this move." or not getPokemonCooldownn(slot,12) then
doItemSetAttribute(slot, "cooldown12", "Don't have this move.")
else
doItemSetAttribute(slot, "cooldown12", 0)
end
end 



------------------------------------------------------------------------------------------------------
poke2 = {'Elite Hitmonlee', 'Elite Hitmonchan','Shiny Venusaur', 'Shiny Oddish', 'Shiny Electrode', 'Shiny Dratini','Shiny Voltorb','Shiny Zubat','Shiny Tentacruel','Shiny Raichu', 'Shiny Tentacool', 'Shiny Muk', 'Shiny Electabuzz','Shiny Grimer','Shiny Jynx', 'Shiny Kingler', 'Shiny Krabby','Shiny Blastoise', 'Shiny Venomoth','Shiny Venonat', 'Shiny Beedrill', 'Shiny Butterfree','Shiny Parasect','Shiny Paras', 'Shiny Raticate', 'Shiny Horsea', 'Shiny Rattata', 'Shiny Farfetchd', 'Shiny Growlithe','Shiny Scyther','Shiny Arcanine','Crystal Onix','bulbasaur','ivysaur','chikorita','bayleef','meganium','cyndaquil','quilava','typhlosion','ivysaur','venusaur','Totodile','Croconaw','Feraligatr','Squirtle','wartortle','Blastoise','Pidgey','persian', 'Pidgeotto', 'Pidgeot', 'Rattata',
'Bellsprout', 'Weepinbell', 'hoppip', 'jumpluff', 'Victreebel', 'Poliwag', 'Poliwhirl', 'Poliwrath', 'azumarill', 'Abra', 'Oddish', 'Gallade', 'Skarmory',
'Gloom', 'Vileplume', 'Horsea', 'Seadra', 'Kingdra', 'Grimer', 'Muk', 'Weedle', 'Kakuna', 'Beedrill', 'Raticate', 'Aipom', 'Zubat', 'Golbat', 'Crobat',
'Doduo', 'Dodrio', 'Magnemite', 'Magneton', 'Voltorb', 'Electrode', 'Geodude', 'Graveler', 'Golem','Sandshrew', 'Hoothoot', 'larvitar', 'Politoed',
'Sandslash', 'Charmander', 'Charmeleon', 'Charizard', 'Kadabra', 'Alakazam', 'Shiny Abra', 'caterpie', 'metapod', 'Butterfree', 'Murkrow', 'Pupitar',
'spearow', 'fearow', 'ekans', 'arbok', 'pikachu', 'raichu', 'nidoran female', 'nidorina', 'nidoqueen', 'nidoran male', 'Marill', 'Pineco', 'Quaqsire',
'nidorino', 'nidoking', 'clefairy', 'clefable', 'cleffa', 'vulpix', 'Ninetales', 'Jigglypuff', 'Wigglytuff', 'zubat', 'igglypuff', 'golbat', 'Qwilfish',
'Paras', 'Parasect', 'Venonat', 'Venomoth', 'Diglett', 'Dugtrio', 'Meowth', 'Psyduck', 'Golduck', 'Mankey', 'Primeape', 'Natu', 'Piloswine', 'Skiploom',
'Growlithe', 'arcanine', 'houndor', 'houndoom', 'machop', 'machoke', 'machamp', 'tentacool', 'tentacruel', 'Ponyta', 'Rapidash', 'Slowpoke', 'Granbull',
'Slowbro', 'Farfetchd', 'seel', 'dewgong', 'Shellder', 'Cloyster', 'Gastly', 'haunter', 'gengar', 'onix', 'drowzee', 'Girafarig', 'Misdreavus',
'hypno', 'krabby', 'kingler', 'Exeggcute', 'Exeggutor', 'Marowak', 'Hitmonlee', 'cubone','Hitmonchan', 'Lickitung', 'Koffing', 'Heracross', 'Octillery', 'Remoraid', 'Sentret',
'Weezing', 'Rhyhorn', 'Rhydon', 'Chansey', 'Tangela', 'Kangaskhan', 'Goldeen', 'Seaking', 'Staryu', 'Starmie', 'MrMime', 'Hitmontop', 'miltank', 'Scizor',
'Scyther', 'Jynx', 'Electabuzz', 'Ampharos', 'Magmar', 'Pinsir', 'Tauros', 'Lapras', 'Eevee', 'Vaporeon', 'Jolteon', 'Flareon', 'Mareep', 'Noctowl', 'Shuckle',
'Porygon', 'Omanyte', 'Omastar', 'Kabuto', 'Kabutops', 'Aerodactyl', 'Snorlax', 'Articuno', 'Zapdos', 'Moltres', 'Dratini', 'Shiny Charizard', 'Phanpy', 'Porygon2',
'Dragonair', 'Dragonite', 'Mew', 'Mewtwo', 'Gyarados', 'Ariados', 'Spinarak', 'Snubbull', 'Chinchou', 'Sneasel', 'Delibird', 'Slowking', 'Smoochum', 'Smeargle', 'lanturn', 'Donphan', 'Dunsparce', 'Espeon', 'Ledian', 'Ledyba', 'magby', 'Flaaffy', 'Forretress', 'Furret', 'Mantine', 'Magcarbo', 'Slugma', 'Gligar'}
------------------------------------------------------------------------------------------------------
poke3 = {'Elite Hitmonlee', 'Elite Hitmonchan','Shiny Venusaur', 'Shiny Oddish','Shiny Electrode','Shiny Dratini','Shiny Voltorb','Shiny Zubat','Shiny Tentacruel','Shiny Raichu','Shiny Tentacool','Shiny Muk','Shiny Electabuzz','Shiny Grimer','Shiny Jynx', 'Shiny Kingler', 'Shiny Krabby','Shiny Blastoise','Shiny Venomoth','Shiny Venonat','Shiny Beedrill','Shiny Butterfree','Shiny Parasect','Shiny Paras','Shiny Raticate','Shiny Horsea','Shiny Rattata','Shiny Farfetchd','Shiny Growlithe','Shiny Scyther','Shiny Arcanine','Crystal Onix','bulbasaur','ivysaur','venusaur','chikorita', 'Spinarak', 'bayleef','meganium','cyndaquil','quilava','typhlosion','Totodile','Croconaw','Feraligatr','Squirtle','wartortle','Blastoise','Pidgey', 'Pidgeotto', 'Pidgeot', 'Rattata',
'Bellsprout', 'Weepinbell', 'Victreebel', 'jumpluff', 'hoppip', 'Poliwag', 'Poliwhirl', 'Poliwrath', 'azumarill', 'Abra', 'Oddish', 'Quaqsire',
'Gloom', 'Vileplume', 'Horsea', 'Seadra', 'kingdra', 'Grimer', 'Muk', 'Weedle', 'Kakuna', 'Beedrill', 'Raticate', 'Aipom', 'Zubat', 'Golbat','Crobat', 'Gligar', 'Hoothoot',
'Doduo', 'Dodrio', 'Magnemite', 'Magneton', 'Voltorb', 'Electrode', 'Geodude', 'Graveler', 'Golem', 'Sandshrew', 'Politoed', 'remoraid', 'Skiploom',
'Sandslash', 'Charmander', 'larvitar', 'Charmeleon', 'Charizard', 'Shiny Charizard', 'Kadabra', 'Alakazam', 'Shiny Abra', 'caterpie', 'metapod', 'Butterfree', 'Murkrow',
'spearow', 'fearow', 'ekans', 'arbok', 'pikachu', 'raichu', 'nidoran female', 'nidorina', 'nidoqueen', 'nidoran male', 'Gallade', 'Shuckle', 
'nidorino', 'nidoking', 'cleffa', 'clefairy', 'clefable', 'vulpix', 'Ninetales', 'igglybuff', 'Jigglypuff', 'Wigglytuff', 'zubat', 'golbat','persian', 'Pineco',
'Paras', 'Parasect', 'Venonat', 'Venomoth', 'Diglett', 'Dugtrio', 'Meowth', 'Psyduck', 'Golduck', 'Mankey', 'Primeape', 'Piloswine', 'Skarmory',
'Growlithe', 'arcanine', 'houndor', 'houndoom', 'machop', 'machoke', 'machamp', 'tentacool', 'tentacruel', 'Ponyta', 'Rapidash', 'Slowpoke', 'Heracross',
'Slowbro', 'Farfetchd', 'seel', 'dewgong', 'Shellder', 'Cloyster', 'gastly', 'haunter', 'gengar', 'onix', 'drowzee', 'Granbull', 'Natu',
'hypno', 'krabby', 'kingler', 'Exeggcute', 'Exeggutor', 'Marowak', 'Hitmonlee', 'cubone','Hitmonchan', 'Lickitung', 'Koffing', 'Mareep', 'Marill', 'Phanpy', 'Qwilfish',
'Weezing', 'Rhyhorn', 'Rhydon', 'Chansey', 'Tangela', 'Kangaskhan', 'Goldeen', 'Seaking', 'Staryu', 'Starmie', 'MrMime', 'Hitmontop', 'Porygon2', 'Pupitar', 'Scizor', 'Sentret',
'Scyther', 'Jynx', 'Electabuzz', 'Ampharos', 'Magmar', 'Pinsir', 'Tauros', 'Lapras','eevee', 'Vaporeon', 'Jolteon', 'Flareon', 'Misdreavus',
'Porygon', 'Omanyte', 'Omastar', 'Kabuto', 'Kabutops', 'Aerodactyl', 'Snorlax', 'Articuno', 'Zapdos', 'Moltres', 'Dratini', 'Girafarig', 'Miltank', 'Noctowl', 'Octillery',
'Dragonair', 'Dragonite', 'Mew', 'Mewtwo', 'Snubbull', 'Ariados', 'Gyarados', 'Chinchou', 'Sneasel', 'Magcarbo', 'Delibird', 'Smoochum', 'Smeargle', 'Slowking', 'Donphan', 'Dunsparce', 'Espeon', 'Flaaffy', 'lanturn', 'ledian', 'magby', 'ledyba', 'Forretress', 'Mantine', 'Furret'}
------------------------------------------------------------------------------------------------------
poke4 = {'Elite Hitmonlee', 'Elite Hitmonchan','Shiny Venusaur', 'Shiny Oddish','Shiny Electrode','Shiny Dratini','Shiny Voltorb','Shiny Zubat','Shiny Tentacruel','Shiny Raichu','Shiny Tentacool','Shiny Muk','Shiny Electabuzz','Shiny Grimer','Shiny Jynx', 'Shiny Kingler', 'Shiny Krabby','Shiny Blastoise','Shiny Venomoth','Shiny Venonat','Shiny Beedrill','Shiny Butterfree','Shiny Parasect','Shiny Paras','Shiny Raticate','Shiny Horsea','Shiny Rattata','Shiny Farfetchd','Shiny Growlithe','Shiny Scyther','Shiny Arcanine','Crystal Onix','Bulbasaur', 'Ivysaur', 'chikorita', 'Ariados', 'bayleef','meganium', 'cyndaquil', 'quilava','typhlosion', 'Venusaur', 'Charmander', 'Charmeleon', 'Charizard', 'Squirtle', 'Totodile', 'Croconaw', 'Feraligatr', 
'Wartortle', 'Blastoise', 'Metapod', 'Butterfree', 'Kakuna', 'Beedrill', 'Pidgey', 'Pidgeotto', 'Pidgeot', 'Hoothoot', 'Noctowl', 
'Rattata', 'Raticate', 'Aipom', 'Spearow', 'Fearow', 'Ekans', 'Arbok', 'Pikachu', 'Raichu', 'Nidoranfe', 'Nidorina', 'Pineco', 
'Nidoqueen', 'NidoranMa', 'Nidorino', 'Nidoking', 'Cleffa', 'Clefairy', 'Clefable', 'Vulpix', 'Ninetales', 'Jigglypuff', 
'Wigglytuff', 'Zubat', 'igglypuff', 'Golbat', 'Crobat', 'Bellsprout', 'Weepinbell', 'hoppip', 'jumpluff', 'Victreebel', 'Paras', 'Parasect', 'Venonat', 
'Venomoth', 'Diglett', 'Dugtrio', 'Meowth', 'Persian', 'Psyduck', 'Golduck', 'Mankey', 'Primeape', 'houndor', 'Growlithe', 'Skarmory',
 'Arcanine', 'Poliwag', 'azumarill', 'Houndoom', 'Poliwhirl', 'Poliwrath', 'Abra', 'Alakazam', 'Shiny Abra','Kadabra', 'Oddish', 'Gloom', 'Vileplume',
 'Machop', 'Machoke', 'Machamp', 'Tentacool', 'Tentacruel', 'Ponyta', 'Rapidash', 'Slowpoke', 'Slowbro', 'Gligar', 'Murkrow', 
 'Farfetchd', 'Seel', 'Dewgong', 'Shellder', 'Cloyster', 'Gastly', 'Haunter', 'Gengar', 'Onix', 'Drowzee', 'Granbull', 'Natu', 'Sentret',
 'Hypno', 'Krabby', 'Kingler', 'Exeggcute', 'Exeggutor', 'Cubone', 'Marowak', 'Hitmonlee', 'Hitmonchan','Donphan','Miltank',
 'Lickitung', 'Koffing', 'Weezing', 'Rhyhorn', 'Rhydon', 'Chansey', 'Tangela', 'Kangaskhan', 'Horsea', 'Furret', 'Mareep', 'Octillery', 'remoraid',
 'Seadra', 'Grimer', 'kingdra', 'Muk', 'Doduo', 'Dodrio', 'Magnemite', 'Magneton', 'Voltorb', 'Electrode', 'Geodude', 'Heracross', 
 'Graveler', 'Golem', 'Sandshrew', 'larvitar', 'Sandslash', 'Onix', 'Drowzee', 'Hypno', 'Cubone', 'Marowak', 'Hitmonlee', 'Hitmonchan', 'Lickitung', 'Kofiing', 'Weezing', 'Rhyhorn', 'Politoed',
 'Rhydon', 'Chansey', 'Tangela', 'Kangaskhan', 'Goldeen', 'Seaking', 'Staryu', 'Starmie', 'MrMime', 'Gallade', 'Marill', 'Shuckle',
 'Scyther', 'Jynx', 'Electabuzz', 'Ampharos', 'Magmar', 'Pinsir', 'Tauros', 'Gyarados', 'Lapras', 'Eevee', 'Misdreavus', 'Phanpy', 'Piloswine', 'Pupitar', 'Quaqsire', 'Qwilfish', 'Skiploom',
 'Vaporeon', 'Jolteon', 'Flareon','Porygon2', 'Porygon', 'Omanyte', 'Omastar', 'Kabuto', 'Kabutops', 'Aerodactyl', 'Girafarig', 'Scizor',
 'Snorlax', 'Articuno', 'Zapdos', 'Moltres', 'Snubbull', 'Dratini', 'Spinarak', 'Sneasel', 'Dragonair', 'Slowking', 'Dragonite', 'Smeargle', 'Smoochum', 'Slugma', 'Hitmontop', 'Shiny Charizard', 'Crystal Onix', 'Mew', 'Mewtwo', 'Chinchou', 'Delibird', 'Dunphan', 'Dunsparce', 'Espeon', 'Ledian', 'Magby', 'Ledyba', 'lanturn', 'Flaaffy', 'Mantine', 'Magcarbo', 'Forretress'}
------------------------------------------------------------------------------------------------------
poke5 = {'Shiny Venusaur', 'Shiny Oddish','Shiny Electrode','Shiny Voltorb','Shiny Zubat','Shiny Tentacruel','Shiny Raichu','Shiny Tentacool','Shiny Muk','Shiny Electabuzz','Shiny Grimer','Shiny Jynx', 'Shiny Kingler', 'Shiny Krabby','Shiny Blastoise','Shiny Venomoth','Shiny Venonat','Shiny Beedrill','Shiny Butterfree','Shiny Parasect','Shiny Paras','Shiny Horsea','Shiny Farfetchd','Shiny Growlithe','Shiny Scyther','Shiny Arcanine','Crystal Onix','Bulbasaur', 'Ivysaur','chikorita','bayleef','meganium','cyndaquil','quilava','typhlosion', 'Venusaur', 'Charmander', 'Charmeleon', 'Charizard', 'Squirtle', 'Totodile', 'Croconaw', 'Feraligatr',
 'Wartortle', 'Blastoise', 'Butterfree', 'Aipom', 'Beedrill', 'Pidgeotto', 'Pidgeot', 'Fearow', 'Ekans', 'Marill',
 'Arbok', 'Pikachu', 'Raichu', 'Nidoranfe', 'Nidorina', 'Nidoqueen', 'Nidoranma', 'Nidorino', 'Nidoking', 'Granbull', 'Shuckle',
 'Clefairy', 'Cleffa', 'Clefable', 'Vulpix', 'Ninetales', 'Jigglypuff', 'igglypuff', 'Wigglytuff', 'Zubat', 'Golbat', 'Crobat', 'Skarmory', 
 'Weepinbell', 'Victreebel', 'hoppip', 'jumpluff', 'Paras', 'Parasect', 'Venonat', 'Venomoth', 'Diglett', 'Dugtrio', 'Persian', 'Hoothoot', 'Noctowl', 'Qwilfish',
 'Golduck', 'Mankey', 'Primeape', 'Houndor', 'Growlithe', 'Arcanine', 'Poliwag', 'houndoom', 'Poliwhirl', 'Poliwrath', 'Politoed', 'azumarill', 'Kadabra', 'Piloswine', 'Quaqsire',
 'Alakazam', 'Shiny Abra', 'Oddish', 'Gloom', 'Vileplume', 'Machop', 'Machoke', 'Machamp', 'Tentacool', 'Tentacruel', 
 'Ponyta', 'Rapidash', 'Slowpoke', 'Slowbro', 'Farfetchd', 'Seel', 'Dewgong', 'Shellder', 'Cloyster', 'Gastly', 'Murkrow',
 'Haunter', 'Gengar', 'Onix', 'Drowzee', 'Hypno', 'Krabby', 'Kingler',  'Exeggutor', 'Cubone', 'Marowak', 'Mareep', 
 'Hitmonchan', 'Lickitung', 'Koffing', 'Weezing', 'Rhyhorn', 'Rhydon', 'Chansey', 'Tangela', 'Kangaskhan', 'Heracross', 'Skiploom',
 'Horsea', 'Seadra', 'Kingdra', 'Grimer', 'Muk', 'Doduo', 'Dodrio', 'Magnemite', 'Magneton', 'Voltorb', 'Electrode', 'Hitmontop', 'Scizor',
 'Geodude', 'Graveler', 'Golem','larvitar', 'Sandshrew','Sandslash', 'Goldeen', 'Seaking', 'Staryu', 'Starmie', 'MrMime', 'Pineco',
 'Scyther', 'Jynx', 'Electabuzz', 'Ampharos', 'Magmar', 'Pinsir', 'Tauros', 'Gyarados', 'Lapras', 'Eevee', 'Octillery', 'Remoraid',
 'Vaporeon', 'Jolteon', 'Flareon', 'Porygon', 'Omanyte', 'Omastar', 'Kabuto', 'Kabutops', 'Aerodactyl', 'Gligar', 'Natu', 'Porygon2',
 'Snorlax', 'Articuno', 'Zapdos', 'Moltres', 'Dragonair', 'Dragonite', 'Shiny Charizard', 'Crystal Onix', 'Miltank', 'Sentret',
 'Mew', 'Mewtwo', 'Chinchou', 'lanturn', 'Delibird', 'Donphan', 'Sneasel', 'Slowking', 'Smoochum', 'Slugma', 'Smeargle', 'Dunsparce', 'Espeon', 'Flaaffy', 'Forretress', 'Furret', 'Ledian', 'Magcarbo', 'Phanpy', 'Pupitar',
 'Ledyba', 'Magby', 'Gallade', 'Girafarig', 'Snubbull', 'Mantine', 'Ariados', 'Spinarak', 'Misdreavus'}
------------------------------------------------------------------------------------------------------
poke6 = {'Shiny Venusaur', 'Shiny Oddish','Shiny Electrode','Shiny Tentacruel','Shiny Raichu','Shiny Tentacool','Shiny Muk','Shiny Electabuzz', 'Shiny Grimer','Shiny Jynx', 'Shiny Kingler', 'Shiny Blastoise','Shiny Venomoth','Shiny Venonat','Shiny Butterfree','Shiny Parasect','Shiny Paras','Shiny Farfetchd','Shiny Growlithe','Shiny Scyther','Shiny Arcanine','Crystal Onix','Bulbasaur', 'Ivysaur', 'Venusaur', 'chikorita', 'bayleef', 'meganium', 'Ariados', 'cyndaquil','quilava','typhlosion', 'Charmander', 'Charmeleon', 'Charizard', 'Totodile', 'Croconaw', 'Feraligatr', 'Squirtle', 'Wartortle', 'Blastoise', 'Butterfree', 'Pidgeotto',
 'Pidgeot', 'Fearow', 'Arbok', 'Pikachu', 'Raichu', 'Nidorina', 'Nidoqueen', 'Nidorino', 'Nidoking', 'Cleffa', 'Clefairy', 'Clefable', 'Ninetales', 'Jigglypuff', 'igglypuff', 'Wigglytuff', 
 'Golbat', 'Crobat', 'jumpluff', 'Weepinbell', 'Victreebel', 'Paras', 'Parasect', 'Venonat', 'Venomoth', 'Dugtrio', 'Persian', 'Golduck', 'Primeape', 'houndoom', 'Growlithe', 'azumarill', 'Arcanine', 'houndor',  'Poliwhirl', 'Politoed', 'Skiploom', 
 'Poliwrath',  'Alakazam', 'Shiny Abra', 'Kadabra', 'Oddish', 'Gloom', 'Vileplume', 'Machoke', 'Machamp', 'Aipom', 'Tentacool', 'Tentacruel', 'Rapidash', 'Slowpoke', 'Slowbro', 'Slowking', 'Farfetchd',
 'Seel', 'Dewgong', 'Shellder', 'Cloyster', 'Haunter', 'Gengar', 'Onix', 'Hypno', 'Kingler', 'Exeggutor', 'Marowak', 'Hitmonchan', 'Lickitung', 'Koffing', 'Weezing', 'Mantine', 'Marill', 'Natu', 'Noctowl', 'Sentret',
 'Rhydon', 'Tangela', 'Kangaskhan', 'Seadra', 'Kingdra', 'Grimer', 'Muk', 'Dodrio', 'Magneton', 'Electrode', 'Graveler', 'Golem', 'Sandslash', 'Onix', 'Quaqsire',
 'Hitmonchan', 'Lickitung', 'Kofiing', 'Weezing', 'Rhydon', 'Tangela', 'Kangaskhan', 'Goldeen', 'Seaking', 'Granbull', 'Misdreavus', 'Qwilfish',
 'Staryu', 'Starmie', 'MrMime', 'Scyther', 'Jynx', 'Electabuzz', 'Ampharos', 'Magmar', 'Pinsir', 'Tauros', 'Gyarados', 'Miltank', 'Porygon2', 'Scizor', 'Skarmory',
 'Lapras', 'Eevee', 'Vaporeon', 'Jolteon', 'Flareon', 'Porygon', 'Omanyte', 'Omastar', 'Kabuto', 'Hitmontop', 'Mareep', 'Murkrow', 'Remoraid',
 'Kabutops', 'Aerodactyl', 'Snorlax', 'Articuno', 'Zapdos', 'Moltres', 'Dragonair', 'Dragonite', 'Furret', 'Gligar', 'Heracross', 'Octillery', 'Donphan', 'Piloswine', 'Pupitar',
 'Shiny Charizard', 'Crystal Onix', 'Mew', 'Mewtwo', 'Chinchou', 'Snubbull', 'Spinarak', 'Smoochum', 'Sneasel', 'Smeargle', 'Delibird', 'lanturn', 'Donphan', 'Slugma', 'Espeon', 'Flaaffy', 'Gallade', 'Ledian', 'Magcarbo', 'Ledyba', 'Magby', 'Girafarig'}
------------------------------------------------------------------------------------------------------
poke7 = {'Shiny Venusaur', 'Shiny Electrode','Shiny Tentacruel','Shiny Raichu','Shiny Muk','Shiny Jynx', 'Shiny Kingler', 'Shiny Blastoise','Shiny Venomoth','Shiny Venonat','Shiny Butterfree','Shiny Parasect','Shiny Farfetchd','Shiny Growlithe','Shiny Scyther','Shiny Arcanine','Crystal Onix','bulbasaur','ivysaur','venusaur','chikorita', 'Ariados', 'bayleef','meganium','cyndaquil','quilava','typhlosion','Squirtle','Totodile','Croconaw','Feraligatr','wartortle','Blastoise', 'Pidgeot', 'Noctowl',
 'Victreebel', 'Poliwrath', 'azumarill', 'Marill', 'Politoed', 'Skarmory', 'Skiploom',
'Gloom', 'Vileplume', 'jumpluff', 'Seadra', 'kingdra', 'Muk',  'Golbat', 'Crobat',
 'Magneton', 'Electrode', 'Graveler', 'Golem','Pupitar', 'Quaqsire',
'Sandslash', 'Charmander', 'Charmeleon', 'Charizard', 'Kadabra', 'Shiny Abra', 'Alakazam','Butterfree',
 'fearow',  'arbok', 'pikachu', 'raichu',   'nidoqueen', 'Furret', 'Miltank', 'Sentret', 
 'nidoking', 'clefable', 'Ninetales', 'Wigglytuff',  'golbat', 'Granbull', 'Heracross',
 'Parasect', 'Venonat', 'Venomoth',  'Dugtrio', 'Golduck',  'Primeape', 'Mantine',
'Growlithe', 'arcanine', 'houndor', 'houndoom', 'machoke', 'machamp', 'tentacruel',  'Rapidash', 'Hitmontop', 
'Slowbro', 'Slowking', 'Farfetchd', 'dewgong',  'Cloyster', 'haunter', 'gengar', 'onix', 'Misdreavus', 'Octillery', 'Scizor', 
'hypno', 'kingler', 'Exeggcute', 'Exeggutor', 'Marowak', 'Lickitung', 'Koffing',
'Weezing',  'Rhydon', 'Tangela', 'Kangaskhan', 'Seaking', 'Starmie', 'MrMime', 'Gligar', 'Shiny Charizard', 'Porygon2', 
'Scyther', 'Jynx', 'Magmar', 'Pinsir', 'Tauros', 'Lapras', 'eevee', 'Vaporeon', 'Jolteon', 'Flareon', 'Ampharos', 'Flaafy',
'Porygon', 'Omanyte', 'Omastar', 'Kabutops', 'Aerodactyl', 'Snorlax', 'Articuno', 'Zapdos', 'Moltres', 'Phanpy',
 'Dragonite', 'Mew', 'Mewtwo', 'Gyarados', 'lanturn', 'Chinchou', 'Delibird', 'Donphan', 'Smeargle', 'Magby', 'Magcarbo', 'Ledian', 'Espeon', 'Gallade', 'Girafarig'}
------------------------------------------------------------------------------------------------------
poke8 = {'Shiny Venusaur', 'Shiny Tentacruel','Shiny Raichu','Shiny Jynx', 'Shiny Blastoise','Shiny Venomoth','Shiny Venonat','Shiny Butterfree','Shiny Parasect','Shiny Arcanine','Crystal Onix','Bulbasaur', 'Ivysaur', 'Venusaur','chikorita', 'Ariados', 'bayleef','meganium','quilava','typhlosion','gloom', 'Charmeleon', 'Charizard', 'Croconaw', 'Feraligatr', 'Wartortle', 'Blastoise', 'Politoed',
 'Butterfree', 'Fearow', 'Arbok', 'Raichu', 'Nidoqueen', 'Nidoking', 'Clefable', 'Ninetales', 'Wigglytuff', 'Heracross', 'Marill',
 'Vileplume', 'Parasect', 'Venonat', 'Venomoth', 'Dugtrio', 'Golduck', 'Primeape', 'Houndoom', 'Arcanine', 'Poliwrath', 'azumarill', 'Granbull',
 'Kadabra', 'Shiny Abra', 'Alakazam', 'Machamp', 'Victreebel', 'Tentacruel', 'jumpluff', 'Slowbro', 'Slowking', 'Dewgong', 'Cloyster', 'Haunter', 'Misdreavus',
 'Gengar', 'Onix', 'Hypno', 'Exeggutor', 'Marowak', 'Hitmonchan', 'Lickitung', 'Weezing', 'Rhydon', 'Gallade', 'Quaqsire', 'Skarmory',
 'Kangaskhan', 'Seadra', 'kingdra', 'Golem', 'Sandslash', 'Starmie', 'Jinx', 'Pinsir', 'Gyarados', 'Lapras', 'Phanpy',
 'Vaporeon', 'Jolteon', 'Flareon', 'Porygon', 'Omastar', 'Aerodactyl', 'Snorlax', 'Zapdos', 'Dragonite', 'Octillery', 'Porygon2', 'Magcarbo',
 'Shiny Charizard', 'Crystal Onix', 'Jynx', 'Crobat', 'Delibird', 'Donphan', 'Ledian', 'Espeon', 'Hitmontop'}
------------------------------------------------------------------------------------------------------
poke9 = {'Shiny Venusaur', 'Shiny Tentacruel','Shiny Raichu','Shiny Jynx', 'Shiny Blastoise','Shiny Venomoth','Shiny Butterfree','Shiny Parasect','Shiny Arcanine','Crystal Onix','Bulbasaur', 'Ivysaur', 'Venusaur','chikorita','bayleef','meganium','quilava','typhlosion', 'Charizard', 'Feraligatr', 'Blastoise', 'Butterfree', 'Raichu', 
'Nidoqueen', 'Nidoking', 'Clefable', 'jumpluff', 'Victreebel', 'Venomoth', 'Golduck', 'Arcanine', 'Houndoom', 'Poliwrath', 'azumarill','Wigglytuff','Shiny Abra', 'Alakazam', 
'Kadabra', 'Vileplume', 'Tentacruel', 'Haunter', 'Gengar', 'Exeggutor', 'Jynx', 'Lapras', 'Aerodactyl', 'Misdreavus', 'Politoed', 'Magcarbo',
 'Dragonite', 'Shiny Charizard', 'Parasect', 'Espeon', 'Gallade', 'Hitmontop', 'Slowking', 'Ledian', 'Granbull', 'Porygon2'}
------------------------------------------------------------------------------------------------------
poke10 = {'Shiny Venusaur', 'Shiny Blastoise','Shiny Parasect','Shiny Arcanine','Shiny Abra', 'Alakazam','Charizard','meganium','typhlosion','Feraligatr','Blastoise','Dragonite', 'Mew', 'Mewtwo', 'Venusaur', 'Arcanine', 'Houndoom', 'Aerodactyl', 'Alakazan',
 'Parasect', 'Espeon', 'Gallade', 'Shiny Charizard', 'Slowking', 'Magcarbo', 'Granbull'}
------------------------------------------------------------------------------------------------------
poke11 = {'Aerodactyl',  'Mew', 'Mewtwo', 'Gallade'}
------------------------------------------------------------------------------------------------------
poke12 = {'Mew', 'Mewtwo', 'Gallade'}
------------------------------------------------------------------------------------------------------