function onUse (cid,item,frompos,item2,topos)
pos = {x=573, y=1139, z=7}

        UID_DO_BAU = 7860
        STORAGE_VALUE = 7860
        ID_DO_PREMIO = 2152
        ID_DO_PREMIO2 = 2147

        if getPlayerLevel(cid) >= 1 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Nao esqueça suas pokebolas , leve também um pouco de dinheiro.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,50)
        doPlayerAddItem(cid,ID_DO_PREMIO2,50)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
          else
        doPlayerSendTextMessage(cid,22,"Tchau Filho!.")
          end
  end
        else
  doPlayerSendCancel(cid,'..')
        end
return 1
end