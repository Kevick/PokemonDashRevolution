function onUse (cid,item,frompos,item2,topos)
pos = {x=918, y=938, z=13}

        UID_DO_BAU = 1008
        STORAGE_VALUE = 1008
        ID_DO_PREMIO = 2160
        ID_DO_PREMIO2 = 2146
        ID_DO_PREMIO3 = 2645
        ID_DO_PREMIO4 = 7886

        if getPlayerLevel(cid) >= 30 then
        if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
          doTeleportThing(cid,pos)
        doPlayerSendTextMessage(cid,22,"Parabens! Voc� Completou a Cerulean Quest!") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,30)
        doPlayerAddItem(cid,ID_DO_PREMIO2,30)
        doPlayerAddItem(cid,ID_DO_PREMIO3,50)
        doPlayerAddItem(cid,ID_DO_PREMIO4,1)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
		sendMsgToPlayer(cid, 27, "Parab�ns voc� terminou a Cerulean Quest!")
          else
        doPlayerSendTextMessage(cid,22,"Voc� ja pegou os itens.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente Players com Level 30+ conseguem abrir este bau.')
        end
return 1
end