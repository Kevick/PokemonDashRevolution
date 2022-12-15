local a = {
[7884] = {balltype = "poke", ballid = 2222,
        pokemons = {"Slowpoke", "Magnemite", "Doduo", "Seel", "Grimer", "Gastly", "Drowzee", "Voltorb", "Cubone", "Koffing",
        "Goldeen", "Vulpix", "Tentacool", "Bulbasaur", "Charmander", "Squirtle", "Butterfree", "Beedrill", "Metapod", "Kakuna",
        "Raticate", "Spearow", "Ekans", "Abra", "Mankey", "Psyduck", "Pikachu", "Sandshrew", "Nidoran Female",
        "Nidoran Male", "Zubat", "Diglett", "Venonat", "Meowth", "Poliwag", "Growlithe", "Machop", "Ponyta", "Geodude"}},
[7885] = {balltype = "great", ballid = 2651,
        pokemons = {"Pidgeotto", "Weepinbell", "Clefairy", "Omanyte", "Kabuto", "Arbok", "Raichu", "Nidorino", "Nidorina",
        "Dodrio", "Muk", "Golbat", "Gloom", "Parasect", "Venomoth", "Dugtrio", "Persian", "Poliwhirl", "Victreebel", "Machoke",
        "Graveler", "Slowbro", "Magneton", "Farfetch'd", "Haunter", "Kingler", "Electrode", "Weezing", "Rhyhorn", "Seadra",
        "Jigglypuff", "Seaking", "Tauros", "Starmie", "Eevee", "Dratini", "Charmeleon", "Wartortle", "Ivysaur"}},
[7886] = {balltype = "super", ballid = 2653,
        pokemons = {"Pidgeot", "Fearow", "Sandslash", "Ninetales", "Vileplume", "Primeape", "Golduck", "Kadabra", "Rapidash",
        "Clefable", "Wigglytuff", "Dewgong", "Onix", "Cloyster", "Hypno", "Exeggutor", "Marowak", "Hitmonchan", "Hitmonlee",
        "Lickitung", "Chansey", "Tangela", "Mr. Mime", "Pinsir", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Dragonair"}},
[7891] = {balltype = "ultra", ballid = 2220,
        pokemons = {"Dragonite", "Snorlax", "Kabutops", "Omastar",
        "Lapras", "Gyarados", "Magmar", "Electabuzz", "Jynx", "Scyther", "Kangaskhan", "Golem", "Venusaur",
        "Machamp", "Poliwrath", "Arcanine", "Nidoking", "Nidoqueen", "Charizard", "Blastoise", "Tentacruel", "Alakazam",
        "Gengar", "Rhydon"}}
}

function onUse(cid, item, frompos, item2, topos)
local b = a[item.itemid]
local gender = nil
    if not b then return true end
    local pokemon = b.pokemons[math.random(#b.pokemons)]
    doPlayerSendTextMessage(cid, 27, "You opened a pokemon box!")
    doSendMagicEffect(getThingPos(cid), 29)
    doPokemonToPlayer(cid, pokemon, b.ballid)
    doRemoveItem(item.uid, 1)
return true
end