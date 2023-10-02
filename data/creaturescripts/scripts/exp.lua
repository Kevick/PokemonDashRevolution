local expcond = createConditionObject(CONDITION_INFIGHT)
setConditionParam(expcond, CONDITION_PARAM_TICKS, 4500)

function onStatsChange(cid, attacker, enps, combatee, value)
    if getPlayerStorageValue(cid, 33) >= 1 then
        if isCreature(attacker) then
            return false
        end
        return true
    end

    if getPlayerStorageValue(cid, 34) >= 1 and combatee ~= COMBAT_PHYSICALDAMAGE and isCreature(attacker) then
        doSendMagicEffect(getThingPos(cid), 135)
        doSendMagicEffect(getThingPos(attacker), 3)
        doSendAnimatedText(getThingPos(cid), "REFLECT", 215)
        doCreatureAddHealth(attacker, -value)
        setPlayerStorageValue(cid, 34, 0)
        doSendAnimatedText(getThingPos(attacker), -value, 191)
        return false
    end

    if getPlayerStorageValue(cid, 35) >= 1 and combatee ~= COMBAT_PHYSICALDAMAGE and isCreature(attacker) then
        doSendAnimatedText(getThingPos(cid), "MISS", 215)
        setPlayerStorageValue(cid, 35, 0)
        return false
    end

    if not isCreature(attacker) or isPlayer(attacker) then
        return true
    end

    local poketype = pokes[getCreatureName(cid)].type

    local damageMappings = {
        [PSYCHICDAMAGE] = COLOR_PSYCHIC,
        [GRASSDAMAGE] = COLOR_GRASS,
        [FIREDAMAGE] = COLOR_FIRE2,
        [WATERDAMAGE] = COLOR_WATER,
        [ICEDAMAGE] = COLOR_ICE,
        [COLOR_NORMAL] = COLOR_NORMAL,
        [FLYINGDAMAGE] = COLOR_FLYING,
        [GHOSTDAMAGE] = COLOR_GHOST,
        [GROUNDDAMAGE] = COLOR_GROUND,
        [ELECTRICDAMAGE] = COLOR_ELECTRIC,
        [ROCKDAMAGE] = COLOR_ROCK,
        [BUGDAMAGE] = COLOR_BUG,
        [FIGHTINGDAMAGE] = COLOR_FIGHTING,
        [DRAGONDAMAGE] = COLOR_DRAGON,
        [POISONDAMAGE] = COLOR_POISON
    }

    local cor = damageMappings[combatee] or NONE

    if combatee ~= COMBAT_PHYSICALDAMAGE then
        if isInArray(effectiveness[combatee].super, poketype) then
            x = 2
            print("setei super")
        elseif isInArray(effectiveness[combatee].weak, poketype) then
            x = 0.5
            print("setei WEAK")
        elseif isInArray(effectiveness[combatee].non, poketype) then
            return false
        else
            x = 1
            print("setei 1x")
        end
    else
        x = 1
        print("setei fora do if 1x")
    end

    local xx = x
    local valor = math.abs(value)

    if isSummon(cid) and valor >= getCreatureHealth(cid) then
        doUpdateStatusPoke(getCreatureMaster(cid))
    elseif isSummon(cid) then
        doUpdateStatusPoke(getCreatureMaster(cid))
    end

    if isSummon(cid) or isMonster(cid) then
        if passiveInfo[getCreatureName(cid)] and math.random(1, 100) <= passiveInfo[getCreatureName(cid)].chance then
            doPokemonUseSpell(cid, passiveInfo[getCreatureName(cid)].spell, passiveInfo[getCreatureName(cid)].min, passiveInfo[getCreatureName(cid)].max)
        end
    end

    if not isSummon(attacker) then
        if not isPlayer(cid) and not isPlayer(getCreatureMaster(cid)) then
            return false
        end

        if isSummon(cid) and getCreatureHealth(cid) <= (getCreatureMaxHealth(cid) * 0.15) and not exhaustion.get(getCreatureMaster(cid), 88726) then
            exhaustion.set(getCreatureMaster(cid), 88726, 6)
            doSendMagicEffect(getThingPos(cid), 178)
        end

        if isPlayer(cid) then
            if #getCreatureSummons(cid) >= 1 then
                return false
            end

            doCreatureAddHealth(cid, -value)
            doSendAnimatedText(getThingPos(cid), value, 180)
            doSendMagicEffect(getThingPos(cid), 3)
            return false
        end

        if getPlayerStorageValue(cid, 4) >= 1 then
            local damage = value
            doSendMagicEffect(getThingPos(cid), 2)
            doCreatureAddHealth(cid, -((math.floor(damage / 2)) * xx))
            doSendAnimatedText(getThingPos(cid), (math.floor((damage) / 2) * xx), cor)
        else
            local damage = value
            if cor == NONE then
                return true
            end

            doCreatureAddHealth(cid, -((math.floor(damage / 1)) * xx))
            doSendAnimatedText(getThingPos(cid), (math.floor((damage) / 1) * xx), cor)
            doSendMagicEffect(getThingPos(cid), 3)
            return false
        end
        return false
    end

    if ehMonstro(cid) and ehMonstro(attacker) and not isSummon(cid) and not isSummon(attacker) then
        return false
    end

    if isSummon(attacker) then
        if isSummon(cid) and canAttackOther(cid, attacker) == "Cant" then
            return false
        end

        local combatx = combatee
        local valor = value

        if getPlayerStorageValue(cid, 4) >= 1 then
            doTargetCombatHealth(getCreatureMaster(attacker), cid, combatx, -((valor / 2) * x), -(((valor / 2) + 10) * x), 255)
        else
            doTargetCombatHealth(getCreatureMaster(attacker), cid, combatx, -((valor) * x), -((valor + 10) * x), 255)
        end
    end
end
