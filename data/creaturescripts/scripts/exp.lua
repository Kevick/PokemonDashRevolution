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
    local porrada = nil
    local poketype = pokes[getCreatureName(cid)].type

    print("Pokemon Atacado: " .. getCreatureName(cid) .. " race: " .. poketype)
    print(combatee)

    local damageMappings = {
        [PSYCHICDAMAGE] = {cor = COLOR_PSYCHIC, porrada = PSYCHICDAMAGE},
        [GRASSDAMAGE] = {cor = COLOR_GRASS, porrada = GRASSDAMAGE},
        [FIREDAMAGE] = {cor = COLOR_FIRE2, porrada = FIREDAMAGE},
        [WATERDAMAGE] = {cor = COLOR_WATER, porrada = WATERDAMAGE},
        [ICEDAMAGE] = {cor = COLOR_ICE, porrada = ICEDAMAGE},
        [COLOR_NORMAL] = {cor = COLOR_NORMAL, porrada = NORMALDAMAGE},
        [FLYINGDAMAGE] = {cor = COLOR_FLYING, porrada = FLYINGDAMAGE},
        [GHOSTDAMAGE] = {cor = COLOR_GHOST, porrada = GHOSTDAMAGE},
        [GROUNDDAMAGE] = {cor = COLOR_GROUND, porrada = GROUNDDAMAGE},
        [ELECTRICDAMAGE] = {cor = COLOR_ELECTRIC, porrada = ELECTRICDAMAGE},
        [ROCKDAMAGE] = {cor = COLOR_ROCK, porrada = ROCKDAMAGE},
        [BUGDAMAGE] = {cor = COLOR_BUG, porrada = BUGDAMAGE},
        [FIGHTINGDAMAGE] = {cor = COLOR_FIGHTING, porrada = FIGHTINGDAMAGE},
        [DRAGONDAMAGE] = {cor = COLOR_DRAGON, porrada = DRAGONDAMAGE},
        [POISONDAMAGE] = {cor = COLOR_POISON, porrada = POISONDAMAGE}
    }

    local mapping = damageMappings[combatee]

    if mapping then
        cor = mapping.cor
        porrada = mapping.porrada
    elseif getCreatureName(cid) == "Kakuna" or getCreatureName(cid) == "Metapod" then
        cor = COLOR_BUG
        porrada = BUGDAMAGE
    elseif getCreatureName(cid) == "Golem" or getCreatureName(cid) == "Graveler" or getCreatureName(cid) == "Geodude" then
        cor = COLOR_ROCK
        porrada = ROCKDAMAGE
    elseif combatee == COMBAT_NONE then
        cor = COLOR_TEAL
        porrada = combatee
    else
        cor = NONE
        porrada = combatee
    end

    if combatee ~= COMBAT_PHYSICALDAMAGE then
        if isInArray(effectiveness[porrada].super, poketype) then
            x = 2
            print("setei super")
        elseif isInArray(effectiveness[porrada].weak, poketype) then
            x = 0.5
            print("setei WEAK")
        elseif isInArray(effectiveness[porrada].non, poketype) then
            return false
        else
            x = 1
            print("setei 1x")
        end
    else
        x = 1
        print("setei fora do if 1x")
    end
end
      local xx = x


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
