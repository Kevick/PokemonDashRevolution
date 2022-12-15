function onDeath(cid, corpse, deathList)
   if corpse.itemid ~= 0 then --alterado v1.8
	  doItemSetAttribute(corpse.uid, "aid", 15189)
	  doItemSetAttribute(corpse.uid, "gender", getPokemonGender(cid))
	  doItemSetAttribute(corpse.uid, "level", getPlayerStorageValue(cid, 11226))
   end
return true 
end