function onUse(cid, item, frompos, item2, topos)
if getItemAttribute(item.uid, "corpseowner") ~= cid then
doPlayerSendCancel(cid, "You're not the owner.")
return true
end
local items = {}
for x=0, getContainerSize(item.uid) - 1 do
local itens = getContainerItem(item.uid, 0)
table.insert(items, {i=itens.itemid, q=itens.type})
doRemoveItem(itens.uid)
end
for y=1, #items do
doPlayerAddItemStacking(cid, items[y].i, items[y].q)
doPlayerSendTextMessage(cid, 20, "Looted "..items[y].q.."x "..getItemNameById(items[y].i)..".")
end
if #items > 0 then
return true
else
return false
end
end
