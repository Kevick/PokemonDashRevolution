function onUse (cid,item,frompos,item2,topos)
pos = {x=1217, y=1213, z=8}
pos2 = getPlayerPosition(cid)

        UID_DO_BAU = 1013
        STORAGE_VALUE = 1012
        ID_DO_PREMIO = 2285
        ID_DO_PREMIO2 = 2277
        ID_DO_PREMIO3 = 2160

        if getPlayerLevel(cid) >= 80 then
        if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
          doTeleportThing(cid,pos)
        doPlayerSendTextMessage(cid,22,"Parabens Você Completou a Gyarados quest.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,50)
        doPlayerAddItem(cid,ID_DO_PREMIO2,1)
        doPlayerAddItem(cid,ID_DO_PREMIO3,1)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
		doTeleportThing(cid, pos)
		doSendMagicEffect(pos2, CONST_ME_TELEPORT)
          else
        doPlayerSendTextMessage(cid,22,"Você ja pegou os itens.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente levels 100+ conseguem desifrar a estatua.')
        end
return 1
end