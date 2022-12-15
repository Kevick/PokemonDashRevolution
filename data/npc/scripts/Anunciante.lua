-- NPC Broadcaster by Alreth, v1.40, 2008-09-22 17:50 CET
-- Idea by souhlen (Anel)
-- Thanks to Qwerty| for helping fix the spambug
-- Thanks to Colandus for providing changes for compability with Tibia 8.21/22.

focus = 0
next_focus = 0
talk_start = 0
msgHi = 'Oi! Quer Anunciar algo para todo o mundo, meu slowbro faz isso muito bem...'
msgBye = 'Peace!'
price = 100
inConvo = 0
broadcast = ''
cast = ''
target = 0
following = false
attacking = false

function onThingMove(creature, thing, oldpos, oldstackpos)
end

function onCreatureAppear(creature)
end

function onCreatureDisappear(cid, pos)
     if (focus == cid) then
        selfSay(msgBye)
        distFocus = getDistanceToCreature(next_focus)
        if (distFocus ~= nil and distFocus < 4) then
            selfSay(msgHi)
            talk_start = os.clock()
            focus = next_focus
            next_focus = 0
            inConvo = 1
        else
            focus = 0
            talk_start = 0
            inConvo = 0
        end
     end
end

function onCreatureTurn(creature)
end

function msgcontains(txt, str)
     return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msg)
    msg2 = msg
    msg = string.lower(msg)
    if (cast ~= '') then
        selfSay('does nothing')
    -- do nothing, wait until message has been broadcasted and npc has replied
    elseif (getDistanceToCreature(cid) >= 4 and focus == cid) then
        selfSay('Chegue mais perto, '..getCreatureName(cid)..'. nao posso te ouvir dai.')
        
    elseif (type == 1) then
         if ((string.find(msg, '(%a*)hi(%a*)') or string.find(msg, '(%a*)hello(%a*)') or string.find(msg, '(%a*)oi(%a*)') or string.find(msg, '(%a*)greetings(%a*)')) and (focus == 0) and getDistanceToCreature(cid) < 4) then
            selfSay(msgHi)
            focus = cid
            talk_start = os.clock()
            inConvo = 1

        elseif ((string.find(msg, '(%a*)hi(%a*)') or string.find(msg, '(%a*)hello(%a*)') or string.find(msg, '(%a*)oi(%a*)') or string.find(msg, '(%a*)greetings(%a*)')) and (focus ~= cid) and getDistanceToCreature(cid) < 4)  then
             if (next_focus > 0 and getDistanceToCreature(next_focus) < 4) then
                 selfSay('Por favor aguarde, ' .. getCreatureName(cid) .. '.')
             else
                 selfSay('Calma, ' .. getCreatureName(cid) .. '.')
                 next_focus = cid
             end

         elseif (focus == cid) then
            talk_start = os.clock()

            if ((msgcontains(msg, 'broadcast') or msgcontains(msg, 'say')) and inConvo == 0) then
                if (getPlayerLevel(cid) >= 30) then
                    selfSay('Quer que eu anuncie algo para voce?')
                    inConvo = 1
                else
                    selfSay('Volte quabo vc crescer!')
                end

            elseif ((msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and inConvo == 1) then
                selfSay('Digame oque quer anunciar.')
                inConvo = 2

            elseif ((msgcontains(msg, 'no') or msgcontains(msg, 'nao')) and inConvo == 1) then
                selfSay('Perhaps tomorrow then..')
                if (next_focus > 0 and getDistanceToCreature(next_focus) < 4) then
                    selfSay(msgHi)
                    talk_start = os.clock()
                    focus = next_focus
                    next_focus = 0
                    inConvo = 1
                else
                    focus = 0
                    talk_start = 0
                    inConvo = 0
                end
                broadcast = ''

            elseif (inConvo == 2 and (msg ~= 'stop')) then
                if (string.len(msg) > 90) then
                    selfSay('Disculpe mais sua mensagem tem mais de 90 caracteres incluindo os espacos. Diga uma nova mensagem ou diga STOP para parar no caracter 90.')
                else
                    broadcast = msg2
                    selfSay('Vc quer pagar '..price..' Dollars para eu anunciar sua mensagem "'..broadcast..'"')
                    inConvo = 3
                end

            elseif ((msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and inConvo == 3) then
                if (doPlayerRemoveItem(cid, 2152, 100) or doPlayerRemoveItem(cid, 2160, 1)) == TRUE then
                    doPlayerBroadcastMessage(cid, broadcast)
                    saycast = os.clock()
                    inConvo = 1
                    
                    io.output(io.open("broadcast.log", "a"))
                    io.write("["..os.date("%y.%m.%d %X").."] <"..getCreatureName(cid).."> "..broadcast.."\n")
                    io.close()
                    cast = broadcast
                else
                    selfSay('Voce nao pode pagar pelo servico, por favor volte mais tarde com o dinheiro!')
                    if (next_focus > 0) then
                        distFocus = getDistanceToCreature(next_focus)
                        if (distFocus ~= nil and distFocus < 4) then
                            selfSay(msgHi)
                            talk_start = os.clock()
                            focus = next_focus
                            next_focus = 0
                            inConvo = 1
                        else
                            focus = 0
                            talk_start = 0
                            inConvo = 0
                        end
                        broadcast = ''
                    end
                end

            elseif ((msgcontains(msg, 'no') or msgcontains(msg, 'nao')) and inConvo == 3) then
                selfSay('Ok then.')
                inConvo = 0
                broadcast = ''

            elseif (string.find(msg, '(%a*)offer(%a*)')) then
                selfSay('Eu tenho a voz mais potento do mundo! Pessoas me pagam para eu anunciar coisas para elas.')
                inConvo = 0

             elseif (string.find(msg, '(%a*)bye(%a*)')) then
                selfSay(msgBye)
                if (next_focus > 0) then
                    distFocus = getDistanceToCreature(next_focus)
                    if (distFocus ~= nil and distFocus < 4) then
                        selfSay(msgHi)
                        talk_start = os.clock()
                        focus = next_focus
                        next_focus = 0
                        inConvo = 1
                    else
                        focus = 0
                        talk_start = 0
                        inConvo = 0
                    end
                    broadcast = ''
                 end
             end
         end
     end
end


function onCreatureChangeOutfit(creature)
end

function onThink()
    if (cast ~= '' and (os.clock() - saycast) > 1) then
        selfSay('Quer anunciar mais?')
        cast = ''
    elseif (os.clock() - talk_start) > 30 then
        if (focus > 0) then    
            selfSay(msgBye)
            if (next_focus > 0) then
                distFocus = getDistanceToCreature(next_focus)
                if (distFocus ~= nil and distFocus < 4) then
                    selfSay(msgHi)
                    talk_start = os.clock()
                    focus = next_focus
                    next_focus = 0
                    inConvo = 1
                else
                    focus = 0
                    talk_start = 0
                    inConvo = 0
                end
            else
                focus = 0
                talk_start = 0
                inConvo = 0
            end
            broadcast = ''
        end
     elseif (focus ~= 0) then
         distFocus = getDistanceToCreature(focus)
        if (distFocus ~= nil and distFocus > 5) then
            selfSay(msgBye)
            if (next_focus > 0) then
                distFocus = getDistanceToCreature(next_focus)
                if (distFocus ~= nil and distFocus < 4) then
                    selfSay(msgHi)
                    talk_start = os.clock()
                    focus = next_focus
                    next_focus = 0
                    inConvo = 1
                end
            else
                focus = 0
                talk_start = 0
                inConvo = 0
            end
            broadcast = ''
        end
    end
end
