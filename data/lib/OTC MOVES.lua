OPCODE_MOVES = 65

function barmoves(cid)
        local msg = NetworkMessage.create()
		for cds = 1, 12 do
        msg:addU16(cds)
		msg:addU16(getPokemonCooldown(cid, cds))
		msg:addString(getMoveNamee(cid, cds))
        doSendPlayerExtendedOpcode(cid, OPCODE_MOVES, msg:getBuffer())
		print (msg:getBuffer())
        end
end
