pokein, pokeout = 2222,2223
greatin, greatout = 2651,2652
superin, superout = 2653,2654
saffariin, saffariout = 2655,2656
ultrapokein, ultrapokeout = 2220, 2221
aguinha = {'4820', '4821', '4822', '4823', '4824', '4825'}
SummonPos = {x = 877, y = 308, z = 7}
HPperVITsummon = 12.2
HPperVITwild = 13
SEX_MALE = 4
SEX_FEMALE = 3
leaf = 2276
water = 2277
venom = 2278
thunder = 2279
rock = 2280
punch = 2281
fire = 2283
coccon = 2284
crystal = 2285
dark = 2286
earth = 2287
enigma = 2288
heart = 2289
ice = 2290

GenderTable = {
[0] =  "Neutro",
[4] = "Macho",
[3] = "Femea",
}

function doPokemonToPlayer(cid, pokemon, ball, gender)
local balls = {
[1] = "poke",
[2] = "great",
[3] = "super",
[4] = "ultra",
}
    if not pokes[pokemon] then
	    doPlayerSendCancel(cid, "Sorry, a pokemon with the name "..pokemon.." doesn't exists.")
	return true
	end
	
    local btype = pokeballs[balls[math.random(1, #balls)]].on
	if (ball == nil) then
	    ball = btype
	else
	    ball = ball
	end
	
		
	if (gender == nil) then
	    gender = math.random(3, 4)
	else
	    gender = gender
	end
	
	if name == "Nidoran Male" then
		gender = 4
	elseif name == "Nidoran Female" then
		gender = 3
	elseif name == "Dragonite" then
		gender = 0
	elseif name == "Magneton" then
		gender = 0
	end
	
	local ballName = getItemNameById(ball)
	
	icon_on  = false
	if icons[doCorrectPokemonName(pokemon)] then
		ball = icons[doCorrectPokemonName(pokemon)].on
		icon_on  = true
	else
		ball = ball
		icon_on  = false
	end
	
	if #getPlayerPokeballs(cid) >= 6 or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
		item = doCreateItemEx(ball-1)
	else
		item = addItemInFreeBag(getPlayerSlotItem(cid, 3).uid, ball, 1)
	end
	print(pokemon)
	setPokeballInfo(item, pokemon)
	doItemSetAttribute(item, "gender", gender)
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
        doPlayerSendMailByName(getCreatureName(cid), item, 1)
        doPlayerSendTextMessage(cid, 27, "Congratulations, you won a "..pokemon.." ("..GenderTable[gender]..") !")
        doPlayerSendTextMessage(cid, 27, "Since you are already holding six pokemons, this pokeball has been sent to your depot.")
    else
        doPlayerSendTextMessage(cid, 27, "Congratulations, you won a "..pokemon.." ("..GenderTable[gender]..") !")
    end
	
	doUpdatePokemons(cid)
end

function isTransformed(cid)
	if getPlayerStorageValue(cid, 1010) == "Ditto" or not getPlayerStorageValue(cid, 1010) then
	return false                                                                              --edited
	else
	return true
	end
end

function deTransform(cid, check)
	if not isCreature(cid) then return true end

	local m = getCreatureMaster(cid)
	local p = getPlayerSlotItem(m, 8)

	if getItemAttribute(p.uid, "transTurn") ~= check then return true end

	setPlayerStorageValue(cid, 1010, getPokeballInfo(p.uid).name == "Ditto" and "Ditto" or "Shiny Ditto")
	doRemoveCondition(cid, CONDITION_OUTFIT)
	doSendMagicEffect(getThingPos(cid), 184)
	doCreatureSay(cid, "DITTO!", TALKTYPE_MONSTER)
	doItemSetAttribute(p.uid, "transBegin", 0)
	doItemSetAttribute(p.uid, "transLeft", 0)
	doItemEraseAttribute(p.uid, "transName")
end

function doSummonPokemon(cid, name)
return doSummonMonster(cid, name)
end

function doUpdateCreature(cid)
local player = getCreatureMaster(cid)
return doTeleportThing(cid, getClosestFreeTile(cid, getThingPos(player)), false)
end

function doCreatureAddCondition(cid, condition)
if not isCreature(cid) then return true end
doAddCondition(cid, condition)
end

function getPokemonGender(cid)
return getCreatureSkullType(cid)
end

function setPokemonGender(cid, gender)
if isCreature(cid) and gender then        --alterado v2.8
   doCreatureSetSkullType(cid, gender)
   return true
end
return false
end

function getTopCorpse(position)
	local pos = position

		for n = 1, 255 do

			pos.stackpos = n
			local item = getTileThingByPos(pos)

			if item.itemid >= 2 and (string.find(getItemNameById(item.itemid), "fainted ") or string.find(getItemNameById(item.itemid), "defeated ")) then
				return getTileThingByPos(pos)
			end
		end
return null
end

function hasSpaceInContainer(container)                --alterado v1.6
if not isContainer(container) then return false end
if getContainerSize(container) < getContainerCap(container) then return true end

for slot = 0, (getContainerSize(container)-1) do
    local item = getContainerItem(container, slot)
    if isContainer(item.uid) then
       if hasSpaceInContainer(item.uid) then
          return true
       end
    end
end
return false
end

function addItemInFreeBag(container, item, num)
if not isContainer(container) then return false end                                             
if not item then return false end
if not num then num = 1 end                                            --alterado v1.6.1
if getContainerSize(container) < getContainerCap(container) then
   return doAddContainerItem(container, item, num)
else
   for slot = 0, (getContainerSize(container)-1) do
       local container2 = getContainerItem(container, slot)
       if isContainer(container2.uid) and getContainerSize(container2.uid) < getContainerCap(container2.uid) then
          return doAddContainerItem(container2.uid, item, num)
       end
   end
end
return false
end

function doRemoveTile(pos)-- Script by mock
pos.stackpos = 0
local sqm = getTileThingByPos(pos)
doRemoveItem(sqm.uid,1)
end

function doCreateTile(id,pos) -- By mock
doAreaCombatHealth(0,0,pos,0,0,0,CONST_ME_NONE)
doCreateItem(id,1,pos)
end

function hasSqm(pos)
local f = getTileThingByPos(pos)
if f.itemid ~= 0 and f.itemid ~= 1 then
return true
end
return false
end

function getPosDirs(p, dir) -- By MatheusMkalo
return dir == 1 and {x=p.x-1, y=p.y, z=p.z} or dir == 2 and {x=p.x-1, y=p.y+1, z=p.z} or dir == 3 and {x=p.x, y=p.y+1, z=p.z} or dir == 4 and {x=p.x+1, y=p.y+1, z=p.z} or dir == 5 and {x=p.x+1, y=p.y, z=p.z} or dir == 6 and {x=p.x+1, y=p.y-1, z=p.z} or dir == 7 and {x=p.x, y=p.y-1, z=p.z} or dir == 8 and {x=p.x-1, y=p.y-1, z=p.z}
end

function doItem(pos,a,d)-- Script by mock
doCreateTile(460,pos)
pos.stackpos = 0
local c = getTileThingByPos(pos)
doItemSetAttribute(c.uid, "aid", a)
end

function getDescription(uid)
for i,x in pairs(getItemDescriptions(uid)) do
if i == "special" then
return x
end
end
end

function findLetter(string, letter)
for i = 1, #string do
if string:sub(i, i) == letter then
return i
end
end
end

function isWalkable(pos, creature, proj, pz)-- by Nord
if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
if getTopCreature(pos).uid > 0 and creature then return false end
if getTileInfo(pos).protection and pz then return false, true end
local n = not proj and 3 or 2
for i = 0, 255 do
pos.stackpos = i
local tile = getTileThingByPos(pos)
if tile.itemid ~= 0 and not isCreature(tile.uid) then
if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
return false
end
end
end
return true
end

function getPosDirs(p, dir)
return dir == 1 and {x=p.x-1, y=p.y, z=p.z} or dir == 2 and {x=p.x-1, y=p.y+1, z=p.z} or dir == 3 and {x=p.x, y=p.y+1, z=p.z} or dir == 4 and {x=p.x+1, y=p.y+1, z=p.z} or dir == 5 and {x=p.x+1, y=p.y, z=p.z} or dir == 6 and {x=p.x+1, y=p.y-1, z=p.z} or dir == 7 and {x=p.x, y=p.y-1, z=p.z} or dir == 8 and {x=p.x-1, y=p.y-1, z=p.z}
end

function canSummon(cid)
local pos = getCreaturePosition(cid)
local state = false
for i = 1, 8 do
if isWalkable(getPosDirs(getCreaturePosition(cid), i)) then
state = true
end
end
return state
end

function isPlayerSummon(cid, uid)
if getCreatureMaster(uid) == cid then
return TRUE
end
return FALSE
end

function getSummonLifes(cid)
for _,x in pairs(getCreatureSummons(cid)) do
return getCreatureHealth(x), getCreatureMaxHealth(x)
end
end

function BackTeam(cid)
  if isCreature(cid) then
     local summon = getCreatureSummons(cid)   --alterado v1.6
     for i = 2, #summon do
         doSendMagicEffect(getThingPos(summon[i]), 211)
         doRemoveCreature(summon[i])
     end
     setPlayerStorageValue(cid, 637501, -1)
  end
end

function isSummon(sid)
    for i, pid in ipairs(getPlayersOnline()) do
        for c, cid in pairs(getCreatureSummons(pid)) do
            if (cid == sid) then
                return true
            end
        end 
    end
    return false
end 

function getCreaturesInRange(position, radiusx, radiusy, showMonsters, showPlayers)
        local creaturesList = {}
                for x = -radiusx, radiusx do
                        for y = -radiusy, radiusy do
                                if not (x == 0 and y == 0) then
                                        creature = getTopCreature({x = position.x+x, y = position.y+y, z = position.z, stackpos = STACKPOS_TOP_CREATURE})
                                        if (creature.type == 1 and showPlayers == 1) or (creature.type == 2 and showMonsters == 1) then
                                                table.insert(creaturesList, creature.uid)
                                        end
                                end
                        end
                end
return creaturesList
end

function getItemsInContainerById(container, itemid) -- Function By Kydrai
local items = {}
if isContainer(container) and getContainerSize(container) > 0 then
for slot=0, (getContainerSize(container)-1) do
local item = getContainerItem(container, slot)
if isContainer(item.uid) then
local itemsbag = getItemsInContainerById(item.uid, itemid)
for i=0, #itemsbag do
table.insert(items, itemsbag[i])
end
else
if itemid == item.itemid then
table.insert(items, item.uid)
end
end
end
end
return items
end

function doPlayerAddItemStacking(cid, itemid, quant) 
local item = getItemsInContainerById(getPlayerSlotItem(cid, 3).uid, itemid)
local piles = 0
    if #item > 0 then
        for i,x in pairs(item) do
            if getThing(x).type < 100 then
                local it = getThing(x)
                doTransformItem(it.uid, itemid, it.type+quant)
                if it.type+quant > 100 then
                    doPlayerAddItem(cid, itemid, it.type+quant-100)
                end
            else
                piles = piles+1
            end
        break
        end
    else
    return doPlayerAddItem(cid, itemid, quant)
    end
 
    if piles == #item then
        doPlayerAddItem(cid, itemid, quant)
    end
end

function getPokemonXMLAttr(name, attr) 
	local cont = 0
	local txt = nil
	while (not tpw) do
		cont = cont + 1
		path = "data/monster/pokes/"..name..".xml"
		tpw = io.type(io.open(path))
	end
	if  tpw then
		local arq = io.open(path, "a+")
		txt = arq:read("*all")
		arq:close()
		a, b = txt:find(attr..'="(.-)"')
		if a then
			txt = string.sub(txt, a + string.len(attr) + 2, b - 1)
		else
			txt = nil
		end
	else
		return false
	end
		return txt
end

function getSpellWildInfo(name, move)
	local cont = 0
	local txt = nil
	while (not tpw) do
		cont = cont + 1
		path = "data/monster/pokes/"..name..".xml"
		tpw = io.type(io.open(path))
	end
	if  tpw then
		local arq = io.open(path, "a+")
		txt = arq:read("*all")
		arq:close()
	local a, b = txt:find('min="(.-)" key = "'..move..'"')
	local c, d = txt:find('key = "'..move..'" max="(.-)"')
	local min =  string.sub(txt, a + string.len("min") + 2, b - 1)
	local max =  string.sub(txt, c + string.len("max") + 2, d - 1)
	print(max)
	print(min)
	end
end

function doGoPokemon(cid, item, evo)
local ball  = getPokeballType(item.itemid)
local pokeball = pokeballs[ball]
local pokeballInfo = getPokeballInfo(item.uid)                

	local effect = pokeball.effect
	if not effect then
		effect = 21
	end
-----------------------------------------------------------------
-----------------------------------------------------------------
    if item.uid ~= getPlayerSlotItem(cid, CONST_SLOT_FEET).uid then
	    doPlayerSendCancel(cid, "You must put your pokeball in the correct place!")
	return TRUE
    end
	
	if getCD(getPlayerSlotItem(cid, 8).uid, "Anti-BugBall") > 0 then
	return true 
	end

	if tonumber(getItemAttribute(item.uid, "php")) <= tonumber(0) then
		doPlayerSendCancel(cid, "Seu Pokemon esta morto!")
	return true
	end
	
	if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 then
    return doPlayerSendCancel(cid, "You can't use pokeball while flying.")
    end


    if not canSummon(cid) then
    return doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTENOUGHROOM)
    end

    if getPlayerStorageValue(cid, 63215) >= 1 then
    return doPlayerSendCancel(cid, "You can't use pokeball while surfing.")
    end

    if getPlayerStorageValue(cid, 62314) >= 1 then
    return doPlayerSendCancel(cid, "You can't use pokeball while flying.")
    end

    if #getCreatureSummons(cid) >= 1 then
    return doPlayerSendCancel(cid, "You have already summoned a pokemon.")
    end

    for i,x in pairs(pokes) do
        if i == getItemAttribute(item.uid, "poke"):sub(9, findLetter(getItemAttribute(item.uid, "poke"), "'")-1) then
            if getPlayerLevel(cid) < x.level then
                doPlayerSendCancel(cid, "You need level "..x.level.." or higher to use this pokemon.")
            return true
            end
				
            local removed = doCreateItem(1285, 1, getThingPos(cid))
            doSummonMonster(cid, i)
	
			local pk = getCreatureSummons(cid)[1]
			local nick = getItemAttribute(item.uid, "nick")

			if not nick then
				if pokeballInfo.nick then
					doCreatureSetNick(pk)
				end
			else
				doCreatureSetNick(pk, nick)
			end
				
			local gender = getItemAttribute(item.uid, "gender") or 0
			doCreatureSetSkullType(pk, gender)

			if getItemAttribute(item.uid, "happy") then
				setPlayerStorageValue(pk, 66604, (getItemAttribute(item.uid, "happy") or 0))
			end

			if pokeballInfo.name == "Ditto" then --edited
				local left = getItemAttribute(item.uid, "transLeft")
				local name = getItemAttribute(item.uid, "transName")
				if left and left > 0 then
					setPlayerStorageValue(pk, 1010, name)
					doSetCreatureOutfit(pk, {lookType = getItemAttribute(item.uid, "transOutfit")}, -1)
					addEvent(deTransform, left * 1000, pk, getItemAttribute(item.uid, "transTurn"))
					doItemSetAttribute(item.uid, "transBegin", os.clock())
				else
					setPlayerStorageValue(pk, 1010, getCreatureName(pk) == "Ditto" and "Ditto" or "Shiny Ditto")     --edited
				end
			else
				setPlayerStorageValue(pk, 1010, pokeballInfo.name)
			end
				
            doRemoveItem(removed, 1)
            doCreatureSetLookDir(pk, 2)
            doConvinceCreature(cid, pk)
			setPlayerStorageValue(pk, 11226, level_poke)
			setPokemonStatus(pk, true, true)
			if getItemAttribute(item.uid, "iconsystem") == "on" then
				doTransformItem(item.uid, pokeballs[pokeballInfo.name].use)
			else
				doTransformItem(item.uid, item.itemid+1)
			end

            local pokename = pokeballInfo.nick
            local mgo = gobackmsgs[math.random(1, #gobackmsgs)].go:gsub("doka", pokename)
            doCreatureSay(cid, mgo, TALKTYPE_SAY)
            doItemSetAttribute(item.uid, "poke", getItemAttribute(item.uid, "poke"):sub(1, findLetter(getItemAttribute(item.uid, "poke"), ".")))
            doItemSetAttribute(item.uid, "php", (getCreatureHealth(pk) / getCreatureMaxHealth(pk)))
			if evo == true then
				doSendMagicEffect(getThingPos(pk), 173)
			else
				sendBallEffect(cid)
			end
            setPlayerStorageValue(cid, 61204, 1)
			doUpdatePokemons(cid)
			doUpdateStatusPoke(cid)
			doUpdateCds(cid)
			getHappinesStatus(pk, true)
			setCD(getPlayerSlotItem(cid, 8).uid, "Anti-BugBall", 1)
			if getItemAttribute(item.uid, "isSleep") == true then
				doSleep(pk)
			elseif getItemAttribute(item.uid, "isConfusion") == true then
				doConfusion(pk)
			end
        break
        end
    end
end

function doReturnPokemon(cid, evo)
local item = getPlayerSlotItem(cid, 8)
local ball  = getPokeballType(getPlayerSlotItem(cid, 8).itemid)
local pokeball = pokeballs[ball]
local pokeballInfo = getPokeballInfo(getPlayerSlotItem(cid, 8).uid)
	
	
    if #getCreatureSummons(cid) >= 1 and getPlayerStorageValue(getCreatureSummons(cid)[1], 33) >= 1 then
    return true
    end
	
    if item.itemid == pokeball.use then
	    checkDuel(cid)  
		
		if getCD(getPlayerSlotItem(cid, 8).uid, "Anti-BugBall") > 0 then
		return true 
		end
		
		if getPlayerStorageValue(cid, 888) == 1 then -- GYM
		    doPlayerSendCancel(cid, "You can't return your pokemon during Control Mind.")
	    return true
	    end
		
		if getPlayerStorageValue(cid, 990) == 1 then -- GYM
		    doPlayerSendCancel(cid, "You can't return your pokemon during gym battles.")
	    return true
	    end
		
		if #getCreatureSummons(cid) > 1 and getPlayerStorageValue(cid, 212124) <= 0 then     
            if getPlayerStorageValue(cid, 637501) == -2 or getPlayerStorageValue(cid, 637501) >= 1 then
                BackTeam(cid)
            end
        end
		
		local Gstr = 0
		if getItemAttribute(item.uid, "gender") == SEX_FEMALE then
			Gstr = 4
		else
			Gstr = Gstr
		end 
		
        if #getCreatureSummons(cid) >= 1 then
            local z = getCreatureSummons(cid)[1]
            local pokename = pokeballInfo.nick
            local mbk = gobackmsgs[math.random(1, #gobackmsgs)].back:gsub("doka", pokename)
                if pokeballInfo.name then
				    if getItemAttribute(item.uid, "iconsystem") == "on" then
						doTransformItem(item.uid, pokeballs[pokeballInfo.name].on)
					else
						doTransformItem(item.uid, item.itemid-1)
					end
					if isSleep(z) then
						doItemSetAttribute(item.uid, "isSleep", true)
				    else
						doItemSetAttribute(item.uid, "isSleep", false)
					end
					if isConfusion(z) then
						doItemSetAttribute(item.uid, "isConfusion", true)
				    else
						doItemSetAttribute(item.uid, "isConfusion", false)
					end
                    doCreatureSay(cid, mbk, TALKTYPE_SAY)
                    setPokeballInfo(item.uid, pokeballInfo.name, getCreatureHealth(z), getCreatureMaxHealth(z))
					doItemSetAttribute(item.uid, "php", (getCreatureHealth(z) / getCreatureMaxHealth(z)))
					doItemSetAttribute(item.uid, "happy", (getPlayerStorageValue(z, 66604) or 0 ))
					setPlayerStorageValue(cid, 61204, 0)
                    setPlayerStorageValue(cid, 2, 0)
					if evo == true then
						doSendMagicEffect(getThingPos(z), 173)
					else
						sendBallEffect(cid)
					end
                    doRemoveCreature(z)
					doUpdatePokemons(cid)
					doPlayerSendCancel(cid, "@H|Hide")
					doPlayerSendCancel(cid, "@M|hide")
					doPlayerSendCancel(cid, nil)
					setCD(getPlayerSlotItem(cid, 8).uid, "Anti-BugBall", 1)
                return true
                end
        end
	end
end

function ehMonstro(cid)
if not isPlayer(cid) and not isSummon(cid) and not isNpc(cid) then
return true
end                                                   --function pro exp.lua...
return false
end

function canAttackOther(cid, pid)         --Function q verifica se um poke/player pode atacar outro poke/player

if not isCreature(cid) or not isCreature(pid) then return "Cant" end

local master1 = isSummon(cid) and getCreatureMaster(cid) or cid
local master2 = isSummon(pid) and getCreatureMaster(pid) or pid

   --alterado v1.6.1 Party system agora eh simplismente party system kk
   
   ----              --alterado v1.6 duel system
   if getPlayerStorageValue(master1, 6598754) >= 5 and getPlayerStorageValue(master2, 6598754) >= 5 then
      if getPlayerStorageValue(master1, 6598754) ~= getPlayerStorageValue(master2, 6598754) then
         if getPlayerStorageValue(master1, 52482) == getCreatureName(master2) and getPlayerStorageValue(master2, 52482) == getCreatureName(master1) then
            if isSummon(cid) and isPlayer(pid) then
               return "Cant"
            else
               return "Can"
            end
         end
      end
   end
   ----              pvp system
   if getPlayerStorageValue(master1, 6598754) >= 1 and getPlayerStorageValue(master2, 6598755) >= 1 then
      return "Can" 
   end
   if getPlayerStorageValue(master1, 6598755) >= 1 and getPlayerStorageValue(master2, 6598754) >= 1 then  ---estar em times diferentes
      return "Can"
   end
   ----
   if ehMonstro(cid) or ehMonstro(pid) then
      return "Can"
   end

return "Cant"
end

function doCorrectPokemonName(poke)
return doCorrectString(poke)
end

function doCorrectString(poke)
local name = ""
	local n = string.explode(poke, " ")
	local str = string.sub(n[1], 1, 1)
	local sta = string.sub(n[1], 2, string.len(n[1]))
	name = ""..string.upper(str)..""..string.lower(sta)..""
	if n[2] then
	str = string.sub(n[2], 1, 1)
	sta = string.sub(n[2], 2, string.len(n[2]))
	name = name.." "..string.upper(str)..""..string.lower(sta)..""
	end
	if n[3] then
	str = string.sub(n[3], 1, 1)
	sta = string.sub(n[3], 2, string.len(n[3]))
	name = name.." "..string.upper(str)..""..string.lower(sta)..""
	end
return name
end

function isStone(uid)
if uid >= leaf and uid <= punch then
return true
end
if uid >= fire and uid <= ice then
return true
end
return false
end

function doSetItemAttribute(item, key, value)
doItemSetAttribute(item, key, value)
end

function getHappinesStatus(cid, check)
	if isSummon(cid) then
		if getPlayerStorageValue(cid, 66604) >= 150 then
		    if check then
				doSendMagicEffect(getCreaturePosition(cid), 170)
			end
		elseif getPlayerStorageValue(cid, 66604) <= 50 and getPlayerStorageValue(cid, 66604) >= 11 then
			doSendMagicEffect(getCreaturePosition(cid), 169)
			doPlayerSendCancel(getCreatureMaster(cid), "Seu Pokemon esta com Fome!")
		elseif getPlayerStorageValue(cid, 66604) <= 10 then
			doSendMagicEffect(getCreaturePosition(cid), 168)
			doPlayerSendCancel(getCreatureMaster(cid), "Seu Pokemon esta com Muita Fome!")
		end
	end
end

function setPokemonStatus(cid, health, vite)
    local owner = getCreatureMaster(cid)
	local Gstr = 0
	if getItemAttribute(getPlayerSlotItem(owner, 8).uid, "gender") == SEX_FEMALE then
		Gstr = 4
	else
		Gstr = Gstr
	end

	if vite == true then
		local maxh = pokes[getCreatureName(cid)].cons *((getPlayerLevel(owner) / 1.5) + getBoost(owner) + Gstr)
		local pct = ((getCreatureHealth(cid)) / (getCreatureMaxHealth(cid)))
		setCreatureMaxHealth(cid, ( maxh + pokes[getCreatureName(cid)].vida ))
		doCreatureAddHealth(cid, pct * (maxh + pokes[getCreatureName(cid)].vida))
	end
	
	if health == true then
		local maxh = pokes[getCreatureName(cid)].cons * ((getPlayerLevel(owner) / 1.5) + getBoost(owner) + Gstr)
		local rd = 1 - (tonumber(getItemAttribute(getPlayerSlotItem(owner, 8).uid, "php")))
		setCreatureMaxHealth(cid, maxh + pokes[getCreatureName(cid)].vida)
		doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
		--doCreatureAddHealth(cid, -(getCreatureMaxHealth(cid) * rd))
	end
return true
end

function getSpellType(type)
	if type == "flying" then
		elementa = FLYDAMAGE
	elseif type== "ground" then
		elementa = GROUNDDAMAGE
	elseif type == "electric" then
		elementa = ELECTRICDAMAGE
	elseif type == "ghost" then
		elementa = GHOSTDAMAGE
	elseif type == "normal" then
		elementa = NORMALDAMAGE
	elseif type == "fighting" then
		elementa = FIGHTINGDAMAGE
	elseif type == "poison" then
		elementa = POISONDAMAGE
	elseif type == "rock" then
		elementa = ROCKDAMAGE
	elseif type == "bug" then
		elementa = BUGDAMAGE
	elseif type == "fire" then
		elementa = FIREDAMAGE
	elseif type == "water" then
		elementa = WATERDAMAGE
	elseif type == "grass" then
		elementa = GRASSDAMAGE
	elseif type == "psychic" then
		elementa = PSYCHICDAMAGE
	elseif type == "ice" then
		elementa = ICEDAMAGE
	elseif type == "dragon" then
		elementa = DRAGONDAMAGE
	end
return elementa
end

local function getThingName(cid)
if not isCreature(cid) then return "" end   --alterado v1.6
return getCreatureName(cid)
end

function getPokemonSpellInfo(cid, spell, level)
	if getThingName(cid) == "Ditto" and pokes[getPlayerStorageValue(cid, 1010)] and getPlayerStorageValue(cid, 1010) ~= "Ditto" then
		name = getPlayerStorageValue(cid, 1010)
	else
		name = getThingName(cid)
	end
	if not level then
		level = pokes[getCreatureName(cid)].level
	else
		level = level
	end
	local x = PokeMoves[name]
	if not x then return "" end
	local z = {x.move1, x.move2, x.move3, x.move4, x.move5, x.move6, x.move7, x.move8, x.move9, x.move10, x.move11, x.move12}
	local dano1 = 0
	local dano2 = 0
	for j = 1, 15 do
		if z[j] and z[j].spell == spell then
			local num1 = (z[j].base1 / 5)
			local num2 = (z[j].base2 / 5)
			local num3 = (z[j].bonus / 5)
			if getPlayerStorageValue(cid, 254) >= 1 then
				num3 = num3 * 1.8
			setPlayerStorageValue(cid, 254, 0)
			end
			setPlayerStorageValue(cid, 1000, ((num1)+(level*(num3))))
			
			
			local Gstr = 0
			if getPokemonGender(cid) == SEX_MALE then
				Gstr = 2
			else
				Gstr = Gstr
			end 
			
			dano1 = (num1+((level+Gstr)*num3))
			dano2 = (num2+((level+Gstr)*num3))
			elementa = getSpellType(z[j].type)
		end
	end
return {min = dano1, max = dano2, element = elementa}
end

function doAppear(cid)    --Faz um poke q tava invisivel voltar a ser visivel...
if not isCreature(cid) then return true end
	doRemoveCondition(cid, CONDITION_INVISIBLE)
    doRemoveCondition(cid, CONDITION_OUTFIT)
	doCreatureSetHideHealth(cid, false)
	if getCreatureName(cid) == "Ditto" and pokes[getPlayerStorageValue(cid, 1010)] and getPlayerStorageValue(cid, 1010) ~= "Ditto" then
       if isSummon(cid) then
          local item = getPlayerSlotItem(getCreatureMaster(cid), 8)
          doSetCreatureOutfit(cid, {lookType = getItemAttribute(item.uid, "transOutfit")}, -1)   --alterado v1.6.1
       end
    end 
end

function doDisapear(cid)   --Faz um pokemon ficar invisivel
if not isCreature(cid) then return true end
doCreatureAddCondition(cid, permanentinvisible)
doCreatureSetHideHealth(cid, true)
doSetCreatureOutfit(cid, {lookType = 400}, -1)
end

function isGhostPokemon(cid)
	if not isCreature(cid) then return false end
	local ghosts = {"Gastly", "Haunter", "Gengar", "Shiny Gengar", "Misdreavus", "Shiny Abra"}
return isInArray(ghosts, getCreatureName(cid))
end


function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function getItemsFromList(items) -- by vodka
	local str = ''
	if table.maxn(items) > 0 then
		for i = 1, table.maxn(items) do
			str = str .. items[i][2] .. ' ' .. getItemNameById(items[i][1])
			if i ~= table.maxn(items) then str = str .. ', ' end 
		end 
	end
return str
end

function doAddItemsFromList(cid,items) -- by vodka
	if table.maxn(items) > 0 then
		for i = 1, table.maxn(items) do
			local count = items[i][2]
			while count > 0 do
				if isItemStackable(items[i][1]) then
					doPlayerAddItemStacking(cid, items[i][1], 1)
				else
					doPlayerAddItem(cid, items[i][1],1)
				end
				count = count - 1
			end
		end
	end
end

function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0
	local iter = function ()
	i = i + 1
	if a[i] == nil then return nil
	else return a[i], t[a[i]]
	end
	end
return iter
end

bpslot = CONST_SLOT_BACKPACK

function hasPokemon(cid)
	if not isCreature(cid) then return false end
	if getCreatureMana(cid) <= 0 then return false end
	if #getCreatureSummons(cid) >= 1 then return true end
	local item = getPlayerSlotItem(cid, CONST_SLOT_FEET)
	local bp = getPlayerSlotItem(cid, bpslot)
	for a, b in pairs (pokeballs) do
        if item.itemid == b.on or item.itemid == b.use then
        return true                              --alterado v1.4
        end
        if #getItemsInContainerById(bp.uid, b.on) >= 1 then
        return true
        end
	end
return false
end

function selfAttackCreature()
	if #getCreatureSummons(getNpcCid()) > 0 and not isCreature(getCreatureTarget(getCreatureSummons(getNpcCid())[1])) then
		local list = getSpectators(getCreaturePosition(getNpcCid()), 7, 7, false)
		for i=0, table.getn(list) do
			local _target = list[i]
			if(_target ~= 0) then
				if isPlayer(_target) and not getTileInfo(getThingPos(_target)).protection then
					if #getCreatureSummons(_target) > 0 then
						doMonsterSetTarget(getCreatureSummons(getNpcCid())[1], getCreatureSummons(_target)[1])
						setPlayerStorageValue(getCreatureSummons(getNpcCid())[1], 99856201, getNpcCid())
					else
					  fighting = false
					end
					target = _target
					break
				end
			end
		end
	end
end