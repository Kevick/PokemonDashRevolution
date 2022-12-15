function onSay(cid, words, param, channel)
    local summon = getCreatureSummons(cid)[1]
 
    if isCreature(summon) then
	    doCreatureCastSpell(summon, "fire blast")
    end
    return true
end