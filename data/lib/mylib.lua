function doCreateTile(cid, tileid, pos)
        doCombatAreaHealth(cid, 0, pos, 0, 0, 0, CONST_ME_NONE)
        doCreateItem(tileid, 1, pos)
end

grass3 = {
"Bulbasaur",
"Shiny Bulbasaur",

"Ivysaur",
"Shiny Ivysaur",

"Venusaur",
"Shiny Venusaur",

"Oddish",
"Shiny Oddish",


"Gloom",
"Shiny Gloom",

"Vileplume",
"Shiny Vileplume",

"Bellsprout",
"Shiny Bellsprout",

"Weepinbell",
"Shiny Weepinbell",

"Victreebel",
"Shiny Victreebel",

"Exeggcute",
"Shiny Exeggcute",

"Exeggutor",
"Shiny Exeggutor",

"Tangela",
"Shiny Tangela"
}

fire3 = {
"Charmander",
"Shiny Charmander",

"Charmeleon",
"Shiny Charmeleon",

"Charizard",
"Elder Charizard",

"Vulpix",
"Shiny Vulpix",

"Ninetales",
"Shiny Ninetales",

"Growlithe",
"Shiny Growlithe",

"Arcanine",
"Shiny Arcanine",

"Ponyta",
"Shiny Ponyta",

"Rapidash",
"Shiny Rapidash",

"Magmar",
"Shiny Magmar",

"Flareon",
"Shiny Flareon",

"Moltres",
"Shiny Moltres"
}

water3 = {
"Squirtle",
"Shiny Squirtle",

"Wartortle",
"Shiny Wartortle",

"Blastoise",
"Shiny Blastoise",


"Psyduck",
"Shiny Psyduck",

"Golduck",
"Shiny Golduck",

"Poliwag",
"Shiny Poliwag",

"Poliwhirl",
"Shiny Poliwhirl",

"Poliwrath",
"Shiny Poliwrath",

"Tentacool",
"Shiny Tentacool",


"Tentacruel",
"Shiny Tentacruel",

"Slowpoke",
"Shiny Slowpoke",

"Slowbro",
"Shiny Slowbro",

"Seel",
"Shiny Seel",

"Dewgong",
"Shiny Dewgong",

"Cloyster",
"Shiny Cloyster",

"Krabby",
"Shiny Krabby",

"Kingler",
"Shiny Kingler",

"Horsea",
"Shiny Horsea",


"Seadra",
"Shiny Seadra",

"Goldeen",
"Shiny Goldeen",

"Seaking",
"Shiny Seaking",

"Staryu",
"Shiny Staryu",

"Starmie",
"Shiny Starmie",

"Magikarp",
"Shiny Magikarp",


"Gyarados",
"Red Gyarados",

"Lapras",
"Shiny Lapras",

"Vaporeon",
"Shiny Vaporeon"

}

bug3 = {
"Caterpie",
"Shiny Caterpie",

"Metapod",
"Shiny Metapod",

"Butterfree",
"Shiny Butterfree",


"Weedle",
"Shiny Weedle",

"Kakuna",
"Shiny Kakuna",

"Beedrill",
"Shiny Beedrill",

"Paras",
"Shiny Paras",

"Parasect",
"Shiny Parasect",


"Venonat",
"Shiny Venonat",

"Venomoth",
"Shiny Venomoth",

"Scyther",
"Shiny Scyther",

"Pinsir",
"Shiny Pinsir"
}

electric3 = {
"Pikachu",
"Shiny Pikachu",

"Raichu",
"Shiny Raichu",


"Magnemite",
"Shiny Magnemite",

"Magneton",
"Shiny Magneton",

"Voltorb",
"Shiny Voltorb",

"Electrode",
"Shiny Electrode",


"Electabuzz",
"Shiny Electabuzz",


"Jolteon",
"Shiny Jolteon",

"Zapdos"
}


normal3 = {
"Rattata",
"Shiny Rattata",

"Raticate",
"Shiny Raticate",


"Clefairy",
"Shiny Clefairy",

"Clefable",
"Shiny Clefable",

"Meowth",
"Shiny Meowth",

"Persian",
"Shiny Persian",


"Doduo",
"Shiny Doduo",

"Dodrio",
"Shiny Dodrio",

"Lickitung",
"Shiny Lickitung",

"Chansey",
"Shiny Chansey",

"Kangaskhan",
"Shiny Kangaskhan",

"Tauros",
"Shiny Tauros",

"Ditto",
"Shiny Ditto",

"Eevee",
"Shiny Eevee",

"Snorlax",
"Shiny Snorlax"
}

flying3 = {
"Pidgey",
"Shiny Pidgey",

"Pidgeotto",
"Shiny Pidgeotto",

"Pidgeot",
"Shiny Pidgeot",

"Spearow",
"Shiny Spearow",
"Fearow",
"Shiny Fearow",

"Farfetchd",
"Shiny Farfetchd"
}

poison3 = {
"Ekans",
"Shiny Ekans",

"Arbok",
"Shiny Arbok",

"Nidoran Female",
"Shiny Nidoran Female",

"Nidorina",
"Shiny Nidorina",

"Nidoqueen",
"Shiny Nidoqueen",

"Nidoran Male",
"Shiny Nidoran Male",

"Nidorino",
"Shiny Nidorino",

"Nidoking",
"Shiny Nidoking",

"Zubat",
"Shiny Zubat",

"Golbat",
"Shiny Golbat",

"Grimer",
"Shiny Grimer",


"Muk",
"Shiny Muk",


"Koffing",
"Shiny Koffing",

"Weezing",
"Shiny Weezing"
}

psychic3 = {
"Abra",
"Dark Abra",
"Kadabra",
"Dark Kadabra", -- os shiny são elemento dark --
"Alakazam",
"Dark Alakazam",


"Drowzee",
"Shiny Drowzee",

"Hypno",
"Shiny Hypno",

"Mr. Mime",
"Mewtwo",
"Mew"
}

dragon3 = {
"Dratini",
"Shiny Dratini",


"Dragonair",
"Shiny Dragonair",

"Dragonite",
"Shiny Dragonite"
}

rock3 = {
"Geodude",
"Shiny Geodude",

"Graveler",
"Shiny Graveler",

"Golem",
"Shiny Golem",

"Onix",
"Crystal Onix",

"Omanyte",
"Shiny Omanyte",

"Omastar",
"Shiny Omastar",

"Kabuto",
"Shiny Kabuto",

"Kabutops",
"Shiny Kabutops",

"Aerodactyl",
"Shiny Aerodactyl"
}

ground3 = {
"Sandshrew",
"Shiny Sandshrew",

"Sandslash",
"Shiny Sandslash",

"Diglett",
"Shiny Diglett",

"Dugtrio",
"Shiny Dugtrio",

"Geodude",
"Shiny Geodude",

"Graveler",
"Shiny Graveler",

"Golem",
"Shiny Golem",

"Onix",
"Crystal Onix",

"Cubone",
"Shiny Cubone",

"Marowak",
"Shiny Marowak",

"Rhyhorn",
"Shiny Rhyhorn",

"Rhydon",
"Shiny Rhydon"
}

ice3 = {
"Jynx",
"Shiny Jynx",


"Articuno",
"Shiny Articuno"
}

ghost3 = {
"Gastly",
"Haunter",

"Gengar",
"Shiny Gengar"

}

fighting3 = {
"Machop",
"Shiny Machop",

"Machoke",
"Shiny Machoke",

"Machamp",
"Shiny Machamp",

"Mankey",
"Shiny Mankey",

"Primeape",
"Shiny Primeape",

"Hitmonlee",
"Elite Hitmonlee",

"Hitmonchan",
"Elite Hitmonchan"

}

