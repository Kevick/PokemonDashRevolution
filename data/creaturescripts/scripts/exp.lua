local expcond = createConditionObject(CONDITION_INFIGHT)
setConditionParam(expcond, CONDITION_PARAM_TICKS, 4500)

function onStatsChange(cid, attacker, enps, combatee, value)

    if getPlayerStorageValue(cid, 33) >= 1 then
        if isCreature(attacker) then
        return false
        end
    return true
    end

	if getPlayerStorageValue(cid, 34) >= 1 then
        if combatee ~= COMBAT_PHYSICALDAMAGE then
            if isCreature(attacker) then
                doSendMagicEffect(getThingPos(cid), 135)
                doSendMagicEffect(getThingPos(attacker), 3)
                doSendAnimatedText(getThingPos(cid), "REFLECT", 215)
                doCreatureAddHealth(attacker, -value)
                setPlayerStorageValue(cid, 34, 0)
                doSendAnimatedText(getThingPos(attacker), -value, 191)
            return false
            end
        end
    end

	if getPlayerStorageValue(cid, 35) >= 1 then
        if combatee ~= COMBAT_PHYSICALDAMAGE then
            if isCreature(attacker) then
                doSendAnimatedText(getThingPos(cid), "MISS", 215)
                setPlayerStorageValue(cid, 35, 0)
            return false
            end
        end
    end
	
    if not isCreature(attacker) then
    return true
    end

	if isPlayer(attacker) then
	return true
    end
	
	if isSummon(attacker) or isPlayer(attacker) then
		if canAttackOther(cid, attacker) == "Cant" then return false end
	end
	
	if isMonster(cid) and isSummon(attacker) and getCreatureCondition(cid, CONDITION_INVISIBLE) then
		doMonsterChangeTarget(getCreatureMaster(attacker))
	end

	if enps == STATSCHANGE_HEALTHGAIN then
		if cid == attacker then
		return true
		end
		if isSummon(cid) and isSummon(attacker) and canAttackOther(cid, attacker) == "Cant" then
		return false
		end
    return true
    end

	if enps == STATSCHANGE_HEALTHLOSS then
        if getCreatureHealth(cid) <= value then
            if isPlayer(cid) then
	            if #getCreatureSummons(cid) == 0 then
	            return true
	            end
            return false
            end

			if isPlayer(getCreatureMaster(attacker)) then
                doTargetCombatHealth(getCreatureMaster(attacker), cid, combatee, -(getCreatureHealth(cid)), -(getCreatureHealth(cid)), 3)
            return false
            end
        return true
        end
		

		if isPlayer(getCreatureMaster(cid)) then
            doAddCondition(getCreatureMaster(cid), expcond)
        end

		if not isPlayer(cid) then
		
		
		local poketype = getMonsterInfo(getCreatureName(cid)).race
			if combatee ~= COMBAT_PHYSICALDAMAGE then
				print("pokemon atacado: " ..getCreatureName(cid).. " Race: " ..poketype)
				if isInArray(effectiveness[combatee].super, poketype) then
					x = 2
					print("setei super")
				elseif isInArray(effectiveness[combatee].weak, poketype) then 
					x = 0.5
					print("setei WEAK")
				elseif isInArray(effectiveness[combatee].non, poketype) then
					return false

				end
			else
				x = 1
				print("SETEI 1X")
			end
		
     
		-- fim do ataque do pokémon	
        else
            x = 1
        end

        local xx = x
        if combatee == PSYCHICDAMAGE then
            cor = COLOR_PSYCHIC
        elseif combatee == GRASSDAMAGE then
            cor = COLOR_GRASS
        elseif combatee == FIREDAMAGE then
            cor = COLOR_FIRE2
        elseif combatee == WATERDAMAGE then
            cor = COLOR_WATER
        elseif combatee == ICEDAMAGE then
            cor = COLOR_ICE
        elseif combatee == NORMALDAMAGE then
            cor = COLOR_NORMAL
        elseif combatee == FLYDAMAGE then
            cor = COLOR_FLYING
        elseif combatee == GHOSTDAMAGE then
            cor = COLOR_GHOST
        elseif combatee == GROUNDDAMAGE then
            cor = COLOR_GROUND
        elseif combatee == ELECTRICDAMAGE then
            cor = COLOR_ELECTRIC
        elseif combatee == ROCKDAMAGE then
            cor = COLOR_ROCK
        elseif combatee == BUGDAMAGE then
            cor = COLOR_BUG
        elseif combatee == FIGHTDAMAGE then
            cor = COLOR_FIGHTING
        elseif combatee == DRAGONDAMAGE then
            cor = COLOR_DRAGON
        elseif combatee == POISONDAMAGE then
            cor = COLOR_POISON
        elseif getCreatureName(cid) == "Kakuna" or getCreatureName(cid) == "Metapod" then
            cor = COLOR_BUG
        elseif getCreatureName(cid) == "Golem" or getCreatureName(cid) == "Graveler" or getCreatureName(cid) == "Geodude" then
            cor = COLOR_ROCK
        else
            cor = NONE
        end
		
		valor = math.abs(value)
	    if isSummon(cid) and valor >= getCreatureHealth(cid) then
			doUpdateStatusPoke(getCreatureMaster(cid))
        elseif isSummon(cid) then
			doUpdateStatusPoke(getCreatureMaster(cid))
        end
		
		if isSummon(cid) or isMonster(cid) then
			if not isCreature(cid) then return true end
			if passiveInfo[getCreatureName(cid)] and math.random(1,100) <= passiveInfo[getCreatureName(cid)].chance then
				if not isCreature(cid) then return true end
				doPokemonUseSpell(cid, passiveInfo[getCreatureName(cid)].spell, passiveInfo[getCreatureName(cid)].min, passiveInfo[getCreatureName(cid)].max)
			end
		end

		local cores = cor
        if not isSummon(attacker) then
            if not isPlayer(cid) and not isPlayer(getCreatureMaster(cid)) then
            return false
            end
        
		    if isSummon(cid) and getCreatureHealth(cid) <= (getCreatureMaxHealth(cid)*0.15) and not exhaustion.get(getCreatureMaster(cid), 88726) then
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
                doCreatureAddHealth(cid, -((math.floor(damage/2))*xx))
                doSendAnimatedText(getThingPos(cid), (math.floor((damage)/2)*xx), cores)
            else
                local damage = value
                if cor == NONE then
                return true
                end

				doCreatureAddHealth(cid, -((math.floor(damage/1))*xx))
                doSendAnimatedText(getThingPos(cid), (math.floor((damage)/1)*xx), cores)
				doSendMagicEffect(getThingPos(cid), 3)
            return false
            end
        return false
        end
        
		--adicionado por valakinhas
        if ehMonstro(cid) and ehMonstro(attacker) and not isSummon(cid) and not isSummon(attacker) then 
				return false                                         
				end
 ---------------------------------------------------------------------------------------------------------------				
		if isSummon(attacker) then
            if isSummon(cid) and canAttackOther(cid, attacker) == "Cant" then
			return false
			end
			

			combatx = combatee
            valor = value
 
            if getPlayerStorageValue(cid, 4) >= 1 then
                doTargetCombatHealth(getCreatureMaster(attacker), cid, combatx, -((valor / 2)*x), -(((valor / 2)+10)*x), 255)
            else
                doTargetCombatHealth(getCreatureMaster(attacker), cid, combatx, -((valor)*x), -((valor+10)*x), 255)
            end
        end
    end
	
end

