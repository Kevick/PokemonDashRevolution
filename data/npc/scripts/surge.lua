local focus = 0
local max_distance = 4
local talk_start = 0
local conv = 0
local fighting = false
local challenger = 0
local pokeNpc = nil
local pokeChalenger = nil
local afk_limit_time = 15	-- seconds
local afk_time = 0		-- don't change
local battle_turn = 0		-- don't change
local challenger_turn = 0	-- don't change

local pokemons = {
{name = "Raichu", optionalLevel = 400, sex = SEX_FEMALE, nick = "", ball = "poke"},
{name = "Electrode", optionalLevel = 400, sex = SEX_FEMALE, nick = "", ball = "poke"},
{name = "Electabuzz", optionalLevel = 400, sex = SEX_FEMALE, nick = "", ball = "poke"},
{name = "Ampharos", optionalLevel = 400, sex = SEX_MALE, nick = "", ball = "poke"},
{name = "Lanturn", optionalLevel = 400, sex = SEX_MALE, nick = "", ball = "poke"},
}


local function doSummonGymPokemon(npc)
	battle_turn = battle_turn + 1
	local this = npc
	if #getCreatureSummons(this) >= 1 or focus == 0 then return true end
	local it = pokemons[battle_turn]
	pokeNpc = doSummonCreature(it.name, getThingPos(this))
	local summon = getCreatureSummons(this)[1]
	local balleffect = pokeballs["poke"].effect
	if it.ball and pokeballs[it.ball] then
		balleffect = pokeballs[it.ball].effect
	end
	doSendMagicEffect(getThingPos(pokeNpc), balleffect)

	setPlayerStorageValue(pokeNpc, 990, this)
	setPlayerStorageValue(pokeNpc, 991, "battle")
	setPlayerStorageValue(pokeNpc, 8595, 1)
	registerCreatureEvent(pokeNpc, "Gym1")
    registerCreatureEvent(pokeNpc, "Gym2")
    registerCreatureEvent(pokeNpc, "Gym3")
    registerCreatureEvent(pokeNpc, "Gym4")
	setPlayerStorageValue(this, 990, 1)
	setPlayerStorageValue(this, 995, 1)
	mgo = gobackmsgs[math.random(1, #gobackmsgs)].go:gsub("doka", it.name)
	doCreatureSay(this, mgo, 1)
	fighting = true
end

local function doWinDuel(cid, npc)
	if not isCreature(cid) then return true end
	local this = npc
	local a = gymbadges[getCreatureName(this)].off
	local c = gymbadges[getCreatureName(this)].on
	doCreatureSay(npc, "You won the duel! Congratulations, take this "..getItemNameById(c).." as a prize.", 1)
	local b = getPlayerItemById(cid, true, a)
	if b.uid > 0 then doTransformItem(b.uid, c) end
	setPlayerStorageValue(cid, 994, 1)
end

function onCreatureSay(cid, type, msg)
	local msg = string.lower(msg)

	if focus == cid then
		talk_start = os.clock()
	end

	if msgcontains(msg, 'hi') and focus == 0 and getDistanceToCreature(cid) <= 4 then
		focus = cid
		talk_start = os.clock()
		conv = 1
		selfSay("Hello "..getCreatureName(cid)..", my name is Misty and I'm Cerulean's Gym Leader. How may I help you?")
		return true
	end

	if isDuelMsg(msg) and conv == 1 and focus == cid then
		--if getPlayerItemCount(cid, gymbadges[getCreatureName(getThis())]) >= 1 then
		--	selfSay("You have already won my Cascade Badge, maybe some other day we can fight.")
		--	focus = 0
		--return true
		--end

		-- if not hasPokemon(cid) then
			-- selfSay("To battle agains't a gym leader you need pokemons.")
		-- return true
		-- end

		if getPlayerStorageValue(cid, 994) == 1 then
		    focus = 0
		    selfSay("already battled with you , find another leader of gym!")
		return true
		end

		selfSay("You are challenging me to a battle. It will be a "..#pokemons.." pokemon limit battle, let's start?")
		conv = 2

	return true
	end

	if isConfirmMsg(msg) and conv == 2 and focus == cid then
		challenger = focus
		setPlayerStorageValue(cid, 990, 1)
		if #getCreatureSummons(cid) >= 1 then
		local pk = getCreatureSummons(cid)[1]
		setPlayerStorageValue(pk, 990, 1)
		end
		selfSay("Yea, let's fight!")
		talk_start = os.clock()
		setPlayerStorageValue(getThis(), 990, 1)
		addEvent(doSummonGymPokemon, 5, getThis())
		conv = 3
	return true
	end

	if isNegMsg(msg) and conv == 2 and focus == cid then
		focus = 0
		selfSay("It is better for you to refuse a battle against me!")
	return true
	end

	local function doRemove(npc)
	local it = pokemons[battle_turn]
		local balleffect = pokeballs["normal"].effect
	if it.ball and pokeballs[it.ball] then
		balleffect = pokeballs[it.ball].effect
	end
	doSendMagicEffect(getThingPos(pokeNpc), balleffect)
	doRemoveCreature(pokeNpc)
	end

	if msgcontains(msg, 'bye') and focus == cid then
		selfSay('Bye and do your best trainer!')
		setPlayerStorageValue(focus, 990, -1)
		if #getCreatureSummons(cid) >= 1 then
		local pk = getCreatureSummons(cid)[1]
		setPlayerStorageValue(pk, 990, -1)
		end
		if getPlayerStorageValue(getThis(), 995) >= 1 then
		setPlayerStorageValue(getThis(), 995, -1)
		addEvent(doRemove, 50, this)
		end
		focus = 0
	return true
	end
end

local afk_warning = false

function checkPoke(player, poke)

end

function onThink()

	local function doRemove(npc)
	local it = pokemons[battle_turn]
		local balleffect = pokeballs["normal"].effect
	if it.ball and pokeballs[it.ball] then
		balleffect = pokeballs[it.ball].effect
	end
	doSendMagicEffect(getThingPos(pokeNpc), balleffect)
	doRemoveCreature(pokeNpc)
	end

	if focus == 0 then
		selfTurn(2)
		fighting = false
		challenger = 0
		challenger_turn = 0
		battle_turn = 0
		afk_time = 0
		afk_warning = false
		setPlayerStorageValue(getThis(), 990, -1)
		return true
	else
		if not isCreature(focus) then
			focus = 0
			return true
		end
		if fighting then
			talk_start = os.clock()

			if #getCreatureSummons(challenger) >= 1 then
				if pokeChalenger == nil then
					pokeChalenger = getCreatureName(getCreatureSummons(challenger)[1])
					afk_time = 0
					challenger_turn = challenger_turn + 1
				elseif pokeChalenger == getCreatureName(getCreatureSummons(challenger)[1]) then
					afk_time = 0
				else
					afk_time = 0
					challenger_turn = challenger_turn + 1
					pokeChalenger = getCreatureName(getCreatureSummons(challenger)[1])
				end
			else
					afk_time = afk_time + 0.5
			end

			if afk_time > afk_limit_time then
				if getPlayerStorageValue(getThis(), 995) >= 1 then
			    addEvent(doRemove, 50, this)
			    end
				setPlayerStorageValue(focus, 990, -1)
				focus = 0
				selfSay("I have waited too long, come back when you are ready!")
			return true
			end

			if not afk_warning and afk_time > afk_limit_time / 2 then
				selfSay("Where's your pokemon? Let's fight!")
				afk_warning = true
			end


			if getPlayerStorageValue(getThis(), 990) == 0 then
				if battle_turn >= #pokemons then
					addEvent(doWinDuel, 1000, focus, getThis())
					setPlayerStorageValue(focus, 990, -1)
					focus = 0
				return true
				end
				setPlayerStorageValue(getThis(), 990, 1)
				addEvent(doSummonGymPokemon, 1000, getThis())
			end

			if challenger_turn >= 7 or challenger_turn > #pokemons then
				selfSay("You lost our duel! Maybe some other time you'll defeat me.")
				setPlayerStorageValue(focus, 990, -1)
				if #getCreatureSummons(getThis()) >= 1 then
			    addEvent(doRemove, 50, this)
			    end
				focus = 0
			return true
			end
		end

		local npcpos = getThingPos(getThis())
		local focpos = getThingPos(focus)

		if npcpos.z ~= focpos.z then
			setPlayerStorageValue(focus, 990, -1)
			if #getCreatureSummons(getThis()) >= 1 then
		    addEvent(doRemove, 50, this)
		    end
			focus = 0
			selfSay("Bye then.")
			return true
		end

		if (os.clock() - talk_start) > 15 then
			selfSay("Good bye and keep training!")
			setPlayerStorageValue(focus, 990, -1)
			if #getCreatureSummons(getThis()) >= 1 then
			setPlayerStorageValue(getThis(), 995, -1)
			addEvent(doRemove, 50, this)
			end
			focus = 0
		end

		if getDistanceToCreature(focus) > max_distance then
			setPlayerStorageValue(focus, 990, -1)
			selfSay("tchau gostoso!")
			if #getCreatureSummons(focus) >= 1 then
		local pk = getCreatureSummons(focus)[1]
		setPlayerStorageValue(pk, 990, -1)
		end
		if getPlayerStorageValue(getThis(), 995) >= 1 then
		setPlayerStorageValue(getThis(), 995, -1)
		addEvent(doRemove, 50, this)
		end
			focus = 0
		return true
		end

		local dir = doRedirectDirection(getDirectionTo(npcpos, focpos))
		selfTurn(dir)
	end
return true
end
