function isSummon(sid)
    for i, pid in ipairs(getPlayersOnline()) do
        for c, cid in pairs(getCreatureSummons(pid)) do
            if (cid == sid) then
                return true
            end
        end 
    end
    return false
end  

function onUse(cid, item, fromPos, itemEx, toPos)
local pokemon = itemEx.uid
	for _,n in pairs(DexLib) do
		if isSummon(pokemon) then
            if getCreatureName(pokemon) == n[1] and getPlayerLevel(cid) >= n[2] and getPlayerStorageValue(cid, n[3]) <= 0 then
                j = (n[2]) *10
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have unlocked " .. n[1] .. " in your pokedex!")
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have gained " .. j .. " experience points.")
                doSendMagicEffect(getThingPos(cid), 210)
                doPlayerAddExperience(cid, (n[2])*10)
                setPlayerStorageValue(cid, n[3], 1)
            elseif getCreatureName(pokemon) == n[1] and getPlayerLevel(cid) < n[2] and getPlayerStorageValue(cid, n[3]) <= 0 then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need to be at least level " .. n[2] .. " to unlock this pokemon.")
            elseif getCreatureName(pokemon) == n[1] and getPlayerStorageValue(cid, n[3]) >= 1 then
                local v = ((n[3]) + 1376)
                local dexstring = ""..n[1]..".txt"
                local Dex = io.open('data/pokedex/'..dexstring, 'r')
				doPlayerSendCancel(cid, "#dex#|"..portrait[n[1]].."|"..n[1])
				doPlayerSendCancel(cid, nil)
                Dex:close() 
            end   
        elseif isMonster(pokemon) then
            if getCreatureName(pokemon) == n[1] and getPlayerStorageValue(cid, n[3]) <= 0 then
                j = (n[2]) *10
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have unlocked " .. n[1] .. " in your pokedex!")
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have gained " .. j .. " experience points.")
                doSendMagicEffect(getThingPos(cid), 210)
                doPlayerAddExperience(cid, (n[2])*10)
                setPlayerStorageValue(cid, n[3], 1)
            elseif getCreatureName(pokemon) == n[1] and getPlayerStorageValue(cid, n[3]) >= 1 then
                local v = ((n[3]) + 1376)
                local dexstring = ""..n[1]..".txt"
                local Dex = io.open('data/pokedex/'..dexstring, 'r')
				doPlayerSendCancel(cid, "#dex#|"..portrait[n[1]].."|"..n[1])
				doPlayerSendCancel(cid, nil)
                Dex:close()
            end
        end
    end

    if not isCreature(itemEx.uid) then
    return true
    end
	
	local store = {1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151}
	local unlock = {}
    for i = 1, #store do
        if getPlayerStorageValue(itemEx.uid, store[i]) < 0 then
		return true
        elseif  getPlayerStorageValue(itemEx.uid, store[i]) >= 0 then
			table.insert(unlock, 1)
        end
    end
    
    if isPlayer(itemEx.uid) then
        setPlayerStorageValue(cid, 7274, 1)
        if getCreatureName(cid) == getCreatureName(itemEx.uid) then
            doPlayerSendTextMessage(cid, 27, "You have unlocked " .. #unlock .. " pokemons already.")
            doPlayerSendTextMessage(cid, 27, "You can open a pokedex entry by typing \"/dex <name>\". Example: \"/dex Pikachu\".")
        else
            doPlayerSendTextMessage(cid, 27, getPlayerName(itemEx.uid) .. " has unlocked " .. #unlock .. " pokemons already.")
        end
    end

return true
end 