function onSay(cid, words, param)

	local bag = getPlayerItemById(cid, false, 1988).uid
	doAddContainerItem(bag, 11397, 1)
	doAddContainerItem(bag, 11398, 1)
	doAddContainerItem(bag, 11399, 1)
	doAddContainerItem(bag, 11400, 1)
	doAddContainerItem(bag, 11401, 1)
	doAddContainerItem(bag, 11402, 1)
	doAddContainerItem(bag, 11403, 1)
	doAddContainerItem(bag, 11404, 1)
    doPlayerSendCancel(cid, "pronto")
return true 
end