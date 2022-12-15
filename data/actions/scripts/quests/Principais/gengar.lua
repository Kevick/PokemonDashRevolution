function onUse (cid,item,frompos,item2,topos)
pos = {x=1247, y=941, z=13}
pos2 = getPlayerPosition(cid)

        UID_DO_BAU = 1006
        STORAGE_VALUE = 1006
        ID_DO_PREMIO = 2157
        ID_DO_PREMIO2 = 7891
        ID_DO_PREMIO3 = 2146

        if getPlayerLevel(cid) >= 80 then
        if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
          doTeleportThing(cid,pos)
        doPlayerSendTextMessage(cid,22,"Parabens Você Completou a Gengar Quest.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,1)
        doPlayerAddItem(cid,ID_DO_PREMIO2,1)
        doPlayerAddItem(cid,ID_DO_PREMIO3,50)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
		sendMsgToPlayer(cid, 27, "Parabéns você terminou a Cerulean Quest!")
          else
        doPlayerSendTextMessage(cid,22,"Você ja pegou os itens.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente levels 80+ conseguem abrir este bau.')
        end
return 1
end