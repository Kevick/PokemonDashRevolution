function onSay(cid,param,words)
if #getCreatureSummons(cid) == 0 then
doPlayerSendCancel(cid, "You need a pokemon to Love.")
return true
end
if #getCreatureSummons(cid) == 1 then
getHappinesStatus(getCreatureSummons(cid)[1], true)
end
return true
end