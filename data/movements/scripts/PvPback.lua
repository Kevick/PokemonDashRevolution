citys = {
--[storage da city] = {posiçao do CP das citys}
[181778] = {x=637,y=1347,z=7}, -- Cinnabar
[181779] = {x=573,y=671,z=6}, -- pewter
[181780] = {x=1059,y=904,z=7}, -- cerulean
[181781] = {x=1053,y=1053,z=7}, -- saffron
[181782] = {x=1075,y=1243,z=7}, -- vermillion
[181783] = {x=1122,y=1449,z=7}, -- fuchsia
[181784] = {x=562,y=1040,z=7}, -- viridian
[181785] = {x=864,y=1015,z=6}, -- Celadon
[181786] = {x=1201,y=1046,z=7}, -- lavender
}

function onStepIn(cid, item, pos)
	if isSummon(cid) then
	return false
	end
	for i = 181778, 181786 do
		if getPlayerStorageValue(cid, i) == 1 then
			if #getCreatureSummons(cid) >= 1 then
				doTeleportThing(getCreatureSummons(cid)[1], {x=citys[i].x - 1, y=citys[i].y, z=citys[i].z}, false)
				doTeleportThing(cid, {x=citys[i].x, y=citys[i].y, z=citys[i].z}, false)
				setPlayerStorageValue(cid, i, 0)
			else
				doTeleportThing(cid, {x=citys[i].x, y=citys[i].y, z=citys[i].z}, false)
				setPlayerStorageValue(cid, i, 0)
			end
		end
	end
return true
end