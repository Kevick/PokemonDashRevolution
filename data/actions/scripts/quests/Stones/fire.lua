function onUse (cid,item,frompos,item2,topos)
pos = {x=987, y=935, z=8}

        UID_DO_BAU = 6000
        STORAGE_VALUE = 6000
        ID_DO_PREMIO = 2283
        ID_DO_PREMIO2 = 2283
        ID_DO_PREMIO3 = 2283


        if getPlayerLevel(cid) >= 30 then
        if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
          doTeleportThing(cid,pos)
        doPlayerSendTextMessage(cid,22,"Parabens! Você recebeu 3 fire stones!!") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,1)
        doPlayerAddItem(cid,ID_DO_PREMIO2,1)
        doPlayerAddItem(cid,ID_DO_PREMIO3,1)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
          else
        doPlayerSendTextMessage(cid,22,"Você ja pegou as stones.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente Players com Level 30+ conseguem abrir este bau.')
        end
return 1
end