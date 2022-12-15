moves = {}
bars = {}
event = nil
eventBars = nil

function updateBars()
	bars[1].bar:setPercent(bars[1].bar:getPercent())
	bars[2].bar:setPercent(bars[2].bar:getPercent())
	bars[3].bar:setPercent(bars[3].bar:getPercent())
	bars[4].bar:setPercent(bars[4].bar:getPercent())
	bars[5].bar:setPercent(bars[5].bar:getPercent())
	bars[6].bar:setPercent(bars[6].bar:getPercent())
	bars[7].bar:setPercent(bars[7].bar:getPercent())
	bars[8].bar:setPercent(bars[8].bar:getPercent())
	bars[9].bar:setPercent(bars[9].bar:getPercent())
	bars[10].bar:setPercent(bars[10].bar:getPercent())
	bars[11].bar:setPercent(bars[11].bar:getPercent())
	bars[12].bar:setPercent(bars[12].bar:getPercent())
	eventBars = nil
end

function init()
 
	movesButton = modules.client_topmenu.addRightGameToggleButton('movesButton', tr('Moves'), '/images/topbuttons/moves', toggle)
	movesButton:setOn(false)

	movesWindow = g_ui.loadUI('moves', modules.game_interface.getRightPanel())
	movesWindow:disableResize()
	for i = 1, 12 do
		bars[i] = {}
		bars[i].bar = movesWindow:recursiveGetChildById('movebar'..i)
		bars[i].label = movesWindow:recursiveGetChildById('movelabel'..i)
		bars[i].max = 1
		bars[i].min = 1
		bars[i].name = ''
	end
	connect(g_game, 'onTextMessage', onCode)
	movesWindow:setup()
	movesWindow:close()
end

function terminate()	
	movesWindow:destroy()
	movesButton:destroy()
	movesWindow = nil
	movesButton = nil
	nextPrintEvent = nil
	timer = nil
	bars = nil
	moves = nil
	disconnect(g_game, 'onTextMessage', onCode)
end

function checkCds()
g_game.talk('/CdsUpdate')
end

function toggle()
	if movesButton:isOn() then
		movesWindow:close()
		movesButton:setOn(false)
	else
		checkCds()
	end
end

function onMiniWindowClose()
	movesButton:setOn(false)
end

function onCode(mode, text)
if not g_game.isOnline() then return end
    if mode == MessageModes.Failure then 
	    if string.find(text, '@M|') then
			onMove(text)
		end
	end
end

function CheckHeight()
	local height = 194
	for i = 0, 11 do
		if bars[12-i].bar:isVisible() then break end 
		height = height - 14
		if i == 11 then
			movesWindow:setHeight(24)
			return true
		end
	end
	movesWindow:setHeight(height)
end

function onMove(text)
    if text == '@M|hide' then
		movesWindow:close()
		movesButton:setOn(false)
	return true
	end
	movesWindow:open()
	movesButton:setOn(true)
    local t = text:explode("|")
	table.remove(t, 1)
	i = tonumber(t[1])
	m = tonumber(t[2])
	name = t[3]
	if name == nil then return true end
	bars[i].name = name
	if (m > 0) and (m < 65530) then
		bars[i].label:setText(i .. '. ' .. name .. ' - 0%')
		bars[i].bar:setPercent(0)
		if bars[i].min <= 1 then
			bars[i].min = os.time()
		end
		bars[i].max = os.time() + m
		bars[i].bar:setVisible(true)
		bars[i].label:setVisible(true)
	elseif (m == 0) then
		bars[i].label:setText(i .. '. ' .. name .. ' - 100%')
		bars[i].bar:setPercent(100)
		bars[i].min = 1
		bars[i].max = 1
		bars[i].bar:setVisible(true)
		bars[i].label:setVisible(true)
	elseif (m == 65534) then
		bars[i].bar:setVisible(false)
		bars[i].label:setVisible(false)
	end
		if name == "n/n" then
		bars[i].bar:setVisible(false)
		bars[i].label:setVisible(false)
		end
	CheckHeight()
	if not event then
		event = scheduleEvent(onEvent, 0)
	end
	if not eventBars then
		eventBars = scheduleEvent(updateBars, 1)
	end
	return true
end

function onEvent()
	printagain = false
	for i=1, 12 do
		if bars[i].bar:isVisible() then
			prc = 0
			if os.time() > bars[i].max then
				prc = 100
				bars[i].bar:setColor('#86ee1c')
				bars[i].bar:setBackgroundColor('#86ee1c')
				bars[i].min = 1
				bars[i].max = 1
			else
				prc = math.floor((os.time() - bars[i].min) * 100 / (bars[i].max+1 - bars[i].min))
				bars[i].bar:setColor('#ffa244')
				bars[i].bar:setBackgroundColor('#ffa244')
				if not printagain then
					printagain = true
				end
			end
			bars[i].label:setText(i .. '. ' .. bars[i].name .. ' - ' .. prc .. '%')
			bars[i].bar:setPercent(prc)
		end
	end
	if not printagain then
		event = nil
	else
		event = scheduleEvent(onEvent, 10)
	end
end

function MoveUpdate(move)
g_game.talk("m"..move)
end