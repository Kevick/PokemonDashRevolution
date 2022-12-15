local FOODS =
{
[2666] = {15, "Munch."},
[2667] = {12, "Munch."},
[2668] = {10, "Mmmm."},
[2669] = {17, "Munch."},
[2670] = {4, "Gulp."},
[2671] = {30, "Chomp."},
[2672] = {60, "Chomp."},
[2673] = {5, "Yum."},
[2674] = {6, "Yum."},
[2675] = {13, "Yum."},
[2676] = {8, "Yum."},
[2678] = {18, "Slurp."},
[2679] = {1, "Yum."},
[2680] = {2, "Yum."},
[2681] = {9, "Yum."},
[2683] = {17, "Munch."},
[2684] = {8, "Crunch."},
[2685] = {6, "Munch."},
[2686] = {9, "Crunch."},
[2688] = {9, "Munch."},
[2689] = {10, "Crunch."},
[2690] = {3, "Crunch."},
[2691] = {8, "Crunch."},
[2793] = {9, "Munch."},
[2695] = {6, "Gulp."},
[2696] = {9, "Smack."},
[2792] = {6, "Munch."},
[2794] = {3, "Munch."},
[2795] = {36, "Munch."},
[2796] = {5, "Munch."},
[5097] = {4, "Yum."},
[6278] = {10, "Mmmm."},
[6279] = {15, "Mmmm."},
[6393] = {12, "Mmmm."},
[6394] = {15, "Mmmm."},
[6501] = {20, "Mmmm."},
[6541] = {6, "Gulp."},
[6542] = {6, "Gulp."},
[6543] = {6, "Gulp."},
[6544] = {6, "Gulp."},
[6545] = {6, "Gulp."},
[6569] = {1, "Mmmm."},
[7158] = {15, "Munch."},
[7159] = {13, "Munch."},
[7372] = {7, "Yum."},
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
local z = getCreatureSummons(cid)[1]
local food = FOODS[item.itemid]
if(not food) then
return false
end

if #getCreatureSummons(cid) <= 0 then
if((getPlayerFood(cid) + food[1]) >= 400) then
doPlayerSendCancel(cid, "You are full.")
return true
end

doPlayerFeed(cid, food[1] * 4)
doCreatureSay(cid, food[2], TALKTYPE_ORANGE_1)
doRemoveItem(item.uid, 1)
return true
elseif #getCreatureSummons(cid) >= 1 then
fome = getPlayerStorageValue(getCreatureSummons(cid)[1], 66604)
if fome<= 250 then
doSendDistanceShoot(getPlayerPosition(cid), getCreaturePosition(z), 39) 
doCreatureSay(getCreatureSummons(cid)[1], food[2], TALKTYPE_ORANGE_1)
doRemoveItem(item.uid, 1)
setPlayerStorageValue(getCreatureSummons(cid)[1], 66604, (fome + (food[1]*4)))
return true
else
doPlayerSendCancel(cid, "Seu pokémon não está com fome.")
getHappinesStatus(getCreatureSummons(cid)[1], true)
return true
end
end
end