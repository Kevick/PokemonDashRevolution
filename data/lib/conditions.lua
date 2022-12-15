-------THUNDER WAVE
thunderwavecondition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(thunderwavecondition, CONDITION_PARAM_TICKS, 9000)
setConditionFormula(thunderwavecondition, -0.75, -0.75, -0.75, -0.75)

------SLEEP POWNDER
sleepcondition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(sleepcondition, CONDITION_PARAM_TICKS, 10000)  -- 5 segundos
setConditionParam(sleepcondition, CONDITION_PARAM_SPEED, -200)  -- paralizado
setConditionFormula(sleepcondition, -0.9, 0, -0.9, 0)

------SLEEP
sleep = createConditionObject(CONDITION_PARALYZE)
setConditionParam(sleep, CONDITION_PARAM_TICKS, 5*1000)
setConditionFormula(sleep, -1.7, 0, -1.8, 0)

paralizeArea2 = createConditionObject(CONDITION_PARALYZE)
setConditionParam(paralizeArea2, CONDITION_PARAM_TICKS, 50000)
setConditionFormula(paralizeArea2, -0.63, -0.63, -0.63, -0.63)

sleepp = createConditionObject(CONDITION_PARALYZE)
setConditionParam(sleepp, CONDITION_PARAM_TICKS, 4500)
setConditionFormula(sleepp, -1.7, 0, -1.8, 0)

------GHOST
condition_ghost = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(condition_ghost, CONDITION_PARAM_TICKS, 7000) 

------CONDITION
condition = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 5000)

------OUTRAS
boostcondition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(boostcondition, CONDITION_PARAM_TICKS, 3 * 1000)

fightcondition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(fightcondition, CONDITION_PARAM_TICKS, 18 * 1000)

playerexhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(playerexhaust, CONDITION_PARAM_TICKS, 250)

tonto = createConditionObject(CONDITION_DRUNK)
setConditionParam(tonto, CONDITION_PARAM_TICKS, 5000)

permanentinvisible = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(permanentinvisible, CONDITION_PARAM_TICKS, -1)