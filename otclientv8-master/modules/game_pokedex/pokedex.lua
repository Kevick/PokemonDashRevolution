local pokedexWindow = nil
local pokedexButton = nil

local pokemons = {"Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie",
"Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate", "Spearow",
"Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran Female", "Nidorina", "Nidoqueen",
"Nidoran Male", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff", "Zubat", "Golbat",
"Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian",
"Psyduck", "Golduck", "Mankey", "Primeape", "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell",
"Victreebel", "Tentacool", "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
"Magnemite", "Magneton", "Farfetchd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk", "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix",
"Drowzee", "Hypno", "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak", "Hitmonlee",
"Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen",
"Seaking", "Staryu", "Starmie", "MrMime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp",
"Gyarados", "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar", "Kabuto",
"Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres", "Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew",
"Aipom", "Ampharos", "Ariados", "Bayleef", "Bellossom", "Bellossom", "Blissey", "Celebi", "Chikorita", "Chinchou", "Cleffa",
"Corsola", "Crobat", "Croconaw", "Cyndaquil", "Delibird", "Donphan", "Dunsparce", "Dunsparce", "Elekid", "Entei", "Espeon",
"Feraligatr", "Flaaffy", "Forretress", "Furret", "Gallade", "Girafarig", "Gligar", "Granbull", "Heracross", "Hitmontop",
"Ho oh", "Hoothoot", "Hoppip", "Houndoom", "Houndor", "Igglybuff", "Jumpluff", "Kingdra", "Lanturn", "Larvitar", "Ledian",
"Ledyba", "Lugia", "Magby", "Magcarbo", "Mantine", "Mareep", "Marill", "Meganium", "Miltank", "Misdreavus", "Murkrow",
"Natu", "Noctowl", "Octillery", "Phanpy", "Pichu", "Piloswine", "Pineco", "Politoed", "Porygon2", "Pupitar", "Quaqsire",
"Quilava", "Qwilfish", "Raikou", "Remoraid", "Scizor", "Shuckle", "Skarmory", "Skiploom", "Slowking", "Slugma", "Smeargle",
"Smoochum", "Sneasel", "Sentret", "Snubbull", "Spinarak", "Stantler", "Steelix", "Sudowoodo", "Suicune", "Sunflora",
"Sunkern", "Swinub", "Teddiursa", "Togepi", "Togetic", "Totodile", "Typhlosion", "Tyranitar", "Tyrogue", "Umbreon", "Unown",
"Ursaring", "Wobbuffet", "Wooper", "Xatu", "Yanma"}

function init()
  connect(g_game, { onGameEnd = hide } )
  pokedexButton = modules.client_topmenu.addRightGameToggleButton('pokedexButton', 'Pokedex', '/images/topbuttons/pokedex', toggle)
  pokedexButton:setOn(false)
  
  connect(g_game, 'onTextMessage', onMsg)
  
  pokedexWindow = g_ui.displayUI('pokedex', modules.game_interface.getRootPanel())
  pokedexWindow:setVisible(false)
  online()
  
end

function terminate()
  disconnect(g_game, { onGameEnd = hide })
  disconnect(g_game, 'onTextMessage', onMsg)
  pokedexWindow:destroy()
end

function toggle()
  if pokedexButton:isOn() then
    pokedexWindow:hide()
    pokedexButton:setOn(false)
  else
    pokedexWindow:show()
    pokedexButton:setOn(true)
  end
end

function hide()
   pokedexWindow:hide()
   pokedexButton:setOn(false)
end

function DoubleClick(window, name)
        pokedexWindow:hide()
        g_game.talk("/dex "..name) 
end

function onMsg(mode, text)
if not g_game.isOnline() then return end
    if mode == MessageModes.Failure then 
	    if string.find(text, '#dex#|') then
			onDex(text)
		end
	end
end

function online()
   pokedexWindow:setVisible(false)
   
   local pokelistDex = pokedexWindow:recursiveGetChildById('pokedexList')
   for id, name in ipairs(pokemons) do
       local label = g_ui.createWidget('ModuleListLabel', pokelistDex) 
       
       if id < 10 then
         number = "#00"..id 
       elseif id > 9 and id < 100 then
         number = "#0"..id 
       else
         number = "#"..id 
       end
       

      label:setText(number.." - "..name)
      label.onDoubleClick = function() DoubleClick(pokedexWindow, name) end
       
                                  
   end
end

function onDex(text)
  pokedexWindow:setVisible(true)
  print(text)
  
  local b = text:explode("|")
  local i = b[2]
  local iconDex = pokedexWindow:recursiveGetChildById("pokedexIcon")
  iconDex:setItemId(i)
   
  local name = ""..b[3]..".txt"
  local descDex = pokedexWindow:recursiveGetChildById("pokedexDesc")
  local patch = io.open('data/pokesinfo/'..name, 'r')
  descDex:setText(patch:read("*all"))
end