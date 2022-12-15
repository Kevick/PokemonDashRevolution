gymbadges = {
["Brock"] = {on = 11389, off = 11397},
["Misty"] = {on = 11390, off = 11398},
["Surge"] = {on = 11391, off = 11399},
["Erika"] = {on = 11392, off = 11400},
["Sabrina"] = {on = 11393, off = 11401},
["Koga"] = {on = 11394, off = 11402},
["Blaine"] = {on = 11395, off = 11403},
["Kira"] = {on = 11396, off = 11404}
}

function returnPokeNpc(summon, npc)
	local msgba = gobackmsgs[math.random(1, #gobackmsgs)].back:gsub("doka", getCreatureName(summon))
	local balleffect = pokeballs["poke"].effect

	doSendMagicEffect(getThingPos(summon), balleffect)
	doCreatureSay(npc, msgba, 1)

	doRemoveCreature(summon)
end
