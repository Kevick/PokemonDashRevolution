local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false
local talkState = {}
local states = {'1', '2', '3', '4', '5', '6'}
local store = {1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066,  1067, 1068, 1069, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151}
local unlock = {}

function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msg)
local msg = string.lower(msg)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	for a, b in pairs(gobackmsgs) do
		local gm = string.gsub(b.go, "doka!", "")
		local bm = string.gsub(b.back, "doka!", "")
		if string.find(string.lower(msg), string.lower(gm)) or string.find(string.lower(msg), string.lower(bm)) then
		return true
		end
	end
	
    if((msgcontains(msg, 'hi') or msgcontains(msg, 'heal') or msgcontains(msg, 'help')) and (getDistanceToCreature(cid) <= 3)) then

 	    if exhaustion.get(cid, 9211) then
	        selfSay('Please wait a few moment before asking me to heal your pokemons again!')
	    return true
        end
		
		if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 then
        return doPlayerSendCancel(cid, "You can't use pokeball while flying.")
        end

		if #getCreatureSummons(cid) >= 1 then
            doReturnPokemon(cid)
		end
	
	    exhaustion.set(cid, 9211, 5)
	    doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid))
	    doSendMagicEffect(getThingPos(cid), 132)
	    
		local slotBall = getPlayerSlotItem(cid, 8)
	    if slotBall.itemid ~= 0 and isPokeball(slotBall.itemid) then
			for a, b in pairs (pokeballs) do
				if isInArray(b.all, slotBall.itemid) then
					local pokeballInfo = getPokeballInfo(slotBall.uid)
	                local maxh = tonumber(pokeballInfo.maxhp)
	                setPokeballInfo(slotBall.uid, pokeballInfo.name, maxh, maxh)
					doTransformItem(slotBall.uid, b.on)
				end
			end
	    end
		    
		
		local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
		local balls = getPokeballsInContainer(bp.uid)
		for _, uid in pairs(balls) do
		    local this = getThing(uid)
		    for a, b in pairs (pokeballs) do
		       if isInArray(b.all, this.itemid) then
			   	  local pokeballInfo = getPokeballInfo(uid)
			      local maxh = tonumber(pokeballInfo.maxhp)
			      setPokeballInfo(uid, pokeballInfo.name, maxh, maxh)
	              doTransformItem(uid, b.on)
               end
            end
		end
	
	    selfSay('There you go! You and your pokemons are healthy again.')
		doUpdatePokemons(cid)
    end
end
 
function onThink()

if focus ~= 0 then
a, b, c = selfGetPosition()
if c ~= getThingPos(focus).z then
focus = 0
end
end

if focus ~= 0 then
if getDistanceToCreature(focus) > 3 then
focus = 0
end
end

return true
end