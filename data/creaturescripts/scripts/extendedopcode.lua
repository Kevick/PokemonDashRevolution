OPCODE_LANGUAGE = 1
OPCODE_MOVES = 65
OPCODE_MOVES2 = 65
 
function onExtendedOpcode(cid, opcode, buffer)
        if opcode == OPCODE_LANGUAGE then
          -- otclient language
          if buffer == 'en' or buffer == 'pt' then
                  -- example, setting player language, because otclient is multi-language...
                  --doCreatureSetStorage(cid, CREATURE_STORAGE_LANGUAGE, buffer)
          end
		elseif opcode == OPCODE_MOVES then -- use valores acima de 100 ate 255
		
        local msg = NetworkMessage.create()
		for cds = 1, 12 do
        msg:addU16(cds)
		msg:addU16(getPokemonCooldown(cid, cds))
		msg:addString(getMoveNamee(cid, cds))
        doSendPlayerExtendedOpcode(cid, OPCODE_MOVES, msg:getBuffer())
		print (msg:getBuffer())
        end

        else
          -- other opcodes can be ignored, and the server will just work fine...
        end
end