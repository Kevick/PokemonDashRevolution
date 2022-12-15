LOGDEBUG_NETWORKMESSAGE = true

-- Data size
local U8  = 256^1
local U16 = 256^2
local U32 = 256^4
local U64 = 256^8

NetworkMessageTypes = {
    Boolean = 1,
    U8 = 2,
    U16 = 3,
    U32 = 4,
    U64 = 5,
    NumberString = 6,
    String = 7,
    Table = 8
}

if NetworkMessage == nil then

    NetworkMessage = {}
    
    function NetworkMessage.create(pdata, psize)
        local obj = {data = pdata, size = psize, pos = 1}
        if obj.data == nil then obj.data = {} end
        if obj.size == nil then obj.size = 0 end

        setmetatable(obj, { __index = NetworkMessage })
        return obj
    end
    
    function NetworkMessage:reset()
        self.data = {}
        self.size = 0
        self.pos = 1
    end

    function NetworkMessage:getBuffer()
        local str = ''
        for i=1,self.size do str = str .. string.char(self.data[i]) end
        return str
    end

    function NetworkMessage:setBuffer(buffer)
        local len = string.len(buffer)
        for i=1,len do
            self:addU8(tonumber(string.byte(buffer, i)))
        end
        self.pos = 1
    end

    function NetworkMessage:getSize()
        return self.size
    end
    
    function NetworkMessage:finished()
        if self.pos < self.size then 
            return false 
        end
        return true
    end
    
    function NetworkMessage:logDebug(data)
        if LOGDEBUG_NETWORKMESSAGE == true then
            print(debug.traceback(data))
        end
    end

    function NetworkMessage:addU8(value)
        if value >= U8 then
            self:logDebug("Value is greater than " .. U8 .. ".")
            return false
        end
        
        for i=0,0,-1 do
            local power = U8^i
            self.data[self.pos + i] = math.floor(value / power)
            value = value - math.floor(value / power)*power
        end
        
        self.size = self.size + 1
        self.pos = self.pos + 1
        return true
    end

    function NetworkMessage:addU16(value)
        if value >= U16 then
            self:logDebug("Value is greater than " .. U16 .. ".")
            return false
        end
        
        for i=1,0,-1 do
            local power = U8^i
            self.data[self.pos + i] = math.floor(value / power)
            value = value - math.floor(value / power)*power
        end
        
        self.size = self.size + 2
        self.pos = self.pos + 2
        return true
    end
    
    function NetworkMessage:addU32(value)
        if value >= U32 then
            self:logDebug("Value is greater than " .. U32 .. ".")
            return false
        end
        
        for i=3,0,-1 do
            local power = U8^i
            self.data[self.pos + i] = math.floor(value / power)
            value = value - math.floor(value / power)*power
        end
        self.size = self.size + 4
        self.pos = self.pos + 4
        return true
    end

    function NetworkMessage:addU64(value)
        if value >= U64 then
            self:logDebug("Value is greater than " .. U64 .. ".")
            return false
        end
        
        for i=7,0,-1 do
            local power = U8^i
            self.data[self.pos + i] = math.floor(value / power)
            value = value - math.floor(value / power)*power
        end
        self.size = self.size + 8
        self.pos = self.pos + 8
        return true
    end
    
    function NetworkMessage:addString(value)
        if not self:addU16(string.len(value)) then
            self:logDebug("String length is bigger than " .. U16 .. ".")
            return false
        end
        
        local strLen = string.len(value)
        for i=1,strLen do
            self.data[self.pos + i-1] = string.byte(value, i)
        end
        self.pos = self.pos + strLen
        self.size = self.size + strLen
        return true
    end

    function NetworkMessage:addData(data)
        if type(data) == 'boolean' then
            self:addU8(NetworkMessageTypes.Boolean)
            self:addU8(booleantonumber(data))
        elseif type(data) == 'number' then
            if math.isu8(data) then
                self:addU8(NetworkMessageTypes.U8)
                self:addU8(data)
            elseif math.isu16(data) then
                self:addU8(NetworkMessageTypes.U16)
                self:addU16(data)
            elseif math.isu32(data) then
                self:addU8(NetworkMessageTypes.U32)
                self:addU32(data)
            elseif math.isu64(data) then
                self:addU8(NetworkMessageTypes.U64)
                self:addU64(data)
            else -- negative or non integer numbers
                self:addU8(NetworkMessageTypes.NumberString)
                self:addString(tostring(data))
            end
        elseif type(data) == 'string' then
            self:addU8(NetworkMessageTypes.String)
            self:addString(data)
        elseif type(data) == 'table' then
            self:addU8(NetworkMessageTypes.Table)
            self:addTable(data)
        else
            self:logDebug('Invalid data type '  .. type(data))
        end
    end

    function NetworkMessage:addTable(data)
        local size = 0

        -- reserve for size
        local sizePos = self.pos
        self:addU16(size)
        local sizeSize = self.pos - sizePos

        -- add values
        for key,value in pairs(data) do
            self:addData(key)
            self:addData(value)
            size = size + 1
        end

        -- write size
        local currentPos = self.pos
        self.pos = sizePos
        self:addU16(size)

        -- fix msg size and go back to end
        self.size = self.size - sizeSize
        self.pos = currentPos
    end

    function NetworkMessage:addColor(r, g, b, a)
        self:addU8(r)
        self:addU8(g)
        self:addU8(b)
        self:addU8(a)
    end

    function NetworkMessage:addPosition(position)
        self:addU16(position.x)
        self:addU16(position.y)
        self:addU8(position.z)
    end

    function NetworkMessage:getU8(peek)
        if not self:canRead(1) then return false end
        local ret = 0
        for i=0,0 do ret = ret + (self.data[self.pos + i] * (U8^i)) end
        if peek == nil then self.pos = self.pos + 1 end
        return ret
    end
    
    function NetworkMessage:getU16(peek)
        if not self:canRead(2) then return false end
        local ret = 0
        for i=0,1 do ret = ret + (self.data[self.pos + i] * (U8^i)) end
        if peek == nil then self.pos = self.pos + 2 end
        return ret
    end
    
    function NetworkMessage:getU32(peek)
        if not self:canRead(4) then return false end
        local ret = 0
        for i=0,3 do ret = ret + (self.data[self.pos + i] * (U8^i)) end
        if peek == nil then self.pos = self.pos + 4 end
        return ret
    end

    function NetworkMessage:getU64(peek)
        if not self:canRead(8) then return false end
        local ret = 0
        for i=0,7 do ret = ret + (self.data[self.pos + i] * (U8^i)) end
        if peek == nil then self.pos = self.pos + 8 end
        return ret
    end
    
    function NetworkMessage:getString()
        local size = self:getU16()
        if not size then 
            return false
        end
        if not self:canRead(size) then return false end
        
        local ret = ""
        for i = 0, size-1 do
            ret = ret .. string.char(self.data[self.pos + i]) 
        end
        self.pos = self.pos + size
        return ret
    end

    function NetworkMessage:getData()
        local dataType = self:getU8()
        if dataType == NetworkMessageTypes.Boolean then
            return numbertoboolean(self:getU8())
        elseif dataType == NetworkMessageTypes.U8 then
            return self:getU8()
        elseif dataType == NetworkMessageTypes.U16 then
            return self:getU16()
        elseif dataType == NetworkMessageTypes.U32 then
            return self:getU32()
        elseif dataType == NetworkMessageTypes.U64 then
            return self:getU64()
        elseif dataType == NetworkMessageTypes.NumberString then
            return tonumber(self:getString())
        elseif dataType == NetworkMessageTypes.String then
            return self:getString()
        elseif dataType == NetworkMessageTypes.Table then
            return self:getTable()
        else
            self:logDebug('Unknown data type ' .. dataType)
        end
        return nil
    end

    function NetworkMessage:getTable()
        local ret = {}
        local size = self:getU16()
        for i=1,size do
            local index = self:getData()
            local value = self:getData()
            ret[index] = value
        end
        return ret
    end

    function NetworkMessage:getColor()
        local r = self:getU8()
        local g = self:getU8()
        local b = self:getU8()
        local a = self:getU8()
        return r,g,b,a
    end

    function NetworkMessage:getPosition()
        local position = {}
        position.x = self:getU16()
        position.y = self:getU16()
        position.z = self:getU8()
        return position
    end

    function NetworkMessage:canRead(size)
        if self.pos+size > self.size+1 then
            self:logDebug("Message has reached end.")
            return false
        end
        return true
    end
end
