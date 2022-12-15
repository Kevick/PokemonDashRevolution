local ballslot = 11409
local ballslot_run = 11406

local stoneslot = 11408
local stoneslot_run = 11407

local button = 11410
local button_run = 11411

function isRunning(id)
	if isInArray({button_run, stoneslot_run, ballslot_run}, id) then
	return true
	end
return false
end

boost_stones = {
["Bulbasaur"] = {leaf},
["Ivysaur"] = {leaf},
["Venusaur"] = {leaf},
["Charmander"] = {fire},
["Charmeleon"] = {fire},
["Charizard"] = {fire},
["Squirtle"] = {water},
["Wartortle"] = {water},
["Blastoise"] = {water},
["Caterpie"] = {coccon},
["Metapod"] = {coccon},
["Butterfree"] = {coccon},
["Weedle"] = {coccon},
["Kakuna"] = {coccon},
["Beedrill"] = {coccon},
["Pidgey"] = {heart},
["Pidgeotto"] = {heart},
["Pidgeot"] = {heart},
["Rattata"] = {heart},
["Raticate"] = {heart},
["Spearow"] = {heart},
["Fearow"] = {heart},
["Ekans"] = {venom},
["Arbok"] = {venom},
["Pikachu"] = {thunder},
["Raichu"] = {thunder},
["Sandshrew"] = {earth},
["Sandslash"] = {earth},
["Nidoran Female"] = {venom},
["Nidorina"] = {venom},
["Nidoqueen"] = {venom, earth},
["Nidoran Male"] = {venom},
["Nidorino"] = {venom},
["Nidoking"] = {venom, earth},
["Clefairy"] = {heart},
["Clefable"] = {heart},
["Vulpix"] = {fire},
["Ninetales"] = {fire},
["Jigglypuff"] = {heart},
["Wigglytuff"] = {heart},
["Zubat"] = {venom},
["Golbat"] = {venom},
["Oddish"] = {leaf, venom},
["Gloom"] = {leaf, venom},
["Vileplume"] = {leaf, venom},
["Paras"] = {coccon, leaf},
["Parasect"] = {coccon, leaf},
["Venonat"] = {coccon, venom},
["Venomoth"] = {coccon, venom},
["Diglett"] = {earth},
["Dugtrio"] = {earth},
["Meowth"] = {heart},
["Persian"] = {heart},
["Psyduck"] = {water},
["Golduck"] = {water, enigma},
["Mankey"] = {punch},
["Primeape"] = {punch},
["Growlithe"] = {fire},
["Arcanine"] = {fire},
["Poliwag"] = {water},
["Poliwhirl"] = {water},
["Poliwrath"] = {water, punch},
["Abra"] = {enigma},
["Kadabra"] = {enigma},
["Alakazam"] = {enigma},
["Machop"] = {punch},
["Machoke"] = {punch},
["Machamp"] = {punch},
["Bellsprout"] = {leaf, venom},
["Weepinbell"] = {leaf, venom},
["Victreebel"] = {leaf, venom},
["Tentacool"] = {water, venom},
["Tentacruel"] = {water, venom},
["Geodude"] = {earth, rock},
["Graveler"] = {earth, rock},
["Golem"] = {earth, rock},
["Ponyta"] = {fire},
["Rapidash"] = {fire},
["Slowpoke"] = {water, enigma},
["Slowbro"] = {water, enigma},
["Magnemite"] = {thunder},
["Magneton"] = {thunder},
["Farfetch'd"] = {heart},
["Doduo"] = {heart},
["Dodrio"] = {heart},
["Seel"] = {water, ice},
["Dewgong"] = {water, ice},
["Grimer"] = {venom},
["Muk"] = {venom},
["Shellder"] = {water, ice},
["Cloyster"] = {water, ice},
["Gastly"] = {dark},
["Haunter"] = {dark},
["Gengar"] = {dark},
["Onix"] = {rock, earth},
["Drowzee"] = {enigma},
["Hypno"] = {enigma},
["Krabby"] = {water},
["Kingler"] = {water},
["Voltorb"] = {thunder},
["Electrode"] = {thunder},
["Exeggcute"] = {enigma, leaf},
["Exeggutor"] = {enigma, leaf},
["Cubone"] = {earth},
["Marowak"] = {earth},
["Hitmonlee"] = {punch},
["Hitmonchan"] = {punch},
["Lickitung"] = {heart},
["Koffing"] = {venom},
["Weezing"] = {venom},
["Rhyhorn"] = {earth, rock},
["Rhydon"] = {earth, rock},
["Chansey"] = {heart},
["Tangela"] = {leaf},
["Kangaskhan"] = {heart},
["Horsea"] = {water},
["Seadra"] = {water},
["Goldeen"] = {water},
["Seaking"] = {water},
["Staryu"] = {water},
["Starmie"] = {water},
["Mr. Mime"] = {enigma},
["Scyther"] = {coccon},
["Jynx"] = {enigma, ice},
["Electabuzz"] = {thunder},
["Magmar"] = {fire},
["Pinsir"] = {coccon},
["Tauros"] = {heart},
["Magikarp"] = {water},
["Gyarados"] = {water, crystal},
["Lapras"] = {water, ice},
["Ditto"] = {heart},
["Eevee"] = {heart},
["Vaporeon"] = {water},
["Jolteon"] = {thunder},
["Flareon"] = {fire},
["Porygon"] = {heart, enigma},
["Omanyte"] = {rock, water},
["Omastar"] = {rock, water},
["Kabuto"] = {rock, water},
["Kabutops"] = {rock, water},
["Aerodactyl"] = {rock},
["Snorlax"] = {heart},
["Articuno"] = {ice},
["Zapdos"] = {thunder},
["Moltres"] = {fire},
["Dratini"] = {crystal},
["Dragonair"] = {crystal},
["Dragonite"] = {crystal},
["Mewtwo"] = {enigma},
["Mew"] = {enigma},
--
["Shiny Bulbasaur"] = {leaf},
["Shiny Ivysaur"] = {leaf},
["Shiny Venusaur"] = {leaf},
["Shiny Charmander"] = {fire},
["Shiny Charmeleon"] = {fire},
["Shiny Charizard"] = {fire},
["Shiny Squirtle"] = {water},
["Shiny Wartortle"] = {water},
["Shiny Blastoise"] = {water},
["Shiny Caterpie"] = {coccon},
["Shiny Metapod"] = {coccon},
["Shiny Butterfree"] = {coccon},
["Shiny Weedle"] = {coccon},
["Shiny Kakuna"] = {coccon},
["Shiny Beedrill"] = {coccon},
["Shiny Pidgey"] = {heart},
["Shiny Pidgeotto"] = {heart},
["Shiny Pidgeot"] = {heart},
["Shiny Rattata"] = {heart},
["Shiny Raticate"] = {heart},
["Shiny Spearow"] = {heart},
["Shiny Fearow"] = {heart},
["Shiny Ekans"] = {venom},
["Shiny Arbok"] = {venom},
["Shiny Pikachu"] = {thunder},
["Shiny Raichu"] = {thunder},
["Shiny Sandshrew"] = {earth},
["Shiny Sandslash"] = {earth},
["Shiny Nidoran Female"] = {venom},
["Shiny Nidorina"] = {venom},
["Shiny Nidoqueen"] = {venom, earth},
["Shiny Nidoran Male"] = {venom},
["Shiny Nidorino"] = {venom},
["Shiny Nidoking"] = {venom, earth},
["Shiny Clefairy"] = {heart},
["Shiny Clefable"] = {heart},
["Shiny Vulpix"] = {fire},
["Shiny Ninetales"] = {fire},
["Shiny Jigglypuff"] = {heart},
["Shiny Wigglytuff"] = {heart},
["Shiny Zubat"] = {venom},
["Shiny Golbat"] = {venom},
["Shiny Oddish"] = {leaf, venom},
["Shiny Gloom"] = {leaf, venom},
["Shiny Vileplume"] = {leaf, venom},
["Shiny Paras"] = {coccon, leaf},
["Shiny Parasect"] = {coccon, leaf},
["Shiny Venonat"] = {coccon, venom},
["Shiny Venomoth"] = {coccon, venom},
["Shiny Diglett"] = {earth},
["Shiny Dugtrio"] = {earth},
["Shiny Meowth"] = {heart},
["Shiny Persian"] = {heart},
["Shiny Psyduck"] = {water},
["Shiny Golduck"] = {water, enigma},
["Shiny Mankey"] = {punch},
["Shiny Primeape"] = {punch},
["Shiny Growlithe"] = {fire},
["Shiny Arcanine"] = {fire},
["Shiny Poliwag"] = {water},
["Shiny Poliwhirl"] = {water},
["Shiny Poliwrath"] = {water, punch},
["Shiny Abra"] = {enigma},
["Shiny Kadabra"] = {enigma},
["Shiny Alakazam"] = {enigma},
["Shiny Machop"] = {punch},
["Shiny Machoke"] = {punch},
["Shiny Machamp"] = {punch},
["Shiny Bellsprout"] = {leaf, venom},
["Shiny Weepinbell"] = {leaf, venom},
["Shiny Victreebel"] = {leaf, venom},
["Shiny Tentacool"] = {water, venom},
["Shiny Tentacruel"] = {water, venom},
["Shiny Geodude"] = {earth, rock},
["Shiny Graveler"] = {earth, rock},
["Shiny Golem"] = {earth, rock},
["Shiny Ponyta"] = {fire},
["Shiny Rapidash"] = {fire},
["Shiny Slowpoke"] = {water, enigma},
["Shiny Slowbro"] = {water, enigma},
["Shiny Magnemite"] = {thunder},
["Shiny Magneton"] = {thunder},
["Shiny Farfetch'd"] = {heart},
["Shiny Doduo"] = {heart},
["Shiny Dodrio"] = {heart},
["Shiny Seel"] = {water, ice},
["Shiny Dewgong"] = {water, ice},
["Shiny Grimer"] = {venom},
["Shiny Muk"] = {venom},
["Shiny Shellder"] = {water, ice},
["Shiny Cloyster"] = {water, ice},
["Shiny Gastly"] = {dark},
["Shiny Haunter"] = {dark},
["Shiny Gengar"] = {dark},
["Shiny Onix"] = {rock, earth},
["Shiny Drowzee"] = {enigma},
["Shiny Hypno"] = {enigma},
["Shiny Krabby"] = {water},
["Shiny Kingler"] = {water},
["Shiny Voltorb"] = {thunder},
["Shiny Electrode"] = {thunder},
["Shiny Exeggcute"] = {enigma, leaf},
["Shiny Exeggutor"] = {enigma, leaf},
["Shiny Cubone"] = {earth},
["Shiny Marowak"] = {earth},
["Shiny Hitmonlee"] = {punch},
["Shiny Hitmonchan"] = {punch},
["Shiny Hitmontop"] = {punch}, --alterado v1.4
["Shiny Lickitung"] = {heart},
["Shiny Koffing"] = {venom},
["Shiny Weezing"] = {venom},
["Shiny Rhyhorn"] = {earth, rock},
["Shiny Rhydon"] = {earth, rock},
["Shiny Chansey"] = {heart},
["Shiny Tangela"] = {leaf},
["Shiny Kangaskhan"] = {heart},
["Shiny Horsea"] = {water},
["Shiny Seadra"] = {water},
["Shiny Goldeen"] = {water},
["Shiny Seaking"] = {water},
["Shiny Staryu"] = {water},
["Shiny Starmie"] = {water},
["Shiny Mr. Mime"] = {enigma},
["Shiny Scyther"] = {coccon},
["Shiny Jynx"] = {enigma, ice},
["Shiny Electabuzz"] = {thunder},
["Shiny Magmar"] = {fire},
["Shiny Pinsir"] = {coccon},
["Shiny Tauros"] = {heart},
["Shiny Magikarp"] = {water},
["Shiny Gyarados"] = {water, crystal},
["Shiny Lapras"] = {water, ice},
["Shiny Ditto"] = {heart},
["Shiny Eevee"] = {heart},
["Shiny Vaporeon"] = {water},
["Shiny Jolteon"] = {thunder},
["Shiny Flareon"] = {fire},
["Shiny Porygon"] = {heart, enigma},
["Shiny Omanyte"] = {rock, water},
["Shiny Omastar"] = {rock, water},
["Shiny Kabuto"] = {rock, water},
["Shiny Kabutops"] = {rock, water},
["Shiny Aerodactyl"] = {rock},
["Shiny Snorlax"] = {heart},
["Shiny Articuno"] = {ice},
["Shiny Zapdos"] = {thunder},
["Shiny Moltres"] = {fire},
["Shiny Dratini"] = {crystal},
["Shiny Dragonair"] = {crystal},
["Shiny Dragonite"] = {crystal},
["Shiny Mewtwo"] = {enigma},
["Shiny Mew"] = {enigma},
--
["Chikorita"] = {leaf},
["Bayleef"] = {leaf},
["Meganium"] = {leaf},
["Cyndaquil"] = {fire},
["Quilava"] = {fire},
["Typhlosion"] = {fire},
["Totodile"] = {water},
["Croconaw"] = {water},
["Feraligatr"] = {water},
["Sentret"] = {heart},
["Furret"] = {heart},
["Hoothoot"] = {heart, enigma},
["Noctowl"] = {heart, enigma},
["Ledyba"] = {coccon},
["Ledian"] = {coccon},
["Spinarak"] = {coccon, venom},
["Ariados"] = {coccon, venom},
["Crobat"] = {venom},
["Chinchou"] = {water, thunder},
["Lanturn"] = {water, thunder},
["Pichu"] = {thunder},
["Cleffa"] = {heart},
["Iglybuff"] = {venom},
["Natu"] = {enigma},
["Xatu"] = {enigma},
["Mareep"] = {thunder},
["Flaaffy"] = {thunder},
["Ampharos"] = {thunder},
["Bellossom"] = {leaf},
["Marill"] = {water},
["Azulmarill"] = {water},
["Sudowoodo"] = {rock, earth},
["Politoed"] = {water, earth},
["Hoppip"] = {leaf},
["Skiploom"] = {leaf},
["Jumpluff"] = {leaf},
["Aipom"] = {heart},
["Sunkern"] = {leaf},
["Sunflora"] = {leaf},
["Yanma"] = {venom, coccon},
["Wooper"] = {water},
["Quagsire"] = {water, earth},
["Murkrow"] = {dark},
["Slowking"] = {water,enigma},
["Misdreavus"] = {dark},
["Wobbuffet"] = {enigma},
["Girafarig"] = {enigma},
["Pineco"] = {coccon},
["Forretress"] = {coccon},
["Gligar"] = {dark, heart},
["Steelix"] = {earth, rock},
["Snubbull"] = {heart},
["Granbull"] = {heart},
["Qwilfish"] = {water},
["Shuckle"] = {earth},
["Heracross"] = {coccon},
["Teddiursa"] = {heart},
["Ursaring"] = {heart, dark},
["Slugma"] = {fire},
["Magcargo"] = {fire},
["Swinub"] = {ice, earth},
["Piloswine"] = {ice, earth},
["Corsola"] = {water},
["Remoraid"] = {water},
["Octillery"] = {water},
["Delibird"] = {ice, heart},
["Mantine"] = {water},
["Skarmory"] = {heart},
["Houndour"] = {fire, dark},
["Houndoom"] = {fire, dark},
["Kingdra"] = {water, crystal},
["Phanpy"] = {earth},
["Donphan"] = {earth},
["porygon2"] = {enigma},
["Stantler"] = {heart},
["Smeargle"] = {heart},
["Tyrogue"] = {punch},
["Hitmontop"] = {punch},
["Smoochum"] = {ice, enigma},
["Elekid"] = {thunder},
["Magby"] = {fire},
["Miltank"] = {heart},
["Blissey"] = {heart},
["Raikou"] = {thunder},
["Entei"] = {fire},
["Suicune"] = {water},
["Larvitar"] = {earth, dark},
["Pupitar"] = {earth, dark},
["Tyranitar"] = {earth, dark},
["Lugia"] = {enigma, water},
["Ho-oh"] = {enigma, fire},
["Celebi"] = {leaf, enigma}
}

function doRestoreBoostMachine(cid, b_pos, p_pos, s_pos, msg, msg2)

	doSendAnimatedText(b_pos, "DONE.", 1)

	if isCreature(cid) then
		doCreatureSetNoMove(cid, false)
		doPlayerSendTextMessage(cid, 27, msg)
		doPlayerSendTextMessage(cid, 27, msg2)
	end

	local ball_s = getTileItemById(p_pos, ballslot_run)
	doTransformItem(ball_s.uid, ballslot)

	local stne_s = getTileItemById(s_pos, stoneslot_run)
	doTransformItem(stne_s.uid, stoneslot)

	local butn_s = getTileItemById(b_pos, button_run)
	doTransformItem(butn_s.uid, button)

end

local stones_required = {	-- custo base de stones para boostar
[heart] = 1,
[leaf] = 1,
[water] = 1,
[venom] = 1,
[thunder] = 1,
[rock] = 1,
[punch] = 1,
[fire] = 1,
[coccon] = 1,
[crystal] = 1,
[dark] = 1,
[earth] = 1,
[enigma] = 1,
[ice] = 1,
}

local stone_increase = {	-- a cada quantos boosts irá aumentar o custo de stones
[heart] = 3,
[leaf] = 3,
[water] = 3,
[venom] = 4,
[thunder] = 4,
[rock] = 3,
[punch] = 4,
[fire] = 3,
[coccon] = 2,
[crystal] = 15,
[dark] = 4,
[earth] = 4,
[enigma] = 4,
[ice] = 4,
}

function onUse(cid, item, topos, item2, frompos)

	if isRunning(item.itemid) then
		doPlayerSendCancel(cid, "Wait until boosting finishes.")
	return true
	end

	if item.itemid == button then

		local pbpos = topos
		      pbpos.x = pbpos.x + 1
		local ball_slot = getTileItemById(pbpos, ballslot)
		local myball = getContainerItem(ball_slot.uid, 0)

		if myball.uid <= 0 or getItemWeight(myball.uid) == 0 then
			doPlayerSendCancel(cid, "You need to put a pokeball in the ball slot.")
		return true
		end

		local pokemon = getPokeballInfo(myball.uid).name
		local boost = getItemAttribute(myball.uid, "Boost") or 0

		if boost >= 50 then
			doPlayerSendCancel(cid, "Your pokemon is already at maximum boost.")
		return true
		end

		local stnpos = pbpos
		      stnpos.x = stnpos.x - 2
		local stone_slot = getTileItemById(stnpos, stoneslot)

		local stone = getContainerItem(stone_slot.uid, 0)

		if stone.uid <= 0 then
			doPlayerSendCancel(cid, "You need to put a stone in the stone slot.")
		return true
		end

		if not isStone(stone.itemid) then
			doPlayerSendCancel(cid, "Please, put only stones in the stone slot.")
		return true
		end

		if not isInArray(boost_stones[pokemon], stone.itemid) then

			local cancelstr = "Sorry, you are not using the correct stone."

			if #boost_stones[pokemon] > 1 then
				local stonesused = ""
				cancelstr = cancelstr.." This pokemon needs "
				for su = 1, #boost_stones[pokemon] do
					local n = doCorrectString(getItemNameById(boost_stones[pokemon][su]))
					if su == #boost_stones[pokemon] then
						stonesused = stonesused.." or "..getArticle(n).." "..n..""
					elseif su == 1 then
						stonesused = stonesused..""..getArticle(n).." "..n..""
					else
						stonesused = stonesused..", "..n..""
					end
				end
				cancelstr = cancelstr..""..stonesused.." to be boosted."
			else
				cancelstr = cancelstr.." This pokemon needs a "..doCorrectString(getItemNameById(boost_stones[pokemon][1])).." to be boosted."
			end

			doPlayerSendCancel(cid, cancelstr)

		return true
		end

		local removeStones = 0
		local extraStones = math.floor(boost / stone_increase[stone.itemid])
		local required_stones = stones_required[stone.itemid] + extraStones

		local boosts = 0

		for a = 0, getContainerSize(stone_slot.uid) - 1 do

			local it = getContainerItem(stone_slot.uid, a)

			if it.uid > 0 then

				if not isStone(it.itemid) then
					doPlayerSendCancel(cid, "Please, put only stones in the stone slot.")
				return true
				end

				if it.itemid ~= stone.itemid then
					doPlayerSendCancel(cid, "Please, put only one type of stone in the stone slot.")
				return true
				end

				if required_stones > 0 then
					required_stones = required_stones - (it.type ~= 0 and it.type or 1) --alterado v1.7

					if required_stones <= 0 then
						boosts = boosts + 1
						removeStones = removeStones + stones_required[stone.itemid] + extraStones
						
						if boost + boosts <= 49 then
							extraStones = math.floor((boost + boosts) / stone_increase[stone.itemid])
							required_stones = stones_required[stone.itemid] + extraStones
						end
						break
					end
				end

			end

		end

		if required_stones > 0 and boosts == 0 then
			doPlayerSendCancel(cid, "You need more stones to boost this pokemon.")
		return true
		end
		
		for b = 1, removeStones do
            local i = getContainerItem(stone_slot.uid, 0)
		    if i.type ~= 0 then
               doChangeTypeItem(i.uid, i.type - 1)    --alterado v1.7
            else
               doRemoveItem(i.uid, 1)
            end
        end

		doItemSetAttribute(myball.uid, "Boost", boost + boosts)

		local msg = "Your "..getPokeballInfo(myball.uid).name.." has been boosted!"
		local msg2 = "• Boost: "..(boost + boosts).." (+"..boosts..")"


		doTransformItem(ball_slot.uid, ballslot_run)
		doTransformItem(stone_slot.uid, stoneslot_run)
		doTransformItem(item.uid, button_run)

		doCreatureSetNoMove(cid, true)
		doCreatureAddCondition(cid, boostcondition)

		addEvent(doRestoreBoostMachine, 3000, cid, getThingPos(item.uid), getThingPos(ball_slot.uid), getThingPos(stone_slot.uid), msg, msg2)

	return true
	end
end