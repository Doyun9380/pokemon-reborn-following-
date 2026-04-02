#this is the hash that will become the full multforms hash
PokemonForms = {
PBSpecies::UNOWN => {
	:OnCreation => proc{rand(28)}
},

PBSpecies::MISSINGNO => {
	#:OnCreation => proc{rand(6)}
	:FormName => {
		0 => "Missingno",
		1 => "Omegamon"
	},
	"Omegamon" => {
		:BaseStats => [115,145,120,130,145,120],
		:Type1 => PBTypes::QMARKS,
		:Ability => PBAbilities::STELLAREAN
		}
},

PBSpecies::PALDIATINA => {
	:FormName => {
		0 => "Original",
		1 => "NeoN",
		2 => "NeoN Mega"
	},
	
	:DefaultForm => 1,
	:PulseForm => 1,
	:MegaForm => 2,
	
	"NeoN" => {
		:BaseStats => [90,150,120,150,120,120],
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::DRAGON,
		:Ability => PBAbilities::RENEGADEPLATINUM
		},
	
	"NeoN Mega" => {
		:BaseStats => [150,120,120,120,150,120],
		:Type1 => PBTypes::SWG,
		:Type2 => PBTypes::COSMIC,
		:Ability => PBAbilities::NIGHOMNIPOTENCE
		}
},

PBSpecies::FLABEBE => {
	:OnCreation => proc{rand(5)}
},

PBSpecies::SQUAWKABILLY => {
	:FormName => {
		0 => "Green",
		1 => "Blue",
		2 => "Yellow",
		3 => "White"
	},
	:OnCreation => proc{rand(4)},

	"Blue" => {
		:DexEntry => "Blue-feathered Squawkabilly view their green-feathered counterparts as rivals, since the latter make up the largest, most powerful groups."
	},

	"Yellow" => {
		:DexEntry => "These Squawkabilly are hotheaded, and their fighting style is vicious. They’ll leap within reach of their foes to engage in close combat."
	},

	"White" => {
		:DexEntry => "This Pokémon dislikes being alone. It has a strong sense of community and survives by cooperating with allies."
	}
},

PBSpecies::CASTFORM => {
	:FormName => {
		1 => "Sunny Form",
		2 => "Rainy Form",
		3 => "Snowy Form",
		4 => "Sandy Form",
		9 => "Amalgaform"
	},
	"Sunny Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FIRE
	},
	"Rainy Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::WATER
	},
	"Snowy Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE
	},
	"Sandy Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::ROCK
	},
	"Amalgaform" =>  {
		:BaseStats => [250,120,200,70,110,200],
		:EVs => [12,0,0,0,0,0],
		:type1 => PBTypes::QMARKS,
		:type2 => PBTypes::QMARKS
	}
},

PBSpecies::DEOXYS => {
	:FormName => {
		1 => "Attack Form",
		2 => "Defense Form",
		3 => "Speed Form",
		4 => "PULSE",
		5 => "Health Form"
	},

	:DefaultForm => 0, #Not really
	:PulseForm => 4,

	"Attack Form" => {
		:BaseStats => [50,180,20,150,180,20],
		:EVs => [0,2,0,0,1,0],
	},

	"Defense Form" => {
		:BaseStats => [50, 70,160, 90, 70,160],
		:EVs => [0,0,2,0,0,1],
	},

	"Speed Form" => {
		:BaseStats => [50, 95, 90,180, 95, 90],
		:EVs => [0,0,0,3,0,0],
	},

	"PULSE" => {
		:BaseStats => [50,180,160,180,180,160],
		:EVs => [0,2,2,3,1,1],
		:Ability => PBAbilities::STELLAREAN
	},

	"Health Form" => {
		:BaseStats => [150,95,90,180,95,90],
		:EVs => [0,0,0,3,0,0],
	}
},

PBSpecies::BURMY => {
	:FormName => {
		1 => "Sandy Cloak",
		2 => "Trash Cloak"
	},

	:OnCreation => proc{
		begin #horribly stupid section to make the battle stress test work
		case $fefieldeffect
			when 1,5,6,10,11,17,18,19,24,26,29,30,35,36,37
				next 2 # Trash Cloak
			when 2,3,7,8,9,15,21,22,31,33,34
				next 0 # Plant Cloak
			when 4,12,13,14,16,20,23,25,27,28,32
				next 1 # Sandy Cloak
		end
		env=pbGetEnvironment()
		if env==PBEnvironment::Sand || env==PBEnvironment::Rock || env==PBEnvironment::Cave
			next 1 # Sandy Cloak
		elsif !pbGetMetadata($game_map.map_id,MetadataOutdoor)
			next 2 # Trash Cloak
		else
			next 0 # Plant Cloak
		end
		rescue
			next 0
		end
	}
},

PBSpecies::WORMADAM => {
	:FormName => {
		1 => "Sandy Cloak",
		2 => "Trash Cloak"
	},

	:OnCreation => proc{
		begin #horribly stupid section to make the battle stress test work
		case $fefieldeffect
			when 1,5,6,10,11,17,18,19,24,26,29,30,35,36,37
				next 2 # Trash Cloak
			when 2,3,7,8,9,15,21,22,31,33,34
				next 0 # Plant Cloak
			when 4,12,13,14,16,20,23,25,27,28,32
				next 1 # Sandy Cloak
		end
		env=pbGetEnvironment()
		if env==PBEnvironment::Sand || env==PBEnvironment::Rock || env==PBEnvironment::Cave
			next 1 # Sandy Cloak
		elsif !pbGetMetadata($game_map.map_id,MetadataOutdoor)
			next 2 # Trash Cloak
		else
			next 0 # Plant Cloak
		end
		rescue
			next 0
		end
	},

	"Sandy Cloak" => {
		:BaseStats => [60,79,105,36,59,85],
		:EVs => [0,0,2,0,0,0],
		:Type2 => PBTypes::GROUND,
		:Movelist => [[0,PBMoves::GUST],[1,PBMoves::LEAFSTORM],[1,PBMoves::ROLLOUT],[1,PBMoves::MUDSLAP],
		[1,PBMoves::GUST],[1,PBMoves::TACKLE],[1,PBMoves::PROTECT],[1,PBMoves::STRUGGLEBUG],
		[10,PBMoves::STRINGSHOT],[15,PBMoves::BUGBITE],[20,PBMoves::HIDDENPOWER],[23,PBMoves::CONFUSION],
		[26,PBMoves::ROCKBLAST],[28,PBMoves::HARDEN],[30,PBMoves::INFESTATION],[32,PBMoves::CAPTIVATE],
		[35,PBMoves::PSYBEAM],[37,PBMoves::SILVERWIND],[39,PBMoves::FLAIL],[41,PBMoves::ATTRACT],
		[43,PBMoves::EARTHPOWER],[45,PBMoves::PSYCHIC],[47,PBMoves::FISSURE],[50,PBMoves::SUCKERPUNCH],
		[53,PBMoves::BUGBUZZ],[56,PBMoves::QUIVERDANCE]],
	},

	"Trash Cloak" => {
		:BaseStats => [60,69,95,36,69,95],
		:EVs => [0,0,1,0,0,1],
		:Type2 => PBTypes::STEEL,
		:Movelist => [[0,PBMoves::GUST],[1,PBMoves::MAGNETRISE],[1,PBMoves::TELEKINESIS],
		[1,PBMoves::ALLYSWITCH],[1,PBMoves::GUST],[1,PBMoves::TACKLE],[1,PBMoves::PROTECT],
		[1,PBMoves::STRUGGLEBUG],[10,PBMoves::STRINGSHOT],[15,PBMoves::BUGBITE],[20,PBMoves::HIDDENPOWER],
		[23,PBMoves::CONFUSION],[26,PBMoves::MIRRORSHOT],[28,PBMoves::METALSOUND],[30,PBMoves::INFESTATION],
		[32,PBMoves::CAPTIVATE],[35,PBMoves::PSYBEAM],[37,PBMoves::SILVERWIND],[39,PBMoves::FLAIL],
		[41,PBMoves::ATTRACT],[43,PBMoves::IRONHEAD],[45,PBMoves::PSYCHIC],[47,PBMoves::METALBURST],
		[50,PBMoves::SUCKERPUNCH],[53,PBMoves::BUGBUZZ],[56,PBMoves::QUIVERDANCE]],
	}
},

PBSpecies::CHERRIM => {
	:FormName => {
		1 => "Sunshine Form"
	},

	"Sunshine Form" => {
		:BaseStats => [70,90,70,85,87,117],
		:Type2 => PBTypes::FAIRY,
	}
},

PBSpecies::SHELLOS => {
	:OnCreation => proc{
		maps=[206,513,519,522,526,528,530,536,538,547,553,555,556,558,562,563,565,566,567,569,574,585,586,603,604,605,608,610] # Map IDs for second form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	}
},

PBSpecies::ROTOM => {
	:FormName => {
		1 => "Heat",
		2 => "Wash",
		3 => "Frost",
		4 => "Fan",
		5 => "Mow"
	},

	"Heat" => {
		:Type2 => PBTypes::FIRE,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::SOLARPOWER,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Wash" => {
		:Type2 => PBTypes::WATER,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::WATERABSORB,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Frost" => {
		:Type2 => PBTypes::ICE,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::SNOWWARNING,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Fan" => {
		:Type2 => PBTypes::FLYING,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::WINDPOWER,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Mow" => {
		:Type2 => PBTypes::GRASS,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::GRASSYSURGE,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	}
},

PBSpecies::GIRATINA => {
	:FormName => {
		0 => "Altered",
		1 => "Origin",
		2 => "Cyrus' Origin",
		3 => "Cyrus' Cosmic"
	},

	"Origin" => {
		:BaseStats => [150,120,100,90,120,100],
		:Ability => PBAbilities::RENEGADEPLATINUM,
		:Height => 69,
		:Weight => 6500
	},

	"Cyrus' Origin" => {
		:BaseStats => [155,125,105,95,125,105],
		:Ability => PBAbilities::LEVITATE,
		:Height => 69,
		:Weight => 6500
	},

	"Cyrus' Cosmic" => {
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [155,125,105,95,125,105],
		:Ability => PBAbilities::LEVITATE,
		:Height => 69,
		:Weight => 6500
	}
},

PBSpecies::PALKIA => {
	:FormName => {
		0 => "Altered",
		1 => "Origin"
	},

	"Origin" => {
		:BaseStats => [90,100,100,120,150,120],
		:Ability => PBAbilities::SHININGPEARL,
		:Weight => 6600
	}
},

PBSpecies::DIALGA => {
	:FormName => {
		0 => "Altered",
		1 => "Origin",
		2 => "Primal"
	},

	"Origin" => {
		:BaseStats => [100,100,120,90,150,120],
		:Ability => PBAbilities::BRILLIANTDIAMOND,
		:Weight => 8500,
		:Height => 700
	},

	"Primal" => {
		:BaseStats => [100,170,65,110,170,65],
		:Weight => 683
	}
},

PBSpecies::SHAYMIN => {
	:FormName => {1 => "Sky"},

	"Sky" => {
		:BaseStats => [100,103,75,127,120,75],
		:EVs => [0,0,0,3,0,0],
		:Type2 => PBTypes::FLYING,
		:Ability => PBAbilities::GRACEFULBLOOM,
		:Height => 04,
		:Weight => 52
	}
},

PBSpecies::BASCULIN => {
	:FormName => {
		0 => "White-Striped",
		1 => "Red-Striped",
		2 => "Blue-Striped"
	},
	:OnCreation => proc{rand(3)},

	"Red-Striped" => {
		:DexEntry => "Its temperament is vicious and aggressive. This Pokémon is also full of vitality and can multiply rapidly before anyone notices.",
		:WildHoldItems => [0,PBItems::DEEPSEATOOTH,0],
		:GetEvo => []
	},

	"Blue-Striped" => {
		:DexEntry => "The power of its jaws is immense—enough to leave teeth marks in iron sheets. Its personality is also extremely vicious.",
		:WildHoldItems => [0,PBItems::DEEPSEASCALE,0],
		:GetEvo => []
	}
},

PBSpecies::BASCULEGION => {
	#Gender difference
	"Female" => {
		:DexEntry => "It can afflict a target with terrifying illusions that are under its control. The deeper the sadness in its friends' souls, the paler Basculegion becomes.",
		:BaseStats => [120,80,65,78,112,75] #Canon: [120,92,65,78,100,75]
	}
},

PBSpecies::DARUMAKA => {
	:FormName => {2 => "Galarian"},

	:OnCreation => proc{
		maps=[412] # Map IDs for Galarian form
		next $game_map && maps.include?($game_map.map_id) ? 2 : 0
	},

	"Galarian" => {
		:DexEntry => "It lived in snowy areas for so long that its fire sac cooled off and atrophied. It now has an organ that generates cold instead.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE,
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TACKLE],[4,PBMoves::TAUNT],[8,PBMoves::BITE],
			[12,PBMoves::HEADBUTT],[16,PBMoves::AVALANCHE],[20,PBMoves::WORKUP],[24,PBMoves::ICEFANG],
			[28,PBMoves::UPROAR],[32,PBMoves::BELLYDRUM],[36,PBMoves::ICEPUNCH],[40,PBMoves::THRASH],
			[44,PBMoves::BLIZZARD],[48,PBMoves::SUPERPOWER]],
		:EggMoves => [PBMoves::FLAMEWHEEL,PBMoves::FOCUSPUNCH,PBMoves::FREEZEDRY,PBMoves::HAMMERARM,
			PBMoves::INCINERATE,PBMoves::POWERUPPUNCH,PBMoves::TAKEDOWN,PBMoves::YAWN]
	}
},

PBSpecies::DARMANITAN => {
	:FormName => {
		1 => "Zen",
		2 => "Galarian",
		3 => "Galarian Zen"
	},

	:OnCreation => proc{
		maps=[] # Map IDs for Galarian form
		next $game_map && maps.include?($game_map.map_id) ? 2 : 0
	},

	"Zen" => {
		:DexEntry => "When wounded, it stops moving. It goes as still as stone to meditate, sharpening its mind and spirit.",
		:BaseStats => [105,30,105,55,140,105],
		:EVs => [0,0,0,0,2,0],
		:Type2 => PBTypes::PSYCHIC
	},

	"Galarian" => {
		:DexEntry => "Though it has a gentle disposition, it's also very strong. It will quickly freeze the snowball on its head before going for a headbutt.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE,
		:Ability => [PBAbilities::GORILLATACTICS,PBAbilities::GORILLATACTICS,PBAbilities::GORILLATACTICS,PBAbilities::ZENMODE],
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TACKLE],[4,PBMoves::TAUNT],[8,PBMoves::BITE],
		[12,PBMoves::HEADBUTT],[16,PBMoves::AVALANCHE],[20,PBMoves::WORKUP],[24,PBMoves::ICEFANG],
		[28,PBMoves::UPROAR],[32,PBMoves::BELLYDRUM],[36,PBMoves::ICEPUNCH],[40,PBMoves::THRASH],
		[44,PBMoves::BLIZZARD],[48,PBMoves::SUPERPOWER],[50,PBMoves::ICICLECRASH]],
		:Height => 1.7,
		:Weight => 120
	},

	"Galarian Zen" => {
		:DexEntry => "Darmanitan takes this form when enraged. It won't stop spewing flames until its rage has settled, even if its body starts to melt.",
		:BaseStats => [105,160,55,135,30,55],
		:EVs => [0,0,0,0,2,0],
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FIRE,
		:Ability => [PBAbilities::GORILLATACTICS,PBAbilities::GORILLATACTICS,PBAbilities::GORILLATACTICS,PBAbilities::ZENMODE],
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TACKLE],[4,PBMoves::TAUNT],[8,PBMoves::BITE],
		[12,PBMoves::HEADBUTT],[16,PBMoves::AVALANCHE],[20,PBMoves::WORKUP],[24,PBMoves::ICEFANG],
		[28,PBMoves::UPROAR],[32,PBMoves::BELLYDRUM],[36,PBMoves::ICEPUNCH],[40,PBMoves::THRASH],
		[44,PBMoves::BLIZZARD],[48,PBMoves::SUPERPOWER],[50,PBMoves::ICICLECRASH]],
		:Height => 1.7,
		:Weight => 120
	}
},

PBSpecies::DEERLING => {
	:OnCreation => proc{
		maps=[710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,725,726,727,728,729,742]
		case rand(2)
			when 0 then next $game_map && maps.include?($game_map.map_id) ? 2 : 0
			when 1 then next $game_map && maps.include?($game_map.map_id) ? 3 : 1
		end
	}
},

PBSpecies::TORNADUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [79,100,80,121,110,90],
		:EVs => [0,0,0,3,0,0],
		:Ability => [PBAbilities::REGENERATOR,PBAbilities::WINDRIDER,PBAbilities::WINDPOWER],
		:Height => 14
	}
},

PBSpecies::THUNDURUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [79,105,70,101,145,80],
		:EVs => [0,0,0,0,3,0],
		:Ability => [PBAbilities::VOLTABSORB,PBAbilities::WINDRIDER,PBAbilities::STORMBRINGER],
		:Height => 30
	}
},

PBSpecies::LANDORUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [89,145,90,91,105,80],
		:EVs => [0,3,0,0,0,0],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::WINDRIDER],
		:Height => 13
	}
},

PBSpecies::ENAMORUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [74,115,110,46,135,100],
		:Ability => [PBAbilities::OVERCOAT,PBAbilities::WINDRIDER],
		:Height => 16
	}
},

PBSpecies::KYUREM => {
	:FormName => {
		1 => "White",
		2 => "Black"
	},

	"White" => {
		:BaseStats => [125,120,90,95,170,100],
		:EVs => [0,0,0,0,3,0],
		:Ability => PBAbilities::TURBOBLAZE,
		:Height => 36
	},

	"Black" => {
		:BaseStats => [125,170,100,95,120,90],
		:EVs => [0,3,0,0,0,0],
		:Ability => PBAbilities::TERAVOLT,
		:Height => 33
	}
},

PBSpecies::CALYREX => {
	:FormName => {
		1 => "Ice Rider",
		2 => "Shadow Rider",
		3 => "Mega"
	},
	
	:DefaultForm => {
		PBItems::REINSOFUNITYSHINY => 0,
		PBItems::REINSOFUNITYSHINY => 1,
		PBItems::REINSOFUNITYSHINY => 2
	},
	
	:MegaForm => 3,

	"Ice Rider" => {
		:DexEntry => "According to lore, this Pokémon showed no mercy to those who got in its way, yet it would heal its opponents' wounds after battle.",
		:BaseStats => [100,165,150,50,85,130],
		:EVs => [0,3,0,0,0,0],
		:Type2 => PBTypes::ICE,
		:Ability => PBAbilities::ASONE,
		:Height => 24,
		:Weight => 809
	},

	"Shadow Rider" => {
		:DexEntry => "Legend says that by using its power to see all events from past to future, this Pokémon saved the creatures of a forest from a meteorite strike.",
		:BaseStats => [100,85,80,150,165,100],
		:EVs => [0,3,0,0,0,0],
		:Type2 => PBTypes::GHOST,
		:Ability => PBAbilities::ASONE,
		:Height => 24,
		:Weight => 53
	},
	
	"Mega" => {
		:DexEntry => "Legend says that by using its power to see all events from past to future, this Pokémon saved the creatures of a forest from a meteorite strike.",
		:BaseStats => [100,165,150,150,165,130],
		:EVs => [0,3,0,0,0,0],
		:Type1 => PBTypes::PG,
		:Type2 => PBTypes::ICE,
		:Ability => PBAbilities::ASONE,
		:Height => 48,
		:Weight => 862
	},
},

PBSpecies::MELOETTA => {
	:FormName => {1 => "Pirouette"},

	"Pirouette" => {
		:BaseStats => [100,128,90,128,77,77],
		:EVs => [0,1,1,1,0,0],
		:Type2 => PBTypes::FIGHTING,
	}
},

PBSpecies::PUMPKABOO => {
	:FormName => {1 => "Small"},
	:OnCreation => proc{rand(2)},

	"Small" => {
		:BaseStats => [44,66,70,56,44,55],
		:Height => 03,
		:Weight => 35
	}
},

PBSpecies::GOURGEIST => {
	:FormName => {
		1 => "Small",
		2 => "Mega"
	},
	:OnCreation => proc{rand(2)},

	:DefaultForm => 0, #Not really
	:MegaForm => 2,

	"Small" => {
		:BaseStats => [55,85,122,99,58,75],
		:Height => 07,
		:Weight => 95
	},

	"Mega" => {
		:BaseStats => [85,130,132,84,78,85],
		:Ability => [PBAbilities::PRANKSTER],
	}
},

PBSpecies::AEGISLASH => {
	:FormName => {
		1 => "Blade",
		2 => "Crystal"
	},

	"Blade" => {:BaseStats => [60,140,50,60,140,50]},

	"Crystal" => {
		:BaseStats => [200,150,150,70,150,150],
		:EVs => [0,2,0,0,2,0],
		:Type2 => PBTypes::FAIRY,
		:Ability => PBAbilities::FRIENDGUARD
	}
},

PBSpecies::ZYGARDE => {
	:FormName => {
		0 => "50%",
		1 => "10%",
		2 => "100%",
		3 => "Mega"
	},
	
	:DefaultForm => 2,
	:MegaForm => 3,
	
	

	"10%" => {
		:DexEntry => "Its sharp fangs make short work of finishing off its enemies, but it's unable to maintain this body indefinitely. After a period of time, it falls apart.",
		:BaseStats => [54,100,71,115,61,85],
		:Height => 12,
		:Weight => 335
	},

	"100%" => {
		:DexEntry => "This is Zygarde's form at times when it uses its overwhelming power to suppress those who endanger the ecosystem.",
		:BaseStats => [216,100,121,85,91,95],
		:Ability => PBAbilities::AURABREAK,
		:Height => 45,
		:Weight => 6100
	},
	
	"Mega" => {
		:DexEntry => "In response to people's emotions during an unprecedented crisis, Zygarde Mega Evolves and calms the situation with its unmatched power.",
		:BaseStats => [216,70,91,100,216,85],
		:Ability => PBAbilities::AURABREAK,
		:Height => 77,
		:Weight => 6100
	}
},

PBSpecies::HOOPA => {
	:FormName => {1 => "Unbound"},

	"Unbound" => {
		:BaseStats => [80,160,60,80,170,130],
		:Type2 => PBTypes::DARK,
		:Height => 65,
		:Weight => 4900
	}
},

PBSpecies::ORICORIO => {
	:FormName => {
		1 => "Pom-Pom",
		2 => "Pa'u",
		3 => "Sensu"
	},

	"Pom-Pom" => {
		:DexEntry => "It creates an electric charge by rubbing its feathers together. It dances over to its enemies and delivers shocking electrical punches.",
		:Type1 => PBTypes::ELECTRIC
	},

	"Pa'u" => {
		:DexEntry => "This Oricorio relaxes by swaying gently. This increases its psychic energy, which it then fires at its enemies.",
		:Type1 => PBTypes::PSYCHIC
	},

	"Sensu" => {
		:DexEntry => "It summons the dead with its dreamy dancing. From their malice, it draws power with which to curse its enemies.",
		:Type1 => PBTypes::GHOST
	}
},

PBSpecies::LYCANROC => {
	:FormName => {
		1 => "Midnight",
		2 => "Dusk"
	},

	:OnCreation => proc{
		daytime = PBDayNight.isDay?(pbGetTimeNow)
		dusktime = PBDayNight.isDusk?(pbGetTimeNow)
		if dusktime
			next 2
		elsif daytime
			next 0
		else
			next 1
		end
	},

	"Midnight" => {
		:DexEntry => "It goads its enemies into attacking, withstands the hits, and in return, delivers a headbutt, crushing their bones with its rocky mane.",
		:BaseStats => [85,115,75,82,55,75],
		:Ability => [PBAbilities::KEENEYE,PBAbilities::VITALSPIRIT,PBAbilities::VITALSPIRIT,
			PBAbilities::NOGUARD],
		:Height => 11,
	},

	"Dusk" => {
		:DexEntry => "Bathed in the setting sun of evening, Lycanroc has undergone a special kind of evolution. An intense fighting spirit underlies its calmness.",
		:BaseStats => [75,117,65,110,55,65],
		:Ability => [PBAbilities::TOUGHCLAWS,PBAbilities::TOUGHCLAWS,PBAbilities::TOUGHCLAWS,
			PBAbilities::TOUGHCLAWS],
	}
},

PBSpecies::WISHIWASHI => {
	:FormName => {1 => "School"},

	"School" => {
		:DexEntry => "At their appearance, even Gyarados will flee. When they team up to use Water Gun, its power exceeds that of Hydro Pump.",
		:BaseStats => [45,140,130,30,140,135],
		:Height => 82,
 		:Weight => 786,
	}
},

PBSpecies::MINIOR => {
	:FormName => {7 => "Core"},
	:OnCreation => proc{rand(7)},

	"Core" => {
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [60,60,100,60,60,100],
		:EVs => [0,1,0,0,1,0],
 		:Weight => 400,
		:CatchRate => 30
	}
},

PBSpecies::NECROZMA => {
	:FormName => {
		1 => "Dusk Mane",
		2 => "Dawn Wings",
		3 => "Ultra",
		4 => "Totem"
	},

	:UltraForm => 3,

	"Dusk Mane" => {
		:DexEntry => "This is its form while it is devouring the light of Solgaleo. It pounces on foes and then slashes them with the claws on its four limbs and back.",
		:BaseStats => [97,157,127,77,113,109],
		:EVs => [0,3,0,0,0,0],
		:Type2 => PBTypes::STEEL,
		:Height => 38,
		:Weight => 4600
	},

	"Dawn Wings" => {
		:DexEntry => "This is its form while it's devouring the light of Lunala. It grasps foes in its giant claws and rips them apart with brute force.",
		:BaseStats => [97,113,109,77,157,127],
		:EVs => [0,0,0,0,3,0],
		:Type2 => PBTypes::GHOST,
		:Height => 42,
		:Weight => 3500
	},

	"Ultra" => {
		:DexEntry => "The light pouring out from all over its body affects living things and nature, impacting them in various ways.",
		:BaseStats => [97,167,97,129,167,97],
		:EVs => [0,1,0,1,1,0],
		:Type2 => PBTypes::DRAGON,
		:Ability => PBAbilities::NEUROFORCE,
		:Height => 75,
		:Weight => 2300
	},

	"Totem" => {
		:BaseStats => [97,167,97,129,167,97],
		:EVs => [0,1,0,1,1,0],
		:Type2 => PBTypes::DRAGON,
		:Ability => PBAbilities::NEUROFORCE,
		:Height => 75,
		:Weight => 2300
	}
},

PBSpecies::EISCUE => {
	:FormName => {1 => "Noice"},

	"Noice" => {
		:DexEntry => "Contrary to its looks, Eiscue is a poor swimmer. It creates ice balls at the tip of its single hair to lure prey in and fish them up.",
		:BaseStats => [75,80,70,130,65,50]
	}
},

PBSpecies::MORPEKO => {
	:FormName => {
		0 => "Full Belly",
		1 => "Hangry"
	},

	"Hangry" => {
		:DexEntry => "Hunger hormones affect its temperament. Until its hunger is appeased, it gets up to all manner of evil deeds."
	}
},

PBSpecies::INDEEDEE => {
	#Gender difference
	"Female" => {
		:DexEntry => "These intelligent Pokémon touch horns with each other to share information between them.",
		:Ability => [PBAbilities::SYNCHRONIZE,PBAbilities::PSYCHICSURGE,PBAbilities::INNERFOCUS,
			PBAbilities::OWNTEMPO],
		:BaseStats => [70,55,65,85,95,105]
	}
},

###################### Regional Variants ######################

PBSpecies::CHARMANDER => {
	:FormName => {
		4 => "Rebornian",
		5 => "Egho",
		6 => "Rebornian Wasteland"
	},

	:OnCreation => proc{
		mapStarterHallVolcano=[27,39] # Map IDs for Rebornian form
		mapWasteland=[209]
		randomnum = rand(4)
		if $game_map && mapStarterHallVolcano.include?($game_map.map_id) && randomnum==0
			next 4
		elsif $game_map && mapWasteland.include?($game_map.map_id)
			next 6
		else
			next 0
		end
	},

	"Rebornian" => {
		:DexEntry => "The candles of this region have given a new form to our favorite starter!",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [39,56,40,59,65,50],
		:Ability => [PBAbilities::BLAZE,PBAbilities::DROUGHT],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[4,PBMoves::EMBER],[6,PBMoves::QUICKATTACK],[7,PBMoves::FOCUSENERGY],[10,PBMoves::BITE],[13,PBMoves::PURSUIT],[22,PBMoves::CRUNCH],[25,PBMoves::SUCKERPUNCH],
			[29,PBMoves::SUPERFANG],[31,PBMoves::DOUBLEEDGE]],
		:EggMoves => [PBMoves::COUNTER,PBMoves::FINALGAMBIT,PBMoves::FURYSWIPES,PBMoves::MEFIRST,PBMoves::SNATCH,PBMoves::UPROAR],
		:Weight => 370
	},

	"Egho" => {
		:DexEntry => "A small dragon Pokémon that enjoys a competitive bout. As it battles, the flame on its tail gets hotter.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [39,52,43,65,60,50],
		:EVs => [0,0,0,1,0,0],
		:Ability => [PBAbilities::OBLIVIOUS,PBAbilities::COMPETITIVE,PBAbilities::COMPETITIVE],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[5,PBMoves::EMBER],
			[7,PBMoves::HONECLAWS],[10,PBMoves::NAILFLICK],[13,PBMoves::SMOKESCREEN],
			[17,PBMoves::FLAMEWHEEL],[20,PBMoves::SCARYFACE],[24,PBMoves::INCINERATE],
			[26,PBMoves::DRAGONRAGE],[28,PBMoves::FIREFANG],[34,PBMoves::FLAMEBURST],
			[37,PBMoves::FLAMETHROWER],[40,PBMoves::DRAGONPULSE],[44,PBMoves::INFERNO]],
		:EggMoves => [PBMoves::ANCIENTPOWER,PBMoves::BITE,PBMoves::CRUNCH,
				PBMoves::DRAGONDANCE,PBMoves::DRAGONPULSE,PBMoves::DRAGONRUSH,
				PBMoves::FLAREBLITZ,PBMoves::METALCLAW,PBMoves::OUTRAGE,PBMoves::POWERSWAP],
		:Weight => 85,
		:Height => 8,
		:kind => "Flare Lizard"
	},

	"Rebornian Wasteland" => {
		:DexEntry => "This Pokémon has a mixture of thousands of deadly toxins and minerals inside its belly and tail. Due to its body's naturally high temperature, the venomous solution inside it glows bright, attracting bugs and other preys.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::POISON,
		:BaseStats => [70,60,60,35,20,70],
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::LIQUIDOOZE,PBAbilities::INJECTION],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[7,PBMoves::POISONSTING],[10,PBMoves::SMOKESCREEN],[10,PBMoves::TWINEEDLE],[16,PBMoves::JETINJECTOR],[19,PBMoves::FELLSTINGER],[25,PBMoves::FIREFANG],
			[28,PBMoves::POISONFANG],[28,PBMoves::NEEDLEARM],[34,PBMoves::POISONJAB],[37,PBMoves::NEEDLEDRAIN],[43,PBMoves::CRUNCH],[46,PBMoves::FLAREBLITZ]],
		:EggMoves => [PBMoves::COUNTER,PBMoves::FINALGAMBIT,PBMoves::FURYSWIPES,PBMoves::MEFIRST,PBMoves::SNATCH,PBMoves::UPROAR],
		:Weight => 370,
		:kind => "Venomous Lizard"
	}
},

PBSpecies::CHARMELEON => {
	:FormName => {
		4 => "Rebornian",
		5 => "Egho",
		6 => "Rebornian Wasteland"
	},

	"Rebornian" => {
		:DexEntry => "People do not like when this is referred as the perfect first evolution.",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [75,62,80,73,65,65],
		:Ability => [PBAbilities::BLAZE,PBAbilities::DROUGHT],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[4,PBMoves::QUICKATTACK],
			[7,PBMoves::FOCUSENERGY],[10,PBMoves::BITE],[13,PBMoves::PURSUIT],[22,PBMoves::CRUNCH],
			[25,PBMoves::SUCKERPUNCH],[29,PBMoves::SUPERFANG],[31,PBMoves::DOUBLEEDGE]],
		:Weight => 38
	},

	"Egho" => {
		:DexEntry => "Without pity, its sharp claws destroy foes. If it encounters a strong enemy, it becomes agitated, and the flame on its tail flares with a bluish white color.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [58,64,58,80,80,65],
		:EVs => [0,0,0,1,0,0],
		:Ability => [PBAbilities::OBLIVIOUS,PBAbilities::COMPETITIVE,PBAbilities::COMPETITIVE],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[5,PBMoves::EMBER],
			[7,PBMoves::HONECLAWS],[10,PBMoves::NAILFLICK],[13,PBMoves::SMOKESCREEN],
			[16,PBMoves::NOSTRILFLARE],[19,PBMoves::FLAMEWHEEL],[23,PBMoves::SCARYFACE],[27,PBMoves::INCINERATE],
			[29,PBMoves::DRAGONRAGE],[31,PBMoves::FIREFANG],[35,PBMoves::DRAGONCLAW],
			[38,PBMoves::FLAMEBURST],[41,PBMoves::FLAMETHROWER],[45,PBMoves::DRAGONPULSE],
			[47,PBMoves::DRAGONDANCE],[49,PBMoves::INFERNO]],
		:Weight => 190,
		:Height => 13,
		:kind => "Flare Dragon"
	},

	"Rebornian Wasteland" => {
		:DexEntry => "After evolving, the venom inside its body becomes stronger, which is said to make this Pokémon more aggressive. This may explain Charmeleon's inclination for rebellious behavior.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::POISON,
		:BaseStats => [90,85,70,40,30,90],
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::LIQUIDOOZE,PBAbilities::INJECTION],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[1,PBMoves::POISONSTING],[7,PBMoves::PINMISSILE],[10,PBMoves::SMOKESCREEN],[10,PBMoves::TWINEEDLE],[17,PBMoves::JETINJECTOR],[21,PBMoves::FELLSTINGER],[28,PBMoves::FIREFANG],
			[28,PBMoves::POISONFANG],[32,PBMoves::NEEDLEARM],[39,PBMoves::POISONJAB],[43,PBMoves::NEEDLEDRAIN],[50,PBMoves::CRUNCH],[54,PBMoves::FLAREBLITZ]],
		:Weight => 370,
		:kind => "Needle"
	}
},

PBSpecies::RATTATA => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[170, 524] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	"Alolan" => {
		:DexEntry => "With its incisors, it gnaws through doors and infiltrates people's homes. Then, with a twitch of its whiskers, it steals whatever food it finds.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::NORMAL,
		:Weight => 38,
		:Ability => [PBAbilities::GLUTTONY,PBAbilities::HUSTLE,PBAbilities::THICKFAT],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[1,PBMoves::GROWL],
			[4,PBMoves::QUICKATTACK],[6,PBMoves::LEER],[8,PBMoves::FOCUSENERGY],
			[10,PBMoves::BITE],[12,PBMoves::SANDATTACK],[14,PBMoves::PURSUIT],
			[16,PBMoves::LASERFOCUS],[18,PBMoves::TAKEDOWN],[22,PBMoves::HYPERFANG],
			[24,PBMoves::ASSURANCE],[28,PBMoves::SUCKERPUNCH],[30,PBMoves::CRUNCH],
			[32,PBMoves::SUPERFANG],[34,PBMoves::DOUBLEEDGE],[42,PBMoves::REVERSAL],
			[44,PBMoves::ENDEAVOR],[46,PBMoves::HYPERBEAM]],
		:EggMoves => [PBMoves::COUNTER,PBMoves::FINALGAMBIT,PBMoves::FURYSWIPES,PBMoves::MEFIRST,
				PBMoves::REVENGE,PBMoves::REVERSAL,PBMoves::SNATCH,PBMoves::STOCKPILE,
				PBMoves::SWALLOW,PBMoves::SWITCHEROO,PBMoves::UPROAR],
		:WildHoldItems => [0,PBItems::PECHABERRY,0],
		:GetEvo => [[PBSpecies::RATICATE,PBEvolution::LevelNight,20]]
	}
},

PBSpecies::RATICATE => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[170, 524] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	"Alolan" => {
		:DexEntry => "It forms a group of Rattata, which it assumes command of. Each group has its own territory, and disputes over food happen often.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [75,71,70,77,40,80],
		:Weight => 255,
		:Ability => [PBAbilities::GLUTTONY,PBAbilities::HUSTLE,PBAbilities::THICKFAT],
		:Movelist => [[0,PBMoves::SCARYFACE],[1,PBMoves::SWORDSDANCE],[1,PBMoves::COUNTER],
			[1,PBMoves::FURYSWIPES],[1,PBMoves::SCARYFACE],[1,PBMoves::TACKLE],
			[1,PBMoves::TAILWHIP],[1,PBMoves::GROWL],[4,PBMoves::QUICKATTACK],
			[6,PBMoves::LEER],[8,PBMoves::FOCUSENERGY],[10,PBMoves::BITE],
			[12,PBMoves::SANDATTACK],[14,PBMoves::PURSUIT],[16,PBMoves::LASERFOCUS],
			[18,PBMoves::TAKEDOWN],[22,PBMoves::HYPERFANG],[24,PBMoves::ASSURANCE],
			[26,PBMoves::GLARE],[28,PBMoves::SUCKERPUNCH],[30,PBMoves::CRUNCH],
			[32,PBMoves::SUPERFANG],[34,PBMoves::DOUBLEEDGE],[36,PBMoves::LUNGE],
			[38,PBMoves::THRASH],[40,PBMoves::SLASH],[42,PBMoves::REVERSAL],
			[44,PBMoves::ENDEAVOR],[46,PBMoves::HYPERBEAM]],
		:WildHoldItems => [0,PBItems::PECHABERRY,0]
	}
},

##############################################
# Nuclear Altforms
##############################################

PBSpecies::NIDORANfE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NIDORINA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:GetEvo => [[PBSpecies::NIDOQUEEN,PBEvolution::Item,PBItems::MOONSTONE]]
	}
},

PBSpecies::NIDOQUEEN => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Mega" => {
		:BaseStats => [90,102,107,76,125,105],
		:Ability => PBAbilities::TOXICDEBRIS,
		:Weight => 840
	}
},

PBSpecies::NIDORANmA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NIDORINO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:GetEvo => [[PBSpecies::NIDOKING,PBEvolution::Item,PBItems::MOONSTONE]]
	}
},

PBSpecies::MAGIKARP => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ZUBAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOLBAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CROBAT => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VAPOREON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::JOLTEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLAREON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ESPEON => {
	:FormName => {
		1 => "Nuclear",
		2 => "Auroreon",
		3 => "Soluneon"
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},
	
	"Auroreon" => {
		:name => "Auroreon",
		:DexEntry => "Caught in a dangerous experiment of Team Meteor, Espeon and Glaceon fused into this Pokémon.",
		:BaseStats => [60,60,95,130,95,110],
		:Ability => [PBAbilities::MAGICCHILL],
		:Movelist => [[0,PBMoves::AQUATAIL],[0,PBMoves::AURORAVEIL],[0,PBMoves::AVALANCHE],
		[0,PBMoves::BABYDOLLEYES],[0,PBMoves::BATONPASS],[0,PBMoves::BIDE],[0,PBMoves::BLIZZARD],
		[0,PBMoves::BODYSLAM],[0,PBMoves::CELEBRATE],[0,PBMoves::CHARM],[0,PBMoves::COVET],
		[0,PBMoves::CURSE],[0,PBMoves::DETECT],[0,PBMoves::DIG],[0,PBMoves::DOUBLEEDGE],
		[0,PBMoves::ECHOEDVOICE],[0,PBMoves::FAKETEARS],[0,PBMoves::FOCUSENERGY],[0,PBMoves::FROSTBREATH],
		[0,PBMoves::GIGAIMPACT],[0,PBMoves::HAIL],[0,PBMoves::HEADBUTT],[0,PBMoves::HEALBELL],
        [0,PBMoves::HELPINGHAND],[0,PBMoves::HYPERBEAM],[0,PBMoves::HYPERVOICE],[0,PBMoves::ICEBEAM],
		[0,PBMoves::ICEFANG],[0,PBMoves::ICICLESPEAR],[0,PBMoves::ICYWIND],[0,PBMoves::IRONTAIL],
		[0,PBMoves::LASERFOCUS],[0,PBMoves::LASTRESORT],[0,PBMoves::MIMIC],
        [0,PBMoves::MUDSLAP],[0,PBMoves::PAYDAY],[0,PBMoves::RAGE],[0,PBMoves::RAINDANCE],
		[0,PBMoves::RETALIATE],[0,PBMoves::ROAR],[0,PBMoves::ROCKSMASH],[0,PBMoves::SHADOWBALL],
		[0,PBMoves::SIGNALBEAM],[0,PBMoves::SKULLBASH],[0,PBMoves::STOREDPOWER],[0,PBMoves::PSYCHICNOISE],
        [0,PBMoves::STRENGTH],[0,PBMoves::SUNNYDAY],[0,PBMoves::SWIFT],[0,PBMoves::TAKEDOWN],
		[0,PBMoves::TRIPLEAXEL],[0,PBMoves::WATERPULSE],[0,PBMoves::WORKUP],[0,PBMoves::ALLYSWITCH],
		[0,PBMoves::BATONPASS],[0,PBMoves::CALMMIND],[0,PBMoves::CUT],[0,PBMoves::DAZZLINGGLEAM],
		[0,PBMoves::POWERGEM],[0,PBMoves::DREAMEATER],[0,PBMoves::EXPANDINGFORCE],[0,PBMoves::FLASH],
		[0,PBMoves::FUTURESIGHT],[0,PBMoves::GRASSKNOT],[0,PBMoves::IRONTAIL],[0,PBMoves::LIGHTSCREEN],
		[0,PBMoves::MAGICCOAT],[0,PBMoves::MAGICROOM],[0,PBMoves::NIGHTMARE],[0,PBMoves::PSYCHIC],[0,PBMoves::FAKEOUT],
        [0,PBMoves::PSYCHICFANGS],[0,PBMoves::PSYCHUP],[0,PBMoves::PSYSHOCK],[0,PBMoves::REFLECT],
		[0,PBMoves::SKILLSWAP],[0,PBMoves::TELEKINESIS],[0,PBMoves::TRICK],[0,PBMoves::TRICKROOM],
		[0,PBMoves::ZAPCANNON],[0,PBMoves::ZENHEADBUTT],[0,PBMoves::PSYBEAM],[0,PBMoves::SNOWSCAPE],
		[0,PBMoves::BITE],[0,PBMoves::ALLURINGVOICE],[0,PBMoves::SING],[0,PBMoves::CONFUSION],[0,PBMoves::ICYWIND],[1,PBMoves::HELPINGHAND],
		[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::SANDATTACK],[9,PBMoves::BABYDOLLEYES],
		[13,PBMoves::QUICKATTACK],[17,PBMoves::BITE],[17,PBMoves::SWIFT],[20,PBMoves::PSYBEAM],
		[20,PBMoves::ICEFANG],[25,PBMoves::FUTURESIGHT],[25,PBMoves::ICESHARD],[29,PBMoves::PSYCHUP],
		[29,PBMoves::BARRIER],[33,PBMoves::MORNINGSUN],[33,PBMoves::MIRRORCOAT],[37,PBMoves::PSYCHIC],
		[37,PBMoves::HAIL],[41,PBMoves::LASTRESORT],[41,PBMoves::LASTRESORT],[45,PBMoves::POWERSWAP],
		[45,PBMoves::BLIZZARD],[70,PBMoves::GLITZYGLOW],[70,PBMoves::FREEZYFROST]],
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::ICE,
		:EVs => [0,0,0,2,0,0],
	},
	
	"Soluneon" => {
		:name => "Soluneon",
		:DexEntry => "Caught in a dangerous experiment of Team Meteor, Umbreon and Espeon fused into this Pokémon.",
		:BaseStats => [80,60,110,95,110,95],
		:Ability => [PBAbilities::ECLIPSE],
		:Movelist => [[0,PBMoves::ASSURANCE],[0,PBMoves::BABYDOLLEYES],[0,PBMoves::BATONPASS],
		[0,PBMoves::BIDE],[0,PBMoves::BODYSLAM],[0,PBMoves::CELEBRATE],[0,PBMoves::CHARM],
		[0,PBMoves::COVET],[0,PBMoves::CRUNCH],[0,PBMoves::CURSE],[0,PBMoves::CUT],
		[0,PBMoves::DARKPULSE],[0,PBMoves::DETECT],[0,PBMoves::DIG],[0,PBMoves::DOUBLEEDGE],
		[0,PBMoves::DREAMEATER],[0,PBMoves::ECHOEDVOICE],[0,PBMoves::FAKETEARS],
		[0,PBMoves::FLASH],[0,PBMoves::FOCUSENERGY],[0,PBMoves::FOULPLAY],[0,PBMoves::GIGAIMPACT],
		[0,PBMoves::GUARDSWAP],[0,PBMoves::HEADBUTT],[0,PBMoves::HEALBELL],[0,PBMoves::HELPINGHAND],
		[0,PBMoves::HYPERBEAM],[0,PBMoves::HYPERVOICE],[0,PBMoves::IRONTAIL],[0,PBMoves::LASERFOCUS],
		[0,PBMoves::LASHOUT],[0,PBMoves::LASTRESORT],[0,PBMoves::MIMIC],[0,PBMoves::MUDSLAP],
		[0,PBMoves::NIGHTMARE],[0,PBMoves::PAYBACK],[0,PBMoves::PAYDAY],[0,PBMoves::PSYCHIC],
		[0,PBMoves::PSYCHUP],[0,PBMoves::RAGE],[0,PBMoves::RAINDANCE],[0,PBMoves::RETALIATE],
		[0,PBMoves::SCREECH],[0,PBMoves::SHADOWBALL],[0,PBMoves::SKULLBASH],[0,PBMoves::SNARL],
		[0,PBMoves::SNATCH],[0,PBMoves::POWERGEM],[0,PBMoves::SPITE],[0,PBMoves::STOREDPOWER],
		[0,PBMoves::SUCKERPUNCH],[0,PBMoves::SUNNYDAY],[0,PBMoves::SWIFT],[0,PBMoves::TAKEDOWN],
		[0,PBMoves::TAUNT],[0,PBMoves::THROATCHOP],[0,PBMoves::TORMENT],[0,PBMoves::WONDERROOM],
		[0,PBMoves::WORKUP],[0,PBMoves::ZAPCANNON],[0,PBMoves::ALLYSWITCH],[0,PBMoves::CALMMIND],
		[0,PBMoves::DAZZLINGGLEAM],[0,PBMoves::EXPANDINGFORCE],[0,PBMoves::FUTURESIGHT],
		[0,PBMoves::GRASSKNOT],[0,PBMoves::LIGHTSCREEN],[0,PBMoves::MAGICCOAT],[0,PBMoves::MAGICROOM],
		[0,PBMoves::PSYCHICFANGS],[0,PBMoves::PSYSHOCK],[0,PBMoves::REFLECT],
		[0,PBMoves::SIGNALBEAM],[0,PBMoves::SKILLSWAP],[0,PBMoves::TELEKINESIS],
		[0,PBMoves::TRICK],[0,PBMoves::TRICKROOM],[0,PBMoves::ZENHEADBUTT],[0,PBMoves::PSYBEAM],
		[0,PBMoves::FAKEOUT],[0,PBMoves::PSYCHICNOISE],[0,PBMoves::ALLURINGVOICE],
		[0,PBMoves::CONFUSION],[0,PBMoves::PURSUIT],[1,PBMoves::HELPINGHAND],[1,PBMoves::TACKLE],
		[1,PBMoves::TAILWHIP],[5,PBMoves::SANDATTACK],[9,PBMoves::BABYDOLLEYES],
		[13,PBMoves::QUICKATTACK],[17,PBMoves::CONFUSERAY],[17,PBMoves::SWIFT],
		[20,PBMoves::FEINTATTACK],[20,PBMoves::PSYBEAM],[25,PBMoves::ASSURANCE],
		[25,PBMoves::FUTURESIGHT],[29,PBMoves::SCREECH],[29,PBMoves::PSYCHUP],
		[33,PBMoves::MOONLIGHT],[33,PBMoves::MORNINGSUN],[37,PBMoves::MEANLOOK],
		[37,PBMoves::PSYCHIC],[41,PBMoves::LASTRESORT],[45,PBMoves::GUARDSWAP],
		[45,PBMoves::POWERSWAP],[70,PBMoves::BADDYBAD],[70,PBMoves::GLITZYGLOW]],
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::PSYCHIC,
		:EVs => [0,0,1,0,1,0],
	}
},

PBSpecies::LEAFEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SYLVEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EEVEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MANEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAWKEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ZIRCONEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TITANEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DREKEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KITSUNEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EPHEMEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TOXEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRISTLEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MAREEP => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLAAFFY => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YANMA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YANMEGA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WYNAUT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WOBBUFFET => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SNUBBULL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GRANBULL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TEDDIURSA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::URSARING => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::URSALUNA => {
	:FormName => {
		1 => "Nuclear",
		2 => "Blood Moon"
},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Blood Moon" => {
		:DexEntry => "This special Ursaluna can see in the dark with its left eye and protects itself with mud that is as hard as iron.",
		:BaseStats => [113,70,120,52,135,65],
		:Ability => [PBAbilities::MINDSEYE],
		:Movelist => [[0,PBMoves::HARDEN],[1,PBMoves::SCARYFACE],[1,PBMoves::MOONLIGHT],[1,PBMoves::HARDEN],
			[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[1,PBMoves::LICK],[1,PBMoves::BABYDOLLEYES],
			[7,PBMoves::FAKETEARS],[10,PBMoves::FURYSWIPES],[13,PBMoves::SWEETSCENT],[15,PBMoves::TACKLE],
			[17,PBMoves::PAYBACK],[19,PBMoves::FLING],[22,PBMoves::COVET],[25,PBMoves::PLAYNICE],
			[27,PBMoves::BULLDOZE],[29,PBMoves::CHARM],[31,PBMoves::FEINTATTACK],[33,PBMoves::SLASH],
			[36,PBMoves::PLAYROUGH],[41,PBMoves::REST],[41,PBMoves::SNORE],[43,PBMoves::EARTHPOWER],
			[45,PBMoves::THRASH],[47,PBMoves::MOONBLAST],[49,PBMoves::HIGHHORSEPOWER],[51,PBMoves::DOUBLEEDGE],
			[54,PBMoves::HAMMERARM],[57,PBMoves::HEADLONGRUSH],[64,PBMoves::BLOODMOON]]
	}
},

PBSpecies::HOUNDOUR => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SKARMORY => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},
	
	"Mega" => {
		:BaseStats => [65,140,110,110,40,100],
		:Ability => PBAbilities::GOODASGOLD,
		#:Height => 29,
		:Weight => 404,
	}
},

PBSpecies::LARVITAR => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PUPITAR => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SNEASLER => {
	:FormName => {3 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YAMASK => {
	:FormName => {
		1 => "Galar",
		2 => "Nuclear",
		3 => "NuclearGalar"
	},

	:OnCreation => proc{
		chancemaps=[198,281] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Galar" => {
		:Type2 => PBTypes::GROUND,
		:Ability => [PBAbilities::WANDERINGSPIRIT],
		:Movelist => [[1,PBMoves::ASTONISH],[1,PBMoves::MEANLOOK],[4,PBMoves::DISABLE],[8,PBMoves::HAZE],
			[12,PBMoves::NIGHTSHADE],[16,PBMoves::CURSE],[20,PBMoves::SLAM],[24,PBMoves::CRAFTYSHIELD],
			[28,PBMoves::BRUTALSWING],[32,PBMoves::HEX],[36,PBMoves::POWERSPLIT],[36,PBMoves::GUARDSPLIT],
			[40,PBMoves::PROTECT],[44,PBMoves::SHADOWBALL],[48,PBMoves::EARTHQUAKE],[52,PBMoves::DESTINYBOND]],
		:EggMoves => [PBMoves::ALLYSWITCH,PBMoves::CRAFTYSHIELD,PBMoves::DISABLE,PBMoves::ENDURE,
			PBMoves::FAKETEARS,PBMoves::HEALBLOCK,PBMoves::IMPRISON,PBMoves::MEMENTO,PBMoves::NASTYPLOT,
			PBMoves::NIGHTMARE,PBMoves::POLTERGEIST,PBMoves::TOXICSPIKES],
		:GetEvo => [[PBSpecies::RUNERIGUS,PBEvolution::LevelNight,34]]
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"NuclearGalar" => {
		:Type2 => PBTypes::NUCLEAR,
		:Ability => [PBAbilities::WANDERINGSPIRIT],
		:Movelist => [[1,PBMoves::ASTONISH],[1,PBMoves::MEANLOOK],[4,PBMoves::DISABLE],[8,PBMoves::HAZE],
		[12,PBMoves::NIGHTSHADE],[16,PBMoves::CURSE],[20,PBMoves::SLAM],[24,PBMoves::CRAFTYSHIELD],
		[28,PBMoves::BRUTALSWING],[32,PBMoves::HEX],[36,PBMoves::POWERSPLIT],[36,PBMoves::GUARDSPLIT],
		[40,PBMoves::PROTECT],[44,PBMoves::SHADOWBALL],[48,PBMoves::EARTHQUAKE],[52,PBMoves::DESTINYBOND]],
	:EggMoves => [PBMoves::ALLYSWITCH,PBMoves::CRAFTYSHIELD,PBMoves::DISABLE,PBMoves::ENDURE,
		PBMoves::FAKETEARS,PBMoves::POLTERGEIST,PBMoves::TOXICSPIKES],
		:GetEvo => [[PBSpecies::RUNERIGUS,PBEvolution::LevelNight,34]]
	}
},

PBSpecies::COFAGRIGUS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [58,115,85,85,125,115],
		:Ability => PBAbilities::WANDERINGSPIRIT
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::RUNERIGUS => {
	:FormName => {3 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SURSKIT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MASQUERAIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NINCADA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NINJASK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHEDINJA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PROBOPASS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NOSEPASS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ARON => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LAIRON => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SPOINK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GRUMPIG => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FEEBAS => {
	:FormName => {
		1 => "Nuclear",
		3 => "Delta"
	},

	:OnCreation => proc{
		mapDelta1=[758] # Map IDs for Delta form
		next $game_map && mapDelta1.include?($game_map.map_id) ? 3 : 0
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Delta" => {
		:DexEntry => "Condemned to live in the darkest places of the abyss, it uses its orbs' psychic powers and its toxic spiked tail to defend itself.",
		:BaseStats => [26,16,31,76,11,46],
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::POISON,
		:Ability => [PBAbilities::POISONPOINT,PBAbilities::LIQUIDOOZE,PBAbilities::MAGICGUARD],
		:Movelist => [[1,PBMoves::SPLASH],[115,PBMoves::POISONSTING],[25,PBMoves::FLAIL]],
	}
},

PBSpecies::SEVIPER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLYGON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TRAPINCH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VIBRAVA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SNORUNT => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HIPPOPOTAS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HIPPOWDON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DRIFBLIM => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DRIFLOON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRONZOR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHINX => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LUXIO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LUXRAY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::RAMPARDOS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CRANIDOS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BASTIODON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHIELDON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ROGGENROLA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BOLDORE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GIGALITH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::THROH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SAWK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SCRAGGY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SOLOSIS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DUOSION => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TRUBBISH => {
	:FormName => {
		2 => "Nuclear",
		4 => "Egho"
	},

	:OnCreation => proc{
		chancemaps=[214,215,216,217,219]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Egho" => {
		:DexEntry => "As a result of urban clean-up initiatives, many Trubbish were mistakenly thrown into garbage cans. Being too weak to escape, they instead repurpose the cans as armor.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [50,40,72,45,60,62],
		:EVs => [0,0,1,0,0,0],
		:Ability => [PBAbilities::BATTLEARMOR,PBAbilities::FILTER],
		:Movelist => [[1,PBMoves::MUDSLAP],[1,PBMoves::SMOG],[1,PBMoves::TOXICSPIKES],
			[3,PBMoves::RECYCLE],[7,PBMoves::BULLETPUNCH],[12,PBMoves::ACIDSPRAY],
			[14,PBMoves::TOXIC],[18,PBMoves::SLUDGE],[23,PBMoves::STOCKPILE],
			[23,PBMoves::SWALLOW],[25,PBMoves::BODYSLAM],[29,PBMoves::SLUDGEBOMB],
			[34,PBMoves::HEAVYSLAM],[36,PBMoves::PROTECT],[40,PBMoves::IRONDEFENSE],
			[45,PBMoves::DARKPULSE],[47,PBMoves::FLASHCANNON],[50,PBMoves::BELCH]],
		:EggMoves => [PBMoves::CURSE,PBMoves::HAZE,PBMoves::MUDSPORT,
				PBMoves::ROCKBLAST,PBMoves::POWERGEM,PBMoves::SANDATTACK,
				PBMoves::SELFDESTRUCT,PBMoves::SPIKES,PBMoves::CLEARSMOG],
		:Weight => 430,
		:Height => 6,
		:kind => "Trash Can"
	}
},

PBSpecies::VANILLITE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VANILLISH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},


PBSpecies::VANILLUXE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MIENFOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MIENSHAO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EELEKTRIK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TYNAMO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EELEKTROSS => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLETCHLING => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLETCHINDER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TALONFLAME => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SKIDDO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOGOAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PYROAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LITLEO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SWIRLIX => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SLURPUFF => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::INKAY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MALAMAR => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},
	
	"Mega" => {
		:BaseStats => [86,102,88,88,98,120],
		:Ability => PBAbilities::CONTRARY,
		:Height => 29,
		:Weight => 698,
	}
	
},

PBSpecies::HELIOPTILE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HELIOLISK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ESPURR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MEOWSTIC => {
	:FormName => {1 => "Nuclear"},

	#Gender difference
	"Female" => {
		:Ability => [PBAbilities::KEENEYE,PBAbilities::INFILTRATOR,PBAbilities::COMPETITIVE,
			PBAbilities::PRANKSTER]
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	#Gender difference
	"NuclearFemale" => {
		:Ability => [PBAbilities::KEENEYE,PBAbilities::INFILTRATOR,PBAbilities::COMPETITIVE,
		PBAbilities::PRANKSTER],
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KINGAMBIT => {
	#Gender difference
	"Female" => {
		:BaseStats => [100,135,50,120,60,85],
		:Ability => [PBAbilities::KEENEYE,PBAbilities::INFILTRATOR,PBAbilities::COMPETITIVE,
			PBAbilities::SHARPNESS,PBAbilities::SHACKLE]
	}
},

PBSpecies::HAWLUCHA => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},
	
	"Mega" => {
		:BaseStats => [78,137,100,118,74,93],
		:Ability => PBAbilities::MOLDBREAKER,
		:Height => 10,
		:Weight => 250,
	}
},

PBSpecies::CARBINK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KLEFKI => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NOIVERN => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NOIBAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GRUBBIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHARJABUG => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VIKAVOLT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MORELULL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHIINOTIC => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BOUNSWEET => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::STEENEE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SALAZZLE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SALANDIT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KOMMOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::JANGMOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAKAMOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DHELMISE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DRAMPA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PYUKUMUKU => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WIMPOD => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOLISOPOD => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PASSIMIAN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ORANGURU => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::COMFEY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ELDEGOSS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOSSIFLEUR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WOOLOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DUBWOOL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHEWTLE => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YAMPER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BOLTUND => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SILICOBRA => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ROLYCOLY => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CARKOL => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::IMPIDIMP => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MORGREM => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FALINKS => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},
	
	"Mega" => {
		:BaseStats => [65,135,135,100,70,65],
		:Ability => PBAbilities::BATTLEARMOR,
		:Height => 16,
		:Weight => 990,
	}
},

PBSpecies::CUFANT => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SIZZLIPEDE => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GLIGAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GLISCOR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BUIZEL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLOATZEL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHYINMUNK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KINETMUNK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BIRBIE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::AVEDEN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SPLENDIFOWL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TONEMY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TOFURANG => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::OWTEN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ESHOUTEN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRAINOAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRAILIP => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TANCOON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TANSCURE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PALIJ => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PAJAY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PAHAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::JERBOLTA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BAASHAUN => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BAASCHAF => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TRAWPINT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::COSTRAW => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TUBJAW => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TUBAREEL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NUPIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GELLIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BARAND => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PARAUDIO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PARABOOM => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLAGER => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHIMICAL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHIMACONDA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::UNYMPH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HARPTERA => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TRACTON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TITANICE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FRYNAI => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SAIDINE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DAIKATUNA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LUCHABRA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHUPACHO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHRIMPUTY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KRILVOLVER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LAVENT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAGOOP => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAAGROSS => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GARLIKID => {
	:FormName => {
		1 => "Nuclear",
		2 => "Saitama"
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Saitama" => { #* This is for a special boss fight
		:Ability => PBAbilities::PLOTARMOR
	}
},

PBSpecies::KOMALA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

#############################################################
# Nuclear Altforms End
#############################################################

PBSpecies::RAICHU => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		chancemaps=[834]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Alolan" => {
		:DexEntry => "It uses psychokinesis to control electricity. It hops aboard its own tail, using psychic power to lift the tail and move about while riding it.",
		:Type2 => PBTypes::PSYCHIC,
		:BaseStats => [60,85,50,120,95,85],
		:Height => 7,
		:Weight => 210,
		:Ability => [PBAbilities::SURGESURFER,PBAbilities::SURGESURFER,PBAbilities::SURGESURFER,PBAbilities::INSTINCT],
		:Movelist => [[0,PBMoves::PSYCHIC],[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],
			[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::SPEEDSWAP],[1,PBMoves::FAKEOUT],
			[1,PBMoves::ENCORE],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],
			[1,PBMoves::TAILSLAP],[1,PBMoves::PSYCHIC],[1,PBMoves::METEORMASH],[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],
			[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],
			[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],[3,PBMoves::PLAYNICE],
			[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN],[101,PBMoves::ZIPPYZAP],[101,PBMoves::FLOATYFALL],[101,PBMoves::SPLISHYSPLASH],[101,PBMoves::PIKAPAPOW]]
	}
},

PBSpecies::SANDSHREW => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[364, 366, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 390, 396, 430, 433, 434, 440, 441, 442] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "It lives on snowy mountains. Its steel shell is very hard—so much so, it can't roll its body up into a ball.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [50,75,90,40,10,35],
		:Height => 6,
		:Weight => 400,
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SLUSHRUSH],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::DEFENSECURL],[3,PBMoves::BIDE],
			[5,PBMoves::POWDERSNOW],[7,PBMoves::ICEBALL],[9,PBMoves::RAPIDSPIN],
			[11,PBMoves::MIST],[13,PBMoves::FURYCUTTER],[15,PBMoves::METALCLAW],[17,PBMoves::SWIFT],
			[19,PBMoves::ROLLOUT],[21,PBMoves::FURYSWIPES],[23,PBMoves::IRONDEFENSE],[26,PBMoves::SLASH],
			[28,PBMoves::ICESHARD],[30,PBMoves::IRONHEAD],[32,PBMoves::MIRRORCOAT],[34,PBMoves::GYROBALL],
			[36,PBMoves::ICEPUNCH],[38,PBMoves::SWORDSDANCE],[42,PBMoves::HAIL],[45,PBMoves::SNOWSCAPE],
			[48,PBMoves::BLIZZARD]],
		:EggMoves => [PBMoves::AMNESIA,PBMoves::CELEBRATE,PBMoves::CHIPAWAY,PBMoves::COUNTER,PBMoves::CRUSHCLAW,PBMoves::CURSE,
				PBMoves::ENDURE,PBMoves::FLAIL,PBMoves::HONECLAWS,PBMoves::ICICLECRASH,PBMoves::ICICLESPEAR,
				PBMoves::METALCLAW,PBMoves::NIGHTSLASH,PBMoves::POISONSTING,PBMoves::SANDATTACK],
		:WildHoldItems => [0,PBItems::PECHABERRY,0],
		:GetEvo => [[PBSpecies::SANDSLASH,PBEvolution::Item,PBItems::ICESTONE]]
	}
},

PBSpecies::SANDSLASH => {
	:FormName => {
		1 => "Alolan",
		2 => "Mega"
	},

	:OnCreation => proc{
		maps=[364, 366, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 390, 396, 430, 433, 434, 440, 441, 442, 749, 750, 834, 882] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Alolan" => {
		:DexEntry => "This Pokémon's steel spikes are sheathed in ice. Stabs from these spikes cause deep wounds and severe frostbite as well.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [75,100,120,65,25,65],
		:Height => 12,
		:Weight => 550,
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SLUSHRUSH],
		:Movelist => [[0,PBMoves::ICICLESPEAR],[1,PBMoves::SPIKYSHIELD],[1,PBMoves::ICICLECRASH],[1,PBMoves::METALBURST],
			[1,PBMoves::COUNTER],[1,PBMoves::ICICLESPEAR],[1,PBMoves::SCRATCH],[1,PBMoves::DEFENSECURL],[3,PBMoves::BIDE],
			[5,PBMoves::POWDERSNOW],[7,PBMoves::ICEBALL],[9,PBMoves::RAPIDSPIN],[11,PBMoves::MIST],[13,PBMoves::FURYCUTTER],
			[15,PBMoves::METALCLAW],[17,PBMoves::SWIFT],[19,PBMoves::ROLLOUT],[21,PBMoves::FURYSWIPES],[23,PBMoves::IRONDEFENSE],
			[26,PBMoves::SLASH],[28,PBMoves::ICESHARD],[30,PBMoves::IRONHEAD],[32,PBMoves::MIRRORCOAT],[34,PBMoves::GYROBALL],
			[36,PBMoves::ICEPUNCH],[38,PBMoves::SWORDSDANCE],[42,PBMoves::HAIL],[45,PBMoves::SNOWSCAPE],[48,PBMoves::BLIZZARD]],
		:EggMoves => [PBMoves::AMNESIA,PBMoves::CELEBRATE,PBMoves::CHIPAWAY,PBMoves::COUNTER,PBMoves::CRUSHCLAW,PBMoves::CURSE,
				PBMoves::ENDURE,PBMoves::FLAIL,PBMoves::HONECLAWS,PBMoves::ICICLECRASH,PBMoves::ICICLESPEAR,
				PBMoves::METALCLAW,PBMoves::NIGHTSLASH,PBMoves::POISONSTING,PBMoves::SANDATTACK],
		:WildHoldItems => [0,PBItems::PECHABERRY,0]
	},

	"Mega" => {
		:BaseStats => [75,130,130,95,45,75],
		:Ability => [PBAbilities::TOUGHCLAWS],
	}
},

PBSpecies::VULPIX => {
	:FormName => {
		1 => "Alolan",
		2 => "Nuclear"
	},

	:OnCreation => proc{
		maps=[439,721,723,725,726,727,729,794] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Alolan" => {
		:DexEntry => "In hot weather, this Pokémon makes ice shards with its six tails and sprays them around to cool itself off.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE,
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SNOWWARNING],
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TAILWHIP],[1,PBMoves::DISABLE],[1,PBMoves::TACKLE],
			[3,PBMoves::ROAR],[5,PBMoves::MIST],[7,PBMoves::QUICKATTACK],[9,PBMoves::BABYDOLLEYES],
			[12,PBMoves::ICESHARD],[14,PBMoves::CONFUSERAY],[15,PBMoves::ICYWIND],[17,PBMoves::PAYBACK],
			[19,PBMoves::SPITE],[21,PBMoves::DRAININGKISS],[23,PBMoves::CAPTIVATE],[25,PBMoves::FEINTATTACK],
			[27,PBMoves::HEX],[29,PBMoves::ICEFANG],[31,PBMoves::AURORABEAM],[33,PBMoves::EXTRASENSORY],
			[35,PBMoves::SAFEGUARD],[37,PBMoves::ICEBEAM],[39,PBMoves::IMPRISON],[41,PBMoves::AURORAVEIL],
			[43,PBMoves::FREEZEDRY],[45,PBMoves::GRUDGE],[47,PBMoves::NASTYPLOT],[49,PBMoves::BLIZZARD],
			[51,PBMoves::SHEERCOLD]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::CELEBRATE,PBMoves::CHARM,PBMoves::DISABLE,PBMoves::EMBER,PBMoves::ENCORE,
				PBMoves::ENERGYBALL,PBMoves::EXTRASENSORY,PBMoves::FIREBLAST,PBMoves::FIRESPIN,PBMoves::FLAIL,
				PBMoves::FLAMETHROWER,PBMoves::FREEZEDRY,PBMoves::HOWL,PBMoves::HYPNOSIS,PBMoves::MOONBLAST,
				PBMoves::POWERSWAP,PBMoves::SPITE,PBMoves::SECRETPOWER,PBMoves::TAILSLAP,PBMoves::WILLOWISP],
		:WildHoldItems => [0,PBItems::SNOWBALL,0],
		:GetEvo => [[PBSpecies::NINETALES,PBEvolution::Item,PBItems::ICESTONE]]
	}
},

PBSpecies::NINETALES => {
	:FormName => {
		1 => "Alolan",
		2 => "Nuclear",
		3 => "Mega"
	},

	:OnCreation => proc{
		maps=[439,721,723,725,726,727,729,794,857,859] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Mega" => {
		:BaseStats => [73,86,75,110,131,130],
		:Ability => PBAbilities::TRACE,
		:Type2 => PBTypes::GHOST
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Alolan" => {
		:DexEntry => "Possessing a calm demeanor, this Pokémon was revered as a deity incarnate before it was identified as a regional variant of Ninetales.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [73,67,75,109,81,100],
		:EVs => [0,0,0,2,0,0],
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SNOWWARNING],
		:Movelist => [[0,PBMoves::DAZZLINGGLEAM],[1,PBMoves::DAZZLINGGLEAM],[1,PBMoves::HYPNOSIS],[1,PBMoves::POWDERSNOW],
			[1,PBMoves::TAILWHIP],[1,PBMoves::DISABLE],[1,PBMoves::TACKLE],[3,PBMoves::ROAR],[5,PBMoves::MIST],
			[7,PBMoves::QUICKATTACK],[9,PBMoves::BABYDOLLEYES],[12,PBMoves::ICESHARD],[14,PBMoves::CONFUSERAY],
			[15,PBMoves::ICYWIND],[17,PBMoves::PAYBACK],[19,PBMoves::SPITE],[21,PBMoves::DRAININGKISS],
			[23,PBMoves::CAPTIVATE],[25,PBMoves::FEINTATTACK],[27,PBMoves::HEX],[29,PBMoves::ICEFANG],
			[31,PBMoves::AURORABEAM],[33,PBMoves::EXTRASENSORY],[35,PBMoves::SAFEGUARD],[37,PBMoves::ICEBEAM],
			[39,PBMoves::IMPRISON],[41,PBMoves::AURORAVEIL],[43,PBMoves::FREEZEDRY],[45,PBMoves::GRUDGE],
			[47,PBMoves::NASTYPLOT],[49,PBMoves::BLIZZARD],[51,PBMoves::SHEERCOLD]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::CELEBRATE,PBMoves::CHARM,PBMoves::DISABLE,PBMoves::EMBER,PBMoves::ENCORE,
				PBMoves::ENERGYBALL,PBMoves::EXTRASENSORY,PBMoves::FIREBLAST,PBMoves::FIRESPIN,PBMoves::FLAIL,
				PBMoves::FLAMETHROWER,PBMoves::FREEZEDRY,PBMoves::HOWL,PBMoves::HYPNOSIS,PBMoves::MOONBLAST,
				PBMoves::POWERSWAP,PBMoves::SPITE,PBMoves::SECRETPOWER,PBMoves::TAILSLAP,PBMoves::WILLOWISP],
		:WildHoldItems => [0,PBItems::SNOWBALL,0]
	}
},

PBSpecies::DIGLETT => {
	:FormName => {
		1 => "Alolan",
		3 => "Cosmic"
	},

	:OnCreation => proc{
		aMaps=[33, 34, 35, 199, 201, 202, 203, 204]
		cMaps=[305]
		# Map IDs for Alolan and Cosmic forms respectively
		if $game_map && aMaps.include?($game_map.map_id)
			next 1
		elsif $game_map && cMaps.include?($game_map.map_id)
			next 3
		else
			next 0
		end
 	},

	"Alolan" => {
		:DexEntry => "Its head sports an altered form of whiskers made of metal. When in communication with its comrades, its whiskers wobble to and fro.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [10,55,30,90,35,40],
		:Ability => [PBAbilities::SANDVEIL,PBAbilities::TANGLINGHAIR,PBAbilities::SANDFORCE],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::SANDATTACK],[1,PBMoves::METALCLAW],[4,PBMoves::GROWL],
			[7,PBMoves::ASTONISH],[10,PBMoves::MUDSLAP],[14,PBMoves::MAGNITUDE],[18,PBMoves::BULLDOZE],
			[20,PBMoves::FURYSWIPES],[22,PBMoves::SUCKERPUNCH],[25,PBMoves::MUDBOMB],[28,PBMoves::EARTHPOWER],
			[31,PBMoves::DIG],[33,PBMoves::AGILITY],[35,PBMoves::IRONHEAD],[37,PBMoves::SLASH],
			[39,PBMoves::EARTHQUAKE],[41,PBMoves::SANDSTORM],[43,PBMoves::FISSURE]],
		:EggMoves => [PBMoves::ANCIENTPOWER,PBMoves::BEATUP,PBMoves::ENDURE,PBMoves::FEINTATTACK,
				PBMoves::FINALGAMBIT,PBMoves::REVERSAL,PBMoves::FLASH,PBMoves::HEADBUTT,PBMoves::MEMENTO,
				PBMoves::METALSOUND,PBMoves::HONECLAWS,PBMoves::PURSUIT,PBMoves::THRASH],
		:Weight => 10
	},

	"Cosmic" => {
		:DexEntry => "Its head sports an opal that gives it extra sturdiness.",
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [45,30,55,90,40,35],
		:Ability => [PBAbilities::SANDSTREAM,PBAbilities::SANDFORCE,PBAbilities::PROTEAN],
		:Movelist => [[1,PBMoves::SANDATTACK],[1,PBMoves::METALCLAW],[4,PBMoves::GROWL],
			[7,PBMoves::ASTONISH],[10,PBMoves::MUDSLAP],[14,PBMoves::MAGNITUDE],
			[18,PBMoves::BULLDOZE],[22,PBMoves::SUCKERPUNCH],[25,PBMoves::MUDBOMB],
			[28,PBMoves::EARTHPOWER],[31,PBMoves::DIG],[35,PBMoves::IRONHEAD],
			[39,PBMoves::EARTHQUAKE],[43,PBMoves::FISSURE]],
		:EggMoves => [PBMoves::ANCIENTPOWER,PBMoves::BEATUP,PBMoves::ENDURE,PBMoves::FEINTATTACK,
				PBMoves::FINALGAMBIT,PBMoves::HEADBUTT,PBMoves::MEMENTO,PBMoves::METALSOUND,
				PBMoves::PURSUIT,PBMoves::REVERSAL,PBMoves::FLASH],
		:Weight => 10
	},
},

PBSpecies::DUGTRIO => {
	:FormName => {
		1 => "Alolan",
		2 => "Mega",
		3 => "Cosmic"
	},

	:OnCreation => proc{
		maps=[33, 34, 35, 199, 201, 202, 203, 204] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Alolan" => {
		:DexEntry => "Its shining gold hair provides it with protection. It's reputed that keeping any of its fallen hairs will bring bad luck.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [35,100,60,110,50,70],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::SANDVEIL,PBAbilities::TANGLINGHAIR,PBAbilities::SANDFORCE],
		:Movelist => [[0,PBMoves::SANDTOMB],[0,PBMoves::TRIATTACK],[1,PBMoves::MAKEITRAIN],[1,PBMoves::ROTOTILLER],
			[1,PBMoves::NIGHTSLASH],[1,PBMoves::SCREECH],[1,PBMoves::TRIATTACK],[1,PBMoves::SANDTOMB],
			[1,PBMoves::SCRATCH],[1,PBMoves::SANDATTACK],[1,PBMoves::METALCLAW],[4,PBMoves::GROWL],
			[7,PBMoves::ASTONISH],[10,PBMoves::MUDSLAP],[14,PBMoves::MAGNITUDE],[18,PBMoves::BULLDOZE],
			[20,PBMoves::FURYSWIPES],[22,PBMoves::SUCKERPUNCH],[25,PBMoves::MUDBOMB],[28,PBMoves::EARTHPOWER],
			[31,PBMoves::DIG],[33,PBMoves::AGILITY],[35,PBMoves::IRONHEAD],[37,PBMoves::SLASH],
			[39,PBMoves::EARTHQUAKE],[41,PBMoves::SANDSTORM],[43,PBMoves::FISSURE]],
		:Weight => 666
	},

	"Mega" => {
		:BaseStats => [85,120,75,135,60,70],
		:Ability => [PBAbilities::MOLDBREAKER],
	},

	"Cosmic" => {
		:DexEntry => "It's head is surrounded by Cosmic opals that give it protection from the ambient above and below.",
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [68,93,70,108,68,78], #? Cosmic adds +60 to BST
		:EVs => [0,0,2,0,0,0],
		:Ability => [PBAbilities::SANDSTREAM,PBAbilities::SANDFORCE,PBAbilities::PROTEAN],
		:Movelist => [[0,PBMoves::SANDTOMB],[1,PBMoves::ROTOTILLER],[1,PBMoves::DEFENSECURL],[1,PBMoves::NIGHTSLASH],
			[1,PBMoves::TRIATTACK],[1,PBMoves::SCRATCH],[1,PBMoves::ROCKTOMB],[1,PBMoves::SANDATTACK],[1,PBMoves::METALCLAW],[1,PBMoves::GROWL],[4,PBMoves::GROWL],[7,PBMoves::ASTONISH],[10,PBMoves::MUDSLAP],[14,PBMoves::MAGNITUDE],
			[16,PBMoves::ROCKTHROW],[18,PBMoves::SMACKDOWN],[18,PBMoves::BULLDOZE],[22,PBMoves::SUCKERPUNCH],[25,PBMoves::MUDBOMB],[28,PBMoves::ROCKTOMB],[28,PBMoves::STEALTHROCK],[30,PBMoves::ROCKBLAST],[30,PBMoves::EARTHPOWER],[31,PBMoves::ROCKSLIDE],[35,PBMoves::DIG],[38,PBMoves::IRONDEFENSE],[40,PBMoves::DOUBLEEDGE],[41,PBMoves::SLASH],[41,PBMoves::IRONHEAD],[42,PBMoves::STONEEDGE],[47,PBMoves::EARTHQUAKE],[50,PBMoves::TRIPLEEDGE],[53,PBMoves::FISSURE],[60,PBMoves::HEAVYSLAM],[70,PBMoves::METALBURST]],
		:Weight => 666
	}
},

PBSpecies::RELICANTH => {
	:FormName => {1 => "Cosmic"},

	:OnCreation => proc{
		cMaps=[862] # Splashing Grounds # Map IDs for Cosmic Form
		next $game_map && cMaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Cosmic" => {
		:DexEntry => "Its form has remained the same for one hundred million eons. Its body is filled with cosmic dust, so it can withstand the pressure of the deep cosmos.",
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::WATER,
		:BaseStats => [160,120,55,80,100,55], #? Cosmic adds +85 to BST
		:EVs => [1,1,0,0,1,0],
		:Ability => [PBAbilities::SHADOWTAG,PBAbilities::GRAVITOSY,PBAbilities::ANALYTIC,PBAbilities::STURDINESS],
		:Movelist => [[1,PBMoves::AQUAJET],[1,PBMoves::ASTRALSHOT],[1,PBMoves::FLAIL],[1,PBMoves::CURSE],
			[1,PBMoves::TACKLE],[1,PBMoves::HARDEN],[1,PBMoves::MUDSPORT],[1,PBMoves::THUNDERBOLT],
			[1,PBMoves::REFRESH],[6,PBMoves::MUDSPORT],[10,PBMoves::WATERGUN],[10,PBMoves::WATERSPOUT],
			[15,PBMoves::ROCKTOMB],[15,PBMoves::AQUARING],[18,PBMoves::ROOST],[21,PBMoves::ANCIENTPOWER],
			[22,PBMoves::EARTHPOWER],[26,PBMoves::IRONHEAD],[26,PBMoves::PSYCHICFANGS],[31,PBMoves::ANCIENTPOWER],
			[31,PBMoves::IRONDEFENSE],[31,PBMoves::TAKEDOWN],[35,PBMoves::YAWN],[40,PBMoves::ICEBEAM],
			[40,PBMoves::REFLECT],[40,PBMoves::LIGHTSCREEN],[41,PBMoves::REST],[41,PBMoves::CRUNCH],
			[46,PBMoves::HYDROPUMP],[46,PBMoves::SIGNALBEAM],[50,PBMoves::DRAGONTAIL],[55,PBMoves::RECOVER],
			[56,PBMoves::HEADSMASH],[60,PBMoves::COMETSHOWER],[70,PBMoves::MIRRORCOAT],[75,PBMoves::COSMICRAY],
			[105,PBMoves::COSMICBARRAGE]],
		:Weight => 280,
		:Height => 4,
		:kind => "Cosmic Fish"
	}
},

PBSpecies::MEOWTH => {
	:FormName => {
		1 => "Alolan",
		2 => "Galarian",
		3 => "Dyna"
	},

	:OnCreation => proc{
		aMaps=[170, 524]
		gMaps=[412,439]
		# Map IDs for Alolan and Galarian forms respectively
		if $game_map && aMaps.include?($game_map.map_id)
			next 1
		elsif $game_map && gMaps.include?($game_map.map_id)
			next 2
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Alolan" => {
		:DexEntry => "When its delicate pride is wounded, or when the gold coin on its forehead is dirtied, it flies into a hysterical rage.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK,
		:BaseStats => [40,35,35,90,50,40],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::PICKUP,PBAbilities::TECHNICIAN,PBAbilities::RATTLED,PBAbilities::BONANZA,PBAbilities::MOUNTAINEER],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[6,PBMoves::BITE],
			[9,PBMoves::FAKEOUT],[14,PBMoves::FURYSWIPES],[17,PBMoves::SCREECH],
			[22,PBMoves::FEINTATTACK],[25,PBMoves::TAUNT],[30,PBMoves::PAYDAY],
			[33,PBMoves::FEINT],[38,PBMoves::CAPTIVATE],[41,PBMoves::ASSURANCE],
			[46,PBMoves::SLASH],[48,PBMoves::NASTYPLOT],[50,PBMoves::NIGHTSLASH],
			[53,PBMoves::DARKPULSE],[55,PBMoves::PLAYROUGH]],
		:EggMoves => [PBMoves::AMNESIA,PBMoves::ASSIST,PBMoves::CHARM,PBMoves::COVET,PBMoves::FLAIL,PBMoves::FLATTER,
			PBMoves::FOULPLAY,PBMoves::HYPNOSIS,PBMoves::PARTINGSHOT,PBMoves::PUNISHMENT,
			PBMoves::SNATCH,PBMoves::SPITE],
		:GetEvo => [[PBSpecies::PERSIAN,PBEvolution::Happiness,0]]
	},

	"Galarian" => {
		:DexEntry => "These daring Pokémon have coins on their foreheads. Darker coins are harder, and harder coins garner more respect among Meowth.",
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [40,35,35,90,50,40],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::PICKUP,PBAbilities::TOUGHCLAWS,PBAbilities::UNNERVE,PBAbilities::BONANZA,PBAbilities::MOUNTAINEER],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[4,PBMoves::FAKEOUT],[8,PBMoves::HONECLAWS],
			[12,PBMoves::FURYSWIPES],[16,PBMoves::METALCLAW],[20,PBMoves::SCREECH],[24,PBMoves::TAUNT],
			[29,PBMoves::PAYDAY],[32,PBMoves::SWAGGER],[36,PBMoves::METALSOUND],[40,PBMoves::SLASH],
			[44,PBMoves::THRASH]],
		:EggMoves => [PBMoves::COVET,PBMoves::FEINT,PBMoves::FLAIL,PBMoves::SPITE,PBMoves::DOUBLEEDGE,PBMoves::CURSE,
			PBMoves::NIGHTSLASH],
		:GetEvo => [[PBSpecies::PERRSERKER,PBEvolution::Level,28]]
	},

	"Dyna" => {
		:BaseStats => [80,55,50,115,40,50],
		:Ability => PBAbilities::HUGEPOWER
	}
},

PBSpecies::PERSIAN => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[170, 524, 866] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "It looks down on everyone other than itself. Its preferred tactics are sucker punches and blindside attacks.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK,
		:BaseStats => [65,60,60,115,75,65],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::FURCOAT,PBAbilities::TECHNICIAN,PBAbilities::RATTLED,PBAbilities::RATTLED,PBAbilities::MOUNTAINEER],
		:Movelist => [[0,PBMoves::SWIFT],[0,PBMoves::POWERGEM],[1,PBMoves::QUASH],[1,PBMoves::AMNESIA],[1,PBMoves::HYPNOSIS],
			[1,PBMoves::SWITCHEROO],[1,PBMoves::POWERGEM],[1,PBMoves::SWIFT],[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],
			[6,PBMoves::BITE],[9,PBMoves::FAKEOUT],[14,PBMoves::FURYSWIPES],[17,PBMoves::SCREECH],
			[22,PBMoves::FEINTATTACK],[25,PBMoves::TAUNT],[30,PBMoves::PAYDAY],
			[33,PBMoves::FEINT],[38,PBMoves::CAPTIVATE],[41,PBMoves::ASSURANCE],
			[46,PBMoves::SLASH],[48,PBMoves::NASTYPLOT],[50,PBMoves::NIGHTSLASH],
			[53,PBMoves::DARKPULSE],[55,PBMoves::PLAYROUGH]],
		:GetEvo => [],
		:Height => 11,
		:Weight => 330
	}
},

PBSpecies::GEODUDE => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[231, 247, 251, 258, 259, 260, 261, 262, 263, 264, 340, 341, 342, 343, 344, 346, 347, 348, 349, 371, 614, 615, 616, 618, 847] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "If you accidentally step on a Geodude sleeping on the ground, you'll hear a crunching sound and feel a shock ripple through your entire body.",
		:Type2 => PBTypes::ELECTRIC,
		:Ability => [PBAbilities::MAGNETPULL,PBAbilities::STURDY,PBAbilities::GALVANIZE],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::DEFENSECURL],[2,PBMoves::THUNDERSHOCK],[4,PBMoves::CHARGE],
			[6,PBMoves::ROCKPOLISH],[8,PBMoves::BIDE],[10,PBMoves::ROLLOUT],[12,PBMoves::SPARK],[14,PBMoves::TAKEDOWN],
			[16,PBMoves::ROCKTHROW],[18,PBMoves::SMACKDOWN],[22,PBMoves::THUNDERPUNCH],[24,PBMoves::SELFDESTRUCT],
			[28,PBMoves::STEALTHROCK],[30,PBMoves::ROCKBLAST],[34,PBMoves::DISCHARGE],[36,PBMoves::EXPLOSION],
			[38,PBMoves::ROCKSLIDE],[40,PBMoves::DOUBLEEDGE],[42,PBMoves::STONEEDGE]],
		:EggMoves => [PBMoves::AUTOTOMIZE,PBMoves::BLOCK,PBMoves::COUNTER,PBMoves::CURSE,PBMoves::ENDURE,PBMoves::FLAIL,
			PBMoves::MAGNETRISE,PBMoves::ROCKCLIMB,PBMoves::SANDATTACK,PBMoves::SCREECH,PBMoves::WIDEGUARD,
			PBMoves::ZAPCANNON],
		:Weight => 203,
		:WildHoldItems => [0,PBItems::CELLBATTERY,0]
	}
},

PBSpecies::GRAVELER => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[231, 247, 251, 258, 259, 260, 261, 262, 263, 264, 340, 341, 342, 343, 344, 346, 347, 348, 349, 371, 614, 615, 616, 618, 847] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "They eat rocks and often get into a scrap over them. The shock of Graveler smashing together causes a flash of light and a booming noise.",
		:Type2 => PBTypes::ELECTRIC,
		:Ability => [PBAbilities::MAGNETPULL,PBAbilities::STURDY,PBAbilities::GALVANIZE],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::DEFENSECURL],[2,PBMoves::THUNDERSHOCK],[4,PBMoves::CHARGE],
			[6,PBMoves::ROCKPOLISH],[8,PBMoves::BIDE],[10,PBMoves::ROLLOUT],[12,PBMoves::SPARK],[14,PBMoves::TAKEDOWN],
			[16,PBMoves::ROCKTHROW],[18,PBMoves::SMACKDOWN],[22,PBMoves::THUNDERPUNCH],[24,PBMoves::SELFDESTRUCT],
			[28,PBMoves::STEALTHROCK],[30,PBMoves::ROCKBLAST],[34,PBMoves::DISCHARGE],[36,PBMoves::EXPLOSION],
			[38,PBMoves::ROCKSLIDE],[40,PBMoves::DOUBLEEDGE],[42,PBMoves::STONEEDGE]],
		:Weight => 1100,
		:WildHoldItems => [0,PBItems::CELLBATTERY,0]
	}
},

PBSpecies::GOLEM => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[231, 247, 251, 258, 259, 260, 261, 262, 263, 264, 340, 341, 342, 343, 344, 346, 347, 348, 349, 371, 614, 615, 616, 618, 847] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "Because it can't fire boulders at a rapid pace, it's been known to seize nearby Geodude and fire them from its back.",
		:Type2 => PBTypes::ELECTRIC,
		:Ability => [PBAbilities::MAGNETPULL,PBAbilities::STURDY,PBAbilities::GALVANIZE],
		:Movelist => [[1,PBMoves::MEGAPUNCH],[1,PBMoves::STEAMROLLER],[1,PBMoves::TACKLE],[1,PBMoves::DEFENSECURL],
			[2,PBMoves::THUNDERSHOCK],[4,PBMoves::CHARGE],[6,PBMoves::ROCKPOLISH],[8,PBMoves::BIDE],
			[10,PBMoves::ROLLOUT],[12,PBMoves::SPARK],[14,PBMoves::TAKEDOWN],[16,PBMoves::ROCKTHROW],
			[18,PBMoves::SMACKDOWN],[22,PBMoves::THUNDERPUNCH],[24,PBMoves::SELFDESTRUCT],[28,PBMoves::STEALTHROCK],
			[30,PBMoves::ROCKBLAST],[34,PBMoves::DISCHARGE],[36,PBMoves::EXPLOSION],[38,PBMoves::ROCKSLIDE],
			[40,PBMoves::DOUBLEEDGE],[42,PBMoves::STONEEDGE],[44,PBMoves::HEAVYSLAM],[50,PBMoves::DOUBLESHOCK]],
		:Height => 17,
		:Weight => 3160,
		:WildHoldItems => [0,PBItems::CELLBATTERY,0]
	}
},

PBSpecies::GRIMER => {
	:FormName => {
		1 => "Alolan",
		3 => "Nuclear",
		4 => "Egho"
	},

	:OnCreation => proc{
		maps=[467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "The crystals on Grimer's body are lumps of toxins. If one falls off, lethal poisons leak out.",
		:Type2 => PBTypes::DARK,
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::GLUTTONY,PBAbilities::POWEROFALCHEMY],
		:Movelist => [[1,PBMoves::POUND],[1,PBMoves::POISONGAS],[4,PBMoves::HARDEN],[7,PBMoves::BITE],
			[12,PBMoves::DISABLE],[15,PBMoves::ACIDSPRAY],[18,PBMoves::POISONFANG],[21,PBMoves::MINIMIZE],
			[26,PBMoves::FLING],[29,PBMoves::KNOCKOFF],[31,PBMoves::CRUNCH],[33,PBMoves::TOXIC],
			[35,PBMoves::SCREECH],[37,PBMoves::SLUDGEBOMB],[40,PBMoves::GUNKSHOT],[43,PBMoves::ACIDARMOR],
			[46,PBMoves::BELCH],[48,PBMoves::MEMENTO]],
		:EggMoves => [PBMoves::ASSURANCE,PBMoves::CELEBRATE,PBMoves::CLEARSMOG,PBMoves::CURSE,
			PBMoves::GASTROACID,PBMoves::IMPRISON,PBMoves::MEANLOOK,PBMoves::POWERUPPUNCH,PBMoves::PURSUIT,
			PBMoves::RECYCLE,PBMoves::SCARYFACE,PBMoves::SHADOWSNEAK,PBMoves::SLUDGE,PBMoves::SPITE,
			PBMoves::SPITUP,PBMoves::STOCKPILE,PBMoves::SWALLOW],
		:Height => 7,
		:Weight => 420
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Egho" => {
		:DexEntry => "This version of Grimer is made up of hot asphalt. Often used in cities to help fill potholes, this Pokémon's body reaches temperatures of just over 300 degrees.",
		:Type2 => PBTypes::ROCK,
		:BaseStats => [80,70,50,25,60,40],
		:EVs => [1,0,0,0,0,0],
		:Ability => [PBAbilities::STENCH,PBAbilities::FLAREBOOST,PBAbilities::POISONTOUCH],
		:Movelist => [[1,PBMoves::POISONGAS],[1,PBMoves::METALCLAW],[4,PBMoves::HARDEN],
			[7,PBMoves::MUDSLAP],[12,PBMoves::SMACKDOWN],[15,PBMoves::SLUDGE],
			[18,PBMoves::MINIMIZE],[21,PBMoves::BULLETPUNCH],[23,PBMoves::HEAVYSLAM],
			[26,PBMoves::SLUDGEBOMB],[29,PBMoves::FLING],[32,PBMoves::ROCKSLIDE],
			[35,PBMoves::SCREECH],[37,PBMoves::SLUDGEWAVE],[40,PBMoves::ACIDARMOR],
			[43,PBMoves::GUNKSHOT],[45,PBMoves::KNOCKOFF],[49,PBMoves::MEMENTO],
			[52,PBMoves::METEORMASH],[55,PBMoves::STONEEDGE]],
		:EggMoves => [PBMoves::ACIDSPRAY,PBMoves::CURSE,PBMoves::HAZE,
				PBMoves::FLAMECHARGE,PBMoves::LICK,PBMoves::MEANLOOK,
				PBMoves::FIREPUNCH,PBMoves::SHADOWPUNCH,PBMoves::SHADOWSNEAK,
				PBMoves::STOCKPILE,PBMoves::SPITUP,PBMoves::SWALLOW,
				PBMoves::ROCKPOLISH],
		:Weight => 2050,
		:Height => 10,
		:kind => "Coal Tar"
	}
},

PBSpecies::MUK => {
	:FormName => {
		1 => "Alolan",
		2 => "PULSE",
		3 => "Nuclear",
		4 => "Egho"
	},

	:OnCreation => proc{
		maps=[467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 879] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	:DefaultForm => 0,
	:PulseForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Alolan" => {
		:DexEntry => "While it's unexpectedly quiet and friendly, if it's not fed any trash for a while, it will smash its Trainer's furnishings and eat up the fragments.",
		:Type2 => PBTypes::DARK,
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::GLUTTONY,PBAbilities::POWEROFALCHEMY],
		:Movelist => [[0,PBMoves::VENOMDRENCH],[1,PBMoves::MOONBLAST],[1,PBMoves::HAZE],[1,PBMoves::VENOMDRENCH],
			[1,PBMoves::POUND],[1,PBMoves::POISONGAS],[4,PBMoves::HARDEN],[7,PBMoves::BITE],[12,PBMoves::DISABLE],
			[15,PBMoves::ACIDSPRAY],[18,PBMoves::POISONFANG],[21,PBMoves::MINIMIZE],[26,PBMoves::FLING],
			[29,PBMoves::KNOCKOFF],[31,PBMoves::CRUNCH],[33,PBMoves::TOXIC],[35,PBMoves::SCREECH],[37,PBMoves::SLUDGEBOMB],
			[40,PBMoves::GUNKSHOT],[43,PBMoves::ACIDARMOR],[46,PBMoves::BELCH],[48,PBMoves::MEMENTO]],
		:Height => 10,
		:Weight => 520
	},

	"PULSE" => {
		:BaseStats => [105,105,70,40,97,250],
		:Ability => PBAbilities::PROTEAN,
		:Weight => 1023
	},

	"Egho" => {
		:DexEntry => "As Muk traverses urban areas, various debris and items get stuck in it. The differing street signs that end up in Muk help set it apart from one another.",
		:Type2 => PBTypes::ROCK,
		:BaseStats => [110,105,70,55,95,65],
		:EVs => [2,1,0,0,0,0],
		:Ability => [PBAbilities::STENCH,PBAbilities::FLAREBOOST,PBAbilities::POISONTOUCH],
		:Movelist => [[1,PBMoves::POISONGAS],[1,PBMoves::METALCLAW],[4,PBMoves::HARDEN],
			[7,PBMoves::MUDSLAP],[12,PBMoves::SMACKDOWN],[15,PBMoves::SLUDGE],
			[18,PBMoves::MINIMIZE],[21,PBMoves::BULLETPUNCH],[23,PBMoves::HEAVYSLAM],
			[26,PBMoves::SLUDGEBOMB],[29,PBMoves::FLING],[32,PBMoves::ROCKSLIDE],
			[35,PBMoves::SCREECH],[37,PBMoves::SLUDGEWAVE],[43,PBMoves::ACIDARMOR],
			[49,PBMoves::GUNKSHOT],[51,PBMoves::KNOCKOFF],[57,PBMoves::MEMENTO],
			[61,PBMoves::METEORMASH],[64,PBMoves::STONEEDGE],[68,PBMoves::SCORCHINGSANDS],
			[72,PBMoves::TARTANTRUM]],
		:GetEvo => [[PBSpecies::OOZMA,PBEvolution::Item,PBItems::FIRESTONE]],
		:Weight => 3950,
		:Height => 14,
		:kind => "Tar Pond"
	}
},

PBSpecies::EXEGGUTOR => {
	:FormName => {1 => "Alolan"},

	"Alolan" => {
		:DexEntry => "As it grew taller and taller, it outgrew its reliance on psychic powers, while within it awakened the power of the sleeping dragon.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [95,105,85,45,125,75],
		:Ability => [PBAbilities::FRISK,PBAbilities::FRISK,PBAbilities::HARVEST],
		:Movelist => [[0,PBMoves::DRAGONHAMMER],[1,PBMoves::SOFTBOILED],[1,PBMoves::POWERWHIP],[1,PBMoves::DRAGONPULSE],
			[1,PBMoves::PSYSHOCK],[1,PBMoves::SEEDBOMB],[1,PBMoves::GROWTH],[1,PBMoves::DRAGONHAMMER],[1,PBMoves::BARRAGE],
			[1,PBMoves::HYPNOSIS],[1,PBMoves::ABSORB],[6,PBMoves::CONFUSION],[11,PBMoves::LEECHSEED],[13,PBMoves::BULLETSEED],
			[15,PBMoves::SWEETSCENT],[17,PBMoves::REFLECT],[19,PBMoves::STUNSPORE],[21,PBMoves::POISONPOWDER],
			[23,PBMoves::SLEEPPOWDER],[25,PBMoves::MEGADRAIN],[27,PBMoves::PSYBEAM],[29,PBMoves::NATURALGIFT],
			[31,PBMoves::EGGBOMB],[33,PBMoves::BESTOW],[35,PBMoves::SYNTHESIS],[37,PBMoves::UPROAR],
			[39,PBMoves::WOODHAMMER],[41,PBMoves::GIGADRAIN],[43,PBMoves::EXTRASENSORY],[45,PBMoves::LEAFSTORM],
			[47,PBMoves::WORRYSEED],[50,PBMoves::PSYCHIC],[53,PBMoves::SOLARBEAM]],
		:Height => 109,
		:Weight => 4156
	}
},

PBSpecies::MAROWAK => {
	:FormName => {
		1 => "Alolan",
		2 => "Mega"
	},

	:OnCreation => proc{
		chancemaps=[669,881] # Map IDs for Alolan form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Alolan" => {
		:DexEntry => "The bones it possesses were once its mother's. Its mother's regrets have become like a vengeful spirit protecting this Pokémon.",
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,80,110,45,50,80],
		:Ability => [PBAbilities::CURSEDBODY,PBAbilities::LIGHTNINGROD,PBAbilities::ROCKHEAD],
		:Movelist => [[0,PBMoves::SHADOWBONE],[1,PBMoves::SWORDSDANCE],[1,PBMoves::FLAMEWHEEL],
			[1,	PBMoves::FIRESPIN],[1,PBMoves::SCREECH][1,PBMoves::SHADOWBONE],[1,PBMoves::MUDSLAP],
			[1,PBMoves::GROWL],[3,PBMoves::TAILWHIP],[5,PBMoves::HEADBUTT],[7,PBMoves::LEER],
			[9,PBMoves::FOCUSENERGY],[11,PBMoves::BONECLUB],[13,PBMoves::RAGE],[17,PBMoves::CHARM],
			[19,PBMoves::HEX],[21,PBMoves::FALSESWIPE],[23,PBMoves::FLING],[25,PBMoves::WILLOWISP],
			[27,PBMoves::BONERUSH],[31,PBMoves::RETALIATE],[33,PBMoves::STOMPINGTANTRUM],
			[37,PBMoves::THRASH],[41,PBMoves::BONEMERANG],[43,PBMoves::ENDEAVOR],[47,PBMoves::DOUBLEEDGE],
			[50,PBMoves::FLAREBLITZ]],
		:GetEvo => [],
		:Weight => 340
	},

	"Mega" => {
		:BaseStats => [70,110,120,95,50,80],
		:Ability => [PBAbilities::STAMINA],
	}
},

PBSpecies::MISDREAVUS => {
	:FormName => {1 => "Aevian"},

	"Aevian" => {
		:DexEntry => "It knows the swamp it lives in like no other and blends in perfectly. It's more timid than its regular counterpart, and doesn't like showing itself to bypassers.",
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,85,60,85,85,60],
		:Ability => [PBAbilities::MAGICBOUNCE,PBAbilities::POISONPOINT,PBAbilities::TANGLINGHAIR],
		:Movelist => [[1,PBMoves::GROWL],[1,PBMoves::VINEWHIP],[5,PBMoves::POISONPOWDER],[10,PBMoves::ASTONISH],
			[14,PBMoves::CONFUSERAY],[19,PBMoves::SNAPTRAP],[23,PBMoves::HEX],[28,PBMoves::GIGADRAIN],
			[32,PBMoves::INGRAIN],[37,PBMoves::GRUDGE],[41,PBMoves::SHADOWBALL],
			[46,PBMoves::PERISHSONG],[50,PBMoves::POWERWHIP],[55,PBMoves::POWERGEM]],
		:EggMoves => [PBMoves::CURSE,PBMoves::DESTINYBOND,PBMoves::GROWTH,PBMoves::MEFIRST,PBMoves::MEMENTO,
			PBMoves::NASTYPLOT,PBMoves::CLEARSMOG,PBMoves::SCREECH,PBMoves::SHADOWSNEAK,PBMoves::LIFEDEW,
			PBMoves::TOXIC,PBMoves::SUCKERPUNCH,PBMoves::WONDERROOM],
		:Height => 7,
		:Weight => 420,
		:GetEvo => [[PBSpecies::MISMAGIUS,PBEvolution::Item,PBItems::LEAFSTONE]]
	}
},

PBSpecies::MISMAGIUS => {
	:FormName => {
		1 => "Aevian",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Aevian" => {
		:DexEntry => "A gentle but misleadingly strong Pokémon, it helps those who got lost in the wetlands find their way out... At the cost of a little of their life force.",
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,105,60,105,105,60],
		:Ability => [PBAbilities::MAGICBOUNCE,PBAbilities::POISONPOINT,PBAbilities::TANGLINGHAIR],
		:Movelist => [[1,PBMoves::POISONJAB],[1,PBMoves::POWERGEM],[1,PBMoves::PHANTOMFORCE],[1,PBMoves::LUCKYCHANT],[1,PBMoves::MAGICALLEAF],[1,PBMoves::GROWL],[1,PBMoves::VINEWHIP],[1,PBMoves::POISONPOWDER],[1,PBMoves::ASTONISH],[0,PBMoves::SHADOWCLAW]],
		:Weight => 10
	},

	"Mega" => {
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [70,60,70,125,140,135],
		:Ability => [PBAbilities::INFILTRATOR],
	}
},

PBSpecies::GROWLITHE => {
	:FormName => {
		1 => "Hisui",
		2 => "Nuclear"
	},

	:OnCreation => proc{
		chancemaps=[523] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Hisui" => {
		:DexEntry => "They patrol their territory in pairs. I believe the igneous rock components in the fur of this species are the result of volcanic activity in its habitat.",
		:Type2 => PBTypes::ROCK,
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::FLASHFIRE,PBAbilities::ROCKHEAD,PBAbilities::JUSTIFIED],
		:BaseStats => [60,75,45,55,65,50],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::LEER],[1,PBMoves::EMBER],[4,PBMoves::HOWL],[8,PBMoves::BITE],
			[12,PBMoves::FLAMEWHEEL],[16,PBMoves::HELPINGHAND],[20,PBMoves::ROCKTHROW],[24,PBMoves::FIREFANG],
			[28,PBMoves::RETALIATE],[32,PBMoves::CRUNCH],[36,PBMoves::TAKEDOWN],[40,PBMoves::FLAMETHROWER],
			[44,PBMoves::ROAR],[48,PBMoves::ROCKSLIDE],[52,PBMoves::REVERSAL],[56,PBMoves::DOUBLEEDGE],
			[60,PBMoves::FLAREBLITZ]],
		:EggMoves => [PBMoves::COVET,PBMoves::DOUBLEEDGE,PBMoves::DOUBLEKICK,PBMoves::HEADSMASH,PBMoves::MORNINGSUN,
			PBMoves::SACREDFIRE,PBMoves::THRASH],
		:Weight => 227,
		:Height => 8
	}
},

PBSpecies::ARCANINE => {
	:FormName => {
		1 => "Hisui",
		2 => "Nuclear",
		3 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Hisui" => {
		:DexEntry => "Despite its bulk, it deftly feints every which way, leading opponents on a deceptively merry chase as it all but dances around them.",
		:Type2 => PBTypes::ROCK,
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::FLASHFIRE,PBAbilities::ROCKHEAD,PBAbilities::JUSTIFIED],
		:BaseStats => [95,115,80,90,95,80],
		:Movelist => [[0,PBMoves::EXTREMESPEED],[1,PBMoves::AGILITY],[1,PBMoves::EXTREMESPEED],[1,PBMoves::TACKLE],
			[1,PBMoves::LEER],[1,PBMoves::EMBER],[4,PBMoves::HOWL],[8,PBMoves::BITE],[12,PBMoves::FLAMEWHEEL],
			[16,PBMoves::HELPINGHAND],[20,PBMoves::ROCKTHROW],[24,PBMoves::FIREFANG],[28,PBMoves::RETALIATE],
			[32,PBMoves::CRUNCH],[36,PBMoves::TAKEDOWN],[40,PBMoves::FLAMETHROWER],[44,PBMoves::ROAR],
			[48,PBMoves::ROCKSLIDE],[52,PBMoves::REVERSAL],[56,PBMoves::DOUBLEEDGE],[60,PBMoves::FLAREBLITZ],
			[64,PBMoves::RAGINGFURY]],
		:Weight => 1680,
		:Height => 20
	},

	"Mega" => {
		:BaseStats => [100,130,95,105,130,95],
		:Ability => [PBAbilities::DROUGHT]
	}
},

PBSpecies::VOLTORB => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[198,281] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "An enigmatic Pokémon that happens to bear a resemblance to a Poké Ball. When excited, it discharges the electric current it has stored in its belly, then lets out a great, uproarious laugh.",
		:Type2 => PBTypes::GRASS,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::CHARGE],[3,PBMoves::THUNDERSHOCK],[5,PBMoves::THUNDERWAVE],
			[7,PBMoves::STUNSPORE],[9,PBMoves::BULLETSEED],[11,PBMoves::ROLLOUT],[13,PBMoves::SCREECH],
			[16,PBMoves::CHARGEBEAM],[18,PBMoves::SPARK],[20,PBMoves::SWIFT],[22,PBMoves::ELECTROBALL],
			[26,PBMoves::SELFDESTRUCT],[29,PBMoves::GYROBALL],[31,PBMoves::THUNDERBOLT],[34,PBMoves::SEEDBOMB],
			[37,PBMoves::THUNDER],[39,PBMoves::DISCHARGE],[41,PBMoves::EXPLOSION],[46,PBMoves::ENERGYBALL],
			[50,PBMoves::GRASSYTERRAIN]],
		:EggMoves => [PBMoves::LEECHSEED,PBMoves::RECYCLE,PBMoves::WORRYSEED],
		:Weight => 130,
		:GetEvo => [[PBSpecies::ELECTRODE,PBEvolution::Item,PBItems::LEAFSTONE]]
	}
},

PBSpecies::ELECTRODE => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[455,857] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "The tissue on the surface of its body is curiously similar in composition to an Apricorn. When irritated, this Pokémon lets loose an electric current equal to 20 lightning bolts.",
		:Type2 => PBTypes::GRASS,
		:Movelist => [[0,PBMoves::CHLOROBLAST],[1,PBMoves::CHLOROBLAST],[1,PBMoves::TACKLE],[1,PBMoves::CHARGE],
			[3,PBMoves::THUNDERSHOCK],[5,PBMoves::THUNDERWAVE],[7,PBMoves::STUNSPORE],[9,PBMoves::BULLETSEED],
			[11,PBMoves::ROLLOUT],[13,PBMoves::SCREECH],[16,PBMoves::CHARGEBEAM],[18,PBMoves::SPARK],[20,PBMoves::SWIFT],
			[22,PBMoves::ELECTROBALL],[26,PBMoves::SELFDESTRUCT],[29,PBMoves::GYROBALL],[31,PBMoves::THUNDERBOLT],
			[34,PBMoves::SEEDBOMB],[37,PBMoves::THUNDER],[39,PBMoves::DISCHARGE],[41,PBMoves::EXPLOSION],
			[46,PBMoves::ENERGYBALL],[50,PBMoves::GRASSYTERRAIN]],
		:Weight => 710
	}
},

PBSpecies::QWILFISH => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[364,366,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,390,430,433,434] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "Fishers detest this troublesome Pokémon because it sprays poison from its spines, getting it everywhere. A different form of Qwilfish lives in other regions.",
		:Type1 => PBTypes::DARK,
		:Ability => [PBAbilities::TOXICDEBRIS,PBAbilities::POISONPOINT,PBAbilities::SWIFTSWIM,
			PBAbilities::INTIMIDATE],
		:Movelist => [[1,PBMoves::POISONSTING],[1,PBMoves::TACKLE],[4,PBMoves::HARDEN],[8,PBMoves::BITE],
			[12,PBMoves::SPIKES],[14,PBMoves::FELLSTINGER],[16,PBMoves::MINIMIZE],[20,PBMoves::WATERPULSE],
			[24,PBMoves::SELFDESTRUCT],[26,PBMoves::PINMISSILE],[28,PBMoves::TOXICSPIKES],[32,PBMoves::BRINE],
			[36,PBMoves::STOCKPILE],[36,PBMoves::SPITUP],[40,PBMoves::TOXIC],[44,PBMoves::DARKPULSE],
			[48,PBMoves::POISONJAB],[50,PBMoves::AQUATAIL],[52,PBMoves::BARBBARRAGE],[56,PBMoves::DOUBLEEDGE],
			[60,PBMoves::CRUNCH],[66,PBMoves::DESTINYBOND]],
		:EggMoves => [PBMoves::AQUAJET,PBMoves::ASTONISH,PBMoves::BUBBLEBEAM,PBMoves::FLAIL,PBMoves::ICEBALL,
			PBMoves::SUPERSONIC],
		:GetEvo => [[PBSpecies::OVERQWIL,PBEvolution::HasMove,PBMoves::BARBBARRAGE]]
	}
},

PBSpecies::SNEASEL => {
	:FormName => {
		1 => "Hisui",
		2 => "Nuclear",
		3 => "NuclearHisui",
		4 => "Delta"
	},

	:OnCreation => proc{
		maps=[361,404]
		mapDelta1=[757]
		if $game_map && maps.include?($game_map.map_id)
			next 1
		elsif $game_map && mapDelta1.include?($game_map.map_id)
			next 4
		else
			next 0
		end
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Hisui" => {
		:DexEntry => "Its sturdy, curved claws are ideal for traversing precipitous cliffs. From the tips of these claws drips a venom that infiltrates the nerves of any prey caught in Sneasel's grasp.",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::POISON,
		:Ability => [PBAbilities::INNERFOCUS,PBAbilities::KEENEYE,PBAbilities::SHARPNESS,
			PBAbilities::PICKPOCKET,PBAbilities::POISONTOUCH],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[1,PBMoves::TAUNT],[6,PBMoves::ROCKSMASH],
			[8,PBMoves::QUICKATTACK],[11,PBMoves::METALCLAW],[18,PBMoves::SWIFT],[24,PBMoves::SCREECH],
			[30,PBMoves::SLASH],[34,PBMoves::HONECLAWS],[36,PBMoves::POISONJAB],[42,PBMoves::AGILITY],
			[48,PBMoves::BRICKBREAK],[54,PBMoves::SWORDSDANCE],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::COUNTER,PBMoves::CRUSHCLAW,PBMoves::DETECT,PBMoves::DIRECLAW,PBMoves::DOUBLEHIT,
			PBMoves::DRAINPUNCH,PBMoves::FAKEOUT,PBMoves::FEINT,PBMoves::FOCUSENERGY,PBMoves::IRONTAIL,
			PBMoves::NIGHTSLASH,PBMoves::QUICKGUARD,PBMoves::SHADOWSNEAK,PBMoves::SNARL,PBMoves::SWITCHEROO],
		:GetEvo => [[PBSpecies::SNEASLER,PBEvolution::DayHoldItem,PBItems::RAZORCLAW]]
	},

	"NuclearHisui" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::NUCLEAR,
		:Ability => [PBAbilities::INNERFOCUS,PBAbilities::KEENEYE,PBAbilities::SHARPNESS,
		PBAbilities::PICKPOCKET,PBAbilities::POISONTOUCH],
		:Movelist => [[1,PBMoves::NUCLEARSLASH],[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[1,PBMoves::TAUNT],
			[6,PBMoves::ROCKSMASH],[8,PBMoves::QUICKATTACK],[11,PBMoves::METALCLAW],[18,PBMoves::SWIFT],
			[24,PBMoves::SCREECH],[30,PBMoves::SLASH],[34,PBMoves::HONECLAWS],[36,PBMoves::POISONJAB],
			[42,PBMoves::AGILITY],[48,PBMoves::BRICKBREAK],[54,PBMoves::SWORDSDANCE],[60,PBMoves::CLOSECOMBAT]],
		:GetEvo => [[PBSpecies::SNEASLER,PBEvolution::DayHoldItem,PBItems::RAZORCLAW]]
	},

	"Delta" => {
		:DexEntry => "The obsidian shard shoved in its head drove it insane. Only the sound of its quartz claws screeching on rocks may calm it down.",
		:BaseStats => [61,101,76,101,41,56],
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::GHOST,
		:Ability => [PBAbilities::CURSEDBODY,PBAbilities::KEENEYE,PBAbilities::PICKPOCKET,
			PBAbilities::INNERFOCUS,PBAbilities::TOUGHCLAWS],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::CONFUSERAY],[6,PBMoves::SANDATTACK],
			[12,PBMoves::ASTONISH],[18,PBMoves::ACCELEROCK],[24,PBMoves::MEANLOOK],[30,PBMoves::ANCIENTPOWER],
			[36,PBMoves::HONECLAWS],[42,PBMoves::SHADOWSNEAK],[48,PBMoves::ROCKPOLISH],[54,PBMoves::HEX],
			[60,PBMoves::SLASH]],
		:EggMoves => [PBMoves::FAKEOUT,PBMoves::DOUBLEHIT,PBMoves::ICEPUNCH,PBMoves::COUNTER,PBMoves::SPITE,
			PBMoves::POISONFANG,PBMoves::THROATCHOP,PBMoves::CRUSHCLAW,PBMoves::CROSSPOISON,PBMoves::DETECT,
			PBMoves::SKYUPPERCUT,PBMoves::DIRECLAW]
	}
},

PBSpecies::TYPHLOSION => {
	:FormName => {
		1 => "Hisui",
		2 => "Egho",
		3 => "Rebornian",
		4 => "Mega X",
		5 => "Mega Y",
		6 => "Gen 2"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::TYPHLOSINITEX => 4,
		PBItems::TYPHLOSINITEY => 5
	},

	"Hisui" => {
		:DexEntry => "Said to purify lost, forsaken souls with its flames and guide them to the afterlife. I believe its form has been influenced by the energy of the sacred mountain towering at Hisui's center.",
		:Type2 => PBTypes::GHOST,
		:Ability => [PBAbilities::BLAZE,PBAbilities::INFILTRATOR,PBAbilities::FRISK,PBAbilities::FLASHFIRE],
		:BaseStats => [73,84,78,95,119,85],
		:Movelist => [[0,PBMoves::HEX],[1,PBMoves::GYROBALL],[1,PBMoves::OMINOUSWIND],[1,PBMoves::MYSTICALFIRE],
			[1,PBMoves::SLASH],[1,PBMoves::HEX],[1,PBMoves::FURYCUTTER],[1,PBMoves::SCRATCH],[1,PBMoves::LEER],
			[6,PBMoves::SMOKESCREEN],[9,PBMoves::TACKLE],[11,PBMoves::EMBER],[13,PBMoves::QUICKATTACK],
			[15,PBMoves::ROAR],[17,PBMoves::BITE],[19,PBMoves::FLAMEWHEEL],[21,PBMoves::DEFENSECURL],
			[23,PBMoves::FURYSWIPES],[25,PBMoves::FLAMECHARGE],[27,PBMoves::SCARYFACE],[29,PBMoves::SWIFT],
			[31,PBMoves::ROLLOUT],[33,PBMoves::LAVAPLUME],[35,PBMoves::REST],[37,PBMoves::INFERNO],
			[39,PBMoves::DOUBLEEDGE],[41,PBMoves::INFERNALPARADE],[43,PBMoves::FLAMETHROWER],
			[45,PBMoves::OVERHEAT],[47,PBMoves::BURNUP],[49,PBMoves::SHADOWBALL],[51,PBMoves::WILLOWISP],
			[55,PBMoves::ERUPTION]]
	},

	"Egho" => {
		:DexEntry => "Typhlosion is very dangerous to be around if it is not in a good mood. The energy that is generated from the heat and electricity matches that of a nuclear reactor.",
		:Type2 => PBTypes::ELECTRIC,
		:BaseStats => [84,64,94,97,120,78],
		:EVs => [0,0,0,1,2,0],
		:Ability => [PBAbilities::STATIC,PBAbilities::CLOUDNINE],
		:Movelist => [[0,PBMoves::SHOCKWAVE],[1,PBMoves::FIREPLEDGE],[1,PBMoves::FLAMEWHEEL],
			[1,PBMoves::TACKLE],[1,PBMoves::LEER],[6,PBMoves::SMOKESCREEN],
			[10,PBMoves::EMBER],[13,PBMoves::THUNDERSHOCK],[19,PBMoves::SPARK],
			[22,PBMoves::DEFENSECURL],[28,PBMoves::FLAMECHARGE],[31,PBMoves::SWIFT],
			[40,PBMoves::LAVAPLUME],[43,PBMoves::WILDCHARGE],[51,PBMoves::NATUREPOWER],
			[54,PBMoves::THUNDERBOLT],[62,PBMoves::HEATWAVE],[66,PBMoves::THUNDER],
			[70,PBMoves::TAILWIND]],
		:Weight => 680,
		:Height => 19,
		:kind => "Ash Cloud"
	},

	"Rebornian" => {
		:DexEntry => "As this Pokémon runs, the scales on its back rub against each other creating a massive amount of static electricity that keeps it moving through any fatigue it may have. This Pokémon can chase prey for a month without rest. It will always take the most direct course to get to where it's going. There have even been reports that entire towns have been run through by this pokemon.",
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [89,109,81,100,79,81],
		:EVs => [0,0,0,1,2,0],
		:Ability => [PBAbilities::RECKLESS,PBAbilities::HUSTLE,PBAbilities::CLOUDNINE],
		:Movelist => [[0,PBMoves::DOUBLEEDGE],[0,PBMoves::FLAMECHARGE],[0,PBMoves::ENDEAVOR],[0,PBMoves::LEER],[0,PBMoves::THUNDERSHOCK],[6,PBMoves::THUNDERSHOCK],[10,PBMoves::QUICKATTACK],[20,PBMoves::SPARK],
			[24,PBMoves::DUALCHOP],[27,PBMoves::POISONFANG],[31,PBMoves::HONECLAWS],
			[35,PBMoves::WILDCHARGE],[38,PBMoves::TAKEDOWN],[43,PBMoves::SCALESHOT],[48,PBMoves::DRAGONRUSH],[56,PBMoves::JAWLOCK],[62,PBMoves::VOLTTACKLE],[69,PBMoves::SLACKOFF],[70,PBMoves::TAILWIND]],
		:EggMoves => [PBMoves::FLAREBLITZ,PBMoves::HEADSMASH,PBMoves::CLANGOROUSSOUL,PBMoves::EXTREMESPEED,PBMoves::NATUREPOWER,PBMoves::THRASH,PBMoves::IRONHEAD],
		:Weight => 680,
		:Height => 19,
		:kind => "Static Predator"
	},

	"Mega X" => {
		:Type2 => PBTypes::FIGHTING,
		:Ability => PBAbilities::RECKLESS,
		:BaseStats => [78,154,118,90,99,95],
		:Weight => 860
	},

	"Mega Y" => {
		:Ability => PBAbilities::BERSERK,
		:BaseStats => [78,84,88,120,149,115],
		:Weight => 860
	},
	
	"Gen 2" => {
		:Ability => PBAbilities::BLAZERUSH,
	}
},

PBSpecies::SAMUROTT => {
	:FormName => {
		1 => "Hisui",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Hisui" => {
		:DexEntry => "Hard of heart and deft of blade, this rare form of Samurott is a product of the Pokémon's evolution in the region of Hisui. Its turbulent blows crash into foes like ceaseless pounding waves.",
		:Type2 => PBTypes::DARK,
		:Ability => [PBAbilities::TORRENT,PBAbilities::SHELLARMOR,PBAbilities::AQUABOOST,PBAbilities::SHARPNESS],
		:BaseStats => [90,108,80,85,100,65],
		:Movelist => [[0,PBMoves::CEASELESSEDGE],[1,PBMoves::PSYCHOCUT],[1,PBMoves::POISONJAB],
			[1,PBMoves::SACREDSWORD],[1,PBMoves::AQUACUTTER],[1,PBMoves::CEASELESSEDGE],
			[1,PBMoves::TACKLE],[5,PBMoves::TAILWHIP],[7,PBMoves::WATERSPORT],[11,PBMoves::WATERGUN],
			[13,PBMoves::FOCUSENERGY],[15,PBMoves::SOAK],[17,PBMoves::FURYCUTTER],[19,PBMoves::AQUAJET],
			[21,PBMoves::REVENGE],[23,PBMoves::WATERPULSE],[25,PBMoves::AERIALACE],[29,PBMoves::SLASH],
			[31,PBMoves::RAZORSHELL],[35,PBMoves::ENCORE],[37,PBMoves::SUCKERPUNCH],[39,PBMoves::RETALIATE],
			[41,PBMoves::AQUATAIL],[43,PBMoves::MEGAHORN],[45,PBMoves::NIGHTSLASH],[49,PBMoves::SWORDSDANCE],
			[52,PBMoves::DARKPULSE],[57,PBMoves::HYDROPUMP]],
		:Weight => 582
	},

	"Mega" => {
		:BaseStats => [95,140,105,90,108,90],
		:Ability => PBAbilities::SHARPNESS
	}
},

PBSpecies::EMBOAR => {

	:FormName => {
		1 => "Mega",
		2 => "Mega ZA"
	},
	
	:DefaultForm => 0,
	:MegaForm => {
		PBItems::EMBOARNITE => 1,
		PBItems::EMBOARITE => 2
	},
	
	"Mega" => {
		:BaseStats => [110,163,95,75,100,85],
		:Ability => PBAbilities::MOXIE
	},
	
	"Mega ZA" => {
		:BaseStats => [110,148,75,75,110,110],
		:Ability => PBAbilities::SHEERFORCE,
		:Weight => 1803,
		:Height => 18,
	}
},

PBSpecies::SERPERIOR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [75,95,115,133,95,115],
		:Ability => PBAbilities::ADAPTABILITY
	}
},

PBSpecies::DECIDUEYE => {
	:FormName => {1 => "Hisui"},

	"Hisui" => {
		:DexEntry => "The air stored inside the rachises of Decidueye's feathers insulates the Pokémon against Hisui's extreme cold. This is firm proof that evolution can be influenced by environment.",
		:Type2 => PBTypes::FIGHTING,
		:Ability => [PBAbilities::OVERGROW,PBAbilities::LONGREACH,PBAbilities::SCRAPPY,PBAbilities::STRONGHEEL],
		:BaseStats => [88,112,80,60,95,95],
		:Movelist => [[0,PBMoves::ROCKSMASH],[1,PBMoves::PSYCHOCUT],[1,PBMoves::SPIKES],[1,PBMoves::BULKUP],
			[1,PBMoves::FOCUSENERGY],[1,PBMoves::ROCKSMASH],[1,PBMoves::TACKLE],[1,PBMoves::GROWL],
			[4,PBMoves::LEAFAGE],[6,PBMoves::PECK],[8,PBMoves::FORESIGHT],[11,PBMoves::GUST],
			[14,PBMoves::ASTONISH],[16,PBMoves::FURYATTACK],[18,PBMoves::SHADOWSNEAK],[20,PBMoves::RAZORLEAF],
			[22,PBMoves::OMINOUSWIND],[25,PBMoves::SYNTHESIS],[27,PBMoves::MAGICALLEAF],[29,PBMoves::PLUCK],
			[31,PBMoves::FEATHERDANCE],[33,PBMoves::AERIALACE],[35,PBMoves::ROOST],[37,PBMoves::SUCKERPUNCH],
			[39,PBMoves::TRIPLEARROWS],[43,PBMoves::UTURN],[46,PBMoves::AURASPHERE],[49,PBMoves::NASTYPLOT],
			[51,PBMoves::AIRSLASH],[54,PBMoves::LEAFBLADE],[58,PBMoves::BRAVEBIRD],[60,PBMoves::LEAFSTORM]],
		:Weight => 370
	}
},

PBSpecies::ZORUA => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[797,803,807] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "A once-departed soul, returned to life in Hisui. Derives power from resentment, which rises as energy atop its head and takes on the forms of foes. In this way, Zorua vents lingering malice.",
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [35,60,40,70,85,40],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[4,PBMoves::TORMENT],[8,PBMoves::SPITE],
			[12,PBMoves::SHADOWSNEAK],[16,PBMoves::TAUNT],[20,PBMoves::CURSE],[22,PBMoves::SNARL],
			[24,PBMoves::HONECLAWS],[26,PBMoves::SWIFT],[28,PBMoves::AGILITY],[32,PBMoves::KNOCKOFF],
			[34,PBMoves::SLASH],[36,PBMoves::BITTERMALICE],[40,PBMoves::FOULPLAY],[44,PBMoves::SHADOWCLAW],
			[48,PBMoves::NASTYPLOT],[54,PBMoves::SHADOWBALL]],
		:EggMoves => [PBMoves::COMEUPPANCE,PBMoves::DETECT,PBMoves::EXTRASENSORY,PBMoves::MEMENTO]
	}
},

PBSpecies::ZOROARK => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[797,803,807] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "With its disheveled white fur, it looks like an embodiment of death. Heedless of its own safety, Zoroark attacks its nemeses with a bitter energy so intense, it lacerates Zoroark's own body.",
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [55,100,60,110,125,60],
		:Movelist => [[0,PBMoves::EXTRASENSORY],[1,PBMoves::HAPPYHOUR],[1,PBMoves::ROCKSMASH],
			[1,PBMoves::OMINOUSWIND],[1,PBMoves::EXTRASENSORY],[1,PBMoves::SCRATCH],[1,PBMoves::LEER],
			[4,PBMoves::TORMENT],[8,PBMoves::SPITE],[12,PBMoves::SHADOWSNEAK],[16,PBMoves::TAUNT],
			[20,PBMoves::CURSE],[22,PBMoves::SNARL],[24,PBMoves::HONECLAWS],[26,PBMoves::SWIFT],
			[28,PBMoves::AGILITY],[32,PBMoves::KNOCKOFF],[34,PBMoves::SLASH],[36,PBMoves::BITTERMALICE],
			[40,PBMoves::FOULPLAY],[44,PBMoves::SHADOWCLAW],[48,PBMoves::NASTYPLOT],[52,PBMoves::UTURN],
			[54,PBMoves::SHADOWBALL]],
		:Weight => 730
	}
},

PBSpecies::BRAVIARY => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[642,643,646,836,837] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "Screaming a bloodcurdling battle cry, this huge and ferocious bird Pokémon goes out on the hunt. It blasts lakes with shock waves, then scoops up any prey that float to the water's surface.",
		:Type1 => PBTypes::PSYCHIC,
		:EVs => [0,0,0,0,2,0],
		:Ability => [PBAbilities::KEENEYE,PBAbilities::SHEERFORCE,PBAbilities::DEFIANT,PBAbilities::PRIDE,PBAbilities::TINTEDLENS],
		:BaseStats => [110,57,70,70,123,80], #Canon: [110,83,70,65,112,70]
		:Movelist => [[0,PBMoves::ESPERWING],[1,PBMoves::MYSTICALFIRE],[1,PBMoves::OMINOUSWIND],
			[1,PBMoves::SUPERPOWER],[1,PBMoves::POUNCE],[1,PBMoves::PSYWAVE],[1,PBMoves::ESPERWING],
			[1,PBMoves::PECK],[1,PBMoves::LEER],[5,PBMoves::FURYATTACK],[10,PBMoves::SCARYFACE],
			[12,PBMoves::QUICKATTACK],[14,PBMoves::HONECLAWS],[16,PBMoves::TWISTER],[19,PBMoves::WINGATTACK],
			[23,PBMoves::WHIRLWIND],[28,PBMoves::DEFOG],[32,PBMoves::AERIALACE],[37,PBMoves::SLASH],
			[41,PBMoves::TAILWIND],[43,PBMoves::ROOST],[46,PBMoves::AIRSLASH],[50,PBMoves::CRUSHCLAW],
			[55,PBMoves::SKYDROP],[59,PBMoves::THRASH],[64,PBMoves::BRAVEBIRD],[66,PBMoves::DOUBLEEDGE],
			[72,PBMoves::SKYATTACK],[80,PBMoves::HURRICANE]],
		:Weight => 434
	}
},

PBSpecies::SLIGGOO => {
	:FormName => {1 => "Hisui"},		

	"Hisui" => {
		:DexEntry => "A creature given to melancholy. I suspect its metallic shell developed as a result of the mucus on its skin reacting with the iron in Hisui's water.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [58,75,83,40,83,113],
		:Ability => [PBAbilities::SAPSIPPER,PBAbilities::SHELLARMOR,PBAbilities::OVERCOAT,PBAbilities::GOOEY],
		:Movelist => [[0,PBMoves::IRONHEAD],[1,PBMoves::IRONHEAD],[1,PBMoves::TACKLE],[1,PBMoves::ABSORB],
			[5,PBMoves::BIDE],[9,PBMoves::WATERGUN],[13,PBMoves::DRAGONBREATH],[15,PBMoves::CURSE],
			[18,PBMoves::BUBBLE],[20,PBMoves::FLAIL],[25,PBMoves::ACIDSPRAY],[28,PBMoves::RAINDANCE],
			[30,PBMoves::WATERPULSE],[32,PBMoves::PROTECT],[35,PBMoves::BODYSLAM],[38,PBMoves::ACIDARMOR],
			[40,PBMoves::MUDDYWATER],[42,PBMoves::SHELTER],[45,PBMoves::DRAGONPULSE],[47,PBMoves::HYDROPUMP]],
		:Weight => 685
	}
},

PBSpecies::GOODRA => {
	:FormName => {1 => "Hisui"},

	"Hisui" => {
		:DexEntry => "Able to freely control the hardness of its metallic shell. It loathes solitude and is extremely clingy—it will fume and run riot if those dearest to it ever leave its side.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [80,100,100,60,110,150],
		:Ability => [PBAbilities::SAPSIPPER,PBAbilities::SHELLARMOR,PBAbilities::OVERCOAT,PBAbilities::GOOEY],
		:Movelist => [[0,PBMoves::FEINT],[1,PBMoves::ROCKSMASH],[1,PBMoves::FEINT],[1,PBMoves::IRONHEAD],
		[1,PBMoves::TACKLE],[1,PBMoves::ABSORB],[5,PBMoves::BIDE],[9,PBMoves::WATERGUN],
		[13,PBMoves::DRAGONBREATH],[15,PBMoves::CURSE],[18,PBMoves::BUBBLE],[20,PBMoves::FLAIL],
		[25,PBMoves::ACIDSPRAY],[28,PBMoves::RAINDANCE],[30,PBMoves::WATERPULSE],[32,PBMoves::PROTECT],
		[35,PBMoves::BODYSLAM],[38,PBMoves::ACIDARMOR],[40,PBMoves::MUDDYWATER],[42,PBMoves::SHELTER],
		[45,PBMoves::DRAGONPULSE],[47,PBMoves::HYDROPUMP],[51,PBMoves::IRONTAIL],[55,PBMoves::TEARFULLOOK],
		[67,PBMoves::HEAVYSLAM]],
		:Weight => 3341
	}
},

PBSpecies::WEEZING => {
	:FormName => {
		1 => "Galarian",
		2 => "Cosmic"
	},

	"Galarian" => {
		:DexEntry => "This Pokémon consumes particles that contaminate the air. Instead of leaving droppings, it expels clean air.",
		:Type2 => PBTypes::FAIRY,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::NEUTRALIZINGGAS,PBAbilities::MISTYSURGE],
		:Movelist => [[0,PBMoves::DOUBLEHIT],[1,PBMoves::HEATWAVE],[1,PBMoves::STRANGESTEAM],
			[1,PBMoves::AROMATICMIST],[1,PBMoves::DEFOG],[1,PBMoves::FAIRYWIND],[1,PBMoves::AROMATHERAPY],
			[1,PBMoves::DOUBLEHIT],[1,PBMoves::TACKLE],[1,PBMoves::POISONGAS],[4,PBMoves::SMOG],
			[6,PBMoves::SMOKESCREEN],[8,PBMoves::CLEARSMOG],[10,PBMoves::ASSURANCE],[12,PBMoves::GYROBALL],
			[15,PBMoves::SLUDGE],[18,PBMoves::SELFDESTRUCT],[23,PBMoves::HAZE],[26,PBMoves::TOXIC],
			[28,PBMoves::SLUDGEBOMB],[33,PBMoves::EXPLOSION],[37,PBMoves::MEMENTO],[40,PBMoves::BELCH],
			[42,PBMoves::MISTYTERRAIN],[45,PBMoves::DESTINYBOND]]
	},

	"Cosmic" => {
		:DexEntry => "After evolving, this Pokémon's body mass increases significantly, making it produce an enormous amount of inebriating gas that puts Weezing on a terrible bad trip. ",
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [100,50,70,110,90,120], #? Cosmic increases by +50
		:Ability => [PBAbilities::LEVITATE,PBAbilities::NEUTRALIZINGGAS,PBAbilities::CURIOUSMEDICINE],
		:Movelist => [[0,PBMoves::DOUBLEHIT],[1,PBMoves::DEFOG],[1,PBMoves::SMOG],[1,PBMoves::SMOKESCREEN],
			[1,PBMoves::ASTRALSHOT],[1,PBMoves::CLEARSMOG],[1,PBMoves::SLUDGE],[1,PBMoves::DESTINYBOND],[1,PBMoves::MOONLIGHT],[40,PBMoves::TOXIC],[42,PBMoves::COSMICRAY],[46,PBMoves::MYSTICALFIRE],[50,PBMoves::BELCH],[57,PBMoves::MOONBLAST],[60,PBMoves::COSMICDANCE],[105,PBMoves::COSMICBARRAGE]]
	},
},

PBSpecies::FARFETCHD => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[150,848,849,850,857,859] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "The Farfetch’d of the Galar region are brave warriors, and they wield thick, tough leeks in battle.",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [52,95,55,55,58,62],
		:Ability => [PBAbilities::STEADFAST,PBAbilities::SCRAPPY],
		:Movelist => [[1,PBMoves::PECK],[1,PBMoves::SANDATTACK],[5,PBMoves::LEER],[10,PBMoves::FURYCUTTER],
			[15,PBMoves::ROCKSMASH],[20,PBMoves::BRUTALSWING],[25,PBMoves::DETECT],[30,PBMoves::SLAM],
			[35,PBMoves::KNOCKOFF],[40,PBMoves::DEFOG],[45,PBMoves::BRICKBREAK],[50,PBMoves::SWORDSDANCE],
			[55,PBMoves::LEAFBLADE],[60,PBMoves::FINALGAMBIT],[65,PBMoves::BRAVEBIRD]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::AIRSLASH,PBMoves::COUNTER,PBMoves::COVET,PBMoves::CURSE,PBMoves::CUT,
			PBMoves::DOUBLEEDGE,PBMoves::FEINT,PBMoves::FLAIL,PBMoves::FURYATTACK,PBMoves::MIRRORMOVE,PBMoves::NIGHTSLASH,
			PBMoves::QUICKATTACK,PBMoves::QUICKGUARD,PBMoves::RAZORLEAF,PBMoves::SIMPLEBEAM,PBMoves::SLASH,
			PBMoves::SKYATTACK],
		:GetEvo => [[PBSpecies::SIRFETCHD,PBEvolution::LandCritical,3]]
	}
},

PBSpecies::PONYTA => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[285,286,287,290,291,292] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "This Pokémon will look into your eyes and read the contents of your heart. If it finds evil there, it promptly hides away.",
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::PSYCHIC,
		:Ability => [PBAbilities::RUNAWAY,PBAbilities::PASTELVEIL,PBAbilities::ANTICIPATION],
		:Movelist => [[1,PBMoves::GROWL],[1,PBMoves::TACKLE],[5,PBMoves::TAILWHIP],[10,PBMoves::CONFUSION],
			[15,PBMoves::FAIRYWIND],[20,PBMoves::STOMP],[25,PBMoves::PSYBEAM],[20,PBMoves::TAKEDOWN],[35,PBMoves::AGILITY],
			[41,PBMoves::HEALPULSE],[45,PBMoves::DAZZLINGGLEAM],[50,PBMoves::PSYCHIC],[55,PBMoves::HEALINGWISH]],
		:EggMoves => [PBMoves::DOUBLEEDGE,PBMoves::DOUBLEKICK,PBMoves::EMBER,PBMoves::FIREBLAST,PBMoves::FIRESPIN,
			PBMoves::FLAREBLITZ,PBMoves::HORNDRILL,PBMoves::HYPNOSIS,PBMoves::MORNINGSUN,PBMoves::QUICKATTACK,
			PBMoves::THRASH],
	}
},

PBSpecies::RAPIDASH => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[285,286,287,290,291,696,697,700,788,812,849,850] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "Brave and prideful, this Pokémon dashes airily through the forest, its steps aided by the psychic power stored in the fur on its fetlocks.",
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::FAIRY,
		:Ability => [PBAbilities::RUNAWAY,PBAbilities::PASTELVEIL,PBAbilities::ANTICIPATION],
		:Movelist => [[0,PBMoves::PSYCHOCUT],[1,PBMoves::MEGAHORN],[1,PBMoves::QUICKATTACK],[1,PBMoves::GROWL],
			[1,PBMoves::TACKLE],[5,PBMoves::TAILWHIP],[10,PBMoves::CONFUSION],[15,PBMoves::FAIRYWIND],
			[20,PBMoves::STOMP],[25,PBMoves::PSYBEAM],[20,PBMoves::TAKEDOWN],[35,PBMoves::AGILITY],
			[41,PBMoves::HEALPULSE],[45,PBMoves::DAZZLINGGLEAM],[50,PBMoves::PSYCHIC],[55,PBMoves::HEALINGWISH]]
	}
},

PBSpecies::ARTICUNO => {
	:FormName => {1 => "Galarian"},
	
	"Galarian" => {
		:DexEntry => "Its feather-like blades are composed of psychic energy and can shear through thick iron sheets as if they were paper.",
		:Type1 => PBTypes::PSYCHIC,
		:EVs => [0,0,0,0,3,0],
		:BaseStats => [90,85,85,95,125,100],
		:Ability => [PBAbilities::COMPETITIVE,PBAbilities::MAGICIAN],
		:Movelist => [[1,PBMoves::GUST],[1,PBMoves::PSYCHOSHIFT],[5,PBMoves::CONFUSION],[10,PBMoves::REFLECT],
			[15,PBMoves::HYPNOSIS],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::TAILWIND],
			[35,PBMoves::PSYCHOCUT],[40,PBMoves::RECOVER],[45,PBMoves::FREEZINGGLARE],[50,PBMoves::DREAMEATER],
			[55,PBMoves::HURRICANE],[60,PBMoves::MINDREADER],[65,PBMoves::DOUBLETEAM],[70,PBMoves::FUTURESIGHT],
			[75,PBMoves::TRICKROOM]],
		:Weight => 509
	}
},

PBSpecies::ZAPDOS => {
	:FormName => {1 => "Galarian"},
	
	"Galarian" => {
		:DexEntry => "One kick from its powerful legs will pulverize a dump truck. Supposedly, this Pokémon runs through the mountains at over 180 mph.",
		:Type1 => PBTypes::FIGHTING,
		:EVs => [0,3,0,0,0,0],
		:BaseStats => [90,125,90,100,85,90],
		:Ability => [PBAbilities::DEFIANT,PBAbilities::STRONGHEEL],
		:Movelist => [[1,PBMoves::PECK],[1,PBMoves::FOCUSENERGY],[5,PBMoves::ROCKSMASH],
			[10,PBMoves::LIGHTSCREEN],[15,PBMoves::PLUCK],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],
			[30,PBMoves::BRICKBREAK],[35,PBMoves::DRILLPECK],[40,PBMoves::QUICKGUARD],
			[45,PBMoves::THUNDEROUSKICK],[50,PBMoves::BULKUP],[55,PBMoves::COUNTER],[60,PBMoves::DETECT],
			[65,PBMoves::CLOSECOMBAT],[70,PBMoves::REVERSAL]],
		:Weight => 582
	}
},

PBSpecies::MOLTRES => {
	:FormName => {1 => "Galarian"},
	
	"Galarian" => {
		:DexEntry => "This Pokémon's sinister, flame-like aura will consume the spirit of any creature it hits. Victims become burned-out shadows of themselves.",
		:Type1 => PBTypes::DARK,
		:EVs => [0,0,0,0,0,3],
		:BaseStats => [90,85,90,90,100,125],
		:Ability => [PBAbilities::BERSERK,PBAbilities::FLASHFIRE],
		:Movelist => [[1,PBMoves::GUST],[1,PBMoves::LEER],[5,PBMoves::PAYBACK],[10,PBMoves::SAFEGUARD],
			[15,PBMoves::WINGATTACK],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::SUCKERPUNCH],
			[35,PBMoves::AIRSLASH],[40,PBMoves::AFTERYOU],[45,PBMoves::FIERYWRATH],[50,PBMoves::NASTYPLOT],
			[55,PBMoves::HURRICANE],[60,PBMoves::ENDURE],[65,PBMoves::MEMENTO],[70,PBMoves::SKYATTACK]],
		:Weight => 660
	}
},

PBSpecies::THUFIZER => {
	:FormName => {1 => "Galarian"},

	"Galarian" => {
		:DexEntry => "This fusion is more stable than its Kantonian counterpart, but it emits an aura of great malice.",
		:Type1 => PBTypes::PFD,
		:EVs => [0,0,0,0,1,2],
		:BaseStats => [90,98,88,95,103,105],
		:Ability => [PBAbilities::COMPETITIVE,PBAbilities::BERSERK,PBAbilities::HYDRABOND],
		:Movelist => [[1,PBMoves::GUST],[1,PBMoves::LEER],[5,PBMoves::PAYBACK],[10,PBMoves::SAFEGUARD],
			[15,PBMoves::WINGATTACK],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::SUCKERPUNCH],
			[35,PBMoves::AIRSLASH],[40,PBMoves::AFTERYOU],[45,PBMoves::FIERYWRATH],[50,PBMoves::NASTYPLOT],
			[55,PBMoves::HURRICANE],[60,PBMoves::ENDURE],[65,PBMoves::MEMENTO],[70,PBMoves::SKYATTACK],[1,PBMoves::PECK],[1,PBMoves::FOCUSENERGY],[5,PBMoves::ROCKSMASH],
			[10,PBMoves::LIGHTSCREEN],[15,PBMoves::PLUCK],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],
			[30,PBMoves::BRICKBREAK],[35,PBMoves::DRILLPECK],[40,PBMoves::QUICKGUARD],[45,PBMoves::THUNDEROUSKICK],
			[50,PBMoves::BULKUP],[55,PBMoves::COUNTER],[60,PBMoves::DETECT],[65,PBMoves::CLOSECOMBAT],[70,PBMoves::REVERSAL],[1,PBMoves::GUST],[1,PBMoves::PSYCHOSHIFT],[5,PBMoves::CONFUSION],[10,PBMoves::REFLECT],
			[15,PBMoves::HYPNOSIS],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::TAILWIND],
			[35,PBMoves::PSYCHOCUT],[40,PBMoves::RECOVER],[45,PBMoves::FREEZINGGLARE],[50,PBMoves::DREAMEATER],
			[55,PBMoves::HURRICANE],[60,PBMoves::MINDREADER],[65,PBMoves::FUTURESIGHT],[70,PBMoves::TRICKROOM]],
		:Weight => 584
	}
},

PBSpecies::SLOWPOKE => {
	:FormName => {2 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[238,412,545,546,713,715,716,718,726,742,763] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "Although this Pokémon is normally zoned out, its expression abruptly sharpens on occasion. The cause for this seems to lie in Slowpoke’s diet.",
		:Type1 => PBTypes::PSYCHIC,
		:Ability => [PBAbilities::GLUTTONY,PBAbilities::OWNTEMPO,PBAbilities::REGENERATOR],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::CURSE],[3,PBMoves::GROWL],[6,PBMoves::ACID],[9,PBMoves::YAWN],
			[12,PBMoves::CONFUSION],[15,PBMoves::DISABLE],[18,PBMoves::WATERPULSE],[21,PBMoves::HEADBUTT],
			[24,PBMoves::ZENHEADBUTT],[27,PBMoves::SLACKOFF],[30,PBMoves::RAINDANCE],[33,PBMoves::SURF],
			[36,PBMoves::PSYCHUP],[39,PBMoves::HEALPULSE],[42,PBMoves::AMNESIA],[45,PBMoves::PSYCHIC]],
		:EggMoves => [PBMoves::BELCH,PBMoves::BELLYDRUM,PBMoves::BLOCK,PBMoves::STOMP],
		:GetEvo => [[PBSpecies::SLOWBRO,PBEvolution::Item,PBItems::GALARICACUFF],
			[PBSpecies::SLOWKING,PBEvolution::Item,PBItems::GALARICAWREATH]]
	}
},

PBSpecies::SLOWKING => {
	:FormName => {2 => "Galarian"},

	"Galarian" => {
		:DexEntry => "A combination of toxins and the shock of evolving has increased Shellder’s intelligence to the point that Shellder now controls Slowking.",
		:Type1 => PBTypes::POISON,
		:Ability => [PBAbilities::CURIOUSMEDICINE,PBAbilities::OWNTEMPO,PBAbilities::REGENERATOR],
		:Movelist => [[0,PBMoves::EERIESPELL],[1,PBMoves::CHILLYRECEPTION],[1,PBMoves::NASTYPLOT],[1,PBMoves::TOXICSPIKES],
			[1,PBMoves::POWERGEM],[1,PBMoves::SWAGGER],[1,PBMoves::EERIESPELL],[1,PBMoves::TACKLE],[1,PBMoves::CURSE],
			[3,PBMoves::GROWL],[6,PBMoves::ACID],[9,PBMoves::YAWN],[12,PBMoves::CONFUSION],[15,PBMoves::DISABLE],
			[18,PBMoves::WATERPULSE],[21,PBMoves::HEADBUTT],[24,PBMoves::ZENHEADBUTT],[27,PBMoves::SLACKOFF],
			[30,PBMoves::RAINDANCE],[33,PBMoves::SURF],[36,PBMoves::PSYCHUP],[39,PBMoves::HEALPULSE],[42,PBMoves::AMNESIA],
			[45,PBMoves::PSYCHIC]]
	}
},

PBSpecies::CORSOLA => {
	:FormName => {
		1 => "Galarian",
		2 => "Nuclear",
		3 => "NuclearGalarian",
		4 => "Mega"
	},

	:OnCreation => proc{
		chancemaps=[575,576,577,578,579,608,610,851,856,863] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:MegaForm => 4,

	"Galarian" => {
		:DexEntry => "Sudden climate change wiped out this ancient kind of Corsola. This Pokémon absorbs others’ life-force through its branches.",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,55,100,30,65,100],
		:Ability => [PBAbilities::WEAKARMOR,PBAbilities::CURSEDBODY],
		:Movelist => [[1,PBMoves::HARDEN],[1,PBMoves::TACKLE],[5,PBMoves::ASTONISH],[10,PBMoves::DISABLE],
			[15,PBMoves::SPITE],[20,PBMoves::NIGHTSHADE],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::HEX],
			[35,PBMoves::CURSE],[40,PBMoves::STRENGTHSAP],[45,PBMoves::POWERGEM],[50,PBMoves::GRUDGE],
			[55,PBMoves::MIRRORCOAT]],
		:EggMoves => [PBMoves::CONFUSERAY,PBMoves::CORALBREAK,PBMoves::DESTINYBOND,PBMoves::HAZE,		
			PBMoves::HEADSMASH,PBMoves::NATUREPOWER,PBMoves::WATERPULSE],
		:GetEvo => [[PBSpecies::CURSOLA,PBEvolution::Level,38]],
		:Weight => 5
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"NuclearGalarian" => {
		:DexEntry => "Sudden climate change wiped out this ancient kind of Corsola. This Pokémon absorbs others’ life-force through its branches.",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [60,55,100,30,65,100],
		:Ability => [PBAbilities::WEAKARMOR,PBAbilities::CURSEDBODY],
		:Movelist => [[1,PBMoves::HARDEN],[1,PBMoves::TACKLE],[5,PBMoves::ASTONISH],[10,PBMoves::DISABLE],
		[15,PBMoves::SPITE],[20,PBMoves::NIGHTSHADE],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::HEX],
		[35,PBMoves::CURSE],[40,PBMoves::STRENGTHSAP],[45,PBMoves::POWERGEM],[50,PBMoves::GRUDGE],
		[55,PBMoves::MIRRORCOAT]],
		:EggMoves => [PBMoves::CONFUSERAY,PBMoves::CORALBREAK,PBMoves::DESTINYBOND,PBMoves::HAZE,		
		PBMoves::HEADSMASH,PBMoves::NATUREPOWER,PBMoves::WATERPULSE],
		:GetEvo => [[PBSpecies::CURSOLA,PBEvolution::Level,38]],
		:Weight => 5
	},

	"Mega" => {
		:BaseStats => [55,45,75,105,95,75],
		:Type2 => PBTypes::GHOST,
		:Ability => PBAbilities::WATERBUBBLE
	}
},

PBSpecies::CURSOLA => {
	:FormName => {3 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CORSOREEF => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ZIGZAGOON => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[234,519] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "Thought to be the oldest form of Zigzagoon, it moves in zigzags and wreaks havoc upon its surroundings.",
		:Type1 => PBTypes::DARK,
		:Movelist => [[1,PBMoves::LEER],[1,PBMoves::TACKLE],[3,PBMoves::SANDATTACK],[6,PBMoves::LICK],
			[9,PBMoves::SNARL],[12,PBMoves::HEADBUTT],[15,PBMoves::BABYDOLLEYES],[18,PBMoves::PINMISSILE],
			[21,PBMoves::REST],[24,PBMoves::TAKEDOWN],[27,PBMoves::SCARYFACE],[30,PBMoves::COUNTER],
			[43,PBMoves::TAUNT],[56,PBMoves::DOUBLEEDGE]],
		:EggMoves => [PBMoves::KNOCKOFF,PBMoves::PARTINGSHOT,PBMoves::QUICKGUARD]
	}
},

PBSpecies::LINOONE => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[285,286,287,290,291,519,831] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "This very aggressive Pokémon will recklessly challenge opponents stronger than itself.",
		:Type1 => PBTypes::DARK,
		:Movelist => [[0,PBMoves::FURYSWIPES],[1,PBMoves::FURYSWIPES],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
			[3,PBMoves::SANDATTACK],[6,PBMoves::LICK],[9,PBMoves::SNARL],[12,PBMoves::HEADBUTT],
			[15,PBMoves::BABYDOLLEYES],[18,PBMoves::PINMISSILE],[21,PBMoves::REST],[24,PBMoves::TAKEDOWN],
			[27,PBMoves::SCARYFACE],[30,PBMoves::COUNTER],[33,PBMoves::SWITCHEROO],[38,PBMoves::HONECLAWS],
			[43,PBMoves::TAUNT],[45,PBMoves::SUCKERPUNCH],[52,PBMoves::NIGHTSLASH],[56,PBMoves::DOUBLEEDGE]],
		:GetEvo => [[PBSpecies::OBSTAGOON,PBEvolution::LevelNight,35]]
	}
},

PBSpecies::SINISTEA => {
	:FormName => {
		0 => "Phony",
		1 => "Antique"
	},
	:OnCreation => proc{rand(2)},

	"Antique" => {
		:DexEntry => "The swirl pattern in this Pokémon's body is its weakness. If it gets stirred, the swirl loses its shape, and Sinistea gets dizzy.",
		:GetEvo => [[PBSpecies::POLTEAGEIST,PBEvolution::Item,PBItems::CRACKEDPOT]]
	}
},

PBSpecies::POLTEAGEIST => {
	:FormName => {
		0 => "Phony",
		1 => "Antique"
	},

	"Antique" => {
		:DexEntry => "When angered, it launches tea from its body at the offender's mouth. The tea causes strong chills if swallowed."
	}
},

PBSpecies::POLTCHAGEIST => {
	:FormName => {
		0 => "Counterfeit",
		1 => "Artisan"
	},
	:OnCreation => proc{rand(2)},

	"Artisan" => {
		:DexEntry => "It sprinkles some of its powdery body onto food and drains the life-force from those who so much as lick it.",
		:GetEvo => [[PBSpecies::SINISTCHA,PBEvolution::Item,PBItems::MASTERPIECETEACUP]]
	}
},

PBSpecies::SINISTCHA => {
	:FormName => {
		0 => "Unremarkable",
		1 => "Masterpiece"
	},

	"Masterpiece" => {
		:DexEntry => "It lives inside a superb teacup that was crafted by a potter of great renown. Collectors positively adore this Pokémon."
	}
},

PBSpecies::STUNFISK => {
	:FormName => {1 => "Galarian"},
	:OnCreation => proc{rand(2)},

	"Galarian" => {
		:DexEntry => "Living in mud with a high iron content has given it a strong steel body.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [109,81,99,32,66,84],
		:Ability => [PBAbilities::MIMICRY],
		:Movelist => [[1,PBMoves::MUDSLAP],[1,PBMoves::TACKLE],[1,PBMoves::WATERGUN],[1,PBMoves::ENDURE],
			[5,PBMoves::METALCLAW],[10,PBMoves::METALSOUND],[15,PBMoves::REVENGE],[20,PBMoves::MUDSHOT],
			[25,PBMoves::IRONDEFENSE],[30,PBMoves::SNAPTRAP],[35,PBMoves::FLAIL],[40,PBMoves::SUCKERPUNCH],
			[45,PBMoves::BOUNCE],[50,PBMoves::MUDDYWATER],[55,PBMoves::FISSURE]],
		:EggMoves => [PBMoves::ASTONISH,PBMoves::BIND,PBMoves::COUNTER,PBMoves::CURSE,PBMoves::EARTHPOWER,
			PBMoves::MEFIRST,PBMoves::PAINSPLIT,PBMoves::REFLECTTYPE,PBMoves::SLEEPTALK,PBMoves::SPITE,
			PBMoves::YAWN]
	}
},

###################### Paldean Forms Gen 9 ######################

PBSpecies::TAUROS => {
	:FormName => {
		1 => "Combat Breed",
		2 => "Blaze Breed",
		3 => "Aqua Breed",
		4 => "Gen 2"
	},

	"Combat Breed" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [75,110,105,100,30,70],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::ANGERPOINT,PBAbilities::CUDCHEW],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::WORKUP],[10,PBMoves::DOUBLEKICK],
			[15,PBMoves::ASSURANCE],[20,PBMoves::SCARYFACE],[25,PBMoves::HEADBUTT],[30,PBMoves::REST],
			[35,PBMoves::SWAGGER],[40,PBMoves::ZENHEADBUTT],[45,PBMoves::RAGINGBULL],[50,PBMoves::THRASH],
			[55,PBMoves::DOUBLEEDGE],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::CURSE,PBMoves::ENDEAVOR,PBMoves::SCREECH]
	},

	"Blaze Breed" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [75,110,105,100,30,70],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::ANGERPOINT,PBAbilities::CUDCHEW],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::WORKUP],[10,PBMoves::DOUBLEKICK],
		[15,PBMoves::FLAMECHARGE],[20,PBMoves::SCARYFACE],[25,PBMoves::HEADBUTT],[30,PBMoves::REST],
		[35,PBMoves::SWAGGER],[40,PBMoves::ZENHEADBUTT],[45,PBMoves::RAGINGBULL],[50,PBMoves::THRASH],
		[55,PBMoves::FLAREBLITZ],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::CURSE,PBMoves::ENDEAVOR,PBMoves::SCREECH]
	},

	"Aqua Breed" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::WATER,
		:BaseStats => [75,110,105,100,30,70],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::ANGERPOINT,PBAbilities::CUDCHEW],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::WORKUP],[10,PBMoves::DOUBLEKICK],
		[15,PBMoves::AQUAJET],[20,PBMoves::SCARYFACE],[25,PBMoves::HEADBUTT],[30,PBMoves::REST],
		[35,PBMoves::SWAGGER],[40,PBMoves::ZENHEADBUTT],[45,PBMoves::RAGINGBULL],[50,PBMoves::THRASH],
		[55,PBMoves::WAVECRASH],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::CURSE,PBMoves::ENDEAVOR,PBMoves::SCREECH]
	},
	
	"Gen 2" => {
	:Ability => [PBAbilities::HYPERMOMENTUM]
	}
},

PBSpecies::WOOPER => {
	:FormName => {1 => "Paldean"},
	:OnCreation => proc{rand(2)},

	"Paldean" => {
		:DexEntry => "After losing a territorial struggle, Wooper began living on land. The Pokémon changed over time, developing a poisonous film to protect its body.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::GROUND,
		:Ability => [PBAbilities::POISONPOINT,PBAbilities::WATERABSORB,PBAbilities::WATERABSORB,PBAbilities::DEEPSLEEP,PBAbilities::UNAWARE],
		:Movelist => [[1,PBMoves::TAILWHIP],[1,PBMoves::POISONSTING],[1,PBMoves::MUDSHOT],[4,PBMoves::TACKLE],
			[8,PBMoves::POISONTAIL],[12,PBMoves::TOXICSPIKES],[16,PBMoves::SLAM],[21,PBMoves::YAWN],
			[24,PBMoves::POISONJAB],[28,PBMoves::SLUDGEWAVE],[32,PBMoves::AMNESIA],[40,PBMoves::TOXIC],
			[44,PBMoves::EARTHQUAKE]],
		:EggMoves => [PBMoves::AFTERYOU,PBMoves::ANCIENTPOWER,PBMoves::COUNTER,PBMoves::DOUBLEKICK,
			PBMoves::MIST,PBMoves::RECOVER,PBMoves::SPITUP,PBMoves::STOCKPILE,PBMoves::SWALLOW],
		:GetEvo => [[PBSpecies::CLODSIRE,PBEvolution::Level,20]],
	}
},

PBSpecies::OINKOLOGNE => {
	#Gender difference
	"Female" => {
		:DexEntry => "This is a meticulous Pokémon that likes to keep things tidy. It shrouds itself in a floral aroma that soothes the Pokémon around it.",
		:Ability => [PBAbilities::AROMAVEIL,PBAbilities::LINGERINGAROMA,PBAbilities::GLUTTONY,
			PBAbilities::THICKFAT],
		:BaseStats => [115,90,70,65,59,90]
	}
},

PBSpecies::PALAFIN => {
	:FormName => {1 => "Hero"},

	"Hero" => {
		:DexEntry => "This Pokémon’s ancient genes have awakened. It is now so extraordinarily strong that it can easily lift a cruise ship with one fin.",
		:BaseStats => [100,160,97,100,106,87]
	}
},

PBSpecies::DUNSPARCE => {
	:OnCreation => proc{
		randomnum = rand(10)
		next randomnum==0 ? 1 : 0
	}
},

PBSpecies::DUDUNSPARCE => {
	:FormName => {
		0 => "Double",
		1 => "Triple"
	},

	"Triple" => {
		:DexEntry => "The gentle Dudunsparce will put Pokémon that wander into its nest onto its back and carry them to the entrance."
	}
},

PBSpecies::TANDEMAUS => {
	:OnCreation => proc{
		randomnum = rand(10)
		next randomnum==0 ? 1 : 0
	}
},

PBSpecies::MAUSHOLD => {
	:FormName => {
		0 => "Fours",
		1 => "Threes"
	},

	"Threes" => {
		:DexEntry => "The little one just appeared one day. They all live together like a family, but the relationship between the three is still unclear."
	}
},

PBSpecies::GIMMIGHOUL => {
	:FormName => {
		0 => "Chest",
		1 => "Wandering"
	},

	"Wandering" => {
		:DexEntry => "It wanders around, carrying an old coin on its back. It survives by draining the life-force from humans who try to pick up its coin.",
		:BaseStats => [45,30,25,80,75,45],
		:Ability => PBAbilities::RUNAWAY
	}
},

PBSpecies::TATSUGIRI => {
	:FormName => {
		0 => "Curly",
		1 => "Droopy",
		2 => "Stretchy"
	},
	:OnCreation => proc{rand(3)},

	"Droopy" => {
		:DexEntry => "This species’ differing colors and patterns are apparently the result of Tatsugiri changing itself to suit the preferences of the prey it lures in."
	},

	"Stretchy" => {
		:DexEntry => "It's one of the most intelligent dragon Pokémon. It camouflages itself by inflating its throat sac."
	}
},

PBSpecies::OGERPON => {
	:FormName => {
		0 => "Unmasked",
		1 => "Teal Mask",
		2 => "Wellspring Mask",
		3 => "Hearthflame Mask",
		4 => "Cornerstone Mask",
		5 => "Mega Teal",
		6 => "Mega Wellspring",
		7 => "Mega Hearthflame",
		8 => "Mega Cornerstone",
		9 => "Majora's Mask",
		10 => "Mega Majora"
	},

	:DefaultForm => {
		PBItems::TEALMASK => 1,
		PBItems::WELLSPRINGMASK => 2,
		PBItems::HEARTHFLAMEMASK => 3,
		PBItems::CORNERSTONEMASK => 4,
		PBItems::MAJORAMASK => 9
	},
	:MegaForm => {
		PBItems::TEALMASK => 5,
		PBItems::WELLSPRINGMASK => 6,
		PBItems::HEARTHFLAMEMASK => 7,
		PBItems::CORNERSTONEMASK => 8,
		PBItems::MAJORAMASK => 10
	},

	"Teal Mask" => {
		:DexEntry => "This mischief-loving Pokémon is full of curiosity. It battles by drawing out the type-based energy contained within its masks.",
		
		:Ability => PBAbilities::DEFIANT
	},

	"Wellspring Mask" => {
		:DexEntry => "This form excels in both attack and defense. It ceaselessly unleashes moves like a spring gushes water.",
		:Type2 => PBTypes::WATER,
		:Ability => PBAbilities::WATERABSORB
	},

	"Hearthflame Mask" => {
		:DexEntry => "This form is the most aggressive, bombarding enemies with the intensity of flames blazing within a hearth.",
		:Type2 => PBTypes::FIRE,
		:Ability => PBAbilities::MOLDBREAKER
	},

	"Cornerstone Mask" => {
		:DexEntry => "This form has excellent defenses, absorbing impacts solidly like the cornerstones that support houses.",
		:Type2 => PBTypes::ROCK,
		:Ability => PBAbilities::STURDY
	},

	"Mega Teal" => {
		:Ability => PBAbilities::EMBODYASPECT,
		:Type2 => PBTypes::GRASS
	},

	"Mega Wellspring" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::WATER,
		:Ability => PBAbilities::EMBODYASPECT
	},

	"Mega Hearthflame" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FIRE,
		:Ability => PBAbilities::EMBODYASPECT
	},

	"Mega Cornerstone" => {
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::ROCK,
		:Ability => PBAbilities::EMBODYASPECT
	},
	
	"Majora's Mask" => {
		:DexEntry => "This form extremely boosts its attack. It unleashes cosmic power from another world.",
		:Type2 => PBTypes::COSMIC,
		:Ability => PBAbilities::THICKFAT
	},
	
	"Mega Majora" => {
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::COSMIC,
		:Ability => PBAbilities::EMBODYASPECT
	},
},

###################### Custom Megas ######################

PBSpecies::DELIBIRD => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [60,100,50,120,45,55],
		:Ability => PBAbilities::TECHNICIAN,
	}
},

PBSpecies::VILEPLUME => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,95,105,30,155,120],
		:Ability => PBAbilities::EFFECTSPORE,
	}
},

PBSpecies::VICTREEBEL => {
	:FormName => {
		1 => "Mega",
		2 => "Mega ZA"
	},
	
	:DefaultForm => 0,
	:MegaForm => {
		PBItems::VICTREEBELITE => 1,
		PBItems::VICTREEBELITEZA => 2
	},

	"Mega" => {
		:BaseStats => [90,125,85,80,120,90],
		:Ability => PBAbilities::CHLOROPHYLL,
	},
	
	"Mega ZA" => {
		#:Type2 => PBTypes::FAIRY,
		:BaseStats => [80,125,85,70,135,95],
		:Ability => PBAbilities::CORROSION,
		:Weight => 1255,
		:Height => 45
	}	
},

PBSpecies::STARMIE => {
		:FormName => {
		1 => "Mega",
		2 => "Mega ZA"
	},
	
	:DefaultForm => 0,
	:MegaForm => {
		PBItems::STARMINITE => 1,
		PBItems::STARMINITEZA => 2
	},


	"Mega" => {
		:BaseStats => [70,90,85,130,135,90],
		:Ability => PBAbilities::MAGICGUARD,
	},
	
	"Mega ZA" => {
		#:Type2 => PBTypes::FAIRY,
		:BaseStats => [60,100,105,120,130,105],
		:Ability => PBAbilities::HUGEPOWER,
		#:Weight => 2010,
		:Height => 23
	}	
},

PBSpecies::NOCTOWL => {
	:FormName => {
		1 => "Egho",
		2 => "Mega"
	},

	:OnCreation => proc{
		chancemaps=[333,334,335,358,359,360,361,372,404,412,439,519,522,523,525,526,527,528,530,533,544,551,573]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Egho" => {
		:DexEntry => "Noctowl use the crest on its head to reflect light into the eyes of its prey. On moonless nights, one may mistake the crest as the actual moon.",
		:Type1 => PBTypes::DARK,
		:BaseStats => [86,50,77,70,99,70],
		:EVs => [0,0,0,0,2,0],
		:Ability => [PBAbilities::UNNERVE,PBAbilities::NOGUARD],
		:Movelist => [[0,PBMoves::FOULPLAY],
			[1,PBMoves::GROWL],[1,PBMoves::GUST],[1,PBMoves::ECHOEDVOICE],
			[5,PBMoves::HYPNOSIS],[9,PBMoves::CONFUSION],[13,PBMoves::NIGHTSHADE],
			[17,PBMoves::HORNATTACK],[21,PBMoves::NIGHTMARE],[25,PBMoves::OMINOUSWIND],
			[29,PBMoves::SNARL],[33,PBMoves::AIRSLASH],[37,PBMoves::RAZORWIND],
			[41,PBMoves::MOONBLAST],[45,PBMoves::SNATCH],[49,PBMoves::NIGHTDAZE],
			[53,PBMoves::ROOST],[57,PBMoves::DREAMEATER],[62,PBMoves::HURRICANE],
			[66,PBMoves::NASTYPLOT]],
		:GetEvo => [[PBSpecies::GRIMFOWL,PBEvolution::Item,PBItems::DUSKSTONE]],
		:Weight => 498,
		:Height => 19,
		:kind => "Moon Owl"
	},

	"Mega" => {
		:Type1 => PBTypes::PSYCHIC,
		:BaseStats => [120,50,60,90,136,96],
		:Ability => PBAbilities::TINTEDLENS,
	}
},

PBSpecies::XATU => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,95,80,115,125,90],
		:Ability => PBAbilities::MAGICBOUNCE,
	}
},

PBSpecies::JUMPLUFF => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::DARK,
		:BaseStats => [75,115,80,120,65,105],
		:Ability => PBAbilities::TECHNICIAN
	}
},

PBSpecies::SUNFLORA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,55,65,50,145,115],
		:Ability => PBAbilities::HYDRABOND
	}
},

PBSpecies::SHUCKLE => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::GHOST,
		:BaseStats => [20,15,250,55,15,250],
		:Ability => PBAbilities::SHADOWTAG,
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LANTURN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [125,98,68,107,86,76],
		:Ability => PBAbilities::RECKLESS
	}
},

PBSpecies::ZANGOOSE => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [83,145,70,120,70,70],
		:Ability => PBAbilities::TOUGHCLAWS,
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EXPLOUD => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::ELECTRIC,
		:BaseStats => [124,71,93,58,141,103],
		:Ability => PBAbilities::PUNKROCK
	}
},

PBSpecies::MILOTIC => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega",
		3 => "Delta"
	},

	:OnCreation => proc{
		chancemaps=[879,882] # Map IDs for Delta form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 3 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:BaseStats => [105,70,89,91,130,155],
		:Ability => PBAbilities::REGENERATOR
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Delta" => {
		:DexEntry => "Returned to the surface thanks to its now powerful psychic powers, he's the origin of a myth about a monster guarding Azurine Island.",
		:BaseStats => [106,66,66,81,126,101],
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::DRAGON,
		:Ability => [PBAbilities::POISONHEAL,PBAbilities::BERSERK,PBAbilities::MAGICGUARD],
		:Movelist => [[0,PBMoves::WATERPULSE],[1,PBMoves::FLAIL],[1,PBMoves::WRAP],[1,PBMoves::SMOG],[1,PBMoves::SPLASH],[1,PBMoves::POISONSTING],[4,PBMoves::ACID],[8,PBMoves::TWISTER],[12,PBMoves::AQUARING],[16,PBMoves::LIGHTSCREEN],[20,PBMoves::TOXIC],[24,PBMoves::DRAGONBREATH],[28,PBMoves::REFLECT],[32,PBMoves::VENOSHOCK],[36,PBMoves::SAFEGUARD],[40,PBMoves::PSYSHOCK],[44,PBMoves::DIVE],[48,PBMoves::COIL],[52,PBMoves::DRAGONPULSE],[58,PBMoves::PSYCHIC]],
	}
},

PBSpecies::CHIMECHO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::GHOST,
		:BaseStats => [95,60,90,75,125,110],
		:Ability => PBAbilities::PSYCHICSURGE
	}
},

PBSpecies::CACTURNE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,155,80,75,115,80],
		:Ability => PBAbilities::SANDRUSH,
	}
},

PBSpecies::TORKOAL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,100,160,20,120,100],
		:Ability => PBAbilities::DROUGHT
	}
},

PBSpecies::TORTERRA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::ROCK,
		:BaseStats => [125,139,125,46,85,105],
		:Ability => PBAbilities::ROCKYPAYLOAD
	}
},

PBSpecies::INFERNAPE => {
	:FormName => {
		1 => "Rebornian",
		2 => "Rebornian Rage",
		3 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [77,106,69,116,101,69],
		:Ability => [PBAbilities::BLAZE,PBAbilities::FURIOUSSPIRIT,PBAbilities::RAGINGBLAZE,PBAbilities::PARRY],
		:Movelist => [[1,PBMoves::KNOCKOFF],[1,PBMoves::BULKUP],[1,PBMoves::FACADE],[1,PBMoves::VACUUMWAVE],[1,PBMoves::FLAREBLITZ],[1,PBMoves::BRUTALSWING],[1,PBMoves::MACHPUNCH],[1,PBMoves::NASTYPLOT],[1,PBMoves::FOULPLAY],[1,PBMoves::SLACKOFF],[1,PBMoves::LASHOUT],[1,PBMoves::NIGHTDAZE],[7,PBMoves::FIREPUNCH],[9,PBMoves::TAUNT],[12,PBMoves::POWERUPPUNCH],[16,PBMoves::BRICKBREAK],[19,PBMoves::FLAMEWHEEL],[26,PBMoves::FEINT],[52,PBMoves::SUCKERPUNCH],[58,PBMoves::CALMMIND],[68,PBMoves::FLAREBLITZ]],
		:Weight => 370
	},

	"Rebornian Rage" => {
		:DexEntry => ".",
		:Type1 => PBTypes::NUCLEAR,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [77,106,138,174,101,138],
		:Ability => [PBAbilities::BLAZE,PBAbilities::FURIOUSSPIRIT,PBAbilities::RAGINGBLAZE,PBAbilities::PARRY],
		:Movelist => [[1,PBMoves::KNOCKOFF],[1,PBMoves::BULKUP],[1,PBMoves::FACADE],[1,PBMoves::VACUUMWAVE],[1,PBMoves::FLAREBLITZ],[1,PBMoves::BRUTALSWING],[1,PBMoves::MACHPUNCH],[1,PBMoves::NASTYPLOT],[1,PBMoves::FOULPLAY],[1,PBMoves::SLACKOFF],[1,PBMoves::LASHOUT],[1,PBMoves::NIGHTDAZE],[7,PBMoves::FIREPUNCH],[9,PBMoves::TAUNT],[12,PBMoves::POWERUPPUNCH],[16,PBMoves::THROATCHOP],[19,PBMoves::FLAMEWHEEL],[26,PBMoves::FEINT],[52,PBMoves::SUCKERPUNCH],[58,PBMoves::CALMMIND],[68,PBMoves::FLAREBLITZ]],
		:Weight => 370
	},

	"Mega" => {
		:BaseStats => [96,134,81,118,124,81],
		:Ability => PBAbilities::FLASHFIRE
	}
},

PBSpecies::EMPOLEON => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [84,116,118,60,131,121],
		:Ability => PBAbilities::BULLETPROOF
	}
},

PBSpecies::ROSERADE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,90,75,110,140,125],
		:Ability => PBAbilities::CONTRARY
	}
},

PBSpecies::KINGDRA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,110,95,120,135,95],
		:Ability => PBAbilities::MULTISCALE
	}
},

PBSpecies::NIDOKING => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega X",
		3 => "Mega Y"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::NIDOTITEX => 2,
		PBItems::NIDOTITEY => 3
	},

	"Mega X" => {
		:BaseStats => [81,142,107,85,95,95],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 860
	},

	"Mega Y" => {
		:BaseStats => [81,122,97,95,105,105],
		:Ability => PBAbilities::SHEERFORCE,
		:Weight => 860
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MOTHIM => {
	:FormName => {3 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 3,

	"Mega" => {
		:BaseStats => [70,54,70,126,134,70],
		:Ability => PBAbilities::PROTEAN
	}
},

PBSpecies::BRONZONG => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:BaseStats => [87,109,146,33,89,136],
		:Ability => PBAbilities::LEVITATE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WEAVILE => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		4 => "Delta"
	},

	:OnCreation => proc{
		chancemaps=[866] # Map IDs for Delta form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,150,75,155,65,95],
		:Ability => PBAbilities::SHARPNESS
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Delta" => {
		:DexEntry => "It loves terrifying people by sharpening its claws on their house walls after midnight. Anybody touching its shard will black out instantly.",
		:BaseStats => [76,136,86,111,46,61],
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::GHOST,
		:Ability => [PBAbilities::CURSEDBODY,PBAbilities::TOUGHCLAWS],
		:Movelist => [[1,PBMoves::ASTONISH],[1,PBMoves::ANCIENTPOWER],[1,PBMoves::SHADOWSNEAK],[1,PBMoves::SCRATCH],[1,PBMoves::ROCKPOLISH],[1,PBMoves::SANDATTACK],[1,PBMoves::OMINOUSWIND],[1,PBMoves::CURSE],[1,PBMoves::GLARE],[1,PBMoves::SLASH],[1,PBMoves::CONFUSERAY],[6,PBMoves::SANDATTACK],[12,PBMoves::ASTONISH],[18,PBMoves::ACCELEROCK],[24,PBMoves::MEANLOOK],[30,PBMoves::ROCKTOMB],[36,PBMoves::HONECLAWS],[42,PBMoves::SHADOWCLAW],[48,PBMoves::STEALTHROCK],[54,PBMoves::HEX],[60,PBMoves::SLASH],[66,PBMoves::STONEEDGE],[72,PBMoves::PHANTOMFORCE]]
	}
},

PBSpecies::DUSKNOIR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::DARK,
		:BaseStats => [65,120,135,75,95,135],
		:Ability => PBAbilities::UNAWARE
	}
},

PBSpecies::FROSLASS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "Mega ZA"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::FROSLASSITE => 1,
		PBItems::FROSLASSITEZA => 3
	},

	"Mega" => {
		:BaseStats => [70,90,70,125,135,90],
		:Ability => PBAbilities::REFRIGERATE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},
	
	"Mega ZA" => {
		:BaseStats => [70,80,70,120,140,100],
		:Ability => PBAbilities::SNOWWARNING,
		:Weight => 2960,
		:Height => 26,
	}
},

PBSpecies::SCRAFTY => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega",
		3 => "Mega ZA"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::SCRAFTINITE => 2,
		PBItems::SCRAFTINITEZA => 3
	},

	"Mega" => {
		:BaseStats => [85,120,135,78,35,135],
		:Ability => PBAbilities::INTIMIDATE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},
	
	"Mega ZA" => {
		:BaseStats => [65,130,135,68,55,135],
		:Ability => PBAbilities::MOXIE,
		:Weight => 310
	},
},

PBSpecies::REUNICLUS => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:BaseStats => [130,95,85,40,145,95],
		:Ability => PBAbilities::GOOEY
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BARBARACLE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [72,64,96,108,125,135],
		:Ability => PBAbilities::NEUROFORCE
	}
},

PBSpecies::TSAREENA => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [87,145,108,92,70,108],
		:Ability => PBAbilities::QUEENLYMAJESTY
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

#todo##################### Multicore Variants #####################todo#

#? i should've done this before...

PBSpecies::PYTHONOVA => {
	:FormName => {
		1 => "Mega",
		19 => "Dev"
	},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type1 => PBTypes::GFW,
		:Type2 => PBTypes::DRAGON,
		#:BaseStats => [150,65,100,35,75,105], #! Base form [530]
		:BaseStats => [100,147,30,151,162,40], #? Mega Form [630]
		#:BaseStats => [150,155,5,151,159,10], #todo Proposed [630]
		:Ability => PBAbilities::ANCIENTPRESSURE,
		:Weight => 500
	},

	"Dev" => {
		:Ability => PBAbilities::MULTICORE
	}
},

PBSpecies::CORPHISH => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		chancemaps=[586]
		forcedmaps=[206]
		# Map IDs for Rebornian form
		randomnum = rand(4)
		if $game_map && ((chancemaps.include?($game_map.map_id) && randomnum==0) || forcedmaps.include?($game_map.map_id))
			next 1
		else
			next 0
		end
	},

	"Rebornian" => {
		:DexEntry => "Due to Corphish's hardiness it is usually able to thrive in polluted waters, however not all Corphish are as strong as their neighbors. Due to the extreme strength of the Pulse pollutants in Azurine, some of the local Corphish adapt to take in the poisoned water.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [43,80,65,35,50,35],
		:Ability => [PBAbilities::ADAPTABILITY,PBAbilities::POISONPOINT,PBAbilities::POISONTOUCH],
		:Movelist => [[1,PBMoves::POISONSTING],[5,PBMoves::HARDEN],[7,PBMoves::VISEGRIP],[10,PBMoves::TOXICSPIKES],[14,PBMoves::THIEF],[17,PBMoves::PROTECT],[20,PBMoves::HORNATTACK],[23,PBMoves::KNOCKOFF],[26,PBMoves::SHADOWPUNCH],[31,PBMoves::PAINSPLIT],[34,PBMoves::TAUNT],[37,PBMoves::SWORDSDANCE],[39,PBMoves::DESTINYBOND],[43,PBMoves::CRABHAMMER],[48,PBMoves::TOXIC]],
		:EggMoves => [PBMoves::ASTONISH,PBMoves::BIND,PBMoves::COUNTER,PBMoves::CURSE,PBMoves::EARTHPOWER,PBMoves::MEFIRST,
									PBMoves::PAINSPLIT,PBMoves::REFLECTTYPE,PBMoves::SLEEPTALK,PBMoves::SPITE,PBMoves::YAWN]
	}
},

PBSpecies::CRAWDAUNT => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		chancemaps=[586]
		forcedmaps=[206]
		# Map IDs for Rebornian form
		randomnum = rand(4)
		if $game_map && ((chancemaps.include?($game_map.map_id) && randomnum==0) || forcedmaps.include?($game_map.map_id))
			next 1
		else
			next 0
		end
	},

	"Rebornian" => {
		:DexEntry => "Due to Corphish's hardiness it is usually able to thrive in polluted waters, however not all Corphish are as strong as their neighbors. Due to the extreme strength of the Pulse pollutants in Azurine, some of the local Corphish adapt to take in the poisoned water.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,120,80,55,70,80],
		:Ability => [PBAbilities::ADAPTABILITY,PBAbilities::POISONPOINT,PBAbilities::POISONTOUCH],
		:Movelist => [[0,PBMoves::POISONJAB],[1,PBMoves::SHADOWSNEAK],[1,PBMoves::PAINSPLIT],[1,PBMoves::PHANTOMFORCE],[5,PBMoves::HARDEN],[7,PBMoves::VISEGRIP],[10,PBMoves::TOXICSPIKES],[14,PBMoves::THIEF],[17,PBMoves::PROTECT],[20,PBMoves::HORNATTACK],[23,PBMoves::KNOCKOFF],[26,PBMoves::SHADOWPUNCH],[32,PBMoves::PAINSPLIT],[36,PBMoves::TAUNT],[40,PBMoves::SWORDSDANCE],[48,PBMoves::GUNKSHOT],[54,PBMoves::TOXIC],[57,PBMoves::SHADOWCLAW]]
	}
},

PBSpecies::KOFFING => {
	:FormName => {2 => "Cosmic"},

	:OnCreation => proc{
		mapNewKoffing=[497,498,499,500,501,502,503,504,505] # Map IDs for Rebornian form
		next $game_map && mapNewKoffing.include?($game_map.map_id) ? 2 : 0
	},

	"Cosmic" => {
		:DexEntry => "It releases a highly psychoactive gas, that is believed by many cultures to possess cosmic powers. Thanks to that, this Pokémon is popularly known as the \"shamanic Pokémon\" and it's often used on mystic and religious rituals. It appears to always be pleasantly intoxicated.",
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [60,35,45,65,60,95], #? Cosmic increases by +30
		:Ability => [PBAbilities::LEVITATE,PBAbilities::NEUTRALIZINGGAS,PBAbilities::CURIOUSMEDICINE],
		:Movelist => [[1,PBMoves::POISONGAS],[1,PBMoves::TACKLE],[4,PBMoves::SMOG],[4,PBMoves::EMBER],[7,PBMoves::SMOKESCREEN],[12,PBMoves::CLEARSMOG],[15,PBMoves::PSYBEAM],[18,PBMoves::SLUDGE],[23,PBMoves::FLAMEBURST],[26,PBMoves::COSMICPOWER],[29,PBMoves::ASTRALSHOT],[34,PBMoves::SLUDGEBOMB],[37,PBMoves::TOXIC],[42,PBMoves::MYSTICALFIRE],[52,PBMoves::COSMICDANCE]]
	}
},

PBSpecies::BALTOY => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		mapNewBaltoy=[651,652,653,654,655,656,657,658,659,661,662] # Map IDs for Rebornian form
		next $game_map && mapNewBaltoy.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => "This Pokémon is a fine example of ancient pottery. Rumors say that an artisan's spirit dwells inside it, spending centuries anxiously trying to gather its broken pieces.",
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [75,20,55,40,40,70],
		:Ability => [PBAbilities::LEVITATE,PBAbilities::CURSEDBODY,PBAbilities::SHADOWTAG],
		:Movelist => [[1,PBMoves::HARDEN],[1,PBMoves::ASTONISH],[1,PBMoves::RAPIDSPIN],[4,PBMoves::CURSE],[7,PBMoves::MUDSLAP],[10,PBMoves::MAGNITUDE],[13,PBMoves::CONFUSERAY],[16,PBMoves::HEX],[19,PBMoves::ANCIENTPOWER],[21,PBMoves::COSMICPOWER],[23,PBMoves::ASTRALSHOT],[25,PBMoves::MOONLIGHT],[28,PBMoves::MUDBOMB],[31,PBMoves::EXTRASENSORY],[34,PBMoves::BITTERMALICE],[36,PBMoves::PERISHSONG],[38,PBMoves::EARTHPOWER],[40,PBMoves::SHADOWBALL],[40,PBMoves::PERISHSONG],[43,PBMoves::SANDSTORM],[46,PBMoves::DESTINYBOND],[46,PBMoves::PERISHSONG]]
	}
},

PBSpecies::CLAYDOL => {
	:FormName => {
		1 => "Rebornian",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	:OnCreation => proc{
		mapNewBaltoy=[651,652,653,654,655,656,657,658,659,661,662] # Map IDs for Rebornian form
		next $game_map && mapNewBaltoy.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => "After gathering all its missing pieces, Baltoy starts spinning and singing an ominous song that allows it to evolve. Claydol then starts to devour the souls of those who listened the sinister chant to satiate its bitter malice.",
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [110,50,110,50,70,120],
		:Ability => [PBAbilities::LEVITATE,PBAbilities::CURSEDBODY,PBAbilities::SHADOWTAG],
		:Movelist => [[0,PBMoves::COSMICRAY],[1,PBMoves::HYPERBEAM],[1,PBMoves::TELEPORT],[1,PBMoves::RAPIDSPIN],[1,PBMoves::PERISHSONG],[1,PBMoves::COSMICPOWER],[1,PBMoves::BITTERMALICE],[1,PBMoves::HYPNOSIS],[1,PBMoves::NIGHTMARE],[40,PBMoves::EARTHPOWER],[43,PBMoves::SHADOWBALL],[46,PBMoves::SANDSTORM],[48,PBMoves::DESTINYBOND],[55,PBMoves::COSMICRAY],[80,PBMoves::COMETSHOWER]]
	},

	"Mega" => {
		:BaseStats => [60,70,135,75,105,155],
		:Ability => PBAbilities::ANALYTIC
	}
},

###################### Mega Evolutions ######################

PBSpecies::KYOGRE => {
	:FormName => {1 => "Primal"},

	"Primal" => {
		:BaseStats => [100,150,90,90,180,160],
		:Ability => PBAbilities::PRIMORDIALSEA,
		:Height => 98,
		:Weight => 4300
	}
},

PBSpecies::GROUDON => {
	:FormName => {1 => "Primal"},

	"Primal" => {
		:BaseStats => [100,180,160,90,150,90],
		:Ability => PBAbilities::DESOLATELAND,
		:Height => 50,
		:Weight => 9997,
		:Type2 => PBTypes::FIRE
	}
},

PBSpecies::VENUSAUR => {
	:FormName => {
		1 => "Mega",
		2 => "Dyna",
		3 => "Egho"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::VENUSAURITE => 1,
		PBItems::VENUSAURITEG => 2
	},

	"Mega" => {
		:BaseStats => [80,100,123,80,122,120],
		:Ability => PBAbilities::THICKFAT,
		:Height => 24,
		:Weight => 1555
	},

	"Dyna" => {
		:BaseStats => [105,80,100,80,120,140],
		:Ability => PBAbilities::EFFECTSPORE
	},

	"Egho" => {
		:DexEntry => "Large, thorn covered brambles protect an aged cactus. Small rodent Pokémon tend to make nests in the dry grass patches at the base of the cactus.",
		:Type2 => PBTypes::ROCK,
		:BaseStats => [80,109,88,67,90,100],
		:EVs => [0,2,0,0,0,2],
		:Ability => [PBAbilities::ROCKHEAD,PBAbilities::SOLIDROCK,PBAbilities::SANDSTREAM],
		:Movelist => [[0,PBMoves::BULLDOZE],[1,PBMoves::THORNWHIP],
			[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[1,PBMoves::HARDEN],
			[5,PBMoves::ABSORB],[6,PBMoves::SANDATTACK],[8,PBMoves::DRYNEEDLES],
			[10,PBMoves::BARBEDTACKLE],[12,PBMoves::LEECHSEED],[14,PBMoves::ROCKTHROW],
			[20,PBMoves::SANDSTORM],[23,PBMoves::MAGNITUDE],[26,PBMoves::NEEDLEARM],
			[30,PBMoves::ROCKBLAST],[33,PBMoves::STEALTHROCK],[40,PBMoves::ROCKSLIDE],
			[42,PBMoves::ROCKPOLISH],[47,PBMoves::SOLARBEAM],[50,PBMoves::EARTHQUAKE],
			[53,PBMoves::EARTHPOWER],[55,PBMoves::STONEEDGE],[60,PBMoves::CACTUSSMASH],[70,PBMoves::HEADSMASH]],
		:Weight => 2800,
		:Height => 26,
		:kind => "Harsh Plant"
	}
},

PBSpecies::CHARIZARD => {
	:FormName => {
		1 => "Mega X",
		2 => "Mega Y",
		3 => "Dyna",
		4 => "Rebornian",
		5 => "Egho",
		6 => "Rebornian Wasteland"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::CHARIZARDITEG => 3,
		PBItems::CHARIZARDITEY => 2,
		PBItems::CHARIZARDITEX => 1
	},

	"Mega Y" => {
		:BaseStats => [78,104,78,100,159,115],
		:Ability => PBAbilities::DROUGHT,
		:Weight => 1005
	},

	"Mega X" => {
		:BaseStats => [78,130,111,100,130,85],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Weight => 1105,
		:Type2 => PBTypes::DRAGON
	},

	"Dyna" => {
		:BaseStats => [120,84,100,86,139,105],
		:Ability => PBAbilities::BERSERK,
		:Weight => 1105
	},

	"Rebornian" => {
		:DexEntry => "Even though it seems like this Pokèmon has lost its flame, the plasma inside its body is capable of heating it up to sun surface level.",
		:BaseStats => [90,105,94,96,85,80],
		:Ability => [PBAbilities::DROUGHT,PBAbilities::INNERFLAME],
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::DRAGON,
		:Movelist => [[0,PBMoves::WILLOWISP],[1,PBMoves::DRAGONCLAW],[1,PBMoves::EMBER],[1,PBMoves::GROWL],[1,PBMoves::HEATWAVE],[1,PBMoves::SCRATCH],[1,PBMoves::SMOKESCREEN],[1,PBMoves::SHADOWCLAW],[7,PBMoves::FIREPUNCH],[9,PBMoves::TAUNT],[12,PBMoves::POWERUPPUNCH],[16,PBMoves::SCARYFACE],[19,PBMoves::SLASH],[26,PBMoves::ROOST],[30,PBMoves::PLAYROUGH],[34,PBMoves::FLAMETHROWER],[38,PBMoves::IRONHEAD],[42,PBMoves::CLOSECOMBAT],[44,PBMoves::OUTRAGE],[48,PBMoves::DRAGONDANCE],[52,PBMoves::SUCKERPUNCH],[58,PBMoves::CALMMIND],[68,PBMoves::FLAREBLITZ]]
	},

	"Egho" => {
		:DexEntry => "A powerful dragon Pokémon that is said to be hard to tame. It likes to soar high above the clouds.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [76,88,75,106,109,80],
		:EVs => [0,0,0,1,0,0],
		:Ability => [PBAbilities::LEVITATE,PBAbilities::COMPETITIVE,PBAbilities::INTIMIDATE],
		:Movelist => [[0,PBMoves::DRAGONCLAW],[1,PBMoves::SHADOWCLAW],
			[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[5,PBMoves::EMBER],
			[7,PBMoves::HONECLAWS],[10,PBMoves::NAILFLICK],[13,PBMoves::SMOKESCREEN],
			[16,PBMoves::NOSTRILFLARE],[19,PBMoves::FLAMEWHEEL],[23,PBMoves::SCARYFACE],[27,PBMoves::INCINERATE],
			[29,PBMoves::DRAGONRAGE],[31,PBMoves::FIREFANG],[35,PBMoves::DRAGONCLAW],
			[42,PBMoves::FLAMEBURST],[46,PBMoves::FLAMETHROWER],[50,PBMoves::DRAGONPULSE],
			[52,PBMoves::DRAGONDANCE],[54,PBMoves::INFERNO],[58,PBMoves::HEATWAVE],
			[62,PBMoves::OUTRAGE],[66,PBMoves::FLAREBLITZ],[70,PBMoves::DRACOBLITZ]],
		:Weight => 905,
		:Height => 23,
		:kind => "Sacred Dragon"
	},

	"Rebornian Wasteland" => {
		:DexEntry => "As Charizard grows old, the metallic compounds of its venomous fluids begins to sediment on the tip of its tail, making the needle in it bigger and sturdier. Just a little sting from this Pokémon's needle is enough to kill a person within seconds.",
		:Type1 => PBTypes::POISON,
		:BaseStats => [120,110,95,50,40,120],
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::LIQUIDOOZE,PBAbilities::INJECTION],
		:Movelist => [[0,PBMoves::DUALWINGBEAT],[1,PBMoves::WINGATTACK],[1,PBMoves::JETINJECTOR],[1,PBMoves::CLOSECOMBAT],[1,PBMoves::AIRSLASH],[1,PBMoves::DRAGONCLAW],[1,PBMoves::SHADOWCLAW],[1,PBMoves::FIREFANG],[1,PBMoves::POISONFANG],[1,PBMoves::JAWLOCK],[41,PBMoves::POISONJAB],[47,PBMoves::NEEDLEDRAIN],[50,PBMoves::DRILLPECK],[53,PBMoves::CRUNCH],[56,PBMoves::BRAVEBIRD],[62,PBMoves::FLAREBLITZ]],
		:Weight => 370,
		:kind => "Injection"
	}
},

PBSpecies::BLASTOISE => {
	:FormName => {
		1 => "Mega" ,
		2 => "Dyna",
		3 => "Egho"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::BLASTOISINITE => 1,
		PBItems::BLASTOISINITEG => 2
	},

	"Mega" => {
		:BaseStats => [79,103,120,78,135,115],
		:Ability => PBAbilities::MEGALAUNCHER,
		:Weight => 1011
	},

	"Dyna" => {
		:BaseStats => [119,83,130,48,145,105],
		:Ability => PBAbilities::LIGHTNINGROD,
		:Weight => 1011
	},

	"Egho" => {
		:DexEntry => "Blastoise drift around high in the sky, forming ice crystals on their shell that they use in battle once the've landed.",
		:Type2 => PBTypes::FLYING,
		:BaseStats => [79,80,95,81,95,100],
		:EVs => [0,0,1,0,1,2],
		:Ability => [PBAbilities::SERENEGRACE,PBAbilities::DRIZZLE,PBAbilities::SNOWWARNING],
		:Movelist => [[0,PBMoves::AIRSLASH],[1,PBMoves::GUST],
			[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[1,PBMoves::WITHDRAW],
			[5,PBMoves::BUBBLE],[6,PBMoves::NIMBUSFIST],[9,PBMoves::AQUARING],
			[12,PBMoves::BITE],[15,PBMoves::FOGGYSTRIKE],[19,PBMoves::BUBBLEBEAM],
			[20,PBMoves::ICESHARD],[21,PBMoves::MIST],[25,PBMoves::PROTECT],
			[27,PBMoves::AIRCUTTER],[28,PBMoves::WATERPULSE],[31,PBMoves::AQUATAIL],
			[35,PBMoves::ICYWIND],[38,PBMoves::RAINDANCE],[42,PBMoves::HAIL],
			[44,PBMoves::AURORABEAM],[47,PBMoves::TYPHOON],[50,PBMoves::HYDROPUMP],
			[54,PBMoves::TAILWIND],[56,PBMoves::DISCHARGE],[58,PBMoves::HURRICANE],
			[62,PBMoves::BLIZZARD],[66,PBMoves::WILDCHARGE],[70,PBMoves::SHELLSMASH]],
		:Weight => 760,
		:Height => 16,
		:kind => "Cloud Lord"
	}
},

PBSpecies::INCINEROAR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,115,115,90,80,115],
		:Ability => PBAbilities::SHEERFORCE,
		:Weight => 500
	}
},

PBSpecies::ALAKAZAM => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [55,50,65,150,175,105],
		:Ability => PBAbilities::TRACE,
		:Weight => 480
	}
},

PBSpecies::GENGAR => {
	:FormName => {
		1 => "Mega" ,
		2 => "Dyna"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::GENGARITE => 1,
		PBItems::GENGARITEG => 2
	},

	"Mega" => {
		:BaseStats => [60,65,80,130,170,95],
		:Ability => PBAbilities::SHADOWTAG,
		:Weight => 405
	},

	"Dyna" => {
		:BaseStats => [90,65,80,110,145,110],
		:Ability => PBAbilities::INFILTRATOR,
		:Weight => 405
	}
},

PBSpecies::KANGASKHAN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,125,100,100,60,100],
		:Ability => PBAbilities::PARENTALBOND,
		:Weight => 1000
	}
},

PBSpecies::PINSIR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,155,120,105,65,90],
		:Ability => PBAbilities::AERILATE,
		:Weight => 590,
		:Type2 => PBTypes::FLYING
	}
},

PBSpecies::GYARADOS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke",
		4 => "Yoshitsune-Mega"
	},

	:DefaultForm => {
		PBItems::GYARADOSITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GYARADOSITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Mega" => {
		:BaseStats => [95,155,109,81,70,130],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 3050,
		:Type2 => PBTypes::DARK
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [95,155,109,81,70,130],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 3050
	},
	
	"Yoshitsune-Mega" => {
		:BaseStats => [95,139,79,67,130,100],
		:Ability => PBAbilities::HYDRABOND,
		:Weight => 3050,
		:Type2 => PBTypes::FIRE
	}
},

PBSpecies::AERODACTYL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,135,85,150,70,95],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Weight => 1270
	}
},

PBSpecies::MEWTWO => {
	:FormName => {
		1 => "Mega X",
		2 => "Mega Y"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::MEWTWONITEX => 1,
		PBItems::MEWTWONITEY => 2
	},

	"Mega X" => {
		:BaseStats => [106,190,100,130,154,100],
		:Ability => PBAbilities::STEADFAST,
		:Weight => 1105,
		:Type2 => PBTypes::FIGHTING
	},

	"Mega Y" => {
		:BaseStats => [106,150,70,140,194,120],
		:Ability => PBAbilities::INSOMNIA,
		:Weight => 330
	}
},

PBSpecies::AMPHAROS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::AMPHAROSITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::AMPHAROSITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [90,95,105,45,165,110],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 615
	},

	"Mega" => {
		:BaseStats => [90,95,105,45,165,110],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 615,
		:Type2 => PBTypes::DRAGON
	}
},

PBSpecies::SCIZOR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,150,140,75,65,100],
		:Ability => PBAbilities::TECHNICIAN,
		:Weight => 1250
	}
},

PBSpecies::HERACROSS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,185,115,75,40,105],
		:Ability => PBAbilities::SKILLLINK,
		:Weight => 625
	}
},

PBSpecies::HOUNDOOM => {
	:FormName => {
			1 => "Mega",
			2 => "Nuclear",
			3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::HOUNDOOMINITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::HOUNDOOMINITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [75,90,90,115,140,90],
		:Ability => PBAbilities::SOLARPOWER,
		:Weight => 495
	},

	"Mega" => {
		:BaseStats => [75,90,90,115,140,90],
		:Ability => PBAbilities::SOLARPOWER,
		:Weight => 495
	}
},

PBSpecies::TYRANITAR => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::TYRANITARITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::TYRANITARITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [100,164,150,71,95,120],
		:Ability => PBAbilities::SANDSTREAM,
		:Weight => 2550
	},

	"Mega" => {
		:BaseStats => [100,164,150,71,95,120],
		:Ability => PBAbilities::SANDSTREAM,
		:Weight => 2550
	}
},

PBSpecies::BLAZIKEN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,160,80,100,130,80],
		:Ability => PBAbilities::SPEEDBOOST,
		:Weight => 520
	}
},

PBSpecies::GARDEVOIR => {
	:FormName => {
		1 => "Mega",
		2 => "Void"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::GARDEVOIRITE => 1,
		PBItems::VOIDSTONE => 2
	},

	"Mega" => {
		:BaseStats => [68,85,65,100,165,135],
		:Ability => PBAbilities::PIXILATE,
		:Weight => 484
	},

	"Void" => {
		:BaseStats => [68,110,80,110,175,145],
		:Ability => PBAbilities::DUSKILATE,
		:Weight => 484,
		:Type1 => PBTypes::DARK
	}
},

PBSpecies::MAWILE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [50,105,125,50,55,95],
		:Ability => PBAbilities::HUGEPOWER,
		:Weight => 235
	}
},

PBSpecies::AGGRON => {
	:FormName => {
			1 => "Mega",
			2 => "Nuclear",
			3 => "MegaNuke",
			4 => "TOTEM"
	},

	:DefaultForm => {
		PBItems::AGGRONITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::AGGRONITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [70,140,230,50,60,80],
		:Ability => PBAbilities::FILTER,
		:Weight => 3950
	},

	"Mega" => {
		:BaseStats => [70,140,230,50,60,80],
		:Ability => PBAbilities::FILTER,
		:Weight => 3950,
		:Type2 => PBTypes::STEEL
	},

	"TOTEM" => {
		:BaseStats => [70,110,180,50,60,60],
		:Ability => [PBAbilities::FILTER]
	},
},

PBSpecies::MEDICHAM => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [60,100,85,100,80,85],
		:Ability => PBAbilities::PUREPOWER,
		:Weight => 315
	}
},

PBSpecies::MANECTRIC => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,75,80,135,135,80],
		:Ability => PBAbilities::INTIMIDATE,
		:Weight => 440
	}
},

PBSpecies::BANETTE => {
	:FormName => {
		1 => "Mega X",
		2 => "Mega Y"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::BANETTITEX => 1,
		PBItems::BANETTITEY => 2
	},

	"Mega X" => {
		:BaseStats => [64,165,75,75,93,83],
		:Ability => PBAbilities::PRANKSTER,
		:Weight => 130
	},

	"Mega Y" => {
		:BaseStats => [64,130,75,110,83,83],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Weight => 130
	}
},

PBSpecies::ABSOL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,150,60,115,115,60],
		:Ability => PBAbilities::MAGICBOUNCE,
		:Weight => 490
	}
},

PBSpecies::GARCHOMP => {
	:FormName => {
		1 => "Mega",
		2 => "PULSE"
	},

	:DefaultForm => 0,
	:MegaForm => 1,
	:PulseForm => 2,

	"Mega" => {
		:BaseStats => [108,170,115,92,120,95],
		:Ability => PBAbilities::SANDFORCE,
		:Weight => 950
	},

	"PULSE" => {
		:BaseStats => [120,170,120,20,120,120],
		:Ability => PBAbilities::HUGEPOWER,
		:Weight => 1950
	}
},

PBSpecies::LUCARIO => { #PORTED
	:FormName => {
		1 => "Rebornian",
		2 => "Mega",
		3 => "Mega Rebornian",
		4 => "Rebornian Ametrine"
	},

	:DefaultForm => {
		PBItems::LUCARIONITE => 0,
		PBItems::LUCARIONITER => 1
	},
	:MegaForm => {
		PBItems::LUCARIONITE => 2,
		PBItems::LUCARIONITER => 3
	},

	"Mega" => {
		:BaseStats => [70,145,88,112,140,70],
		:Ability => PBAbilities::ADAPTABILITY,
		:Weight => 575
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [90,110,90,100,75,60],
		:Ability => [PBAbilities::BATTLEARMOR,PBAbilities::MOXIE,PBAbilities::INNERFOCUS],
		:Movelist => [[1,PBMoves::COPYCAT],[1,PBMoves::DETECT],[1,PBMoves::FEINT],[1,PBMoves::FINALGAMBIT],[1,PBMoves::FORCEPALM],[1,PBMoves::HELPINGHAND],[1,PBMoves::LIFEDEW],[1,PBMoves::METALCLAW],[1,PBMoves::NASTYPLOT],[1,PBMoves::NASTYPLOT],[1,PBMoves::QUICKATTACK],[1,PBMoves::REVERSAL],[1,PBMoves::ROCKSMASH],[1,PBMoves::SCREECH],[1,PBMoves::WORKUP],[12,PBMoves::COUNTER],[16,PBMoves::LASERFOCUS],[20,PBMoves::POWERUPPUNCH],[24,PBMoves::BULKUP],[28,PBMoves::BONEMERANG],[32,PBMoves::QUICKGUARD],[36,PBMoves::BONERUSH],[40,PBMoves::SWORDSDANCE],[44,PBMoves::SHADOWBONE],[48,PBMoves::STOMPINGTANTRUM],[52,PBMoves::DRAINPUNCH],[56,PBMoves::DRILLRUN],[60,PBMoves::CLOSECOMBAT]],
	},

	"Mega Rebornian" => {
		:Type2 => PBTypes::GROUND,
		:BaseStats => [96,131,93,112,121,67],
		:Ability => PBAbilities::ADAPTABILITY,
		:Weight => 575
	},

	"Rebornian Ametrine" => {
		:DexEntry => "This variant of lucario was first discovered when sightings of a lucario was found on ametrine mountain, and a riolu egg was left in an icy cavern. When the riolu hatched, they had no choice but to adapt to the frigid conditions, growing thicker fur and a sharp tail that it uses to hunt for prey or to attack.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [80,80,95,60,130,95],
		:Ability => [PBAbilities::SLUSHRUSH,PBAbilities::FURCOAT,PBAbilities::STEADFAST],
		:Movelist => [[0,PBMoves::ROAR],[0,PBMoves::AURASPHERE],[1,PBMoves::LIFEDEW],[1,PBMoves::LASERFOCUS],[1,PBMoves::FORESIGHT],[1,PBMoves::QUICKATTACK],[1,PBMoves::DETECT],[1,PBMoves::METALCLAW],[6,PBMoves::COUNTER],[11,PBMoves::FEINT],[15,PBMoves::HYPERVOICE],[15,PBMoves::POWERUPPUNCH],[19,PBMoves::SWORDSDANCE],[24,PBMoves::METALSOUND],[29,PBMoves::BONERUSH],[33,PBMoves::QUICKGUARD],[37,PBMoves::ICEBEAM],[37,PBMoves::THUNDERBOLT],[37,PBMoves::MEFIRST],[42,PBMoves::EARTHPOWER],[42,PBMoves::WORKUP],[47,PBMoves::POWERGEM],[47,PBMoves::CALMMIND],[51,PBMoves::HEALPULSE],[55,PBMoves::CLOSECOMBAT],[60,PBMoves::HYDROPUMP],[60,PBMoves::DRAGONPULSE],[60,PBMoves::BLIZZARD],[65,PBMoves::EXTREMESPEED]],
	}
},

PBSpecies::ABOMASNOW => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [90,132,105,30,132,105],
		:Ability => PBAbilities::SNOWWARNING,
		:Weight => 1850
	}
},

PBSpecies::BEEDRILL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,150,40,145,15,80],
		:Ability => PBAbilities::ADAPTABILITY,
		:Height => 14,
		:Weight => 405
	}
},

PBSpecies::PIDGEOT => {
	:FormName => {
		1 => "Mega",
		2 => "Totem Mega"
	},

	:DefaultForm => 0,
 	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [83,80,80,121,135,80],
		:Ability => PBAbilities::NOGUARD,
		:Height => 22,
		:Weight => 505
	},

	"Totem Mega" => {
		:BaseStats => [83,80,80,121,135,80],
		:Ability => PBAbilities::NOGUARD,
		:Height => 22,
		:Weight => 505
	}
},

PBSpecies::TREVENANT => {
	:FormName => {1 => "Totem"},

	"Totem" => {
		:BaseStats => [85,110,76,56,65,82],
		:Ability => PBAbilities::HUGEPOWER,
		:Weight => 130
	}
},

PBSpecies::SLOWBRO => {
	:FormName => {
		1 => "Mega",
		2 => "Galarian"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,75,180,30,130,80],
		:Ability => PBAbilities::SHELLARMOR,
		:Height => 20,
		:Weight => 1200
	},

	"Galarian" => {
		:Type1 => PBTypes::POISON,
		:Ability => [PBAbilities::QUICKDRAW,PBAbilities::OWNTEMPO,PBAbilities::REGENERATOR],
		:Movelist => [[0,PBMoves::SHELLSIDEARM],[1,PBMoves::WITHDRAW],[1,PBMoves::SHELLSIDEARM],
			[1,PBMoves::TACKLE],[1,PBMoves::CURSE],[3,PBMoves::GROWL],[6,PBMoves::ACID],[9,PBMoves::YAWN],
			[12,PBMoves::CONFUSION],[15,PBMoves::DISABLE],[18,PBMoves::WATERPULSE],[21,PBMoves::HEADBUTT],
			[24,PBMoves::ZENHEADBUTT],[27,PBMoves::SLACKOFF],[30,PBMoves::RAINDANCE],[33,PBMoves::SURF],
			[36,PBMoves::PSYCHUP],[39,PBMoves::HEALPULSE],[42,PBMoves::AMNESIA],[45,PBMoves::PSYCHIC]]
	}
},

PBSpecies::STEELIX => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke",
		4 => "Gargantuan"
	},

	:DefaultForm => {
		PBItems::STEELIXITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::STEELIXITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Mega" => {
		:BaseStats => [75,125,230,30,55,95],
		:Ability => PBAbilities::SANDFORCE,
		:Height => 105,
		:Weight => 7400
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [75,125,230,30,55,95],
		:Ability => PBAbilities::SANDFORCE,
		:Height => 105,
		:Weight => 7400
	},

	"Gargantuan" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SWAMPERT => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [100,150,110,70,85,110],
		:Ability => PBAbilities::SWIFTSWIM,
		:Height => 19,
		:Weight => 1020
	}
},

PBSpecies::TREECKO => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		mapStarterHall=[39]
		mapChrysoliaForest=[465]
		# Map IDs for Rebornian form
		randomnum = rand(4)
		if $game_map && ((mapStarterHall.include?($game_map.map_id) && randomnum==0) || mapChrysoliaForest.include?($game_map.map_id))
			next 1
		else
			next 0
		end
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [40,65,55,70,45,35],
		:Ability => [PBAbilities::OVERGROW,PBAbilities::UNBURDEN],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::SUPERSONIC],[1,PBMoves::SWIFT],[5,PBMoves::SUPERSONIC],[8,PBMoves::SWIFT],[12,PBMoves::LIGHTSCREEN],[12,PBMoves::REFLECT],[12,PBMoves::SAFEGUARD],[15,PBMoves::MACHPUNCH],[20,PBMoves::SILVERWIND],[24,PBMoves::COMETPUNCH],[29,PBMoves::BATONPASS],[33,PBMoves::AGILITY],[35,PBMoves::XSCISSOR],[38,PBMoves::BUGBUZZ],[42,PBMoves::AIRSLASH],[47,PBMoves::DOUBLEEDGE]],
		:Weight => 450
	}
},

PBSpecies::GROVYLE => {
	:FormName => {1 => "Rebornian"}, 

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::GRASS,
		:BaseStats => [50,85,65,95,65,45],
		:Ability => [PBAbilities::OVERGROW,PBAbilities::UNBURDEN],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::SUPERSONIC],[1,PBMoves::SWIFT],[5,PBMoves::SUPERSONIC],[8,PBMoves::SWIFT],[12,PBMoves::LIGHTSCREEN],[12,PBMoves::REFLECT],[12,PBMoves::SAFEGUARD],[15,PBMoves::MACHPUNCH],[20,PBMoves::SILVERWIND],[24,PBMoves::COMETPUNCH],[29,PBMoves::BATONPASS],[33,PBMoves::AGILITY],[35,PBMoves::XSCISSOR],[38,PBMoves::BUGBUZZ],[42,PBMoves::AIRSLASH],[47,PBMoves::DOUBLEEDGE]],
		:Weight => 450
	}
},

PBSpecies::SCEPTILE => {
	:FormName => {
		1 => "Rebornian",
		2 => "Mega",
		3 => "Mega Rebornian"
	},

	:DefaultForm => {
		PBItems::SCEPTILITE => 0,
		PBItems::SCEPTILITER => 1
	},
	:MegaForm => {
		PBItems::SCEPTILITE => 2,
		PBItems::SCEPTILITER => 3
	},

	"Rebornian" => {
		:BaseStats => [70,105,85,120,85,65],
		:Ability => [PBAbilities::OVERGROW,PBAbilities::SHARPNESS],
		:Height => 17,
		:Weight => 1020,
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::GRASS,
		:Movelist => [[1, PBMoves::SCRATCH],[3, PBMoves::GROWL],[6, PBMoves::ASTONISH],[9, PBMoves::INGRAIN],[12, PBMoves::MAGICALLEAF],[15, PBMoves::SHADOWSNEAK],[15, PBMoves::AERIALACE],[18, PBMoves::LEECHSEED],[21, PBMoves::FURYSWIPES],[24, PBMoves::OMINOUSWIND],[27, PBMoves::MEGADRAIN],[30, PBMoves::SHADOWPUNCH],[33, PBMoves::SUCKERPUNCH],[36, PBMoves::LEAFBLADE],[39, PBMoves::SHADOWBALL],[42, PBMoves::SYNTHESIS],[45, PBMoves::SHADOWCLAW],[48, PBMoves::WOODHAMMER],[51, PBMoves::ENERGYBALL],[54, PBMoves::LEAFSTORM],[54, PBMoves::SACREDSWORD],[54, PBMoves::SOLARBLADE],[57, PBMoves::PHANTOMFORCE]],
	},

	"Mega" => {
		:BaseStats => [70,110,75,145,145,85],
		:Ability => PBAbilities::LIGHTNINGROD,
		:Height => 19,
		:Weight => 1020,
		:Type2 => PBTypes::DRAGON
	},

	"Mega Rebornian" => {
		:BaseStats => [70,145,85,145,110,75],
		:Ability => PBAbilities::DRAGONSWORD,
		:Height => 19,
		:Weight => 1020,
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::DRAGON
	},
},

PBSpecies::SABLEYE => {
	:FormName => {
		1 => "Mega",
		2 => "Rebornian",
		3 => "Also Rebornian",
	},

	:OnCreation => proc{
		chancemaps=[507] # Map IDs for Rebornian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [50,85,125,20,85,115],
		:Ability => PBAbilities::MAGICBOUNCE,
		:Height => 5,
		:Weight => 1610
	},

	"Rebornian" => {
		:DexEntry => "According to an old children's book, there was once a Sableye that used to hate taking showers. So, in order to deceive its trainer and escape shower, it entered a Substitute plush to disguise. No one knows where this Sableye form came from, so everybody takes this story for granted.",
		:BaseStats => [110,90,65,30,30,65],
		:Ability => [PBAbilities::KEENEYE,PBAbilities::PRANKSTER,PBAbilities::DISGUISE],
		:Height => 17,
		:Weight => 1020,
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::NORMAL,
		:Movelist => [[1, PBMoves::LEER],[3, PBMoves::QUICKATTACK],[4, PBMoves::BABYDOLLEYES],[6, PBMoves::SHADOWSNEAK],[9, PBMoves::FAKEOUT],[11, PBMoves::NIGHTSHADE],[11, PBMoves::FEINTATTACK],[14, PBMoves::FAKETEARS],[16, PBMoves::SNARL],[19, PBMoves::SWIFT],[21, PBMoves::GLARE],[24, PBMoves::SHADOWPUNCH],[24, PBMoves::MACHPUNCH],[26, PBMoves::KNOCKOFF],[29, PBMoves::SUBSTITUTE],[31, PBMoves::CHIPAWAY],[34, PBMoves::SUCKERPUNCH],[36, PBMoves::DAZZLINGGLEAM],[39, PBMoves::FOULPLAY],[42, PBMoves::POWERGEM],[45, PBMoves::BATONPASS],[47, PBMoves::THRASH],[51, PBMoves::RECOVER],[60, PBMoves::NASTYPLOT],[68, PBMoves::PRISMATICLASER]]
	},

	"Also Rebornian" => {
		:BaseStats => [110,90,65,30,30,65],
		:Ability => [PBAbilities::DISGUISE],
		:Height => 17,
		:Weight => 1020,
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::NORMAL
	}
},

PBSpecies::SHARPEDO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,140,70,105,110,65],
		:Ability => PBAbilities::STRONGJAW,
		:Height => 25,
		:Weight => 1303
	}
},

PBSpecies::CAMERUPT => {
	:FormName => {
		1 => "Mega",
		2 => "PULSE"
	},

	:DefaultForm => 0,
	:MegaForm => 1,
	:PulseForm => 2,

	"Mega" => {
		:BaseStats => [70,120,100,20,145,105],
		:Ability => PBAbilities::SHEERFORCE,
		:Height => 25,
		:Weight => 3205
	},

	"PULSE" => {
		:BaseStats => [1,10,10,10,170,10],
		:Ability => PBAbilities::STURDY,
		:Weight => 2707,
		:Type2 => PBTypes::GHOST
	}
},

PBSpecies::ALTARIA => {
	:FormName => {
		1 => "Mega",
		2 => "Egho"
	},

	:OnCreation => proc{
		chancemaps=[697,700,710,711,713,714,715,716,797,804,808]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,110,110,80,110,105],
		:Ability => PBAbilities::PIXILATE,
		:Height => 15,
		:Weight => 2060,
		:Type2 => PBTypes::FAIRY
	},

	"Egho" => {
		:DexEntry => "Altaria's body is so cold that it sometimes freezes the moisture in the air around it into crystals. If you hear an Altaria's song, you can be sure a hail storm is coming.",
		:Type2 => PBTypes::ICE,
		:BaseStats => [80,60,90,105,95,60],
		:EVs => [0,0,0,2,0,0],
		:Ability => [PBAbilities::LEVITATE,PBAbilities::CONTRARY],
		:Movelist => [[0,PBMoves::DEFOG],[1,PBMoves::PLUCK],[1,PBMoves::DRAGONDANCE],
			[1,PBMoves::PECK],[1,PBMoves::GROWL],[4,PBMoves::POWDERSNOW],
			[8,PBMoves::SING],[10,PBMoves::HAZE],[11,PBMoves::RAZORWIND],
			[13,PBMoves::GUST],[15,PBMoves::WEATHERBALL],[17,PBMoves::FROSTBREATH],
			[18,PBMoves::ENTRAINMENT],[21,PBMoves::ROUND],[25,PBMoves::UPROAR],
			[25,PBMoves::HAIL],[29,PBMoves::REFRESH],[34,PBMoves::PERISHSONG],
			[37,PBMoves::DRAGONBREATH],[42,PBMoves::COTTONGUARD],[47,PBMoves::DRAGONPULSE],
			[49,PBMoves::ICEBEAM],[50,PBMoves::ROOST],[56,PBMoves::FREEZEDRY],
			[60,PBMoves::HYPERVOICE],[64,PBMoves::BLIZZARD]],
		:Weight => 240,
		:Height => 10,
		:kind => "Dry-Ice Dragon"
	}
},

PBSpecies::GLALIE => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke",
		4 => "Rebornian"
	},

	:DefaultForm => {
		PBItems::GLALITITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GLALITITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [80,120,80,100,120,80],
		:Ability => PBAbilities::REFRIGERATE,
		:Height => 21,
		:Weight => 3502
	},

	"Mega" => {
		:BaseStats => [80,120,80,100,120,80],
		:Ability => PBAbilities::REFRIGERATE,
		:Height => 21,
		:Weight => 3502
	},

	"Rebornian" => {
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [80,110,95,75,55,80],
		:Ability => [PBAbilities::STRONGJAW,PBAbilities::CLEARBODY,PBAbilities::SHEERFORCE],
		:Movelist => [[1,PBMoves::IRONHEAD],[1,PBMoves::SCALESHOT],[1,PBMoves::IRONTAIL],[1,PBMoves::BITE],[1,PBMoves::CRUNCH],[42,PBMoves::FIREFANG],[42,PBMoves::ICEFANG],[42,PBMoves::THUNDERFANG],[45,PBMoves::CHAINCHOMP],[47,PBMoves::PSYCHICFANGS],[49,PBMoves::JAWLOCK],[52,PBMoves::DRAGONRUSH],[55,PBMoves::OUTRAGE],[70,PBMoves::GIGAIMPACT]],
		:Height => 15,
		:Weight => 360
	}
},

PBSpecies::SALAMENCE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,145,130,120,120,90],
		:Ability => PBAbilities::AERILATE,
		:Height => 18,
		:Weight => 1125
	}
},

PBSpecies::METAGROSS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,145,150,110,105,110],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Height => 25,
		:Weight => 9429
	}
},

PBSpecies::LATIAS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,100,120,110,140,150],
		:Height => 18,
		:Weight => 520
	}
},

PBSpecies::LATIOS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,130,100,110,160,120],
		:Height => 23,
		:Weight => 700
	}
},

PBSpecies::RAYQUAZA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,180,100,115,180,100],
		:Ability => PBAbilities::DELTASTREAM,
		:Height => 108,
		:Weight => 3920
	}
},

PBSpecies::ETERNATUS => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [255,115,250,130,125,250],
		:Ability => PBAbilities::PRESSURE,
		:Height => 1080,
		:Weight => 20920
	}
},

PBSpecies::ZACIAN => {
	:FormName => {
		0 => "Uncrowned",
		1 => "King",
		2 => "Mega"
	},
	
	
    :DefaultForm => 1,
	:MegaForm => 2,

	"King" => {
		:DexEntry => "Able to cut down anything with a single strike, it became known as the Fairy King's Sword, and it inspired awe in friend and foe alike.",
		:BaseStats => [92,170,115,148,80,115],
		:Type2 => PBTypes::STEEL,
		:Weight => 3550
	},
	
	"Mega" => {
		:DexEntry => "Able to cut down anything with a single strike, it became known as the Fairy King's Sword, and it inspired awe in friend and foe alike.",
		:BaseStats => [92,170,145,148,80,145],
		:Type2 => PBTypes::STEEL,
		:Weight => 3550
	}
},

PBSpecies::ZAMAZENTA => {
	:FormName => {
		0 => "Uncrowned",
		1 => "King",
		2 => "Mega"
	},
	
	:DefaultForm => 1,
	:MegaForm => 2,


	"King" => {
		:DexEntry => "Its ability to deflect any attack led to it being known as the Fighting Master's Shield. It was feared and respected by all.",
		:BaseStats => [92,130,145,128,80,145],
		:Type2 => PBTypes::STEEL,
		:Weight => 7850
	},
	
	"Mega" => {
		:DexEntry => "Its ability to deflect any attack led to it being known as the Fighting Master's Shield. It was feared and respected by all.",
		:BaseStats => [92,170,145,148,80,145],
		:Type2 => PBTypes::STEEL,
		:Weight => 7850
	}
},

PBSpecies::LOPUNNY => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,136,94,135,54,96],
		:Ability => PBAbilities::SCRAPPY,
		:Height => 13,
		:Weight => 283,
		:Type2 => PBTypes::FIGHTING
	}
},

PBSpecies::GALLADE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [68,165,95,110,65,115],
		:Ability => [PBAbilities::INNERFOCUS,PBAbilities::SHARPNESS],
		:Height => 16,
		:Weight => 564
	}
},

PBSpecies::AUDINO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [103,60,126,50,80,126],
		:Ability => PBAbilities::HEALER,
		:Height => 16,
		:Weight => 564,
		:Type2 => PBTypes::FAIRY
	}
},

PBSpecies::DIANCIE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [50,160,110,110,160,110],
		:Height => 11,
		:Weight => 278
	}
},

PBSpecies::METALYNX => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,140,160,75,70,100],
		:Ability => PBAbilities::HEATPROOF
	}
},

PBSpecies::ARCHILLES => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,125,80,155,125,80],
		:Ability => PBAbilities::DROUGHT
	}
},

PBSpecies::ELECTRUXO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,80,105,110,125,135],
		:Ability => PBAbilities::DRIZZLE
	}
},

PBSpecies::EKANS => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ARBOK => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::ARBOKITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::ARBOKITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [60,130,100,90,65,95],
		:Ability => PBAbilities::PETRIFY
	},

	"Mega" => {
		:BaseStats => [60,130,100,90,65,95],
		:Type2 => PBTypes::DARK,
		:Ability => PBAbilities::PETRIFY
	}
},

PBSpecies::BAARIETTE => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::BAARITITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::BAARITITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [100,160,107,100,75,103],
		:Ability => PBAbilities::BLOODLUST
	},

	"Mega" => {
		:BaseStats => [100,160,107,100,75,103],
		:Ability => PBAbilities::BLOODLUST
	}
},

PBSpecies::DRILGANN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,180,88,84,60,88],
		:Ability => [PBAbilities::SANDRUSH,PBAbilities::SANDFORCE]
	}
},

PBSpecies::S51A => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
 	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,95,90,110,150,90],
		:Ability => PBAbilities::MEGALAUNCHER
	}
},

PBSpecies::INFLAGETAH => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::INFLAGETITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::INFLAGETITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [85,145,80,175,85,85],
		:Ability => PBAbilities::ACCELERATION
	},

	"Mega" => {
		:BaseStats => [85,145,80,175,85,85],
		:Ability => PBAbilities::ACCELERATION
	}
},

PBSpecies::SYRENTIDE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [98,68,128,88,118,158],
		:Ability => PBAbilities::PIXILATE
	}
},

PBSpecies::GARGRYPH => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
 	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::PSYCHIC,
		:BaseStats => [70,105,70,150,130,115],
		:Ability => PBAbilities::WONDERSKIN
	}
},

PBSpecies::DRAMSAMA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,85,80,120,145,85],
		:Ability => PBAbilities::BADDREAMS
	}
},

PBSpecies::KIRICORN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,123,72,128,127,80],
		:Ability => PBAbilities::MAGICBOUNCE
	}
},

PBSpecies::WHIMSICOTT => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [60,67,105,136,117,95],
		:Ability => [PBAbilities::REGENERATOR,PBAbilities::PRANKSTER]
	}
},

PBSpecies::NUCLEON => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,75,70,90,150,140],
		:Ability => PBAbilities::ATOMIZATE
	}
},

###################### Gigantamax ##########################

PBSpecies::BUTTERFREE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [60,30,60,125,140,80],
		:Ability => PBAbilities::TINTEDLENS
	}
},

PBSpecies::MACHAMP => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [105,170,100,75,50,105],
		:Ability => PBAbilities::NOGUARD
	}
},

PBSpecies::KINGLER => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [75,150,130,100,50,70],
		:Ability => PBAbilities::TOUGHCLAWS
	}
},

PBSpecies::MUNCHLAX => {
	:FormName => {2 => "Rebornian"},

	:OnCreation => proc{
		mapDesert=[694,703,704,705] # Map IDs for Rebornian form
		next $game_map && mapDesert.include?($game_map.map_id) ? 2 : 0
	},

	"Rebornian" => {
		:BaseStats => [135,40,85,5,85,40],
		:Ability => [PBAbilities::PICKUP,PBAbilities::THICKFAT,PBAbilities::GLUTTONY],
		:Movelist => [[1,PBMoves::LASTRESORT],[1,PBMoves::RECYCLE],[1,PBMoves::LICK],[1,PBMoves::METRONOME],[1,PBMoves::ODORSLEUTH],[1,PBMoves::TACKLE],[4,PBMoves::DEFENSECURL],[9,PBMoves::AMNESIA],[12,PBMoves::LICK],[17,PBMoves::CHIPAWAY],[20,PBMoves::SCREECH],[25,PBMoves::BODYSLAM],[28,PBMoves::STOCKPILE],[33,PBMoves::SWALLOW],[36,PBMoves::ROLLOUT],[41,PBMoves::FLING],[44,PBMoves::BELLYDRUM],[49,PBMoves::NATURALGIFT],[50,PBMoves::SNATCH],[57,PBMoves::LASTRESORT]]
	}
},

PBSpecies::SNORLAX => {
	:FormName => {
		1 => "Dyna",
		2 => "Rebornian"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [160,140,95,20,75,150],
		:Ability => PBAbilities::THICKFAT
	},

	"Rebornian" => {
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [168,42,105,68,70,87],
		:Ability => [PBAbilities::IMMUNITY,PBAbilities::THICKFAT,PBAbilities::GLUTTONY],
		:Movelist => [[1,PBMoves::TACKLE],[4,PBMoves::DEFENSECURL],[9,PBMoves::AMNESIA],[12,PBMoves::LICK],[17,PBMoves::CHIPAWAY],[20,PBMoves::YAWN],[25,PBMoves::BODYSLAM],[28,PBMoves::REST],[28,PBMoves::SNORE],[33,PBMoves::SLEEPTALK],[35,PBMoves::GIGAIMPACT],[36,PBMoves::ROLLOUT],[41,PBMoves::BLOCK],[44,PBMoves::BELLYDRUM],[49,PBMoves::CRUNCH],[50,PBMoves::HEAVYSLAM],[57,PBMoves::EARTHPOWER]]
	}
},

PBSpecies::LAPRAS => {
	:FormName => {
		1 => "Dyna",
		2 => "Rebornian",
		3 => "Dyna Rebornian"
	},

	:OnCreation => proc{
		mapNewLapras=[586] # Map IDs for Rebornian form
		next $game_map && mapNewLapras.include?($game_map.map_id) ? 2 : 0
	},

	:DefaultForm => 0, #Not really
	:MegaForm => proc{|pokemon|
		next [1,3] if pokemon == "getAll"
		next pokemon.form == 2 ? 3 : 1
	},

	"Dyna" => {
		:BaseStats => [150,115,105,75,90,100],
		:Ability => PBAbilities::REFRIGERATE
	},

	"Rebornian" => {
		:DexEntry => "This species of lapras were first discovered near frozen polluted rivers making them adapt their body to survive the low temperatures and the polluted habitat. Its spikes contain a deadly poison capable of killing its prey in a minute. The stripes on their skin are caused due to them unconciously perfurating themselves but due to their poisonous resistancy it leaves those stripes as scars.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::POISON,
		:BaseStats => [120,75,70,110,105,80],
		:Ability => [PBAbilities::REFRIGERATE,PBAbilities::REGENERATOR,PBAbilities::SNOWWARNING],
		:Movelist => [[1,PBMoves::SING],[1,PBMoves::CALMMIND],[1,PBMoves::ICYWIND],[1,PBMoves::GROWL],[1,PBMoves::WATERGUN],[4,PBMoves::MIST],[7,PBMoves::CONFUSERAY],[10,PBMoves::ICESHARD],[14,PBMoves::ACIDARMOR],[14,PBMoves::WATERPULSE],[15,PBMoves::LIFEDEW],[18,PBMoves::BODYSLAM],[19,PBMoves::ACIDSPRAY],[20,PBMoves::AVALANCHE],[22,PBMoves::DISABLE],[27,PBMoves::THUNDERBOLT],[27,PBMoves::PERISHSONG],[32,PBMoves::REFLECT],[32,PBMoves::LIGHTSCREEN],[32,PBMoves::ICEBEAM],[34,PBMoves::FLASHCANNON],[35,PBMoves::SLUDGEBOMB],[37,PBMoves::BRINE],[43,PBMoves::MIRRORCOAT],[43,PBMoves::SAFEGUARD],[47,PBMoves::HYDROPUMP],[47,PBMoves::SHADOWBALL],[47,PBMoves::VENOSHOCK],[50,PBMoves::TOXICSPIKES],[50,PBMoves::THUNDERWAVE],[50,PBMoves::SIGNALBEAM],[60,PBMoves::POWERGEM],[70,PBMoves::DRAGONPULSE],[80,PBMoves::RECOVER],[80,PBMoves::SHEERCOLD]]
	},

	"Dyna Rebornian" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::POISON,
		:BaseStats => [140,105,95,125,110,85],
		:Ability => PBAbilities::REFRIGERATE
	}
},

PBSpecies::RILLABOOM => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [130,140,110,95,60,90],
		:Ability => PBAbilities::GRASSYSURGE
	}
},

PBSpecies::INTELEON => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [80,115,75,130,155,75],
		:Ability => PBAbilities::DRIZZLE
	}
},

PBSpecies::CINDERACE => {
    :FormName => {1 => "Dyna", 2 => "Giga"},
	:DefaultForm => 0,
	:MegaForm => 1,
	:UltraForm => 2,

	"Dyna" => {
		:BaseStats => [100,156,85,139,65,85],
		:Ability => PBAbilities::LIBERO
	},
	
	"Giga" => {
		:BaseStats => [180,116,75,119,75,65],
	}
	
},

PBSpecies::TERAPAGOS => {
	:FormName => {1 => "Terastal",
	              2 => "Stellar"
},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Terastal" => {
		:DexEntry => "The shell is made of crystallized Terastal energy. When struck by a move, this shell absorbs the move’s energy and transfers it to Terapagos.",
		:BaseStats => [95,95,110,85,105,110],
		:Ability => PBAbilities::TERASHELL
	},

	"Stellar" => {
		:DexEntry => "In this form, Terapagos resembles the world as the ancients saw it, and its Terastal energy is abnormally amplified.",
		:BaseStats => [160,105,110,85,130,110],
		:Type1 => PBTypes::STELLAR,
		:Type2 => PBTypes::STELLAR,
		:Ability => PBAbilities::TERAFORMZERO
	},
},


PBSpecies::PIKACHU => {
	:FormName => {
		2 => "Partner",
		3 => "Dyna",
		4 => "Rock Star",
		5 => "Pop Star",
		6 => "Libre",
		7 => "PhD",
		8 => "Belle",
		9 => "Super Libre"
	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Partner" => {
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::MOLDBREAKER],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],[1,PBMoves::PIKAPAPOW],
			[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],
			[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],[1,PBMoves::TAILSLAP],[1,PBMoves::METEORMASH],
			[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],
			[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::TACKLE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Dyna" => {
		:BaseStats => [85,80,50,100,115,100],
		:Ability => PBAbilities::SIMPLE
	},
	"Rock Star" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::GUTS],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],[1,PBMoves::PIKAPAPOW],
			[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],
			[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],[1,PBMoves::TAILSLAP],[1,PBMoves::METEORMASH],
			[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],
			[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Pop Star" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::TRIAGE],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],[1,PBMoves::PIKAPAPOW],
			[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],
			[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],[1,PBMoves::TAILSLAP],[1,PBMoves::METEORMASH],
			[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],
			[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Libre" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::MOXIE],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],[1,PBMoves::PIKAPAPOW],
			[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],
			[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],[1,PBMoves::TAILSLAP],[1,PBMoves::METEORMASH],
			[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],
			[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::TACKLE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"PhD" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::PSYCHIC,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::TECHNICIAN],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],[1,PBMoves::PIKAPAPOW],
			[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],
			[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],[1,PBMoves::TAILSLAP],[1,PBMoves::METEORMASH],
			[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],
			[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Belle" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::ICE,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::SERENEGRACE],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],[1,PBMoves::PIKAPAPOW],
			[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],
			[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],[1,PBMoves::TAILSLAP],[1,PBMoves::METEORMASH],
			[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],
			[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Super Libre" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::HUGEPOWER],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],[1,PBMoves::PIKAPAPOW],
			[1,PBMoves::EXTREMESPEED],[1,PBMoves::OUTRAGE],[1,PBMoves::SWEETSCENT],[1,PBMoves::ICICLECRASH],[1,PBMoves::ELECTRICTERRAIN],
			[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],[1,PBMoves::HEARTSTAMP],[1,PBMoves::TAILSLAP],[1,PBMoves::METEORMASH],
			[1,PBMoves::HAPPYHOUR],[1,PBMoves::HOLDHANDS],[1,PBMoves::POWDERSNOW],[1,PBMoves::LEER],[1,PBMoves::TACKLE],[1,PBMoves::SING],
			[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],
			[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],
			[50,PBMoves::LIGHTSCREEN],[100,PBMoves::COMBATTORQUE]],
		:GetEvo => []
	}
},

PBSpecies::PICHU => {
	:FormName => {1 => "Spiky-Eared"},

	"Spiky-Eared" => {
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::SEQUENCE,PBAbilities::MOODMAKER,PBAbilities::MOTORDRIVE],
		:Movelist => [[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::TAILWHIP],[3,PBMoves::PLAYNICE],
			[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::HELPINGHAND],[11,PBMoves::NUZZLE],[13,PBMoves::CHARGE],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::ENDURE],[21,PBMoves::SWIFT],[25,PBMoves::SWAGGER],[27,PBMoves::SPARK],[31,PBMoves::DIZZYPUNCH],
			[33,PBMoves::THUNDERBOLT],[35,PBMoves::AGILITY],[37,PBMoves::TEETERDANCE],[39,PBMoves::PAINSPLIT],[41,PBMoves::IRONTAIL],
			[43,PBMoves::ENDEAVOR],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::PETALDANCE],[55,PBMoves::VOLTTACKLE]],
		:GetEvo => []
	}
},

PBSpecies::EEVEE => {
	:FormName => {
		1 => "Dyna",
		2 => "Partner",
		3 => "Infinity"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [80,100,70,100,100,80],
		:Ability => PBAbilities::ADAPTABILITY
	},
	"Partner" => {
		:BaseStats => [65,75,70,75,65,85],
		:Ability => [PBAbilities::PROTEAN,PBAbilities::ADAPTABILITY,PBAbilities::ANTICIPATION,
			PBAbilities::TELEPATHY,PBAbilities::RUNAWAY],
		:Movelist => [[1,PBMoves::BUZZYBUZZ],[1,PBMoves::SIZZLYSLIDE],[1,PBMoves::BOUNCYBUBBLE],
			[1,PBMoves::BADDYBAD],[1,PBMoves::GLITZYGLOW],[1,PBMoves::SAPPYSEED],[1,PBMoves::FREEZYFROST],
			[1,PBMoves::SPARKLYSWIRL],[1,PBMoves::VEEVEEVOLLEY],[1,PBMoves::PUNCHPUMMEL],[1,PBMoves::TWIRLYTWISTER],[1,PBMoves::ROCKYRAMPAGE],
			[1,PBMoves::DUSTYDRIFT],[1,PBMoves::STEELYSTRIKE],[1,PBMoves::STABBYSWARM],[1,PBMoves::ICKYINJECTION],[1,PBMoves::SPOOKYSPELL],[1,PBMoves::SCALYSCORN],
			[1,PBMoves::HELPINGHAND],[1,PBMoves::GROWL],
			[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::SANDATTACK],[7,PBMoves::BABYDOLLEYES],
			[9,PBMoves::FOCUSENERGY],[11,PBMoves::COPYCAT],[13,PBMoves::MUDSLAP],[16,PBMoves::QUICKATTACK],
			[19,PBMoves::DOUBLEKICK],[21,PBMoves::BITE],[23,PBMoves::COVET],[25,PBMoves::REFRESH],
			[27,PBMoves::SWIFT],[29,PBMoves::MIMIC],[31,PBMoves::TRUMPCARD],[33,PBMoves::TAKEDOWN],
			[35,PBMoves::CHARM],[37,PBMoves::BATONPASS],[39,PBMoves::CALMMIND],[41,PBMoves::DOUBLEEDGE],
			[45,PBMoves::LASTRESORT]],
		:GetEvo => []
	},
	"Infinity" => {
		:GetEvo => [
			# 18 = DayHoldItem
			[PBSpecies::VAPOREON,18,PBItems::SPLASHPLATE],
			[PBSpecies::JOLTEON,18,PBItems::ZAPPLATE],
			[PBSpecies::FLAREON,18,PBItems::FLAMEPLATE],
			[PBSpecies::ESPEON,18,PBItems::MINDPLATE],
			[PBSpecies::UMBREON,18,PBItems::DREADPLATE],
			[PBSpecies::LEAFEON,18,PBItems::MEADOWPLATE],
			[PBSpecies::GLACEON,18,PBItems::ICICLEPLATE],
			[PBSpecies::SYLVEON,18,PBItems::PIXIEPLATE],
			[PBSpecies::NUCLEON,18,PBItems::ATOMICPLATE],
			[PBSpecies::OMEON,18,PBItems::SPOOKYPLATE],
			[PBSpecies::CHAMPEON,18,PBItems::FISTPLATE],
			[PBSpecies::LEPIDEON,18,PBItems::INSECTPLATE],
			[PBSpecies::GUARDEON,18,PBItems::IRONPLATE],
			[PBSpecies::OBSIDEON,18,PBItems::STONEPLATE],
			[PBSpecies::SCORPEON,18,PBItems::TOXICPLATE],
			[PBSpecies::SPHYNXEON,18,PBItems::EARTHPLATE],
			[PBSpecies::NIMBEON,18,PBItems::SKYPLATE],
			[PBSpecies::DRACONEON,18,PBItems::DRACOPLATE],
			# 19 = NightHoldItem
			[PBSpecies::VAPOREON,19,PBItems::SPLASHPLATE],
			[PBSpecies::JOLTEON,19,PBItems::ZAPPLATE],
			[PBSpecies::FLAREON,19,PBItems::FLAMEPLATE],
			[PBSpecies::ESPEON,19,PBItems::MINDPLATE],
			[PBSpecies::UMBREON,19,PBItems::DREADPLATE],
			[PBSpecies::LEAFEON,19,PBItems::MEADOWPLATE],
			[PBSpecies::GLACEON,19,PBItems::ICICLEPLATE],
			[PBSpecies::SYLVEON,19,PBItems::PIXIEPLATE],
			[PBSpecies::NUCLEON,19,PBItems::ATOMICPLATE],
			[PBSpecies::OMEON,19,PBItems::SPOOKYPLATE],
			[PBSpecies::CHAMPEON,19,PBItems::FISTPLATE],
			[PBSpecies::LEPIDEON,19,PBItems::INSECTPLATE],
			[PBSpecies::GUARDEON,19,PBItems::IRONPLATE],
			[PBSpecies::OBSIDEON,19,PBItems::STONEPLATE],
			[PBSpecies::SCORPEON,19,PBItems::TOXICPLATE],
			[PBSpecies::SPHYNXEON,19,PBItems::EARTHPLATE],
			[PBSpecies::NIMBEON,19,PBItems::SKYPLATE],
			[PBSpecies::DRACONEON,19,PBItems::DRACOPLATE],
			# 7 = Item
			[PBSpecies::EEVEEON,7,PBItems::ASTRALSTONE],
			[PBSpecies::VAREON,7,PBItems::VARIASTONE]
		],
	}
},

PBSpecies::MELMETAL => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [135,183,163,45,85,85],
		:Ability => PBAbilities::IRONFIST
	}
},

PBSpecies::CORVIKNIGHT => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [98,122,145,67,53,110],
		:Ability => PBAbilities::MIRRORARMOR
	}
},

PBSpecies::ORBEETLE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [60,75,130,105,95,140],
		:Ability => PBAbilities::PSYCHICSURGE
	}
},

PBSpecies::DREDNAW => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::DREDNAWTITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::DREDNAWTITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [90,155,110,94,48,88],
		:Ability => PBAbilities::STRONGJAW,
	},

	"Dyna" => {
		:BaseStats => [90,155,110,94,48,88],
		:Ability => PBAbilities::STRONGJAW
	}
},

PBSpecies::COALOSSAL => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::COALOSSITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::COALOSSITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [110,135,150,35,80,100],
		:Ability => PBAbilities::SOLIDROCK,
		:Weight => 6200
	},

	"Dyna" => {
		:BaseStats => [110,135,150,35,80,100],
		:Ability => PBAbilities::SOLIDROCK,
		:Weight => 6200
	}
},

PBSpecies::FLAPPLE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [70,130,105,90,110,80],
		:Ability => PBAbilities::OWNTEMPO
	}
},

PBSpecies::APPLETUN => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [110,95,110,20,140,110],
		:Ability => PBAbilities::THICKFAT
	}
},

PBSpecies::SANDACONDA => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::SANDACONDITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::SANDACONDITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [92,107,135,81,105,90],
		:Ability => PBAbilities::SANDRUSH,
	},

	"Dyna" => {
		:BaseStats => [72,127,125,91,105,90],
		:Ability => PBAbilities::SANDSTREAM
	}
},

PBSpecies::CENTISKORCH => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::CENTISKORCHITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::CENTISKORCHITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [110,135,85,115,90,90],
		:Ability => PBAbilities::FLASHFIRE,
	},

	"Dyna" => {
		:BaseStats => [110,135,85,115,90,90],
		:Ability => PBAbilities::FLASHFIRE,
	}
},

PBSpecies::GRIMMSNARL => {
	:FormName => {
			1 => "Dyna",
			2 => "Nuclear",
			3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::GRIMMSNARLITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GRIMMSNARLITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [115,140,95,80,75,105],
		:Ability => PBAbilities::PRANKSTER,
	},

	"Dyna" => {
		:BaseStats => [115,140,95,80,75,105],
		:Ability => PBAbilities::PRANKSTER
	}
},

PBSpecies::HATTERENE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [97,80,115,29,166,123],
		:Ability => PBAbilities::MAGICBOUNCE
	}
},

PBSpecies::ALCREMIE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [95,60,95,74,130,141],
		:Ability => PBAbilities::SWEETVEIL
	}
},

PBSpecies::COPPERAJAH => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::COPPERITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::COPPERITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [142,160,99,30,80,89],
		:Ability => PBAbilities::HEAVYMETAL,
		:Weight => 13000
	},

	"Dyna" => {
		:BaseStats => [142,160,99,30,80,89],
		:Ability => PBAbilities::HEAVYMETAL,
		:Weight => 13000
	}
},

PBSpecies::TOXTRICITY => {
	:FormName => {
		0 => "Amped",
		1 => "Low Key",
		2 => "Dyna"
	},
	:OnCreation => proc{rand(2)},

	:DefaultForm => 0, #Not really
	:MegaForm => 2,

	"Dyna" => {
		:BaseStats => [105,98,80,105,134,80],
		:Ability => PBAbilities::GALVANIZE
	},

	"Low Key" => {
		:DexEntry => "Many youths admire the way this Pokémon listlessly picks fights and keeps its cool no matter what opponent it faces.",
		:Ability => [PBAbilities::PUNKROCK,PBAbilities::MINUS,PBAbilities::TECHNICIAN]
	}
},

PBSpecies::DURALUDON => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [100,95,115,75,160,90],
		:Ability => PBAbilities::MAGICGUARD
	}
},

PBSpecies::URSHIFU => {
	:FormName => {
		1 => "Rapid Strike",
		2 => "Dyna X",
		3 => "Dyna Y"
	},

	:DefaultForm => {
		PBItems::URSHIFITEX => 0,
		PBItems::URSHIFITEY => 1
	},
	:MegaForm => {
		PBItems::URSHIFITEX => 2,
		PBItems::URSHIFITEY => 3
	},

	"Rapid Strike" => {
		:DexEntry => "It's believed that this Pokémon modeled its fighting style on the flow of a river—sometimes rapid, sometimes calm.",
		:Type2 => PBTypes::WATER
	},

	"Dyna X" => {
		:BaseStats => [120,165,120,107,63,75]
	},

	"Dyna Y" => {
		:Type2 => PBTypes::WATER,
		:BaseStats => [100,150,100,127,63,110]
	}
},

PBSpecies::URAYNE => {
	:FormName => {1 => "Gamma"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Gamma" => {
		:BaseStats => [125,140,110,130,155,105],
		:Ability => PBAbilities::CHERNOBYL
	}
},

###################### PULSE Forms ######################

PBSpecies::GARBODOR => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke",
		4 => "Egho"
	},

	:OnCreation => proc{
		chancemaps=[875,894]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
 	},

	:DefaultForm => {
		PBItems::GARBODORITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GARBODORITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Mega" => {
		:BaseStats => [80,135,107,85,60,107],
		:Ability => PBAbilities::GOOEY,
		:Height => 6033,
		:Weight => 2366
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [80,135,107,85,60,107],
		:Ability => PBAbilities::GOOEY,
		:Height => 6033,
		:Weight => 2366
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Egho" => {
		:DexEntry => "When Trubbish eat enough to get too big for their can, they will evolve into a Garbodor. They get larger with the more waste they stuff in their dumpster.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [80,50,97,75,90,82],
		:EVs => [0,0,2,0,0,0],
		:Ability => [PBAbilities::BATTLEARMOR,PBAbilities::FILTER],
		:Movelist => [[1,PBMoves::MUDSLAP],[1,PBMoves::SMOG],[1,PBMoves::TOXICSPIKES],
			[3,PBMoves::RECYCLE],[7,PBMoves::BULLETPUNCH],[12,PBMoves::ACIDSPRAY],
			[14,PBMoves::TOXIC],[18,PBMoves::SLUDGE],[23,PBMoves::STOCKPILE],
			[23,PBMoves::SWALLOW],[25,PBMoves::BODYSLAM],[29,PBMoves::SLUDGEBOMB],
			[34,PBMoves::HEAVYSLAM],[36,PBMoves::PROTECT],[42,PBMoves::IRONDEFENSE],
			[48,PBMoves::DARKPULSE],[51,PBMoves::FLASHCANNON],[55,PBMoves::BELCH],
			[59,PBMoves::EXPLOSION]],
		:Weight => 1773,
		:Height => 18,
		:kind => "Dumpster"
	}
},

PBSpecies::TANGROWTH => {
	:FormName => {
		1 => "PULSE C",
		2 => "PULSE B",
		3 => "PULSE A",
		4 => "Egho"
	},

	:OnCreation => proc{
		maps=[281]
		chancemaps=[825,840,894]
		if $game_map && maps.include?($game_map.map_id)
			next 4
		elsif $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:PulseForm => proc{|pokemon|
		v = 1
		for move in pokemon.moves
			if move.type == PBTypes::POISON
				break
			elsif move.type == PBTypes::GROUND
				v = 2; break
			elsif move.type == PBTypes::ROCK
				v = 3; break
			end
		end
		next v
	},

	"PULSE C" => {
		:BaseStats => [100,70,200,10,70,160],
		:Ability => PBAbilities::FILTER,
		:Weight => 2675,
		:Type2 => PBTypes::POISON
	},

	"PULSE B" => {
		:BaseStats => [100,70,200,10,70,160],
		:Ability => PBAbilities::ARENATRAP,
		:Weight => 2675,
		:Type2 => PBTypes::GROUND
	},

	"PULSE A" => {
		:BaseStats => [100,70,200,10,70,160],
		:Ability => PBAbilities::STAMINA,
		:Weight => 2675,
		:Type2 => PBTypes::ROCK
	},

	"Egho" => {
		:DexEntry => "Tangrowth has the ability to absorb and supply electricity through the prongs on the ends of its arms, enabling it to act as a sort of living battery.",
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [114,55,107,92,90,77],
		:EVs => [0,0,2,0,0,2],
		:Ability => [PBAbilities::VOLTABSORB,PBAbilities::MOTORDRIVE,PBAbilities::STATIC],
		:Movelist => [[0,PBMoves::WILDCHARGE],
			[1,PBMoves::BIND],[1,PBMoves::MAGNETRISE],[1,PBMoves::THUNDERSHOCK],
			[4,PBMoves::VINEWHIP],[7,PBMoves::PROTECT],[10,PBMoves::ABSORB],
			[14,PBMoves::HIDDENPOWER],[17,PBMoves::COIL],[20,PBMoves::CHARGEBEAM],
			[23,PBMoves::MEGADRAIN],[25,PBMoves::IRONHEAD],[27,PBMoves::RECOVER],
			[30,PBMoves::IRONDEFENSE],[33,PBMoves::GIGADRAIN],[35,PBMoves::DISCHARGE],
			[40,PBMoves::FLASHCANNON],[46,PBMoves::POWERWHIP],[49,PBMoves::SIMPLEBEAM],
			[53,PBMoves::AUTOTOMIZE],[56,PBMoves::THUNDER]],
		:Weight => 350,
		:Height => 10,
		:kind => "Cable Salad"
	}
},

PBSpecies::ABRA => {
	:FormName => {
		1 => "PULSE",
		2 => "PULSE"
	},

	:DefaultForm => 0,
	:PulseForm => proc{|pokemon|
		next pokemon.happiness==255 ? 2 : 1
	},

	"PULSE" => {
		:BaseStats => [25,20,115,140,195,155],
		:Ability => PBAbilities::MAGICGUARD,
		:Weight => 862,
		:Type2 => PBTypes::STEEL
	}
},

PBSpecies::AVALUGG => {
	:FormName => {
		1 => "PULSE",
		2 => "Hisui"
	},

	:OnCreation => proc{
		chancemaps=[749,750,870,894] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [105,160,255,10,97,255],
		:Ability => PBAbilities::SOLIDROCK,
		:Weight => 8780
	},

	"Hisui" => {
		:DexEntry => "The armor of ice covering its lower jaw puts steel to shame and can shatter rocks with ease. This Pokémon barrels along steep mountain paths, cleaving through the deep snow.",
		:Type2 => PBTypes::ROCK,
		:BaseStats => [95,127,184,38,34,36],
		:Ability => [PBAbilities::STRONGJAW,PBAbilities::STURDY,PBAbilities::ICEBODY],
		:Movelist => [[0,PBMoves::WIDEGUARD],[1,PBMoves::WIDEGUARD],[1,PBMoves::TACKLE],[3,PBMoves::HARDEN],
			[5,PBMoves::SHARPEN],[10,PBMoves::BITE],[12,PBMoves::POWDERSNOW],[15,PBMoves::RAPIDSPIN],
			[18,PBMoves::ICESHARD],[20,PBMoves::TAKEDOWN],[22,PBMoves::ICYWIND],[24,PBMoves::CURSE],
			[26,PBMoves::PROTECT],[30,PBMoves::ICEBALL],[33,PBMoves::IRONDEFENSE],[35,PBMoves::ICEFANG],
			[39,PBMoves::CRUNCH],[41,PBMoves::EARTHPOWER],[43,PBMoves::RECOVER],[47,PBMoves::AVALANCHE],
			[49,PBMoves::ROCKSLIDE],[51,PBMoves::DOUBLEEDGE],[56,PBMoves::MOUNTAINGALE],
			[37,PBMoves::BLIZZARD]],
		:Weight => 2624
	}
},

PBSpecies::SWALOT => {
	:FormName => {1 => "PULSE"},
	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [100,73,210,40,110,210],
		:Ability => PBAbilities::WATERABSORB,
		:Weight => 4621,
		:Type2 => PBTypes::WATER
	}
},

PBSpecies::MAGNEZONE => {
	:FormName => {
		1 => "PULSE",
		2 => "Egho"
	},

	:OnCreation => proc{
		chancemaps=[894]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [70,70,160,70,230,140],
		:Ability => PBAbilities::LEVITATE,
		:Weight => 1673
	},

	"Egho" => {
		:DexEntry => "This Magnezone is a result of a sudden mutation causing one of the Magneton's bodies to absorb the other two and grow rapidly in power.",
		:Type1 => PBTypes::GRASS,
		:BaseStats => [80,120,90,60,70,115],
		:EVs => [0,2,0,0,0,2],
		:Ability => [PBAbilities::OVERGROW,PBAbilities::REGENERATOR,PBAbilities::ANALYTIC],
		:Movelist => [[0,PBMoves::HEAVYSLAM],[1,PBMoves::GROWTH],[1,PBMoves::MIRRORCOAT],[1,PBMoves::BARRIER],
			[1,PBMoves::TACKLE],[4,PBMoves::SUPERSONIC],[7,PBMoves::MAGICALLEAF],
			[11,PBMoves::SONICBOOM],[15,PBMoves::LEECHSEED],[18,PBMoves::VINEWHIP],
			[21,PBMoves::MAGNETBOMB],[25,PBMoves::RAZORLEAF],[29,PBMoves::METALBURST],
			[32,PBMoves::BODYSLAM],[35,PBMoves::SLAM],[38,PBMoves::SEEDBOMB],
			[42,PBMoves::SCREECH],[45,PBMoves::IRONHEAD],[47,PBMoves::HORNLEECH],
			[50,PBMoves::LOCKON],[54,PBMoves::BULLDOZE],[57,PBMoves::FISSURE],
			[62,PBMoves::AUTOTOMIZE],[65,PBMoves::WOODHAMMER]],
		:Weight => 2850,
		:Height => 22,
		:kind => "Overgrown"
	}
},

PBSpecies::HYPNO => {
	:FormName => {
		1 => "PULSE",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:PulseForm => 1,
	:MegaForm => 2,

	"PULSE" => {
		:BaseStats => [120,65,190,80,125,225],
		:Ability => PBAbilities::NOGUARD,
		:Weight => 208,
		:Type2 => PBTypes::DARK
	},

	"Mega" => {
		:BaseStats => [95,73,70,97,123,125],
		:Type2 => PBTypes::GHOST,
		:Ability => PBAbilities::NEUROFORCE
	}
},

PBSpecies::CLAWITZER => {
	:FormName => {1 => "PULSE"},
	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [252,1,60,252,120,70],
		:Ability => PBAbilities::CONTRARY,
		:Weight => 573,
		:Type2 => PBTypes::DRAGON
	}
},

PBSpecies::MRMIME => {
	:FormName => {
		1 => "PULSE",
		2 => "Galarian"
	},

	:OnCreation => proc{
		chancemaps=[526,866,894] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [252,1,190,252,1,190],
		:Ability => PBAbilities::WONDERGUARD,
		:Weight => 483,
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::GHOST
	},

	"Galarian" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::PSYCHIC,
		:EVs => [0,0,0,2,0,0],
		:BaseStats => [50,65,65,100,90,90],
		:Ability => [PBAbilities::VITALSPIRIT,PBAbilities::SCREENCLEANER,PBAbilities::STRONGHEEL,PBAbilities::ICEBODY],
		:Movelist => [[1,PBMoves::MISTYTERRAIN],[1,PBMoves::ICESHARD],[1,PBMoves::RAPIDSPIN],
			[1,PBMoves::ALLYSWITCH],[1,PBMoves::DOUBLEKICK],[1,PBMoves::MIRRORCOAT],[1,PBMoves::TICKLE],
			[1,PBMoves::CONFUSION],[1,PBMoves::BARRIER],[1,PBMoves::POUND],[4,PBMoves::COPYCAT],
			[8,PBMoves::MEDITATE],[11,PBMoves::ENCORE],[13,PBMoves::PROTECT],[15,PBMoves::DOUBLESLAP],
			[18,PBMoves::MIMIC],[20,PBMoves::HYPNOSIS],[22,PBMoves::REFLECT],[22,PBMoves::LIGHTSCREEN],
			[22,PBMoves::SAFEGUARD],[24,PBMoves::PSYBEAM],[26,PBMoves::ICYWIND],[29,PBMoves::RECYCLE],
			[32,PBMoves::TRICK],[34,PBMoves::IRONDEFENSE],[36,PBMoves::ROLEPLAY],[38,PBMoves::SUBSTITUTE],
			[40,PBMoves::BATONPASS],[42,PBMoves::ZENHEADBUTT],[44,PBMoves::CALMMIND],[46,PBMoves::SUCKERPUNCH],
			[48,PBMoves::DAZZLINGGLEAM],[48,PBMoves::FREEZEDRY],[50,PBMoves::PSYCHIC],
			[52,PBMoves::TEETERDANCE]],
		:EggMoves => [PBMoves::CHARM,PBMoves::CONFUSERAY,PBMoves::FAKEOUT,PBMoves::FOLLOWME,
			PBMoves::FUTURESIGHT,PBMoves::HEALINGWISH,PBMoves::HYPNOSIS,PBMoves::ICYWIND,PBMoves::LOVELYKISS,
			PBMoves::MAGICROOM,PBMoves::MIMIC,PBMoves::MINDREADER,PBMoves::MUDSLAP,PBMoves::NASTYPLOT,
			PBMoves::PERISHSONG,PBMoves::POWERSPLIT,PBMoves::POWERWHIP,PBMoves::PSYCHICTERRAIN,PBMoves::PURSUIT,
			PBMoves::QUICKATTACK,PBMoves::SMOG,PBMoves::SONICBOOM,PBMoves::TEETERDANCE,PBMoves::TICKLE,
			PBMoves::TRICK,PBMoves::WAKEUPSLAP],
		:GetEvo => [[PBSpecies::MRRIME,PBEvolution::Level,42]]
	}
},

PBSpecies::REGIGIGAS => {
	:FormName => {1 => "PULSE"},
	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [200,160,200,200,100,200],
		:Ability => PBAbilities::SLOWSTART,
		:Type1 => PBTypes::STELLAR,
		:Type2 => PBTypes::STELLAR,
		:Weight => 14621
	}
},

PBSpecies::ARCEUS => {
	:FormName => {
		21 => "PULSE",
		22 => "PULSE",
		23 => "PULSE",
		24 => "PULSE",
		25 => "PULSE",
		26 => "PULSE",
		27 => "PULSE",
		28 => "PULSE",
		29 => "PULSE",
		30 => "PULSE",
		31 => "PULSE",
		32 => "PULSE",
		33 => "PULSE",
		34 => "PULSE",
		35 => "PULSE",
		36 => "PULSE",
		37 => "PULSE",
		38 => "PULSE",
		39 => "PULSE",
		40 => "PULSE",
		41 => "PULSE"
	},

	:DefaultForm => 0,
	:PulseForm => proc{|pokemon|
		next pokemon.form+21
	},

	"PULSE" => {
		:BaseStats => [255,125,155,160,125,155],
		:Weight => 9084,
	}
},

###################### Misc Forms ######################

PBSpecies::KECLEON => {
	:FormName => {
		1 => "Purple",
		2 => "Nuclear"
	},

	"Purple" => {
		:BaseStats => [130,120,90,95,60,130]
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRELOOM => {
	:FormName => {
		1 => "Bot",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Bot" => {
		:BaseStats => [210,160,140,100,60,100],
		:Weight => 5328,
		:Type1 => PBTypes::STEEL,
		:Ability => [PBAbilities::AUTOMATRON]
	},

	"Mega" => {
		:BaseStats => [80,145,80,105,70,80],
		:Ability => [PBAbilities::NOGUARD],
	}
},

PBSpecies::PYROIMENCE => {
	:FormName => {1 => "LegendaryFight"},

	"LegendaryFight" => {
		:BaseStats => [190,105,130,25,85,145]
	}
},

PBSpecies::DREADXISTENCE => {
	:FormName => {1 => "LegendaryFight"},

	"LegendaryFight" => {
		:BaseStats => [89,155,93,92,155,96]
	}
},

###################### Deso Megas ################################

PBSpecies::MIGHTYENA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,125,70,125,60,70],
		:Ability => PBAbilities::STRONGJAW,
		:Type2 => PBTypes::GHOST
	}
},

PBSpecies::DARKRAI => {
	:FormName => {1 => "Perfection"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Perfection" => {
		:BaseStats => [70,90,95,170,165,100],
		:Ability => PBAbilities::BADDREAMS,
		:Type2 => PBTypes::GHOST,
		:Weight => 1011
	}
},

PBSpecies::TOXICROAK => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [83,136,70,115,116,70],
		:Ability => PBAbilities::ADAPTABILITY
	}
},

PBSpecies::CINCCINO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,125,110,135,40,80],
		:Type2 => PBTypes::FAIRY,
		:Ability => PBAbilities::SKILLLINK
	}
},

PBSpecies::UMBREON => {
	:FormName => {
		1 => "Perfection",
		2 => "Nuclear"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Perfection" => {
		:BaseStats => [95,75,130,75,120,130],
		:Type2 => PBTypes::PSYCHIC,
		:Ability => PBAbilities::MAGICBOUNCE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

########################## Totem Forms ###########################

PBSpecies::AMBIPOM => {
	:FormName => {1 => "TOTEM"},

	"TOTEM" => {
		:BaseStats => [75,100,66,115,60,66],
		:Ability => [PBAbilities::TECHNICIAN]
	}
},

PBSpecies::CRUSTLE => {
	:FormName => {1 => "TOTEM"},

	"TOTEM" => {
		:BaseStats => [70,105,125,45,65,75],
		:Ability => [PBAbilities::WEAKARMOR]
	}
},

###################### Developer Team Forms ######################

PBSpecies::GLACEON => {
	:FormName => {
		1 => "Mismageon",
		2 => "Nuclear"
	},

	"Mismageon" => {
		:BaseStats => [65,60,110,105,130,105],
		:Type2 => PBTypes::GHOST
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CINCCINO => {
	:FormName => {1 => "Meech"},

	"Meech" => {
		:BaseStats => [75,125,110,135,40,80],
		:Type2 => PBTypes::FAIRY,
		:Ability => PBAbilities::SKILLLINK
	}
},

PBSpecies::GOLURK => {
	:FormName => {1 => "Rebornian"},

	"Rebornian" => {
		:BaseStats => [89,131,85,55,40,85],
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::GROUND,
		:Ability => [PBAbilities::DRYSKIN,PBAbilities::NOGUARD,PBAbilities::FLAMEBODY],
		:Movelist => [[0,PBMoves::HIGHHORSEPOWER],[1,PBMoves::FOCUSPUNCH],[1,PBMoves::MUDSLAP],[1,PBMoves::FLAMEWHEEL],
					 [1,PBMoves::DEFENSECURL],[1,PBMoves::POUND],[12,PBMoves::FLAMECHARGE],[16,PBMoves::CURSE],
					 [20,PBMoves::FIREPUNCH],[24,PBMoves::STOMPINGTANTRUM],[28,PBMoves::IRONDEFENSE],[32,PBMoves::MEGAPUNCH],
					 [36,PBMoves::HEATCRASH],[40,PBMoves::HEAVYSLAM],[46,PBMoves::FLAREBLITZ],[50,PBMoves::RAGINGFURY],
					 [52,PBMoves::HAMMERARM],[58,PBMoves::EARTHQUAKE],[64,PBMoves::DYNAMICPUNCH]],
		:EggMoves => [PBMoves::BURNINGJEALOUSY,PBMoves::SCORCHINGSANDS,PBMoves::HEADLONGRUSH],
		:Weight => 350,
		:Height => 28
	}
},

PBSpecies::ELECTIVIRE => {
	:FormName => {1 => "Rebornian"},

	"Rebornian" => {
		:BaseStats => [90,125,85,106,69,75],
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::STEEL,
		:Ability => [PBAbilities::IRONFIST,PBAbilities::NOGUARD,PBAbilities::MOTORDRIVE],
		:Movelist => [[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::IONDELUGE],[1,PBMoves::FIREPUNCH],[1,PBMoves::QUICKATTACK],[1,PBMoves::LEER],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::LOWKICK],[5,PBMoves::THUNDERSHOCK],[8,PBMoves::LOWKICK],[12,PBMoves::SWIFT],[15,PBMoves::SHOCKWAVE],[19,PBMoves::THUNDERWAVE],[22,PBMoves::BULLETPUNCH],[26,PBMoves::LIGHTSCREEN],[29,PBMoves::THUNDERPUNCH],[36,PBMoves::DISCHARGE],[40,PBMoves::IRONHEAD],[42,PBMoves::SCREECH],[43,PBMoves::SHIFTGEAR],[49,PBMoves::THUNDERBOLT],[49,PBMoves::IONICWHIPLASH],[55,PBMoves::THUNDER],[62,PBMoves::GIGAIMPACT],[65,PBMoves::ELECTRICTERRAIN]],
		:Weight => 350,
		:Height => 28
	}
},

PBSpecies::OCTILLERY => {
	:FormName => {
		1 => "Rebornian"
	},

	"Rebornian" => {
		:BaseStats => [110,70,80,40,110,80],
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::FAIRY,
		:Ability => [PBAbilities::SUCTIONCUPS,PBAbilities::SNIPER,PBAbilities::ENCHANTEDCANNON],
		:Movelist => [[0,PBMoves::OCTAZOOKA],[0,PBMoves::DRAININGKISS],[1,PBMoves::GUNKSHOT],[1,PBMoves::ROCKBLAST],[1,PBMoves::WATERGUN],[1,PBMoves::CONSTRICT],[1,PBMoves::PSYBEAM],[1,PBMoves::AURORABEAM],[6,PBMoves::CONSTRICT],[10,PBMoves::PSYBEAM],[14,PBMoves::AURORABEAM],[15,PBMoves::CHARGEBEAM],[18,PBMoves::BUBBLEBEAM],[22,PBMoves::FOCUSENERGY],[25,PBMoves::DRAININGKISS],[28,PBMoves::WRINGOUT],[30,PBMoves::DAZZLINGGLEAM],[32,PBMoves::MISTYTERRAIN],[34,PBMoves::SIGNALBEAM],[40,PBMoves::ICEBEAM],[45,PBMoves::LUSTERBEAM],[46,PBMoves::BULLETSEED],[50,PBMoves::MOONBLAST],[52,PBMoves::HYDROPUMP],[58,PBMoves::HYPERBEAM],[64,PBMoves::SOAK]],
		:Weight => 350,
		:Height => 28
	}
	

},

PBSpecies::RIOLU => {
	:FormName => {
		1 => "Rebornian",
		4 => "Rebornian Ametrine"
	},

	:OnCreation => proc{
		maps=[384,430] # Map IDs for Rebornian form: Celestinine Mountain 2F
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [40,70,50,70,25,30],
		:Ability => [PBAbilities::JUSTIFIED,PBAbilities::MOXIE,PBAbilities::LONGREACH],
		:Movelist => [[1,PBMoves::ENDURE],[1,PBMoves::QUICKATTACK],[4,PBMoves::FEINT],[8,PBMoves::MACHPUNCH],[12,PBMoves::COUNTER],[16,PBMoves::BULLDOZE],[20,PBMoves::ROCKSMASH],[24,PBMoves::SANDATTACK],[28,PBMoves::BONECLUB],[32,PBMoves::QUICKGUARD],[36,PBMoves::FORCEPALM],[40,PBMoves::SWORDSDANCE],[44,PBMoves::HELPINGHAND],[48,PBMoves::COPYCAT],[52,PBMoves::FINALGAMBIT],[56,PBMoves::REVERSAL]],
	},
	
		"Rebornian Ametrine" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [40,35,40,30,70,60],
		:Ability => [PBAbilities::SLUSHRUSH,PBAbilities::FURCOAT,PBAbilities::STEADFAST],
	}
	
},

PBSpecies::GRENINJA => {
	:FormName => {
		1 => "Zalophus-Mega",
		2 => "Genji-Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 3,

	"Zalophus-Mega" => {
		:BaseStats => [72,145,67,132,153,71],
		:Ability => [PBAbilities::SHARPNESS,PBAbilities::PROTEAN],
		:Weight => 40
	},

	"Genji-Mega" => {
		:BaseStats => [36,163,67,150,171,71],
		:Ability => [PBAbilities::SHARPNESS,PBAbilities::PROTEAN],
		:Movelist => [[100,PBMoves::DRAGONBLADE],[100,PBMoves::SEARINGSLASH],[100,PBMoves::THUNDERSLASH],[100,PBMoves::ICESLASH],[100,PBMoves::SECRETSWORD]],
		:Weight => 80
	}
},

PBSpecies::CHIMCHAR => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		mapStarterHall=[39] # Map IDs for Rebornian form
		randomnum = rand(4)
		next $game_map && mapStarterHall.include?($game_map.map_id) && randomnum==0 ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [60,60,50,70,60,30],
		:Ability => [PBAbilities::BLAZE,PBAbilities::FURIOUSSPIRIT],
		:Movelist => [[1,PBMoves::FAKEOUT],[1,PBMoves::SCRATCH],[6,PBMoves::EMBER],[9,PBMoves::TAUNT],
			[12,PBMoves::SNARL],[15,PBMoves::MACHPUNCH],[17,PBMoves::FLAMEWHEEL],[23,PBMoves::NASTYPLOT],
			[25,PBMoves::HOTHEAD],[31,PBMoves::FACADE],[33,PBMoves::FIRELASH],[39,PBMoves::SUCKERPUNCH],[41,PBMoves::SLACKOFF],[47,PBMoves::NIGHTDAZE]],
		:Weight => 370
	}
},

PBSpecies::MONFERNO => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		mapDesertt=[703,704,705] # Map IDs for Rebornian form
		next $game_map && mapDesertt.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [65,80,50,90,75,50],
		:Ability => [PBAbilities::BLAZE,PBAbilities::FURIOUSSPIRIT],
		:Movelist => [[1,PBMoves::FAKEOUT],[1,PBMoves::SCRATCH],[1,PBMoves::EMBER],[1,PBMoves::FLAMETHROWER],[1,PBMoves::MACHPUNCH],[1,PBMoves::SCRATCH],[6,PBMoves::EMBER],[9,PBMoves::TAUNT],
			[12,PBMoves::SNARL],[15,PBMoves::MACHPUNCH],[19,PBMoves::FLAMEWHEEL],[23,PBMoves::NASTYPLOT],
			[25,PBMoves::HOTHEAD],[31,PBMoves::FACADE],[33,PBMoves::FIRELASH],[36,PBMoves::KNOCKOFF],[39,PBMoves::SUCKERPUNCH],[41,PBMoves::SLACKOFF],[47,PBMoves::NIGHTDAZE],[74,PBMoves::FLAREBLITZ]],
		:Weight => 370
	}
},

PBSpecies::LARVESTA => {
	:FormName => {1 => "Cosmic"},

	"Cosmic" => {
		:DexEntry => ".",
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::DARK,
		:BaseStats => [55,85,55,60,50,55],
		:Ability => [PBAbilities::ELEMENTALIST,PBAbilities::DARKAURA,PBAbilities::DUSKILATE],
		:Movelist => [[1,PBMoves::EMBER],[1,PBMoves::ASTRALSHOT],[1,PBMoves::STRINGSHOT],[10,PBMoves::ABSORB],[20,PBMoves::TAKEDOWN],[30,PBMoves::FLAMECHARGE],[40,PBMoves::BUGBITE],[50,PBMoves::WEAKENINGJUMPSCARE],[60,PBMoves::FLAMEWHEEL],[70,PBMoves::BUGBUZZ],[80,PBMoves::AMNESIA],[90,PBMoves::THRASH],[100,PBMoves::FLAREBLITZ]],
		:EggMoves => [PBMoves::ACIDARMOR,PBMoves::BUBBLEBEAM,PBMoves::FLAMEBURST,PBMoves::MIST,PBMoves::MYSTICALFIRE,PBMoves::ACID,PBMoves::AFTERYOU,PBMoves::AQUATAIL,PBMoves::BIND,PBMoves::EARTHPOWER,PBMoves::ENDURE,PBMoves::GIGADRAIN,PBMoves::HEALBELL,PBMoves::HEATWAVE,PBMoves::PAINSPLIT,PBMoves::SIGNALBEAM,PBMoves::SNORE,PBMoves::SPITE,PBMoves::WATERPULSE,PBMoves::WHIRLPOOL,PBMoves::HYDROPUMP,PBMoves::FIREBLAST,PBMoves::FLAMETHROWER,PBMoves::OMINOUSWIND,PBMoves::SLUDGEBOMB,PBMoves::AURORABEAM,PBMoves::ICEBEAM,PBMoves::LAVAPLUME,PBMoves::SLUDGEWAVE,PBMoves::DISCHARGE,PBMoves::DAZZLINGGLEAM,PBMoves::TEETERDANCE,PBMoves::ROOST,PBMoves::HYPERVOICE,PBMoves::THUNDER,PBMoves::BLIZZARD,PBMoves::THUNDERWAVE,PBMoves::THUNDERBOLT,PBMoves::HYPERBEAM,PBMoves::DRAGONDANCE],
		:Weight => 120
	}
},

PBSpecies::VOLCARONA => {
	:FormName => {
		1 => "Cosmic",
		2 => "Paradox",
		3 => "Totem"
	},

	"Cosmic" => {
		:DexEntry => ".",
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::DARK,
		:BaseStats => [98,62,89,109,127,95], #? Cosmic adds +30 to BST
		:Ability => [PBAbilities::DUSKILATE,PBAbilities::DARKAURA,PBAbilities::PROTEAN],
		:Movelist => [[0,PBMoves::COMETSHOWER],[1,PBMoves::COSMICDANCE],[1,PBMoves::ASTRALSHOT],[1,PBMoves::QUIVERDANCE],[1,PBMoves::FIERYDANCE],[1,PBMoves::NASTYPLOT],[1,PBMoves::WHIRLWIND],[60,PBMoves::COSMICDANCE],[60,PBMoves::TRIATTACK],[60,PBMoves::STRENGTHSAP],[63,PBMoves::BUGBUZZ],[65,PBMoves::DARKPULSE],[67,PBMoves::TAUNT],[69,PBMoves::FIERYDANCE],[71,PBMoves::HURRICANE],[73,PBMoves::RAGEPOWDER],[75,PBMoves::HYPERVOICE],[75,PBMoves::COSMICRAY],[75,PBMoves::MOONBLAST],[90,PBMoves::BOOMBURST]],
		:Weight => 100
	},

	"Paradox" => {
		:BaseStats => [82,102,69,101,112,104],
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::GRASS
	},

	"Totem" => {
		:Ability => PBAbilities::SWARM
	}
},

PBSpecies::LEDIAN => { # Special thanks to Etay from the Reborn Server <3
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		mapCemetery=[152,552] # Map IDs for Rebornian form
		next $game_map && mapCemetery.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::BUG,
		:BaseStats => [60,60,80,100,10,80],
		:Ability => [PBAbilities::PUREPOWER,PBAbilities::INTIMIDATE,PBAbilities::TROUBLESHOOTER],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::SUPERSONIC],[1,PBMoves::SWIFT],[5,PBMoves::SUPERSONIC],[8,PBMoves::SWIFT],[12,PBMoves::LIGHTSCREEN],[12,PBMoves::REFLECT],[12,PBMoves::SAFEGUARD],[15,PBMoves::MACHPUNCH],[20,PBMoves::SILVERWIND],[24,PBMoves::COMETPUNCH],[25,PBMoves::SHADOWSNEAK],[29,PBMoves::BATONPASS],[33,PBMoves::AGILITY],[35,PBMoves::XSCISSOR],[38,PBMoves::BUGBUZZ],[42,PBMoves::AIRSLASH],[45,PBMoves::IRONHEAD],[47,PBMoves::DOUBLEEDGE],[50,PBMoves::KINGSSHIELD],[50,PBMoves::SACREDSWORD]],
		:Weight => 450
	}
},

PBSpecies::MIMIKYU => {
	:FormName => {
		2 => "Rebornian",
		3 => "Also Rebornian"
	},

	:OnCreation => proc{
		maps=[27] # Map IDs for Rebornian form: Pyrous Mountain (TOP)
		next $game_map && maps.include?($game_map.map_id) ? 2 : 0
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [55,50,105,96,90,80],
		:Movelist => [[1,PBMoves::APPLEACID],[1,PBMoves::SPLASH],[1,PBMoves::TACKLE],[1,PBMoves::EMBER],[1,PBMoves::COPYCAT],[6,PBMoves::SHADOWSNEAK],[12,PBMoves::DOUBLETEAM],[18,PBMoves::BABYDOLLEYES],[24,PBMoves::MIMIC],[30,PBMoves::NASTYPLOT],[36,PBMoves::SLASH],[42,PBMoves::FLAMETHROWER],[48,PBMoves::CHARM],[54,PBMoves::MOONBLAST],[60,PBMoves::PAINSPLIT]],
		:Weight => 450
	},

	"Also Rebornian" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [55,50,105,96,90,80],
		:Weight => 450
	}
},

###################### Egho Region Variants ######################

PBSpecies::BULBASAUR => {
	:FormName => {3 => "Egho"},

	"Egho" => {
		:DexEntry => "The plants that grow on Bulbasaur use its body for nutrients. Bulbasaur relies on the plant for protection.",
		:Type2 => PBTypes::ROCK,
		:BaseStats => [44,60,54,37,50,64],
		:EVs => [0,1,0,0,0,1],
		:Ability => [PBAbilities::ROUGHSKIN,PBAbilities::POISONPOINT,PBAbilities::POISONPOINT],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[1,PBMoves::HARDEN],
			[5,PBMoves::ABSORB],[6,PBMoves::SANDATTACK],[8,PBMoves::DRYNEEDLES],
			[10,PBMoves::BARBEDTACKLE],[12,PBMoves::LEECHSEED],[14,PBMoves::ROCKTHROW],
			[17,PBMoves::SANDSTORM],[20,PBMoves::MAGNITUDE],[23,PBMoves::NEEDLEARM],
			[27,PBMoves::ROCKBLAST],[29,PBMoves::STEALTHROCK],[33,PBMoves::ROCKSLIDE],
			[35,PBMoves::ROCKPOLISH],[39,PBMoves::SOLARBEAM],[41,PBMoves::EARTHQUAKE]],
		:EggMoves => [PBMoves::CURSE,PBMoves::ENDURE,PBMoves::GIGADRAIN,PBMoves::SANDSTORM,
				PBMoves::INGRAIN,PBMoves::NATUREPOWER,PBMoves::PETALDANCE,PBMoves::POWERWHIP,
				PBMoves::SKULLBASH,PBMoves::LEAFSTORM],
		:Weight => 160,
		:Height => 9,
		:kind => "Cactus Bulb"
	}
},

PBSpecies::IVYSAUR => {
	:FormName => {3 => "Egho"},

	"Egho" => {
		:DexEntry => "As the body of Ivysaur dries up, it grows a patch of dense vines that aid it in battle.",
		:Type2 => PBTypes::ROCK,
		:BaseStats => [60,80,65,45,67,78],
		:EVs => [0,2,0,0,0,1],
		:Ability => [PBAbilities::ROUGHSKIN,PBAbilities::POISONPOINT,PBAbilities::POISONPOINT],
		:Movelist => [[0,PBMoves::THORNWHIP],
			[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[1,PBMoves::HARDEN],
			[5,PBMoves::ABSORB],[6,PBMoves::SANDATTACK],[8,PBMoves::DRYNEEDLES],
			[10,PBMoves::BARBEDTACKLE],[12,PBMoves::LEECHSEED],[14,PBMoves::ROCKTHROW],
			[20,PBMoves::SANDSTORM],[23,PBMoves::MAGNITUDE],[26,PBMoves::NEEDLEARM],
			[30,PBMoves::ROCKBLAST],[33,PBMoves::STEALTHROCK],[37,PBMoves::ROCKSLIDE],
			[39,PBMoves::ROCKPOLISH],[43,PBMoves::SOLARBEAM],[46,PBMoves::EARTHQUAKE]],
		:Weight => 700,
		:Height => 14,
		:kind => "Cactus Plant"
	}
},

PBSpecies::SQUIRTLE => {
	:FormName => {3 => "Egho"},

	"Egho" => {
		:DexEntry => "Squirtle produces a small cloud as a tail that it then uses to float on top of and keep itself cool. They can often be found snoozing, sprawled out on their own cloud.",
		:BaseStats => [44,48,65,43,50,64],
		:EVs => [0,0,1,0,0,1],
		:Ability => [PBAbilities::SERENEGRACE,PBAbilities::OVERCOAT,PBAbilities::OVERCOAT],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[1,PBMoves::WITHDRAW],
			[5,PBMoves::BUBBLE],[6,PBMoves::NIMBUSFIST],[9,PBMoves::AQUARING],
			[12,PBMoves::BITE],[15,PBMoves::FOGGYSTRIKE],[17,PBMoves::BUBBLEBEAM],
			[18,PBMoves::ICESHARD],[19,PBMoves::MIST],[22,PBMoves::PROTECT],
			[25,PBMoves::WATERPULSE],[28,PBMoves::AQUATAIL],[34,PBMoves::HAIL],
			[40,PBMoves::HYDROPUMP]],
		:EggMoves => [PBMoves::AQUAJET,PBMoves::AQUARING,PBMoves::BRINE,
				PBMoves::HAZE,PBMoves::MIRRORCOAT,PBMoves::MIST,
				PBMoves::MUDDYWATER,PBMoves::REFRESH,PBMoves::DEFOG],
		:Weight => 85,
		:Height => 5,
		:kind => "Rain Cloud"
	}
},

PBSpecies::WARTORTLE => {
	:FormName => {3 => "Egho"},

	"Egho" => {
		:DexEntry => "Wartortle's body starts to develop even more cloud forms, allowing it to temporarily hover sometimes. It uses the cloud as a cloak during foggy days.",
		:Type2 => PBTypes::FLYING,
		:BaseStats => [59,63,80,58,65,80],
		:EVs => [0,0,1,0,0,2],
		:Ability => [PBAbilities::SERENEGRACE,PBAbilities::OVERCOAT,PBAbilities::OVERCOAT],
		:Movelist => [[0,PBMoves::GUST],
			[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[1,PBMoves::WITHDRAW],
			[5,PBMoves::BUBBLE],[6,PBMoves::NIMBUSFIST],[9,PBMoves::AQUARING],
			[12,PBMoves::BITE],[15,PBMoves::FOGGYSTRIKE],[19,PBMoves::BUBBLEBEAM],
			[20,PBMoves::ICESHARD],[21,PBMoves::MIST],[25,PBMoves::PROTECT],
			[27,PBMoves::AIRCUTTER],[28,PBMoves::WATERPULSE],[31,PBMoves::AQUATAIL],
			[35,PBMoves::ICYWIND],[38,PBMoves::HAIL],[42,PBMoves::TYPHOON],
			[45,PBMoves::HYDROPUMP],[49,PBMoves::TAILWIND],[52,PBMoves::HURRICANE]],
		:Weight => 200,
		:Height => 10,
		:kind => "Cloud Rider"
	}
},

PBSpecies::SHELLDER => {
	:FormName => {1 => "Egho"},

	:OnCreation => proc{
		randomnum = rand(3)
		next randomnum==0 ? 1 : 0
 	},
	
	"Egho" => {
		:DexEntry => "This Shellder can often times be found attached to a Slowbro. When removed and left alone, it will hunt down other sea creatures to feed on.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [52,40,70,31,55,57],
		:EVs => [0,0,1,0,0,1],
		:Ability => [PBAbilities::IRONBARBS,PBAbilities::SUPERLUCK],
		:Movelist => [[1,PBMoves::SPIKES],[1,PBMoves::WITHDRAW],[1,PBMoves::RAPIDSPIN],
			[1,PBMoves::PROTECT],[1,PBMoves::ACID],[5,PBMoves::GASTROACID],
			[13,PBMoves::METALSOUND],[15,PBMoves::BUBBLE],[17,PBMoves::ABSORB],
			[19,PBMoves::AQUARING],[20,PBMoves::ACIDSPRAY],[23,PBMoves::BUBBLEBEAM],
			[27,PBMoves::POISONFANG],[33,PBMoves::RAZORSHELL],[36,PBMoves::MIRRORSHOT],
			[38,PBMoves::SPITE],[42,PBMoves::IRONDEFENSE],
			[45,PBMoves::LEECHLIFE],[48,PBMoves::HYDROPUMP],[52,PBMoves::SHELLSMASH]],
		:EggMoves => [PBMoves::GUNKSHOT,PBMoves::STOCKPILE,PBMoves::SPITUP,
				PBMoves::SWALLOW,PBMoves::BELCH,PBMoves::DRAGONTAIL,
				PBMoves::BITE,PBMoves::CLEARSMOG,PBMoves::REFRESH],
		:GetEvo => [[PBSpecies::SKULKRAKEN,PBEvolution::Level,39]],
		:Weight => 410,
		:Height => 12,
		:kind => "Cone Shell"
	}
},

PBSpecies::SPEAROW => {
	:FormName => {1 => "Egho"},

	:OnCreation => proc{
		maps=[333,334,335]
		chancemaps=[519,573]
		if $game_map && maps.include?($game_map.map_id)
			next 1
		elsif $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},
	
	"Egho" => {
		:DexEntry => "These Spearow became an invasive species because it had no natural predators. In order to stay at the top of the food chain, it adapted into a vicious predator.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [40,70,25,70,26,31],
		:EVs => [0,1,0,1,0,0],
		:Ability => [PBAbilities::DEFIANT,PBAbilities::ADAPTABILITY],
		:Movelist => [[1,PBMoves::PECK],[1,PBMoves::GROWL],[1,PBMoves::BEATUP],
			[5,PBMoves::FURYATTACK],[9,PBMoves::BITE],[13,PBMoves::DOUBLEKICK],
			[17,PBMoves::PURSUIT],[21,PBMoves::LOWSWEEP],[24,PBMoves::AGILITY],
			[27,PBMoves::FOCUSENERGY],[30,PBMoves::JUMPKICK],[34,PBMoves::AMBUSH],
			[38,PBMoves::CRUNCH],[42,PBMoves::HIJUMPKICK]],
		:EggMoves => [PBMoves::ASTONISH,PBMoves::FEINTATTACK,PBMoves::FEATHERDANCE,
				PBMoves::QUICKATTACK,PBMoves::RAZORWIND,PBMoves::SCARYFACE,
				PBMoves::SUCKERPUNCH,PBMoves::CROSSPOISON,PBMoves::UPROAR,
				PBMoves::WHIRLWIND],
		:GetEvo => [[PBSpecies::FEAROW,PBEvolution::Level,25]],
		:Weight => 280,
		:Height => 4,
		:kind => "Tiny Bird"
	}
},

PBSpecies::FEAROW => {
	:FormName => {1 => "Egho"},

	:OnCreation => proc{
		chancemaps=[519,525,544,511,552,573]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Egho" => {
		:DexEntry => "Because its wings are too thin to fly effectively, it instead uses them as weapons, fanning them out to sweep opponents in all directions.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [65,112,55,110,50,50],
		:EVs => [0,2,0,1,0,0],
		:Ability => [PBAbilities::DEFIANT,PBAbilities::ADAPTABILITY],
		:Movelist => [[0,PBMoves::NIGHTSLASH],[1,PBMoves::DRILLPECK],
			[1,PBMoves::PECK],[1,PBMoves::GROWL],[1,PBMoves::BEATUP],
			[5,PBMoves::FURYATTACK],[9,PBMoves::BITE],[13,PBMoves::DOUBLEKICK],
			[17,PBMoves::PURSUIT],[21,PBMoves::LOWSWEEP],[24,PBMoves::AGILITY],
			[27,PBMoves::CROSSCHOP],[30,PBMoves::STEELWING],[33,PBMoves::FOCUSENERGY],
			[37,PBMoves::JUMPKICK],[41,PBMoves::AMBUSH],[47,PBMoves::BRAVEBIRD],
			[49,PBMoves::CRUNCH],[53,PBMoves::THROATCHOP],[55,PBMoves::HIJUMPKICK]],
		:Weight => 450,
		:Height => 11,
		:kind => "Beak"
	}
},

PBSpecies::HOOTHOOT => {
	:FormName => {1 => "Egho"},

	:OnCreation => proc{
		chancemaps=[333,334,335,519,520,522,525,526,527,528,530,544,551,552,573]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Egho" => {
		:DexEntry => "The crescent on its head glows brightest when the moon is full. It can confuse prey by convincing them that the moon is coming right at them when it's really just bird.",
		:Type1 => PBTypes::DARK,
		:BaseStats => [60,30,40,40,56,36],
		:EVs => [1,0,0,0,0,0],
		:Ability => [PBAbilities::UNNERVE,PBAbilities::NOGUARD],
		:Movelist => [[1,PBMoves::GROWL],[1,PBMoves::GUST],[1,PBMoves::ECHOEDVOICE],
			[5,PBMoves::HYPNOSIS],[9,PBMoves::CONFUSION],[13,PBMoves::NIGHTSHADE],
			[17,PBMoves::HORNATTACK],[21,PBMoves::NIGHTMARE],[25,PBMoves::OMINOUSWIND],
			[29,PBMoves::SNARL],[33,PBMoves::AIRSLASH],[33,PBMoves::RAZORWIND],
			[36,PBMoves::MOONBLAST],[41,PBMoves::SNATCH],[44,PBMoves::NIGHTDAZE],
			[47,PBMoves::ROOST],[51,PBMoves::DREAMEATER],[58,PBMoves::NASTYPLOT]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::DEFOG,PBMoves::ICYWIND,
				PBMoves::MIRRORMOVE,PBMoves::SKYATTACK,PBMoves::SUPERSONIC,
				PBMoves::WHIRLWIND,PBMoves::DRILLPECK,PBMoves::MOONLIGHT],
		:Weight => 235,
		:Height => 90,
		:kind => "Moon Owl"
	}
},

PBSpecies::AZURILL => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "At birth, the tip of Azurill's tail holds a pebble no larger than a grain of sand. Over time, the pebble grows into a rock too large for Azurill to carry, forcing it to evolve.",
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [50,40,30,25,20,25],
		:EVs => [1,0,0,0,0,0],
		:Ability => [PBAbilities::HUGEPOWER,PBAbilities::DRYSKIN],
		:Movelist => [[1,PBMoves::ROLLOUT],[1,PBMoves::STEALTHROCK],[1,PBMoves::FAKETEARS],
			[4,PBMoves::TACKLE],[9,PBMoves::MUDSLAP],[13,PBMoves::QUICKATTACK],
			[16,PBMoves::ROCKTHROW]],
		:EggMoves => [PBMoves::BODYSLAM,PBMoves::ENCORE,PBMoves::TAUNT,
				PBMoves::SMACKDOWN,PBMoves::WISH,PBMoves::POWERUPPUNCH],
		:Weight => 40,
		:Height => 3,
		:kind => "Pebble"
	}
},

PBSpecies::MARILL => {
	:FormName => {1 => "Egho"},

	:OnCreation => proc{
		route2=[358]
		chancemaps=[742]
		if $game_map && route2.include?($game_map.map_id)
			next 1
		elsif $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Egho" => {
		:DexEntry => "It uses its tail to swing around the rock end with ease. When not in combat, it uses the rock as a perch to see above tall grass and watch for enemies.",
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [70,50,40,40,20,30],
		:EVs => [1,0,0,0,0,0],
		:Ability => [PBAbilities::HUGEPOWER,PBAbilities::DRYSKIN],
		:Movelist => [[0,PBMoves::KARATECHOP],[1,PBMoves::ROLLOUT],[1,PBMoves::STEALTHROCK],
			[1,PBMoves::FAKETEARS],[4,PBMoves::TACKLE],[9,PBMoves::MUDSLAP],
			[13,PBMoves::QUICKATTACK],[16,PBMoves::FLAIL],[18,PBMoves::ROCKTHROW],
			[20,PBMoves::LOWKICK],[24,PBMoves::ROCKBLAST],[28,PBMoves::SUBMISSION],
			[33,PBMoves::ASSURANCE],[38,PBMoves::FLING],[42,PBMoves::ARMTHRUST],
			[46,PBMoves::DOUBLEEDGE]],
		:EggMoves => [PBMoves::BODYSLAM,PBMoves::ENCORE,PBMoves::TAUNT,
				PBMoves::SMACKDOWN,PBMoves::WISH,PBMoves::POWERUPPUNCH],
		:Weight => 150,
		:Height => 7,
		:kind => "Rock Mouse"
	}
},

PBSpecies::AZUMARILL => {
	:FormName => {1 => "Egho"},

	:OnCreation => proc{
		randomnum = rand(3)
		next randomnum==0 ? 1 : 0
 	},

	"Egho" => {
		:DexEntry => "In battle, Azumarill uses its tail as a flail or war hammer, swinging and smashing it into opponents. Outside of battle, it swings its tail fancily to attract a worthy partner.",
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [100,80,65,55,60,60],
		:EVs => [2,0,0,0,0,0],
		:Ability => [PBAbilities::HUGEPOWER,PBAbilities::DRYSKIN],
		:Movelist => [[0,PBMoves::REVERSAL],[1,PBMoves::KARATECHOP],[1,PBMoves::ROLLOUT],
			[1,PBMoves::STEALTHROCK],[1,PBMoves::FAKETEARS],[4,PBMoves::TACKLE],
			[9,PBMoves::MUDSLAP],[13,PBMoves::QUICKATTACK],[16,PBMoves::FLAIL],
			[18,PBMoves::ROCKTHROW],[21,PBMoves::LOWKICK],[26,PBMoves::ROCKBLAST],
			[32,PBMoves::SUBMISSION],[36,PBMoves::ASSURANCE],[42,PBMoves::FLING],
			[46,PBMoves::ARMTHRUST],[50,PBMoves::DOUBLEEDGE],[60,PBMoves::HAMMERARM]],
		:Weight => 460,
		:Height => 10,
		:kind => "Rock Rabbit"
	}
},

PBSpecies::SWABLU => {
	:FormName => {2 => "Egho"},

	:OnCreation => proc{
		chancemaps=[282,283,284,288,289,710,711,713,714,715,716] #Swablu from Aventurine Woods onwards
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	"Egho" => {
		:DexEntry => "Swablu tuck themselves into the cottony feathers they have to keep warm during blizzards. Flocks hum in unison as they're bundled up.",
		:Type2 => PBTypes::ICE,
		:BaseStats => [50,30,55,70,60,45],
		:EVs => [0,0,0,1,0,0],
		:Ability => [PBAbilities::LEVITATE,PBAbilities::CONTRARY],
		:Movelist => [[1,PBMoves::PECK],[1,PBMoves::GROWL],[4,PBMoves::POWDERSNOW],
			[8,PBMoves::SING],[10,PBMoves::HAZE],[11,PBMoves::RAZORWIND],
			[13,PBMoves::GUST],[15,PBMoves::WEATHERBALL],[17,PBMoves::FROSTBREATH],
			[18,PBMoves::ENTRAINMENT],[21,PBMoves::ROUND],[25,PBMoves::UPROAR],
			[25,PBMoves::HAIL],[29,PBMoves::REFRESH],[34,PBMoves::PERISHSONG],
			[39,PBMoves::COTTONGUARD],[42,PBMoves::DRAGONPULSE],[44,PBMoves::ICEBEAM],
			[45,PBMoves::ROOST],[46,PBMoves::HYPERVOICE]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::DRAGONRUSH,PBMoves::MIST,
				PBMoves::HYPERVOICE,PBMoves::POWERSWAP,PBMoves::PURSUIT,
				PBMoves::ROOST,PBMoves::STOCKPILE,PBMoves::SWALLOW,
				PBMoves::SPITUP],
		:Weight => 42,
		:Height => 4,
		:kind => "Snow Cloud"
	}
},

PBSpecies::LOTAD => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "Lotad were used to carry ingredients for chefs many years ago, eventually adapting to serve other purposes in the kitchen. Lotad is a naturally occurring stove top.",
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [40,30,40,30,50,30],
		:EVs => [0,0,0,0,1,0],
		:Ability => [PBAbilities::HARVEST,PBAbilities::DRYSKIN],
		:Movelist => [[1,PBMoves::SWEETSCENT],[1,PBMoves::MUDSLAP],[3,PBMoves::METALCLAW],
			[5,PBMoves::RECYCLE],[7,PBMoves::EMBER],[11,PBMoves::STOCKPILE],
			[13,PBMoves::REFRESH],[15,PBMoves::INCINERATE],[19,PBMoves::NATURALGIFT],
			[23,PBMoves::TEETERDANCE],[27,PBMoves::SUNNYDAY],[31,PBMoves::FLAMETHROWER],
			[35,PBMoves::IRONHEAD],[39,PBMoves::ENERGYBALL]],
		:EggMoves => [PBMoves::THUNDERPUNCH,PBMoves::SWALLOW,PBMoves::SPITUP,
				PBMoves::SPIKES,PBMoves::PETALBLIZZARD,PBMoves::SCALD,
				PBMoves::MYSTICALFIRE,PBMoves::IRONDEFENSE],
		:WildItemCommon => :SHUCABERRY,
		:WildItemUncommon => :SALACBERRY,
		:WildItemRare => :SITRUSBERRY,
		:Weight => 80,
		:Height => 6,
		:kind => "Drying Pan"
	}
},

PBSpecies::LOMBRE => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "The flat surface on top of its head sits at a constant 350 degrees Fahrenheit, making it perfect for frying almost any dish a chef could dream up.",
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [60,50,60,50,70,50],
		:EVs => [0,0,0,0,2,0],
		:Ability => [PBAbilities::HARVEST,PBAbilities::DRYSKIN],
		:Movelist => [[1,PBMoves::SWEETSCENT],[1,PBMoves::MUDSLAP],[3,PBMoves::METALCLAW],
			[5,PBMoves::RECYCLE],[7,PBMoves::EMBER],[11,PBMoves::STOCKPILE],
			[13,PBMoves::REFRESH],[14,PBMoves::BULLETPUNCH],[16,PBMoves::INCINERATE],
			[20,PBMoves::NATURALGIFT],[25,PBMoves::TEETERDANCE],[28,PBMoves::SUNNYDAY],
			[30,PBMoves::PROTECT],[34,PBMoves::FLAMETHROWER],[38,PBMoves::IRONHEAD],
			[42,PBMoves::ENERGYBALL],[44,PBMoves::AUTOTOMIZE],[46,PBMoves::AROMATHERAPY],
			[48,PBMoves::HEAVYSLAM],[50,PBMoves::FIERYDANCE],[54,PBMoves::OVERHEAT]],
		:WildItemCommon => :SHUCABERRY,
		:WildItemUncommon => :SALACBERRY,
		:WildItemRare => :SITRUSBERRY,
		:GetEvo => [[PBSpecies::LUDICOLO,PBEvolution::Item,PBItems::FIRESTONE]],
		:Weight => 735,
		:Height => 13,
		:kind => "Cook"
	}
},

PBSpecies::LUDICOLO => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "Anything cooked atop its head gains a unique flavor, which is different for each individual Ludicolo. Some restaurants main attraction is a specific Ludicolo flavoring.",
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [80,60,95,75,95,75],
		:EVs => [0,0,0,0,3,0],
		:Ability => [PBAbilities::HARVEST,PBAbilities::DRYSKIN],
		:Movelist => [[0,PBMoves::BURNUP],
			[1,PBMoves::SWEETSCENT],[1,PBMoves::MUDSLAP],[3,PBMoves::METALCLAW],
			[5,PBMoves::RECYCLE],[7,PBMoves::EMBER],[11,PBMoves::STOCKPILE],
			[13,PBMoves::REFRESH],[14,PBMoves::BULLETPUNCH],[16,PBMoves::INCINERATE],
			[20,PBMoves::NATURALGIFT],[25,PBMoves::TEETERDANCE],[28,PBMoves::SUNNYDAY],
			[30,PBMoves::PROTECT],[34,PBMoves::FLAMETHROWER],[38,PBMoves::IRONHEAD],
			[42,PBMoves::ENERGYBALL],[46,PBMoves::AROMATHERAPY],[48,PBMoves::HEAVYSLAM],
			[50,PBMoves::FIERYDANCE],[54,PBMoves::OVERHEAT]],
		:WildItemCommon => :SHUCABERRY,
		:WildItemUncommon => :SALACBERRY,
		:WildItemRare => :SITRUSBERRY,
		:Weight => 1300,
		:Height => 17,
		:kind => "Chef"
	}
},

PBSpecies::MAGNEMITE => {
	:FormName => {2 => "Egho"},

	:OnCreation => proc{
		chancemaps=[405,409,410,411]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	"Egho" => {
		:DexEntry => "An EMP caused Magnemite to lose its magnetic field, rendering it lifeless. Over time plants fused with its body bringing it back to life.",
		:Type1 => PBTypes::GRASS,
		:BaseStats => [40,80,55,45,35,70],
		:EVs => [0,1,0,0,0,1],
		:Ability => [PBAbilities::OVERGROW,PBAbilities::REGENERATOR,PBAbilities::ANALYTIC],
		:Movelist => [[1,PBMoves::TACKLE],[4,PBMoves::SUPERSONIC],[7,PBMoves::MAGICALLEAF],
			[11,PBMoves::SONICBOOM],[15,PBMoves::LEECHSEED],[18,PBMoves::VINEWHIP],
			[21,PBMoves::MAGNETBOMB],[25,PBMoves::RAZORLEAF],[29,PBMoves::METALBURST],
			[32,PBMoves::SLAM],[35,PBMoves::SEEDBOMB],[39,PBMoves::SCREECH],
			[42,PBMoves::IRONHEAD],[46,PBMoves::LOCKON],[50,PBMoves::BULLDOZE],
			[53,PBMoves::FISSURE],[57,PBMoves::AUTOTOMIZE]],
		:EggMoves => [PBMoves::METEORMASH,PBMoves::BULLETPUNCH,PBMoves::EXPLOSION,
				PBMoves::STUNSPORE,PBMoves::POISONPOWDER,PBMoves::SLEEPPOWDER,
				PBMoves::AROMATHERAPY,PBMoves::SPIKES,PBMoves::MAGNETRISE],
		:Weight => 200,
		:Height => 4,
		:kind => "Overgrown"
	}
},

PBSpecies::MAGNETON => {
	:FormName => {2 => "Egho"},

	:OnCreation => proc{
		chancemaps=[405,409,410,411]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	"Egho" => {
		:DexEntry => "Instead of attaching to each other like standard Magnemite, these Magneton are grown from their original Magnemite form.",
		:Type1 => PBTypes::GRASS,
		:BaseStats => [65,105,70,70,60,95],
		:EVs => [0,2,0,0,0,1],
		:Ability => [PBAbilities::OVERGROW,PBAbilities::REGENERATOR,PBAbilities::ANALYTIC],
		:Movelist => [[0,PBMoves::GROWTH],[1,PBMoves::MIRRORCOAT],[1,PBMoves::BARRIER],
			[1,PBMoves::TACKLE],[4,PBMoves::SUPERSONIC],[7,PBMoves::MAGICALLEAF],
			[11,PBMoves::SONICBOOM],[15,PBMoves::LEECHSEED],[18,PBMoves::VINEWHIP],
			[21,PBMoves::MAGNETBOMB],[25,PBMoves::RAZORLEAF],[29,PBMoves::METALBURST],
			[32,PBMoves::BODYSLAM],[35,PBMoves::SLAM],[38,PBMoves::SEEDBOMB],
			[42,PBMoves::SCREECH],[45,PBMoves::IRONHEAD],[47,PBMoves::HORNLEECH],
			[50,PBMoves::LOCKON],[54,PBMoves::BULLDOZE],[57,PBMoves::FISSURE],
			[62,PBMoves::AUTOTOMIZE]],
		:GetEvo => [[PBSpecies::MAGNEZONE,PBEvolution::Location,153]], #153 is Underoot
		:Weight => 900,
		:Height => 13,
		:kind => "Overgrown"
	}
},

PBSpecies::TANGELA => {
	:FormName => {4 => "Egho"},

	:OnCreation => proc{
		maps=[198]
		next $game_map && maps.include?($game_map.map_id) ? 4 : 0
 	},	

	"Egho" => {
		:DexEntry => "After its habitat was destroyed to make way for a large city, Tangela was forced to adapt by using left over wire from the maintenance tunnels for its new body.",
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [60,70,90,45,80,90],
		:EVs => [0,0,1,0,0,1],
		:Ability => [PBAbilities::VOLTABSORB,PBAbilities::MOTORDRIVE,PBAbilities::STATIC],
		:Movelist => [[1,PBMoves::BIND],[1,PBMoves::MAGNETRISE],[1,PBMoves::THUNDERSHOCK],
			[4,PBMoves::VINEWHIP],[7,PBMoves::PROTECT],[10,PBMoves::ABSORB],
			[14,PBMoves::HIDDENPOWER],[17,PBMoves::COIL],[20,PBMoves::CHARGEBEAM],
			[23,PBMoves::MEGADRAIN],[25,PBMoves::IRONHEAD],[27,PBMoves::RECOVER],
			[30,PBMoves::IRONDEFENSE],[33,PBMoves::GIGADRAIN],[35,PBMoves::DISCHARGE],
			[40,PBMoves::FLASHCANNON],[46,PBMoves::POWERWHIP],[49,PBMoves::SIMPLEBEAM],
			[53,PBMoves::AUTOTOMIZE]],
		:EggMoves => [PBMoves::POWERGEM,PBMoves::ELECTROBALL,PBMoves::EXPLOSION,
				PBMoves::FLAIL,PBMoves::HYPERBEAM,PBMoves::SPIKES,
				PBMoves::INGRAIN,PBMoves::KNOCKOFF,PBMoves::IRONDEFENSE,
				PBMoves::TAKEDOWN,PBMoves::POWERSWAP,PBMoves::BATONPASS],
		:GetEvo => [[PBSpecies::TANGROWTH,PBEvolution::Item,PBItems::THUNDERSTONE]],
		:Weight => 350,
		:Height => 10,
		:kind => "Cable"
	}
},

PBSpecies::HAPPINY => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "In order to adapt to an environment of egg-stealing predators, Happiny has become hyper-aggressive and territorial. It carries an egg-shaped rock in its pouch.",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [65,100,15,30,5,5],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::ANGERPOINT,PBAbilities::RECKLESS,PBAbilities::OWNTEMPO],
		:Movelist => [[1,PBMoves::HELPINGHAND],[1,PBMoves::KARATECHOP],[1,PBMoves::POUND],
			[1,PBMoves::FOLLOWME],[5,PBMoves::QUICKGUARD],[9,PBMoves::REFRESH],
			[12,PBMoves::DEFENSECURL],[13,PBMoves::DOUBLESLAP],[18,PBMoves::HORNATTACK],
			[22,PBMoves::ROCKTHROW],[28,PBMoves::ARMTHRUST],[32,PBMoves::BULKUP]],
		:EggMoves => [PBMoves::FEINT,PBMoves::COUNTER,PBMoves::ENDURE,
				PBMoves::REVENGE,PBMoves::HEALBELL,PBMoves::METEORMASH,
				PBMoves::LASTRESORT,PBMoves::METRONOME,PBMoves::WAKEUPSLAP,
				PBMoves::NATURALGIFT,PBMoves::BEATUP,PBMoves::BULLETPUNCH,
				PBMoves::WIDEGUARD,PBMoves::OUTRAGE],
		:Weight => 244,
		:Height => 6,
		:kind => "Territorial"
	}
},

PBSpecies::CHANSEY => {
	:FormName => {1 => "Egho"},

	:OnCreation => proc{
		randomnum = rand(3)
		next randomnum==0 ? 1 : 0
	},

	"Egho" => {
		:DexEntry => "Chansey is so obsessed with protecting eggs that it will even defend the nests of other Pokémon species. It uses its rock as a decoy egg to trick other predators.",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [105,250,35,50,5,5],
		:EVs => [0,3,0,0,0,0],
		:Ability => [PBAbilities::ANGERPOINT,PBAbilities::RECKLESS,PBAbilities::OWNTEMPO],
		:Movelist => [[0,PBMoves::POWERUPPUNCH],
			[1,PBMoves::HELPINGHAND],[1,PBMoves::KARATECHOP],[1,PBMoves::POUND],
			[1,PBMoves::FOLLOWME],[5,PBMoves::QUICKGUARD],[9,PBMoves::REFRESH],
			[12,PBMoves::DEFENSECURL],[13,PBMoves::DOUBLESLAP],[16,PBMoves::SOFTBOILED],
			[18,PBMoves::HORNATTACK],[22,PBMoves::ROCKTHROW],[24,PBMoves::TAKEDOWN],
			[28,PBMoves::ARMTHRUST],[32,PBMoves::BULKUP],[35,PBMoves::SUBMISSION],
			[41,PBMoves::EGGBOMB],[45,PBMoves::FLING],[50,PBMoves::PLAYROUGH],
			[53,PBMoves::DOUBLEEDGE],[57,PBMoves::HAMMERARM],[62,PBMoves::THRASH]],
		:EggMoves => [PBMoves::FEINT,PBMoves::COUNTER,PBMoves::ENDURE,
				PBMoves::REVENGE,PBMoves::HEALBELL,PBMoves::METEORMASH,
				PBMoves::LASTRESORT,PBMoves::METRONOME,PBMoves::WAKEUPSLAP,
				PBMoves::NATURALGIFT,PBMoves::BEATUP,PBMoves::BULLETPUNCH,
				PBMoves::WIDEGUARD,PBMoves::OUTRAGE],
		:Weight => 346,
		:Height => 11,
		:kind => "Protective"
	}
},

PBSpecies::BLISSEY => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "Because of the strong bond with their trainer, Blissey will do anything in its power to keep the trainer safe. Blissey are often considered too overbearing.",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [135,255,55,75,10,10],
		:EVs => [0,4,0,0,0,0],
		:Ability => [PBAbilities::ANGERPOINT,PBAbilities::RECKLESS,PBAbilities::OWNTEMPO],
		:Movelist => [[0,PBMoves::CROSSCHOP],[1,PBMoves::POWERUPPUNCH],
			[1,PBMoves::HELPINGHAND],[1,PBMoves::KARATECHOP],[1,PBMoves::POUND],
			[1,PBMoves::FOLLOWME],[5,PBMoves::QUICKGUARD],[9,PBMoves::REFRESH],
			[12,PBMoves::DEFENSECURL],[13,PBMoves::DOUBLESLAP],[16,PBMoves::SOFTBOILED],
			[18,PBMoves::HORNATTACK],[22,PBMoves::ROCKTHROW],[24,PBMoves::TAKEDOWN],
			[28,PBMoves::ARMTHRUST],[32,PBMoves::BULKUP],[35,PBMoves::SUBMISSION],
			[41,PBMoves::EGGBOMB],[45,PBMoves::FLING],[50,PBMoves::PLAYROUGH],
			[53,PBMoves::DOUBLEEDGE],[57,PBMoves::HAMMERARM],[62,PBMoves::THRASH]],
		:Weight => 468,
		:Height => 15,
		:kind => "Guardian"
	}
},

PBSpecies::ODDISH => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "As Oddish's habitat changed, it failed to adapt quick enough, which caused its leaves to wilt. Nowadays, these Oddish can be seen in dark caves and forests.",
		:Type1 => PBTypes::GHOST,
		:BaseStats => [45,30,65,50,75,55],
		:EVs => [0,0,0,0,1,0],
		:Ability => [PBAbilities::LEVITATE],
		:Movelist => [[1,PBMoves::MEMENTO],[1,PBMoves::TAUNT],[1,PBMoves::PROTECT],
			[1,PBMoves::CLEARSMOG],[5,PBMoves::LICK],[9,PBMoves::ACID],
			[13,PBMoves::POISONGAS],[15,PBMoves::STUNSPORE],[17,PBMoves::SLEEPPOWDER],
			[21,PBMoves::NIGHTSHADE],[25,PBMoves::OMINOUSWIND],[29,PBMoves::SLUDGEWAVE],
			[33,PBMoves::HEX],[37,PBMoves::TOXIC],[41,PBMoves::NASTYPLOT]],
		:EggMoves => [PBMoves::AFTERYOU,PBMoves::VENOSHOCK,PBMoves::MIST,
				PBMoves::INGRAIN,PBMoves::SIMPLEBEAM,PBMoves::GRUDGE,
				PBMoves::MOONLIGHT,PBMoves::SOLARBEAM,PBMoves::SPITE],
		:Weight => 34,
		:Height => 4,
		:kind => "Wilted Weed"
	}
},

PBSpecies::GLOOM => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "Despite their abiotic features, when exposed to enough light, Oddish may evolve into Gloom. Gloom use decorative skulls to scare away other Pokémon.",
		:Type1 => PBTypes::GHOST,
		:BaseStats => [60,45,90,55,85,65],
		:EVs => [0,0,0,0,2,0],
		:Ability => [PBAbilities::LEVITATE],
		:Movelist => [[0,PBMoves::VENOSHOCK],
			[1,PBMoves::MEMENTO],[1,PBMoves::TAUNT],[1,PBMoves::PROTECT],
			[1,PBMoves::CLEARSMOG],[5,PBMoves::LICK],[9,PBMoves::ACID],
			[13,PBMoves::POISONGAS],[15,PBMoves::STUNSPORE],[17,PBMoves::SLEEPPOWDER],
			[26,PBMoves::NIGHTSHADE],[30,PBMoves::OMINOUSWIND],[34,PBMoves::SLUDGEWAVE],
			[38,PBMoves::HEX],[42,PBMoves::TOXIC],[46,PBMoves::NASTYPLOT]],
		:GetEvo => [[PBSpecies::VILEDOOM,PBEvolution::HasMove,PBMoves::TOXIC],
			[PBSpecies::MORTOSSUM,PBEvolution::Happiness,0]],
		:Weight => 65,
		:Height => 7,
		:kind => "Wilted Weed"
	}
},

PBSpecies::CHIKORITA => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "Its spiky exterior protects it from predators. The spike tips are coated in a sweet and sticky substance that humans love, but most Pokémon hate.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [85,10,49,44,65,65],
		:EVs => [1,0,0,0,0,0],
		:Ability => [PBAbilities::CHLOROPHYLL,PBAbilities::REGENERATOR],
		:Movelist => [[1,PBMoves::AROMATHERAPY],[1,PBMoves::SWEETSCENT],[1,PBMoves::CHARM],
			[1,PBMoves::ABSORB],[1,PBMoves::INGRAIN],[7,PBMoves::TWISTER],
			[11,PBMoves::SLEEPPOWDER],[15,PBMoves::BIDE],[19,PBMoves::MAGICALLEAF],
			[23,PBMoves::LEECHSEED],[27,PBMoves::DRAGONBREATH],[31,PBMoves::MEGADRAIN],
			[35,PBMoves::ASSIST],[40,PBMoves::GIGADRAIN],[45,PBMoves::DRAGONPULSE],
			[50,PBMoves::ENTRAINMENT],[55,PBMoves::WEATHERBALL]],
		:EggMoves => [PBMoves::CRAFTYSHIELD,PBMoves::YAWN,
				PBMoves::COTTONSPORE,PBMoves::SPIKYSHIELD,PBMoves::WIDEGUARD,
				PBMoves::PAINSPLIT,PBMoves::LEAFSTORM,PBMoves::ENDURE,
				PBMoves::STOCKPILE,PBMoves::SWALLOW,PBMoves::SPITUP],
		:EggGroups => [:Dragon,:Grass],
		:Weight => 64,
		:Height => 11,
		:kind => "Fruit"
	}
},

PBSpecies::BAYLEEF => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "The red part of Bayleef is leathery hard, but the white bottom half of Bayleef is soft. Being vulnerable here requires it to be constantly vigilant of its surroundings.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [108,17,63,57,80,80],
		:EVs => [2,0,0,0,0,0],
		:Ability => [PBAbilities::CHLOROPHYLL,PBAbilities::REGENERATOR],
		:Movelist => [[0,PBMoves::BATONPASS],[1,PBMoves::TRIATTACK],
			[1,PBMoves::AROMATHERAPY],[1,PBMoves::SWEETSCENT],[1,PBMoves::CHARM],
			[1,PBMoves::ABSORB],[1,PBMoves::INGRAIN],[7,PBMoves::TWISTER],
			[11,PBMoves::SLEEPPOWDER],[15,PBMoves::BIDE],[22,PBMoves::MAGICALLEAF],
			[26,PBMoves::LEECHSEED],[30,PBMoves::DRAGONBREATH],[34,PBMoves::MEGADRAIN],
			[39,PBMoves::ASSIST],[44,PBMoves::GIGADRAIN],[50,PBMoves::DRAGONPULSE],
			[55,PBMoves::ENTRAINMENT],[60,PBMoves::WEATHERBALL]],
		:EggGroups => [:Dragon,:Grass],
		:Weight => 158,
		:Height => 16,
		:kind => "Fruit"
	}
},

PBSpecies::MEGANIUM => {
	:FormName => {
		1 => "Egho",
		2 => "Mega",
		3 => "Mega ZA"
	},
	
	:DefaultForm => 0,
	:MegaForm => {
		PBItems::MEGANIUMITE => 2,
		PBItems::MEGANIUMITEZA => 3
	},

	"Egho" => {
		:DexEntry => "The black dots on the white part of Meganium are seeds that get scattered around when it battles, leading to the growth of fruit-bearing trees.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [143,24,83,75,100,100],
		:EVs => [3,0,0,0,0,0],
		:Ability => [PBAbilities::CHLOROPHYLL,PBAbilities::REGENERATOR],
		:Movelist => [[0,PBMoves::SYNTHESIS],[1,PBMoves::TRIATTACK],
			[1,PBMoves::BATONPASS],[1,PBMoves::SEISMICTOSS],
			[1,PBMoves::AROMATHERAPY],[1,PBMoves::SWEETSCENT],[1,PBMoves::CHARM],
			[1,PBMoves::ABSORB],[1,PBMoves::INGRAIN],[7,PBMoves::TWISTER],
			[11,PBMoves::SLEEPPOWDER],[15,PBMoves::BIDE],[22,PBMoves::MAGICALLEAF],
			[26,PBMoves::LEECHSEED],[30,PBMoves::DRAGONBREATH],[34,PBMoves::MEGADRAIN],
			[43,PBMoves::ASSIST],[48,PBMoves::GIGADRAIN],[54,PBMoves::DRAGONPULSE],
			[60,PBMoves::ENTRAINMENT],[65,PBMoves::WEATHERBALL]],
		:EggGroups => [:Dragon,:Grass],
		:Weight => 1005,
		:Height => 23,
		:kind => "Fruit Dragon"
	},

	"Mega" => {
		:Type2 => PBTypes::FIRE,
		:BaseStats => [80,92,130,90,103,130],
		:Ability => PBAbilities::HEATGENERATOR
	},
	
	"Mega ZA" => {
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [80,92,115,80,143,115],
		:Ability => PBAbilities::THICKFAT,
		:Weight => 2010,
		:Height => 24
	}
},

PBSpecies::CYNDAQUIL => {
	:FormName => {2 => "Egho"},

	"Egho" => {
		:DexEntry => "Cyndaquil is always producing a small cloud of volcanic ash, which is electrically charged. It can be tough to handle for new trainers.",
		:Type2 => PBTypes::ELECTRIC,
		:BaseStats => [50,38,52,60,65,44],
		:EVs => [0,0,0,0,1,0],
		:Ability => [PBAbilities::STATIC,PBAbilities::CLOUDNINE],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::LEER],[6,PBMoves::SMOKESCREEN],
			[10,PBMoves::EMBER],[13,PBMoves::THUNDERSHOCK],[19,PBMoves::SPARK],
			[22,PBMoves::DEFENSECURL],[28,PBMoves::FLAMECHARGE],[31,PBMoves::SWIFT],
			[37,PBMoves::LAVAPLUME],[40,PBMoves::WILDCHARGE],[46,PBMoves::NATUREPOWER],
			[49,PBMoves::THUNDERBOLT],[55,PBMoves::HEATWAVE],[58,PBMoves::THUNDER],
			[60,PBMoves::TAILWIND]],
		:EggMoves => [PBMoves::ZAPCANNON,PBMoves::FOULPLAY,
				PBMoves::ELECTROBALL,PBMoves::SNARL,PBMoves::BOUNCE,
				PBMoves::DEFOG,PBMoves::MUDSLAP,PBMoves::FLAMEBURST],
		:Weight => 63,
		:Height => 5,
		:kind => "Ash Mouse"
	}
},

PBSpecies::QUILAVA => {
	:FormName => {2 => "Egho"},

	"Egho" => {
		:DexEntry => "As Quilava gets stronger, it is able to better control its volcanic ash cloud. It has learned to store and use the electricity generated by the cloud.",
		:Type2 => PBTypes::ELECTRIC,
		:BaseStats => [66,52,71,73,83,60],
		:EVs => [0,0,0,1,1,0],
		:Ability => [PBAbilities::STATIC,PBAbilities::CLOUDNINE],
		:Movelist => [[0,PBMoves::FLAMEWHEEL],
			[1,PBMoves::TACKLE],[1,PBMoves::LEER],[6,PBMoves::SMOKESCREEN],
			[10,PBMoves::EMBER],[13,PBMoves::THUNDERSHOCK],[20,PBMoves::SPARK],
			[23,PBMoves::DEFENSECURL],[29,PBMoves::FLAMECHARGE],[33,PBMoves::SWIFT],
			[39,PBMoves::LAVAPLUME],[42,PBMoves::WILDCHARGE],[49,PBMoves::NATUREPOWER],
			[52,PBMoves::THUNDERBOLT],[59,PBMoves::HEATWAVE],[62,PBMoves::THUNDER],
			[65,PBMoves::TAILWIND]],
		:Weight => 140,
		:Height => 9,
		:kind => "Ash Mouse"
	}
},

PBSpecies::TOTODILE => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "The saliva in Totodile's mouth is corrosive to most materials. That, combined with its strong jaw, allows it to eat almost anything it gets its mouth on.",
		:Type2 => PBTypes::POISON,
		:BaseStats => [45,56,45,69,57,42],
		:EVs => [0,0,0,1,0,0],
		:Ability => [PBAbilities::MERCILESS,PBAbilities::SPEEDBOOST],
		:Movelist => [[1,PBMoves::AGILITY],[1,PBMoves::POISONSTING],[1,PBMoves::MUDSLAP],
			[6,PBMoves::WATERGUN],[8,PBMoves::ACID],[13,PBMoves::CRUSHCLAW],
			[15,PBMoves::TOXICSPIKES],[20,PBMoves::WATERPULSE],[22,PBMoves::SUPERFANG],
			[27,PBMoves::CROSSCHOP],[29,PBMoves::MUDSHOT],[34,PBMoves::LEECHLIFE],
			[36,PBMoves::AQUATAIL],[41,PBMoves::MUDDYWATER],[43,PBMoves::JUMPKICK],
			[48,PBMoves::SLUDGEBOMB],[50,PBMoves::HYDROPUMP]],
		:EggMoves => [PBMoves::ACIDSPRAY,PBMoves::AQUAJET,PBMoves::AURASPHERE,
				PBMoves::CRUNCH,PBMoves::ACIDARMOR,PBMoves::POISONFANG,
				PBMoves::BATONPASS,PBMoves::THUNDERFANG,PBMoves::RAPIDSPIN],
		:Weight => 95,
		:Height => 6,
		:kind => "Big Jaw"
	}
},

PBSpecies::CROCONAW => {
	:FormName => {1 => "Egho"},

	"Egho" => {
		:DexEntry => "Croconaw's hunched stance appears to be an adaptation to traversing cramped sewer tunnels. Rattata and Grimer are not safe in its territory.",
		:Type2 => PBTypes::POISON,
		:BaseStats => [65,70,59,87,70,54],
		:EVs => [0,0,0,1,1,0],
		:Ability => [PBAbilities::MERCILESS,PBAbilities::SPEEDBOOST],
		:Movelist => [[0,PBMoves::SLUDGE],[1,PBMoves::POISONTAIL],
			[1,PBMoves::AGILITY],[1,PBMoves::POISONSTING],[1,PBMoves::MUDSLAP],
			[6,PBMoves::WATERGUN],[8,PBMoves::ACID],[13,PBMoves::CRUSHCLAW],
			[15,PBMoves::TOXICSPIKES],[23,PBMoves::WATERPULSE],[25,PBMoves::SUPERFANG],
			[31,PBMoves::CROSSCHOP],[33,PBMoves::MUDSHOT],[39,PBMoves::LEECHLIFE],
			[42,PBMoves::AQUATAIL],[48,PBMoves::MUDDYWATER],[50,PBMoves::JUMPKICK],
			[55,PBMoves::SLUDGEBOMB],[57,PBMoves::HYDROPUMP]],
		:Weight => 250,
		:Height => 11,
		:kind => "Big Jaw"
	}
},

PBSpecies::FERALIGATR => {
	:FormName => {
		1 => "Egho",
		2 => "Mega",
		3 => "Mega ZA"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::FERALIGATITE => 2,
		PBItems::FERALIGITE => 3
	},
	
	"Egho" => {
		:DexEntry => "Feraligatr thrives in the dark murky waters of swamps and sewers. They cause problems in sewers because their strong jaws can rip through pipes with ease.",
		:Type2 => PBTypes::POISON,
		:BaseStats => [75,95,70,121,103,66],
		:EVs => [0,0,0,2,1,0],
		:Ability => [PBAbilities::MERCILESS,PBAbilities::SPEEDBOOST],
		:Movelist => [[0,PBMoves::POISONFANG],[1,PBMoves::SLUDGE],[1,PBMoves::POISONTAIL],
			[1,PBMoves::AGILITY],[1,PBMoves::POISONSTING],[1,PBMoves::MUDSLAP],
			[6,PBMoves::WATERGUN],[8,PBMoves::ACID],[13,PBMoves::CRUSHCLAW],
			[15,PBMoves::TOXICSPIKES],[23,PBMoves::WATERPULSE],[25,PBMoves::SUPERFANG],
			[32,PBMoves::CROSSCHOP],[36,PBMoves::MUDSHOT],[43,PBMoves::LEECHLIFE],
			[46,PBMoves::AQUATAIL],[53,PBMoves::MUDDYWATER],[56,PBMoves::JUMPKICK],
			[62,PBMoves::SLUDGEBOMB],[65,PBMoves::HYDROPUMP],[70,PBMoves::VENOMSWIPE],[75,PBMoves::GUNKSHOT]],
		:Weight => 888,
		:Height => 23,
		:kind => "Gaping Jaw"
	},

	"Mega" => {
		:Type2 => PBTypes::DARK,
		:BaseStats => [85,135,120,98,99,93],
		:Ability => PBAbilities::SHEERFORCE
	},
	
	"Mega ZA" => {
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [85,160,125,78,89,93],
		:Ability => PBAbilities::STRONGJAW,
		:Weight => 1088
	}
},


PBSpecies::MISSINGNO2 => {
	:FormName => {
		1 => "Snalo",
		2 => "Hantama",
		3 => "Aurostice",
		4 => "Skarbinger",
		5 => "Nemea",
		6 => "Doodloo",
		7 => "Tortove",
		8 => "Asphere",
		9 => "Raygoten",
		10 => "Doomsday",
		11 => "Arukida",
		12 => "Gigagigearth",
		13 => "Fungwar",
		14 => "Laperouse",
		15 => "Acretto",
		16 => "Diablos",
		17 => "Glamarde",
		18 => "Demorigan",
		19 => "Rasenmai",
		20 => "Coronet",
		21 => "M-Devimon",
		22 => "Megadramon",
		23 => "Crescemon",
		24 => "A-Mermaimon",
		25 => "Beelzebumon",
		26 => "A-Beetlemon",
		27 => "M-Seadramon",
		28 => "Armagemon",
		29 => "Omegamon",
		30 => "Z-Milleniumon",
		31 => "Ad-Yuyuko",
		32 => "S-Sariel",
		33 => "A-Flandre",
		34 => "A-Patchouli",
		35 => "D-Satori",
		36 => "Shion",
		37 => "X-Tenshi",
		38 => "X-Utsuho",
		39 => "X-Suwako",
		40 => "Ex-Marisa",
		41 => "Angeallen",
		42 => "Angeallen2",
		43 => "Diablos-Basic",
		44 => "Diablos-Natural",
		45 => "Diablos-Mountain",
		46 => "Diablos-Grassland",
		47 => "Shingyoku-o",
		48 => "Shingyoku-f",
		49 => "Shingyoku-m",
		50 => "Asphere-Altair",
		51 => "Asphere-Sirius",
		52 => "Asphere-Vega"
	},
	"Snalo" => {
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::WATER,
		:BaseStats => [65,25,120,80,85,110],
		#Stats of Serplant
		:Ability => [PBAbilities::WATERABSORB]
	},
	"Hantama" => {
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [60,115,70,95,65,50],
		:Ability => [PBAbilities::INTIMIDATE]
	},
	"Aurostice" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [80,70,75,100,120,85],
		:Ability => [PBAbilities::PIXILATE]
	},
	"Skarbinger" => {
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [70,100,160,100,40,85],
		:Ability => [PBAbilities::STURDY]
	},
	"Nemea" => {
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::POISON,
		:BaseStats => [111,184,106,84,95,123],
		:Ability => [PBAbilities::FLASHFIRE]
		#Clone
	},
	"Doodloo" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [85,184,73,157,51,96],
		:Ability => [PBAbilities::PUREPOWER]
		#Clone
	},
	"Tortove" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::ROCK,
		:BaseStats => [85,105,160,20,95,80],
		:Ability => [PBAbilities::DROUGHT]
	},
	"Asphere" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [100,155,111,179,201,111],
		:Ability => [PBAbilities::COMPOUNDEYES]
		#Clone
	},
	"Raygoten" => {
		:Type1 => PBTypes::FLYING,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [85,120,80,125,60,80],
		:Ability => [PBAbilities::ADAPTABILITY]
	},
	"Doomsday" => {
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [200,120,200,20,20,200],
		:Ability => [PBAbilities::UNAWARE]
	},
	"Arukida" => {
		:Type1 => PBTypes::BUG,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [88,120,112,80,50,90],
		:Ability => [PBAbilities::HUSTLE]
	},
	"Gigagigearth" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::ROCK,
		:BaseStats => [100,134,94,87,75,110],
		:Ability => [PBAbilities::MOLDBREAKER]
	},
	"Fungwar" => {
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [90,130,90,100,90,120],
		:Ability => [PBAbilities::SPEEDBOOST]
	},
	"Laperouse" => {
		:Type1 => PBTypes::DRAGON,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [90,90,95,90,135,100],
		:Ability => [PBAbilities::AERILATE]
	},
	"Acretto" => {
		:Type1 => PBTypes::BUG,
		:Type2 => PBTypes::ROCK,
		:BaseStats => [145,105,130,50,50,100],
		:Ability => [PBAbilities::SOLIDROCK]
	},
	"Diablos" => {
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::DARK,
		:BaseStats => [140,80,100,150,150,120], #720
		:Ability => [PBAbilities::LEVITATE]
	},
	"Glamarde" => {
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [108,35,125,40,80,130],
		:Ability => [PBAbilities::TRACE]
	},
	"Demorigan" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [80,130,90,106,100,94],
		:Ability => [PBAbilities::MULTISCALE]
	},
	"Rasenmai" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::POISON,
		:BaseStats => [90,115,110,45,70,135],
		:Ability => [PBAbilities::ANALYTIC]
	},
	"Coronet" => {
		:Type1 => PBTypes::FAIRY,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [85,50,105,100,135,75],
		:Ability => [PBAbilities::LEVITATE]
	},
	"M-Devimon" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::DARK,
		:BaseStats => [100,145,80,85,80,130],
		:Ability => [PBAbilities::STAKEOUT]
	},
	"Megadramon" => {
		:Type1 => PBTypes::DRAGON,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [90,145,120,90,85,90],
		:Ability => [PBAbilities::TECHNICIAN]
	},
	"Crescemon" => {
		:Type1 => PBTypes::FAIRY,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [95,130,110,80,85,120],
		:Ability => [PBAbilities::SHARPNESS]
	},
	"A-Mermaimon" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::WATER,
		:BaseStats => [100,80,100,130,170,135],
		:Ability => [PBAbilities::TORRENT]
	},
	"Beelzebumon" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK,
		:BaseStats => [100,90,120,160,160,120],
		:Ability => [PBAbilities::MEGALAUNCHER]
	},
	"A-Beetlemon" => {
		:Type1 => PBTypes::BUG,
		:Type2 => PBTypes::ELECTRIC,
		:BaseStats => [115,180,140,80,85,120],
		:Ability => [PBAbilities::TERAVOLT]
	},
	"M-Seadramon" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [100,80,95,130,170,140],
		:Ability => [PBAbilities::STEELWORKER]
	},
	"Armagemon" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK,
		:BaseStats => [180,110,145,40,180,145],
		:Ability => [PBAbilities::UNAWARE]
	},
	"Omegamon" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::ICE,
		:BaseStats => [110,165,105,150,165,105],
		:Ability => [PBAbilities::DOWNLOAD,PBAbilities::STELLAREAN]
	},
	"Z-Milleniumon" => {
		:Type1 => PBTypes::QMARKS,
		:Type2 => PBTypes::QMARKS,
		:BaseStats => [250,200,250,0,200,250],
		:Ability => [PBAbilities::MAGICBOUNCE]
	},
	"Ad-Yuyuko" => {
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [150,50,180,60,180,100],
		:Ability => [PBAbilities::LEVITATE]
	},
	"S-Sariel" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [80,70,70,120,140,80],
		:Ability => [PBAbilities::DARKAURA]
	},
	"A-Flandre" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [50,170,75,95,105,65],
		:Ability => [PBAbilities::HUSTLE]
	},
	"A-Patchouli" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::WATER,
		:BaseStats => [60,30,50,60,160,160],
		:Ability => [PBAbilities::WATERBUBBLE]
	},
	"D-Satori" => {
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::PSYCHIC,
		:BaseStats => [220,60,65,60,60,65],
		:Ability => [PBAbilities::SHADOWTAG]
	},
	"Shion" => {
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [140,45,95,70,100,100],
		:Ability => [PBAbilities::LEVITATE]
	},
	"X-Tenshi" => {
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [150,90,160,30,90,160],
		:Ability => [PBAbilities::SANDSTREAM]
	},
	"X-Utsuho" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [95,105,85,125,175,85],
		:Ability => [PBAbilities::DESOLATELAND]
	},
	"X-Suwako" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [115,160,105,85,105,100],
		:Ability => [PBAbilities::PRIMORDIALSEA]
	},
	"Ex-Marisa" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [10,200,65,180,200,65],
		:Ability => [PBAbilities::PRESSURE]
	},
	"Angeallen" => {
		:Type1 => PBTypes::DRAGON,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [120,120,120,120,120,120],
		:Ability => [PBAbilities::DELTASTREAM]
	},
	"Angeallen2" => {
		:Type1 => PBTypes::DRAGON,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [120,180,150,160,100,150],
		:Ability => [PBAbilities::DELTASTREAM]
	},
	"Diablos-Basic" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK,
		:BaseStats => [80,80,80,80,80,80], #480
		:Ability => [PBAbilities::CLEARBODY]
	},
	"Diablos-Natural" => {
		:Type1 => PBTypes::FLYING,
		:Type2 => PBTypes::DARK,
		:BaseStats => [130,80,100,90,90,110], #600
		:Ability => [PBAbilities::SPEEDBOOST]
	},
	"Diablos-Mountain" => {
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::DARK,
		:BaseStats => [135,80,100,115,115,115], #660
		:Ability => [PBAbilities::BERSERK]
	},
	"Diablos-Grassland" => {
		:Type1 => PBTypes::BUG,
		:Type2 => PBTypes::DARK,
		:BaseStats => [135,80,100,115,115,115], #660
		:Ability => [PBAbilities::BLOODLUST]
	},
	"Shingyoku-o" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::ICE,
		:BaseStats => [80,120,60,100,120,60],
		:Ability => [PBAbilities::ADAPTABILITY]
	},
	"Shingyoku-f" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [80,45,100,45,100,170],
		:Ability => [PBAbilities::TELEPATHY]
	},
	"Shingyoku-m" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE,
		:BaseStats => [80,45,170,45,100,100],
		:Ability => [PBAbilities::TELEPATHY]
	},
	"Asphere-Altair" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [100,140,100,130,150,100],
		:Ability => [PBAbilities::MARVELSCALE]
	},
	"Asphere-Sirius" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [100,100,120,130,150,120],
		:Ability => [PBAbilities::MARVELSCALE]
	},
	"Asphere-Vega" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [100,120,110,130,150,110],
		:Ability => [PBAbilities::MARVELSCALE]
	}
},

PBSpecies::FURFROU => {
		:FormName => {
			1 => "Star",
			2 => "Heart",
			3 => "Pharaoh",
			4 => "Matron",
			5 => "Dandy",
			6 => "Kabuki",
			7 => "La Reine",
			8 => "Debutante",
			9 => "Diamond",
		},
		"Star" => {
			:Type2 => PBTypes::ELECTRIC,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
				[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
				[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
				[48,PBMoves::RETALIATE],[72,PBMoves::WILDCHARGE]]
		},
		"Heart" => {
			:Type2 => PBTypes::PSYCHIC,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::PSYCHICFANGS]]
		},
		"Pharaoh" => {
			:Type2 => PBTypes::GHOST,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::SHADOWBONE]]
		},
		"Matron" => {
			:Type2 => PBTypes::POISON,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::GUNKSHOT]]
		},
		"Dandy" => {
			:Type2 => PBTypes::DARK,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::KNOCKOFF]]
		},
		"Kabuki" => {
			:Type2 => PBTypes::FIGHTING,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::HIJUMPKICK]]
		},
		"La Reine" => {
			:Type2 => PBTypes::WATER,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::AQUATAIL]]
		},
		"Debutante" => {
			:Type2 => PBTypes::FAIRY,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::PLAYROUGH]]
		},
		"Diamond" => {
			:Type2 => PBTypes::ROCK,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::STONEEDGE]]
		},
},

PBSpecies::PETILIL => {
	:FormName => {
		6 => "Celestial",
		7 => "Cosmic",
		9 => "Delta1",
		10 => "Delta2"
	},

	:OnCreation => proc{
		mapCelestial=[335] # Map IDs for Celestial form
		mapCosmic=[305]
		mapDelta2=[755]
		mapDelta1=[756]
		if $game_map && mapCelestial.include?($game_map.map_id)
			next 6
		elsif $game_map && mapCosmic.include?($game_map.map_id)
			next 7
		elsif $game_map && mapDelta1.include?($game_map.map_id)
			next 9
		elsif $game_map && mapDelta2.include?($game_map.map_id)
			next 10
		else
			next 0
		end
	},

	"Celestial" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FLYING,
		:Type2 => PBTypes::DARK,
		:BaseStats => [55,65,60,60,50,50],
		:Ability => [PBAbilities::CHLOROPHYLL,PBAbilities::DRIZZLE,PBAbilities::AERILATE],
		:Movelist => [[1,PBMoves::ABSORB],[1,PBMoves::PECK],[4,PBMoves::GROWTH],[8,PBMoves::LEECHSEED],[10,PBMoves::SLEEPPOWDER],[13,PBMoves::MEGADRAIN],[17,PBMoves::SYNTHESIS],[19,PBMoves::MAGICALLEAF],[22,PBMoves::STUNSPORE],[26,PBMoves::GIGADRAIN],[28,PBMoves::AROMATHERAPY],[31,PBMoves::HELPINGHAND],[35,PBMoves::ENERGYBALL],[37,PBMoves::ENTRAINMENT],[40,PBMoves::SUNNYDAY],[44,PBMoves::AFTERYOU],[46,PBMoves::LEAFSTORM]]
	},
	"Cosmic" => {
		:DexEntry => "Although appearing to be a form of Petilil this Pokémon was first found in a meteor crash site similar to solrock and lunatone. Very little is known about it other than it likes to nest in Crystal caves and often looks up towards the stars at night.",
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::BUG,
		:BaseStats => [110,30,70,15,20,70], #? Cosmic adds +35 to BST
		:Ability => [PBAbilities::STURDY,PBAbilities::HUSTLE,PBAbilities::SKILLLINK],
		:Movelist => [[0,PBMoves::COSMICBARRAGE],[1,PBMoves::COSMICBARRAGE],[1,PBMoves::ABSORB],[5,PBMoves::LEAFAGE],
					 [9,PBMoves::STUNSPORE],[12,PBMoves::IRONDEFENSE],[15,PBMoves::POISONPOWDER],[15,PBMoves::TWINEEDLE],[15,PBMoves::MEGADRAIN],[15,PBMoves::ROCKPOLISH],[17,PBMoves::WIDEGUARD],[18,PBMoves::BULLETSEED],[20,PBMoves::BUGBITE],[21,PBMoves::GIGADRAIN],[21,PBMoves::LEECHLIFE],[21,PBMoves::ENERGYBALL],[25,PBMoves::ROCKBLAST],[25,PBMoves::POWERGEM],[25,PBMoves::FURYCUTTER],[28,PBMoves::QUIVERDANCE],[29,PBMoves::SLEEPPOWDER],[30,PBMoves::FELLSTINGER],[30,PBMoves::ASTRALSHOT],[30,PBMoves::ROCKSLIDE],[34,PBMoves::VICTORYDANCE],[35,PBMoves::ACCELEROCK],[37,PBMoves::LEAFBLADE],[37,PBMoves::RECOVER],[45,PBMoves::COSMICRAY],[47,PBMoves::LEAFSTORM],[48,PBMoves::STEAMROLLER],[50,PBMoves::METEORBEAM],[50,PBMoves::FIRSTIMPRESSION],[53,PBMoves::PETALDANCE],[55,PBMoves::MINIMIZE],[55,PBMoves::STONEEDGE],[57,PBMoves::CLOSECOMBAT],[60,PBMoves::DECRYSTALLIZATION],[65,PBMoves::COMETSHOWER],[100,PBMoves::DIAMONDSTORM]]
	},
	"Delta1" => {
		:DexEntry => "A Delta Species discovered by Steads42. It can be seen from within submarines, frolicking along the deep sea floor.",
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [45,35,50,30,70,50],
		:Ability => [PBAbilities::STORMDRAIN,PBAbilities::FLASHFIRE,PBAbilities::REGENERATOR],
		:Movelist => [[1,PBMoves::BUBBLE],[4,PBMoves::ACIDARMOR],[8,PBMoves::AQUARING],[10,PBMoves::MIST],[13,PBMoves::EMBER],[17,PBMoves::RECOVER],[19,PBMoves::BUBBLEBEAM],[22,PBMoves::WILLOWISP],[26,PBMoves::FLAMEBURST],[28,PBMoves::REFLECTTYPE],[31,PBMoves::PROTECT],[35,PBMoves::SCALD],[37,PBMoves::ENTRAINMENT],[40,PBMoves::RAINDANCE],[44,PBMoves::AFTERYOU],[46,PBMoves::MYSTICALFIRE]],
		:EggMoves => [PBMoves::ACIDARMOR,PBMoves::BUBBLEBEAM,PBMoves::ENTRAINMENT,PBMoves::FLAMEBURST,PBMoves::MIST,PBMoves::MYSTICALFIRE,PBMoves::REFLECTTYPE,PBMoves::ACID,PBMoves::AFTERYOU,PBMoves::AQUATAIL,PBMoves::BIND,PBMoves::EARTHPOWER,PBMoves::ENDEAVOR,PBMoves::ENDURE,PBMoves::GASTROACID,PBMoves::GIGADRAIN,PBMoves::HEALBELL,PBMoves::HEATWAVE,PBMoves::MAGICCOAT,PBMoves::MIMIC,PBMoves::PAINSPLIT,PBMoves::SIGNALBEAM,PBMoves::SNORE,PBMoves::SPITE,PBMoves::WATERPULSE,PBMoves::WHIRLPOOL]
	},
	"Delta2" => {
		:DexEntry => "A Delta Species discovered by shadowsofme. It gracefully descends upon weary travelers, restoring their morale and energy in the process.",
		:Type1 => PBTypes::FAIRY,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [45,35,50,30,70,50],
		:Ability => [PBAbilities::SERENEGRACE,PBAbilities::SYNCHRONIZE,PBAbilities::HEALER],
		:Movelist => [[1,PBMoves::FAIRYWIND],[4,PBMoves::BABYDOLLEYES],[8,PBMoves::FEATHERDANCE],[10,PBMoves::CHARM],[13,PBMoves::GUST],[17,PBMoves::ROOST],[19,PBMoves::DISARMINGVOICE],[22,PBMoves::WHIRLWIND],[26,PBMoves::AIRCUTTER],[28,PBMoves::DEFOG],[31,PBMoves::MISTYTERRAIN],[35,PBMoves::DAZZLINGGLEAM],[37,PBMoves::ENTRAINMENT],[40,PBMoves::TAILWIND],[44,PBMoves::AFTERYOU],[46,PBMoves::HURRICANE]],
		:EggMoves => [PBMoves::BABYDOLLEYES,PBMoves::CHARM,PBMoves::DISARMINGVOICE,PBMoves::ENTRAINMENT,PBMoves::MISTYTERRAIN,PBMoves::WHIRLWIND,PBMoves::ACID,PBMoves::AFTERYOU,PBMoves::AIRCUTTER,PBMoves::AURASPHERE,PBMoves::BOUNCE,PBMoves::DEFOG,PBMoves::ENDEAVOR,PBMoves::ENDURE,PBMoves::HEALBELL,PBMoves::HEATWAVE,PBMoves::HELPINGHAND,PBMoves::HURRICANE,PBMoves::HYPERVOICE,PBMoves::ICYWIND,PBMoves::LASTRESORT,PBMoves::MAGICCOAT,PBMoves::MAGICROOM,PBMoves::MIMIC,PBMoves::ROLEPLAY,PBMoves::SKYATTACK,PBMoves::SNORE,PBMoves::SWIFT,PBMoves::TAILWIND,PBMoves::TWISTER,PBMoves::WONDERROOM]
	}
},

PBSpecies::LILLIGANT => {
	:FormName => {
		1 => "Dev",
		2 => "Hisui",
		3 => "Alolan A",
		4 => "Alolan B",
		5 => "Rebornian",
		6 => "Celestial",
		7 => "Cosmic",
		8 => "Paldean",
		9 => "Delta1",
		10 => "Delta2",
		11 => "TOTEM",
		12 => "Galarian",
		13 => "Mega",
		14 => "NeoN"
	},

	:DefaultForm => 0,
	:MegaForm => 13,

	"Dev" => {
		:Ability => PBAbilities::SIMPLE
	},
	"Hisui" => {
		:DexEntry => "I suspect that its well-developed legs are the result of a life spent on mountains covered in deep snow. The scent it exudes from its flower crown heartens those in proximity.",
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [70,105,75,105,50,75],
		:Ability => [PBAbilities::CHLOROPHYLL,PBAbilities::LEAFGUARD,PBAbilities::HUSTLE,PBAbilities::LIFEFORCE,PBAbilities::STRONGHEEL],
		:Movelist => [[0,PBMoves::ROCKSMASH],[1,PBMoves::FOCUSENERGY],[1,PBMoves::TEETERDANCE],
			[1,PBMoves::ROCKSMASH],[1,PBMoves::ABSORB],[4,PBMoves::GROWTH],[8,PBMoves::LEAFAGE],
			[10,PBMoves::LEECHSEED],[13,PBMoves::STUNSPORE],[15,PBMoves::POISONPOWDER],
			[17,PBMoves::SLEEPPOWDER],[19,PBMoves::MEGADRAIN],[21,PBMoves::HELPINGHAND],[23,PBMoves::SYNTHESIS],
			[25,PBMoves::DEFOG],[27,PBMoves::AFTERYOU],[29,PBMoves::MAGICALLEAF],[31,PBMoves::CHARM],
			[33,PBMoves::MEGAKICK],[35,PBMoves::AROMATHERAPY],[37,PBMoves::GIGADRAIN],[39,PBMoves::DRAINPUNCH],
			[41,PBMoves::SUNNYDAY],[43,PBMoves::ENERGYBALL],[45,PBMoves::ENTRAINMENT],[47,PBMoves::LEAFBLADE],
			[49,PBMoves::RECOVER],[51,PBMoves::PETALBLIZZARD],[51,PBMoves::PETALDANCE],
			[53,PBMoves::VICTORYDANCE],[55,PBMoves::AXEKICK],[57,PBMoves::LEAFSTORM],[59,PBMoves::CLOSECOMBAT],
			[61,PBMoves::SOLARBLADE]],
		:Weight => 192,
		:Height => 12
	},
	"Alolan A" => {
		:DexEntry => "The love for sunbathing has made it possible to sustain increadibly high and harsh temperatures. The scent it exudes from its ever-burning flower is told to be reinvigorating.",
		:Type2 => PBTypes::FIRE,
		:BaseStats => [70,50,70,120,105,65],
		:Ability => [PBAbilities::DROUGHT,PBAbilities::SOLARPOWER,PBAbilities::ALOLANTECHNIQUESA],
		:Movelist => [[0,PBMoves::FIERYDANCE],[1,PBMoves::FIERYDANCE],[1,PBMoves::ABSORB],[5,PBMoves::EMBER],
					 [9,PBMoves::WILLOWISP],[15,PBMoves::POISONPOWDER],[15,PBMoves::MEGADRAIN],[17,PBMoves::INCINERATE],
					 [21,PBMoves::GIGADRAIN],[21,PBMoves::FLAMETHROWER],[28,PBMoves::QUIVERDANCE],[28,PBMoves::VICTORYDANCE],
					 [29,PBMoves::FLAMEBURST],[37,PBMoves::SYNTHESIS],[42,PBMoves::LAVAPLUME],[42,PBMoves::ENERGYBALL],
					 [46,PBMoves::PETALDANCE],[50,PBMoves::MYSTICALFIRE],[50,PBMoves::PETALBLIZZARD],
					 [55,PBMoves::FIREBLAST],[70,PBMoves::INFERNO],[80,PBMoves::INFERNALFIREBLAST],[80,PBMoves::INFERNALWATERBLAST],[80,PBMoves::LEAFSTORM]],
		:Weight => 154,
		:Height => 11
	},
	"Alolan B" => {
		:DexEntry => "The love for sunbathing has made it possible to sustain increadibly high and harsh temperatures. The scent it exudes from its ever-bubbling flower is told to be reinvigorating.",
		:Type2 => PBTypes::WATER,
		:BaseStats => [70,50,65,105,120,70],
		:Ability => [PBAbilities::DRIZZLE,PBAbilities::REGENERATOR,PBAbilities::ALOLANTECHNIQUESB],
		:Movelist => [[0,PBMoves::FIERYDANCE],[1,PBMoves::FIERYDANCE],[1,PBMoves::ABSORB],[5,PBMoves::EMBER],
					 [9,PBMoves::WILLOWISP],[15,PBMoves::POISONPOWDER],[15,PBMoves::MEGADRAIN],[17,PBMoves::WATERPULSE],
					 [21,PBMoves::GIGADRAIN],[21,PBMoves::BUBBLEBEAM],[28,PBMoves::QUIVERDANCE],[28,PBMoves::VICTORYDANCE],
					 [29,PBMoves::HYDROPUMP],[37,PBMoves::SYNTHESIS],[42,PBMoves::AQUARING],[42,PBMoves::ENERGYBALL],
					 [46,PBMoves::PETALDANCE],[50,PBMoves::SCALD],[50,PBMoves::PETALBLIZZARD],
					 [55,PBMoves::FIREBLAST],[70,PBMoves::INFERNO],[80,PBMoves::INFERNALFIREBLAST],[80,PBMoves::INFERNALWATERBLAST],[80,PBMoves::LEAFSTORM]],
		:Weight => 154,
		:Height => 11
	},
	"Galarian" => {
		:DexEntry => "The mysterious energy cointaned in the various Dens that can be found in Galar have given this Pokèmon the ability to artistically paint anything and anyone.",
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [80,80,80,80,80,80],
		:Ability => [PBAbilities::INTERFERENCE,PBAbilities::PERVASIVENESS,PBAbilities::TRAITINHERITANCE],
		:Movelist => [[1,PBMoves::DOODLE],[1,PBMoves::SKETCH],[11,PBMoves::SKETCH],[21,PBMoves::SKETCH],[31,PBMoves::SKETCH],[41,PBMoves::SKETCH],[51,PBMoves::SKETCH],[61,PBMoves::SKETCH],[71,PBMoves::SKETCH],[81,PBMoves::SKETCH],[91,PBMoves::SKETCH]],
		:Weight => 192,
		:Height => 12
	},
	"Paldean" => {
		:DexEntry => "From enjoying sunbathing, to dancing under the sun. The researchers think this species was influenced by the folklore of the place it comes from, thus evolving into the skillful dance it is nowadays.",
		:Type2 => PBTypes::FAIRY,
		:Type1 => PBTypes::FIGHTING,
		:BaseStats => [80,75,85,110,50,80],
		:Ability => [PBAbilities::TRIAGE,PBAbilities::HUGEPOWER,PBAbilities::GRANDIOSE],
		:Movelist => [[0,PBMoves::ROCKSMASH],[1,PBMoves::ROCKSMASH],[1,PBMoves::SHADOWSNEAK],[1,PBMoves::FAKEOUT],[1,PBMoves::ABSORB],[5,PBMoves::LEAFAGE],[9,PBMoves::STUNSPORE],[14,PBMoves::FEINT],[15,PBMoves::POISONPOWDER],[15,PBMoves::MEGADRAIN],[15,PBMoves::POWERUPPUNCH],[21,PBMoves::GIGADRAIN],[21,PBMoves::FUTURESIGHT],[23,PBMoves::PLAYROUGH],[25,PBMoves::DAZZLINGGLEAM],[28,PBMoves::QUIVERDANCE],[29,PBMoves::SLEEPPOWDER],[34,PBMoves::DRAINPUNCH],[35,PBMoves::PSYCHOCUT],[37,PBMoves::LEAFBLADE],[37,PBMoves::RECOVER],[42,PBMoves::VICTORYDANCE],[43,PBMoves::NIGHTSLASH],[47,PBMoves::LEAFSTORM],[53,PBMoves::PETALDANCE],[56,PBMoves::MOONBLAST],[57,PBMoves::CLOSECOMBAT],[70,PBMoves::KNOCKOFF],[77,PBMoves::DESTINYBOND],[84,PBMoves::QUICKGUARD],[84,PBMoves::WIDEGUARD],[91,PBMoves::SPIRITBREAK]],
		:Weight => 192,
		:Height => 12
	},
	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [85,50,85,100,100,80],
		:Ability => [PBAbilities::SNOWWARNING,PBAbilities::SERENEGRACE,PBAbilities::PETRIFY],
		:Movelist => [[0,PBMoves::FREEZEDRY],[1,PBMoves::FREEZEDRY],[1,PBMoves::WILLOWISP],[5,PBMoves::POWDERSNOW],
					 [9,PBMoves::CONFUSERAY],[13,PBMoves::NIGHTSHADE],[15,PBMoves::POISONPOWDER],[15,PBMoves::VENOMDRENCH],
					 [15,PBMoves::HAIL],[17,PBMoves::TRIATTACK],[21,PBMoves::HEX],[21,PBMoves::ICYWIND],
					 [28,PBMoves::QUIVERDANCE],[28,PBMoves::VICTORYDANCE],[29,PBMoves::FROSTBREATH],[37,PBMoves::SYNTHESIS],
					 [40,PBMoves::OMINOUSWIND],[42,PBMoves::ENERGYBALL],[42,PBMoves::SHADOWBALL],[46,PBMoves::PETALDANCE],
					 [50,PBMoves::SLUDGEBOMB],[50,PBMoves::PETALBLIZZARD],[55,PBMoves::BLIZZARD],[60,PBMoves::ANCIENTICESHARD],[60,PBMoves::MIDNIGHTPHOTOSYNTHESIS],[70,PBMoves::LASTRESPECTS],[90,PBMoves::BOOMBURST],[100,PBMoves::SHEERCOLD]],
		:Weight => 235,
		:Height => 14
	},
	"Celestial" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FLYING,
		:Type2 => PBTypes::DARK,
		:BaseStats => [85,100,90,100,85,80], #? Celestial adds +60 to BST
		:Ability => [PBAbilities::AERILATE,PBAbilities::DRIZZLE,PBAbilities::CELESTIALAURA,PBAbilities::CELESTIALREINCARNATION],
		:Movelist => [[0,PBMoves::FEATHERDANCE],[0,PBMoves::FURYSWIPES],[0,PBMoves::FURYATTACK],[1,PBMoves::FEATHERDANCE],
					[1,PBMoves::ABSORB],[1,PBMoves::ENDEAVOR],[1,PBMoves::QUICKATTACK],[1,PBMoves::SUCKERPUNCH],[1,PBMoves::PECK],[5,PBMoves::AERIALACE],[5,PBMoves::FAKEOUT],[5,PBMoves::FALSESWIPE],[9,PBMoves::STUNSPORE],[10,PBMoves::TRIATTACK],[10,PBMoves::SLASH],[15,PBMoves::POISONPOWDER],[15,PBMoves::DEFOG],[15,PBMoves::THROATCHOP],[18,PBMoves::BULLETSEED],[18,PBMoves::BARRAGE],[18,PBMoves::ROCKBLAST],[18,PBMoves::PINMISSILE],[18,PBMoves::COMETPUNCH],[18,PBMoves::FURYATTACK],[18,PBMoves::SPIKECANNON],[20,PBMoves::SWIFT],[21,PBMoves::GIGADRAIN],[21,PBMoves::FACADE],[21,PBMoves::DRILLPECK],[25,PBMoves::BODYSLAM],[25,PBMoves::HEADBUTT],[25,PBMoves::DARKPULSE],[28,PBMoves::QUIVERDANCE],[29,PBMoves::SLEEPPOWDER],[29,PBMoves::CHIPAWAY],[31,PBMoves::VICTORYDANCE],[33,PBMoves::HYPERVOICE],[33,PBMoves::CRUSHCLAW],[35,PBMoves::TAILWIND],[37,PBMoves::LEAFBLADE],[37,PBMoves::CRUNCH],[37,PBMoves::ROOST],[42,PBMoves::VICTORYDANCE],[45,PBMoves::HYPERBEAM],[46,PBMoves::HYPERFANG],[47,PBMoves::ACROBATICS],[50,PBMoves::EXTREMESPEED],[50,PBMoves::THRASH],[53,PBMoves::PETALDANCE],[55,PBMoves::KNOCKOFF],[57,PBMoves::CLOSECOMBAT],[59,PBMoves::GIGAIMPACT],[60,PBMoves::LEAFSTORM],[80,PBMoves::STORMCUTTER],[80,PBMoves::POWERTRIP],[90,PBMoves::BOOMBURST],[100,PBMoves::REVIVALBLESSING]
					],
	},
	"Cosmic" => {
		:DexEntry => ".",
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::BUG,
		:BaseStats => [170,40,115,35,40,115], #? Cosmic adds +35 to BST
		:Ability => [PBAbilities::TOXICDEBRIS,PBAbilities::MOXIE,PBAbilities::PURIFYINGSALT],
		:Movelist => [[0,PBMoves::COSMICBARRAGE],[1,PBMoves::COSMICBARRAGE],[1,PBMoves::ABSORB],[5,PBMoves::LEAFAGE],
					 [9,PBMoves::STUNSPORE],[15,PBMoves::POISONPOWDER],[15,PBMoves::TWINEEDLE],[15,PBMoves::MEGADRAIN],[15,PBMoves::ROCKPOLISH],[18,PBMoves::BULLETSEED],[18,PBMoves::BARRAGE],[18,PBMoves::ROCKBLAST],[18,PBMoves::PINMISSILE],[18,PBMoves::COMETPUNCH],[18,PBMoves::FURYATTACK],[18,PBMoves::SPIKECANNON],[20,PBMoves::BUGBITE],[21,PBMoves::GIGADRAIN],[21,PBMoves::LEECHLIFE],[21,PBMoves::ENERGYBALL],[25,PBMoves::ROCKBLAST],[25,PBMoves::POWERGEM],[25,PBMoves::FURYCUTTER],[28,PBMoves::QUIVERDANCE],[29,PBMoves::SLEEPPOWDER],[30,PBMoves::FELLSTINGER],[30,PBMoves::ROCKSLIDE],[30,PBMoves::ASTRALSHOT],[34,PBMoves::VICTORYDANCE],[35,PBMoves::ACCELEROCK],[37,PBMoves::LEAFBLADE],[37,PBMoves::MOONLIGHT],[37,PBMoves::MORNINGSUN],[40,PBMoves::WIDEGUARD],[42,PBMoves::RECOVER],[45,PBMoves::COSMICRAY],[47,PBMoves::LEAFSTORM],[48,PBMoves::STEAMROLLER],[50,PBMoves::METEORBEAM],[50,PBMoves::STRENGTHSAP],[50,PBMoves::FIRSTIMPRESSION],[53,PBMoves::PETALDANCE],[55,PBMoves::CAUSTICBREATH],[55,PBMoves::GEMSTONEGLIMMER],[55,PBMoves::STONEEDGE],[57,PBMoves::CLOSECOMBAT],[70,PBMoves::DECRYSTALLIZATION],[75,PBMoves::COMETSHOWER],[80,PBMoves::SALTCURE],[111,PBMoves::BATONPASS]],
	},
	"Delta1" => {
		:DexEntry => "The flame atop its head burns so intensely that not even water can douse it. It has been know to help guide diving humans to safety.",
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [70,60,75,90,110,75],
		:Ability => [PBAbilities::STORMDRAIN,PBAbilities::FLASHFIRE,PBAbilities::REGENERATOR],
		:Movelist => [[1,PBMoves::BUBBLE],[1,PBMoves::AQUARING],[1,PBMoves::EMBER],[1,PBMoves::RECOVER],[10,PBMoves::CONFUSERAY],[28,PBMoves::TAILGLOW],[46,PBMoves::HYDROPUMP],[50,PBMoves::FIERYDANCE]],
		:EggMoves => [PBMoves::ACIDARMOR,PBMoves::BUBBLEBEAM,PBMoves::ENTRAINMENT,PBMoves::FLAMEBURST,PBMoves::MIST,PBMoves::MYSTICALFIRE,PBMoves::REFLECTTYPE,PBMoves::ACID,PBMoves::AFTERYOU,PBMoves::AQUATAIL,PBMoves::BIND,PBMoves::EARTHPOWER,PBMoves::ENDEAVOR,PBMoves::ENDURE,PBMoves::GASTROACID,PBMoves::GIGADRAIN,PBMoves::HEALBELL,PBMoves::HEATWAVE,PBMoves::MAGICCOAT,PBMoves::MIMIC,PBMoves::PAINSPLIT,PBMoves::SIGNALBEAM,PBMoves::SNORE,PBMoves::SPITE,PBMoves::WATERPULSE,PBMoves::WHIRLPOOL]
	},
	"Delta2" => {
		:DexEntry => "Capable of producing massive barriers that provide weaker Pokémon with a sanctuary, it observed the Torren Region from afar during its greatest times of crisis.",
		:Type1 => PBTypes::FAIRY,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [70,60,75,90,110,75],
		:Ability => [PBAbilities::SERENEGRACE,PBAbilities::SYNCHRONIZE,PBAbilities::HEALER],
		:Movelist => [[1,PBMoves::FAIRYWIND],[1,PBMoves::FEATHERDANCE],[1,PBMoves::GUST],[1,PBMoves::ROOST],[10,PBMoves::SWEETKISS],[28,PBMoves::AGILITY],[46,PBMoves::AURASPHERE],[50,PBMoves::MOONBLAST]],
		:EggMoves => [PBMoves::BABYDOLLEYES,PBMoves::CHARM,PBMoves::DISARMINGVOICE,PBMoves::ENTRAINMENT,PBMoves::MISTYTERRAIN,PBMoves::WHIRLWIND,PBMoves::ACID,PBMoves::AFTERYOU,PBMoves::AIRCUTTER,PBMoves::AURASPHERE,PBMoves::BOUNCE,PBMoves::DEFOG,PBMoves::ENDEAVOR,PBMoves::ENDURE,PBMoves::HEALBELL,PBMoves::HEATWAVE,PBMoves::HELPINGHAND,PBMoves::HURRICANE,PBMoves::HYPERVOICE,PBMoves::ICYWIND,PBMoves::LASTRESORT,PBMoves::MAGICCOAT,PBMoves::MAGICROOM,PBMoves::MIMIC,PBMoves::ROLEPLAY,PBMoves::SKYATTACK,PBMoves::SNORE,PBMoves::SWIFT,PBMoves::TAILWIND,PBMoves::TWISTER,PBMoves::WONDERROOM]
	},
	"TOTEM" => {
		:Type1 => PBTypes::STELLAR,
		:BaseStats => [200,80,150,145,160,150],
		:Ability => [PBAbilities::MULTICORE]
	},
	"Mega" => {
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [70,60,100,110,140,100] #! Mega adds +100 to BST
	},
	
	"NeoN" => {
		:DexEntry => "The mysterious energy cointaned in the various Dens that can be found in Galar have given this Pokèmon the ability to artistically paint anything and anyone.",
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [80,80,80,80,80,80],
		:Ability => [PBAbilities::PRANKSTER,PBAbilities::PERVASIVENESS,PBAbilities::TRAITINHERITANCE],
		:Movelist => [[1,PBMoves::DOODLE],[1,PBMoves::SKETCH],[11,PBMoves::SKETCH],[21,PBMoves::SKETCH],[31,PBMoves::SKETCH],[41,PBMoves::SKETCH],[51,PBMoves::SKETCH],[61,PBMoves::SKETCH],[71,PBMoves::SKETCH],[81,PBMoves::SKETCH],[91,PBMoves::SKETCH]],
		:Weight => 192,
		:Height => 12
	}
},

#! This stays untouched <3
PBSpecies::TEDDINOMO => {
	:FormName => {
		1 => "Saiyan",
		3 => "Super Saiyan",
		4 => "Kaio-ken"
	},
	
	:DefaultForm => 1, 
	:MegaForm => 3,

	"Saiyan" => {
		:BaseStats => [121,151,71,136,75,66], #! BST is 620
		:Ability => PBAbilities::PLOTARMOR,
		:Weight => 9001
	},
	
	"Super Saiyan" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [121,181,101,136,75,96], #! BST is 710
		:Ability => PBAbilities::PLOTARMOR,
		:Weight => 9001
	},

	"Kaio-ken" => {
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [121,151,71,136,75,66], #! BST is 620
		:Ability => PBAbilities::ANCIENTPRESSURE,
		:Weight => 9001
	},
},

PBSpecies::DEDENNE => {
	:FormName => {
		1 => "Dev",
		2 => "Nuclear"
	},

	"Dev" => {
		:Ability => PBAbilities::SIMPLE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},


PBSpecies::SMEARGLE => {
	:FormName => {1 => "Dev"},

	"Dev" => {
		:Ability => PBAbilities::PRANKSTER
	}
},


PBSpecies::MARSHADOW => {
	:FormName => {1 => "Dev"},

	"Dev" => {
		:Ability => PBAbilities::SIMPLE
	}
},

PBSpecies::SILVALLY => {
	:FormName => {21 => "Dev"},

	"Dev" => {
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::STEEL,
		:Ability => PBAbilities::INTIMIDATE
	}
},

PBSpecies::DELPHOX => {
	:FormName => {
		1 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,69,72,134,159,125],
		:Ability => PBAbilities::PSYCHICSURGE
	}
},

PBSpecies::FLOETTEETERNAL => {
	:FormName => {
		1 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [74,85,87,102,155,148],
		:Ability => PBAbilities::MAGICGUARD,
		:Weight => 1008
	}
},

PBSpecies::CHANDELURE => {
	:FormName => {
		1 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [60,75,110,90,175,110],
		:Ability => PBAbilities::ADAPTABILITY,
		:Weight => 696,
		:Height => 25
	}
},

PBSpecies::MAGEARNA => {
	:FormName => {
		1 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,125,115,95,170,115],
		#:Ability => PBAbilities::ADAPTABILITY,
		:Weight => 2481,
		:Height => 13
	}
},

PBSpecies::CHROMLET => {
	:FormName => {
		1 => "Fight",
		2 => "Flying",
		3 => "Poison",
		4 => "Ground",
		5 => "Rock",
		6 => "Bug",
		7 => "Ghost",
		8 => "Steel",
		9 => "???",
		10 => "Fire",
		11 => "Water",
		12 => "Grass",
		13 => "Electric",
		14 => "Psychic",
		15 => "Ice",
		16 => "Dragon",
		17 => "Dark",
		18 => "Fairy",
		19 => "Nuclear",
		20 => "Cosmic"
	},

    :DefaultForm => 0,
	
	"Fight" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIGHTING
	},
	"Flying" => {
		:Type1 => PBTypes::FLYING,
		:Type2 => PBTypes::FLYING
	},
	"Poison" => {
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::POISON
	},
	"Ground" => {
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GROUND
	},
	"Rock" => {
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::ROCK
	},
	"Bug" => {
		:Type1 => PBTypes::BUG,
		:Type2 => PBTypes::BUG
	},
	"Ghost" => {
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::GHOST
	},
	"Steel" => {
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::STEEL
	},
	"???" => {
		:Type1 => PBTypes::QMARKS,
		:Type2 => PBTypes::QMARKS
	},
	"Fire" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FIRE
	},
	"Water" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::WATER
	},
	"Grass" => {
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GRASS
	},
	"Electric" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::ELECTRIC
	},
	"Psychic" => {
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::PSYCHIC
	},
	"Ice" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE
	},
	"Dragon" => {
		:Type1 => PBTypes::DRAGON,
		:Type2 => PBTypes::DRAGON
	},
	"Dark" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK
	},
	"Fairy" => {
		:Type1 => PBTypes::FAIRY,
		:Type2 => PBTypes::FAIRY
	},
	"Nuclear" => {
		:Type1 => PBTypes::NUCLEAR,
		:Type2 => PBTypes::NUCLEAR
	},
	"Cosmic" => {
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::COSMIC
	}


},

PBSpecies::CHROMELEON => {
	:FormName => {
		1 => "Fight",
		2 => "Flying",
		3 => "Poison",
		4 => "Ground",
		5 => "Rock",
		6 => "Bug",
		7 => "Ghost",
		8 => "Steel",
		9 => "???",
		10 => "Fire",
		11 => "Water",
		12 => "Grass",
		13 => "Electric",
		14 => "Psychic",
		15 => "Ice",
		16 => "Dragon",
		17 => "Dark",
		18 => "Fairy",
		19 => "Nuclear",
		20 => "Cosmic"
	},

    :DefaultForm => 0,
	
	"Fight" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIGHTING
	},
	"Flying" => {
		:Type1 => PBTypes::FLYING,
		:Type2 => PBTypes::FLYING
	},
	"Poison" => {
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::POISON
	},
	"Ground" => {
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GROUND
	},
	"Rock" => {
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::ROCK
	},
	"Bug" => {
		:Type1 => PBTypes::BUG,
		:Type2 => PBTypes::BUG
	},
	"Ghost" => {
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::GHOST
	},
	"Steel" => {
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::STEEL
	},
	"???" => {
		:Type1 => PBTypes::QMARKS,
		:Type2 => PBTypes::QMARKS
	},
	"Fire" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FIRE
	},
	"Water" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::WATER
	},
	"Grass" => {
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GRASS
	},
	"Electric" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::ELECTRIC
	},
	"Psychic" => {
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::PSYCHIC
	},
	"Ice" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE
	},
	"Dragon" => {
		:Type1 => PBTypes::DRAGON,
		:Type2 => PBTypes::DRAGON
	},
	"Dark" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK
	},
	"Fairy" => {
		:Type1 => PBTypes::FAIRY,
		:Type2 => PBTypes::FAIRY
	},
	"Nuclear" => {
		:Type1 => PBTypes::NUCLEAR,
		:Type2 => PBTypes::NUCLEAR
	},
	"Cosmic" => {
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::COSMIC
	}


},

PBSpecies::CHROMARIDER => {
	:FormName => {
		1 => "Fight",
		2 => "Flying",
		3 => "Poison",
		4 => "Ground",
		5 => "Rock",
		6 => "Bug",
		7 => "Ghost",
		8 => "Steel",
		9 => "???",
		10 => "Fire",
		11 => "Water",
		12 => "Grass",
		13 => "Electric",
		14 => "Psychic",
		15 => "Ice",
		16 => "Dragon",
		17 => "Dark",
		18 => "Fairy",
		19 => "Nuclear",
		20 => "Cosmic",
		21 => "Mega"
	},

    :DefaultForm => 0,
	:MegaForm => 21,
	
	"Fight" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIGHTING
	},
	"Flying" => {
		:Type1 => PBTypes::FLYING,
		:Type2 => PBTypes::FLYING
	},
	"Poison" => {
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::POISON
	},
	"Ground" => {
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GROUND
	},
	"Rock" => {
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::ROCK
	},
	"Bug" => {
		:Type1 => PBTypes::BUG,
		:Type2 => PBTypes::BUG
	},
	"Ghost" => {
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::GHOST
	},
	"Steel" => {
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::STEEL
	},
	"???" => {
		:Type1 => PBTypes::QMARKS,
		:Type2 => PBTypes::QMARKS
	},
	"Fire" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FIRE
	},
	"Water" => {
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::WATER
	},
	"Grass" => {
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GRASS
	},
	"Electric" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::ELECTRIC
	},
	"Psychic" => {
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::PSYCHIC
	},
	"Ice" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE
	},
	"Dragon" => {
		:Type1 => PBTypes::DRAGON,
		:Type2 => PBTypes::DRAGON
	},
	"Dark" => {
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK
	},
	"Fairy" => {
		:Type1 => PBTypes::FAIRY,
		:Type2 => PBTypes::FAIRY
	},
	"Nuclear" => {
		:Type1 => PBTypes::NUCLEAR,
		:Type2 => PBTypes::NUCLEAR
	},
	"Cosmic" => {
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::COSMIC
	},
	
	"Mega" => {
		#:DexEntry => "Legend says that by using its power to see all events from past to future, this Pokémon saved the creatures of a forest from a meteorite strike.",
		:BaseStats => [78,163,92,151,53,93],
		#:EVs => [0,3,0,0,0,0],
		:Type1 => PBTypes::STELLAR,
		:Type2 => PBTypes::STELLAR,
		:Height => 180,
		:Weight => 1100
	},


},

}

FormCopy = [
	[PBSpecies::FLABEBE,PBSpecies::FLOETTE],
	[PBSpecies::FLABEBE,PBSpecies::FLORGES],
	[PBSpecies::SHELLOS,PBSpecies::GASTRODON],
	[PBSpecies::DEERLING,PBSpecies::SAWSBUCK]
]
for form in FormCopy
	PokemonForms[form[1]] = PokemonForms[form[0]].clone
end
