function onUse(cid, item, frompos, item2, topos)
    local ball = getPokeballType(item.itemid)
    local pokeball = pokeballs[ball]
    local pokeballInfo = getPokeballInfo(item.uid)

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

        if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 then
            return doPlayerSendCancel(cid, "You can't use pokeball while flying.")
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
                    doTransformItem(item.uid, item.itemid - 1)
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
                doCreatureSay(cid, mbk, TALKTYPE_MONSTER)
                doPlayerSendCancel(cid, "12//,hide")
                setPokeballInfo(item.uid, pokeballInfo.name, getCreatureHealth(z), getCreatureMaxHealth(z))
                doItemSetAttribute(item.uid, "php", (getCreatureHealth(z) / getCreatureMaxHealth(z)))
                doItemSetAttribute(item.uid, "happy", (getPlayerStorageValue(z, 66604) or 0))
                setPlayerStorageValue(cid, 61204, 0)
                setPlayerStorageValue(cid, 2, 0)
                sendBallEffect(cid)
                doRemoveCreature(z)
                doUpdatePokemons(cid)
                doPlayerSendCancel(cid, "@H|Hide")
                doPlayerSendCancel(cid, "@M|hide")
                doPlayerSendCancel(cid, nil)
                setCD(getPlayerSlotItem(cid, 8).uid, "Anti-BugBall", 1)
                return true
            end
        end
    elseif item.itemid == pokeball.on then
        if item.uid ~= getPlayerSlotItem(cid, CONST_SLOT_FEET).uid then
            doPlayerSendCancel(cid, "You must put your pokeball in the correct place!")
            return TRUE
        end

        if getCD(getPlayerSlotItem(cid, 8).uid, "Anti-BugBall") > 0 then
            return true
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

        if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 then
            return doPlayerSendCancel(cid, "You can't use pokeball while flying.")
        end

        if #getCreatureSummons(cid) >= 1 then
            return doPlayerSendCancel(cid, "You have already summoned a pokemon.")
        end

        for i, x in pairs(pokes) do
            if i == getItemAttribute(item.uid, "poke"):sub(9, findLetter(getItemAttribute(item.uid, "poke"), "'") - 1) then
                if getPlayerLevel(cid) < x.level then
                    doPlayerSendCancel(cid, "You need level " .. x.level .. " or higher to use this pokemon.")
                    return true
                end
                local removed = doCreateItem(1285, 1, getThingPos(cid))
                doSummonMonster(cid, i)

                local nick = getItemAttribute(item.uid, "nick")
                local pk = getCreatureSummons(cid)[1]
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
                        setPlayerStorageValue(pk, 1010, getCreatureName(pk) == "Ditto" and "Ditto" or "Shiny Ditto") --edited
                    end
                else
                    setPlayerStorageValue(pk, 1010, pokeballInfo.name)
                end

                doRemoveItem(removed, 1)
                doCreatureSetLookDir(pk, 2)
                setPlayerStorageValue(pk, 11226)
                doConvinceCreature(cid, pk)
                setPokemonStatus(pk, true, true)
                if getItemAttribute(item.uid, "iconsystem") == "on" then
                    doTransformItem(item.uid, pokeballs[pokeballInfo.name].use)
                else
                    doTransformItem(item.uid, item.itemid + 1)
                end

                local pokename = pokeballInfo.nick
                local mgo = gobackmsgs[math.random(1, #gobackmsgs)].go:gsub("doka", pokename)
                doCreatureSay(cid, mgo, TALKTYPE_MONSTER)
                if useOTClient then
                    doPlayerSendCancel(cid, "12//,show") --alterado v1.7
                end
                if useKpdoDlls then
                    doUpdateMoves(cid)
                end
                if pokeballInfo.name ~= "Ditto" then
                    for i = 1, 12 do
                        if not getMoveNamee(cid, i) then
                            addEvent(doGoBackSetCooldown, 200, cid)
                        end
                    end
                else
                    for a = 1, 12 do
                        setPokemonCooldown(cid, a, "Don't have this move.")
                    end
                end

                doItemSetAttribute(
                    item.uid,
                    "poke",
                    getItemAttribute(item.uid, "poke"):sub(1, findLetter(getItemAttribute(item.uid, "poke"), "."))
                )
                sendBallEffect(cid)
                doItemSetAttribute(item.uid, "php", (getCreatureHealth(pk) / getCreatureMaxHealth(pk)))
                setPlayerStorageValue(cid, 61204, 1)
                doUpdateStatusPoke(cid)
                doUpdateCds(cid)
                doUpdatePokemons(cid)
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
    return TRUE
end
