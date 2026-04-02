def deep_copy(obj)
  Marshal.load(Marshal.dump(obj))
end

def pbHashConverter(mod,hash)
  newhash = {}
  hash.each {|key, value|
      for i in value
          newhash[mod.const_get(i.to_sym)]=key
      end
  }
  return newhash
end

def pbHashForwardizer(hash) #one-stop shop for your hash debackwardsing needs!
  return if !hash.is_a?(Hash)
  newhash = {}
  hash.each {|key, value|
      for i in value
          newhash[i]=key
      end
  }
  return newhash
end

def arrayToConstant(mod,array)
  newarray = []
  for symbol in array
    const = mod.const_get(symbol.to_sym) rescue nil
    newarray.push(const) if const
  end
  return newarray
end

def hashToConstant(mod,hash)
  for key in hash.keys
    const = mod.const_get(hash[key].to_sym) rescue nil
    hash.merge!(key=>const) if const
  end
  return hash
end

def hashArrayToConstant(mod,hash)
  for key in hash.keys
    array = hash[key]
    newarray = arrayToConstant(mod,array)
    hash.merge!(key=>newarray) if !newarray.empty?
  end
  return hash
end


STATUSTEXTS = ["status", "sleep", "poison", "burn", "paralysis", "ice"]
STATSTRINGS = ["HP", "Attack", "Defense", "Speed", "Sp. Attack", "Sp. Defense"]

class PBStuff
#rejuv stuff while we work out the kinks
#massive arrays of stuff that no one wants to see
#List of Abilities that either prevent or co-opt Intimidate
TRACEABILITIES = arrayToConstant(PBAbilities,[:PROTEAN, :CONTRARY, :INTIMIDATE, :WONDERGUARD,
  :MAGICGUARD, :SWIFTSWIM, :SLUSHRUSH, :SANDRUSH, :TELEPATHY, :SURGESURFER, :SOLARPOWER,
  :DRYSKIN, :DOWNLOAD, :LEVITATE, :LIGHTNINGROD, :MOTORDRIVE, :VOLTABSORB, :FLASHFIRE,
  :MAGMAARMOR, :ADAPTABILITY, :DEFIANT, :COMPETITIVE, :PRANKSTER, :SPEEDBOOST, :MULTISCALE,
  :SHADOWSHIELD, :SAPSIPPER, :FURCOAT, :FLUFFY, :MAGICBOUNCE, :REGENERATOR, :DAZZLING,
  :QUEENLYMAJESTY, :SOUNDPROOF, :TECHNICIAN, :BEASTBOOST,:SHEDSKIN, :CLEARBODY, :WHITESMOKE,
  :MOODY, :THICKFAT, :STORMDRAIN, :SIMPLE, :PUREPOWER, :MARVELSCALE, :STURDY, :MEGALAUNCHER,
  :SHEERFORCE, :UNAWARE, :CHLOROPHYLL,
  :LIBERO, :ICESCALES, :STEAMENGINE, :ARMORTAIL, :WELLBAKEDBODY, :GUARDDOG, :PETRIFY])
NEGATIVEABILITIES = arrayToConstant(PBAbilities,[:TRUANT, :DEFEATIST, :SLOWSTART, :KLUTZ,
  :STALL, :RIVALRY, :GORILLATACTICS, :MYCELIUMMIGHT, :LAZY, :RAGINGBLAZE, :OMNIPOTENT])

#Standardized lists of moves or abilities which are sometimes called
#Blacklisted abilities USUALLY can't be copied.
###--------------------------------------ABILITYBLACKLIST-------------------------------------------------------###
ABILITYBLACKLIST = arrayToConstant(PBAbilities,[:TRACE, :FORECAST, :WONDERGUARD, :FLOWERGIFT,
  :MULTITYPE, :IMPOSTER, :ILLUSION, :ZENMODE, :STANCECHANGE, :SCHOOLING, :COMATOSE,
  :SHIELDSDOWN, :DISGUISE, :POWEROFALCHEMY, :RECEIVER, :RKSSYSTEM, :POWERCONSTRUCT,
  :NEUTRALIZINGGAS, :ICEFACE, :HUNGERSWITCH, :GULPMISSILE, :ASONE,
  :ZEROTOHERO, :COMMANDER, :PROTOSYNTHESIS, :QUARKDRIVE, :HADRONENGINE, :ORICHALCUMPULSE,
  :BATTLEBOND, :RAGINGBLAZE, :ASTRALRECKON, :TRAITINHERITANCE, :OMNIPOTENT])

###--------------------------------------FIXEDABILITIES---------------------------------------------------------###
#Fixed abilities USUALLY can't be changed.
FIXEDABILITIES = arrayToConstant(PBAbilities,[:MULTITYPE, :ZENMODE, :STANCECHANGE, :SCHOOLING,
  :COMATOSE, :SHIELDSDOWN, :DISGUISE, :RKSSYSTEM, :POWERCONSTRUCT,
  :ICEFACE, :GULPMISSILE, :ASONE,
  :ZEROTOHERO, :COMMANDER, :PROTOSYNTHESIS, :QUARKDRIVE, :HADRONENGINE, :ORICHALCUMPULSE,
  :BATTLEBOND, :RAGINGBLAZE, :ASTRALRECKON, :OMNIPOTENT])

#Standardized lists of moves with similar purposes/characteristics
#(mostly just "stuff that gets called together")
###--------------------------------------UNFREEZEMOVE-----------------------------------------------------------###
UNFREEZEMOVE = arrayToConstant(PBMoves,[:FLAMEWHEEL, :SACREDFIRE, :FLAREBLITZ, :FUSIONFLARE,
  :SCALD, :STEAMERUPTION, :BURNUP, :PYROBALL, :SCORCHINGSANDS, :MATCHAGOTCHA,
  :HOTHEAD, :DRACOBLITZ])

###--------------------------------------SETUPMOVE--------------------------------------------------------------###
SETUPMOVE = arrayToConstant(PBMoves,[:SWORDSDANCE, :DRAGONDANCE, :CALMMIND, :WORKUP,
  :NASTYPLOT, :TAILGLOW, :BELLYDRUM, :BULKUP, :COIL, :CURSE, :GROWTH, :HONECLAWS, :QUIVERDANCE,
  :SHELLSMASH, :VICTORYDANCE,
  :EEVOBOOST, :PRESSURIZE, :COSMICDANCE])

###--------------------------------------PROTECTMOVE------------------------------------------------------------###
PROTECTMOVE = arrayToConstant(PBMoves,[:PROTECT, :DETECT, :KINGSSHIELD, :SPIKYSHIELD,
  :BANEFULBUNKER, :OBSTRUCT, :SILKTRAP])

###--------------------------------------PROTECTIGNORINGMOVE----------------------------------------------------###
PROTECTIGNORINGMOVE = arrayToConstant(PBMoves,[:FEINT, :HYPERSPACEHOLE,:HYPERSPACEFURY, :SHADOWFORCE, :PHANTOMFORCE])

###--------------------------------------SCREENBREAKERMOVE------------------------------------------------------###
SCREENBREAKERMOVE = arrayToConstant(PBMoves,[:DEFOG, :BRICKBREAK, :PSYCHICFANGS, :RAGINGBULL])

###--------------------------------------CONTRARYBAITMOVE-------------------------------------------------------###
CONTRARYBAITMOVE = arrayToConstant(PBMoves,[:SUPERPOWER, :OVERHEAT, :DRACOMETEOR, :LEAFSTORM,
  :FLEURCANNON, :PSYCHOBOOST])

###--------------------------------------TWOTURNAIRMOVE---------------------------------------------------------###
TWOTURNAIRMOVE = arrayToConstant(PBMoves,[:BOUNCE, :FLY, :SKYDROP])

###--------------------------------------PIVOTMOVE--------------------------------------------------------------###
PIVOTMOVE = arrayToConstant(PBMoves,[:UTURN, :VOLTSWITCH, :PARTINGSHOT, :FLIPTURN, :CHILLYRECEPTION, :SHEDTAIL])

###--------------------------------------DANCEMOVE--------------------------------------------------------------###
DANCEMOVE = arrayToConstant(PBMoves,[:QUIVERDANCE, :DRAGONDANCE, :FIERYDANCE, :FEATHERDANCE,
  :PETALDANCE, :SWORDSDANCE, :TEETERDANCE, :LUNARDANCE, :REVELATIONDANCE, :VICTORYDANCE, :AQUASTEP, :CLANGOROUSSOUL,
  :COSMICDANCE])

###--------------------------------------BULLETMOVE-------------------------------------------------------------###
BULLETMOVE = arrayToConstant(PBMoves,[:ACIDSPRAY, :AURASPHERE, :BARRAGE, :BULLETSEED,
  :EGGBOMB, :ELECTROBALL, :ENERGYBALL, :FOCUSBLAST, :GYROBALL, :ICEBALL, :MAGNETBOMB,
  :MISTBALL, :MUDBOMB, :OCTAZOOKA, :ROCKWRECKER, :SEARINGSHOT, :SEEDBOMB, :SHADOWBALL,
  :SLUDGEBOMB, :WEATHERBALL, :ZAPCANNON, :BEAKBLAST, :PYROBALL, :SYRUPBOMB,
  :GIGADESTROYER, :COSMICBARRAGE])

###--------------------------------------BITEMOVE---------------------------------------------------------------###
BITEMOVE = arrayToConstant(PBMoves,[:BITE, :CRUNCH, :THUNDERFANG, :FIREFANG, :ICEFANG, :CHAINCHOMP,
  :POISONFANG, :HYPERFANG, :PSYCHICFANGS, :FISHIOUSREND, :JAWLOCK, :METALCRUNCHER, :SNAPTRAP,
  :NUCLEARFANGS, :FAENGRUSH])

###--------------------------------------SLASHMOVE---------------------------------------------------------------### (Gen 9)
SLASHMOVE = arrayToConstant(PBMoves,[:AERIALACE, :AIRCUTTER, :AIRSLASH, :AQUACUTTER,
  :BEHEMOTHBLADE, :BITTERBLADE, :CEASELESSEDGE, :CROSSPOISON, :CUT, :FURYCUTTER, :KOWTOWCLEAVE,
  :LEAFBLADE, :NIGHTSLASH, :POPULATIONBOMB, :PSYBLADE, :PSYCHOCUT, :RAZORLEAF, :RAZORSHELL,
  :SACREDSWORD, :SLASH, :SOLARBLADE, :STONEAXE, :XSCISSOR, :RETALIATE, :INFERNALBLADE,
  :CRUSHCLAW, :DIRECLAW, :DRAGONCLAW, :FALSESWIPE, :METALCLAW, :RAZORWIND, :SCRATCH, :SECRETSWORD, :STONEEDGE,
  :SEARINGSLASH, :THUNDERSLASH, :ICESLASH, :TACHYONCUTTER, :MIGHTYCLEAVE, :DRAGONBLADE, :STEELYSTRIKE, :PLASMASABER])

###--------------------------------------KICKMOVE---------------------------------------------------------------### (Gen 9)
KICKMOVE = arrayToConstant(PBMoves,[:HIJUMPKICK, :JUMPKICK, :LOWSWEEP, :ROLLINGKICK, :DOUBLEKICK, :TRIPLEKICK,
:LOWKICK, :BLAZEKICK, :MEGAKICK, :STOMP, :TROPKICK, :PYROBALL, :TRIPLEAXEL, :THUNDEROUSKICK, :TRIPLEARROWS,
:AQUASTEP, :AXEKICK, :DINOKICK])

###--------------------------------------TACKLEMOVE---------------------------------------------------------------###
TACKLEMOVE = arrayToConstant(PBMoves,[:SIZZLYSLIDE, :FOCUSEDRAM, :DRACOBLITZ, :BARBEDTACKLE, :HOTHEAD,
:TRIPLEEDGE, :FLAMEIMPACT, :GLAIVERUSH, :TRAILBLAZE, :RAGINGBULL, :WAVECRASH, :GRASSYGLIDE, :HEADLONGRUSH,
:PSYSHIELDBASH, :BEHEMOTHBASH, :SUNSTEELSTRIKE, :LUNGE, :HIGHHORSEPOWER, :ACCELEROCK, :AQUAJET, :WATERFALL,
:IRONHEAD, :HEADSMASH, :ZENHEADBUTT, :QUICKATTACK, :TACKLE, :HEADBUTT, :EXTREMESPEED, :TAKEDOWN,
:SKULLBASH, :HEADCHARGE, :DOUBLEEDGE, :GIGAIMPACT, :DRILLRUN, :HORNLEECH, :BRAVEBIRD, :FLAMECHARGE,
:FLAMEWHEEL, :FLAREBLITZ, :VCREATE, :SPARK, :WILDCHARGE, :VOLTTACKLE, :BOLTSTRIKE, :DRAGONRUSH])
	
###--------------------------------------WINDMOVE---------------------------------------------------------------### (Gen 9)
WINDMOVE = arrayToConstant(PBMoves,[:AIRCUTTER, :BLEAKWINDSTORM, :BLIZZARD, :FAIRYWIND, :GUST,
  :HEATWAVE, :HURRICANE, :ICYWIND, :PETALBLIZZARD, :SANDSEARSTORM, :SANDSTORM, :SPRINGTIDESTORM,
  :TAILWIND, :TWISTER, :WHIRLWIND, :WILDBOLTSTORM,
  :RAZORWIND, :TYPHOON, :TWIRLYTWISTER])

###--------------------------------------BEAMMOVE---------------------------------------------------------------###
BEAMMOVE = arrayToConstant(PBMoves,[:AURORABEAM, :BUBBLEBEAM, :CHARGEBEAM, :HYPERBEAM,
  :ICEBEAM, :MOONGEISTBEAM, :MOONBLAST, :PSYBEAM, :SIGNALBEAM, :SIMPLEBEAM, :SOLARBEAM,
  :INFERNALFIREBLAST, :INFERNALWATERBLAST])

###--------------------------------------STINGMOVE---------------------------------------------------------------###
STINGMOVE = arrayToConstant(PBMoves,[:POISONSTING, :TWINEEDLE, :PINMISSILE, :SPIKECANNON,
  :NEEDLEARM, :POISONJAB, :FELLSTINGER, :NEEDLEDRAIN, :JETINJECTOR])

###--------------------------------------PHASEMOVE--------------------------------------------------------------###
PHASEMOVE = arrayToConstant(PBMoves,[:ROAR, :WHIRLWIND, :CIRCLETHROW, :DRAGONTAIL, :YAWN, :PERISHSONG])

###--------------------------------------SCREENMOVE-------------------------------------------------------------###
SCREENMOVE = arrayToConstant(PBMoves,[:LIGHTSCREEN, :REFLECT, :AURORAVEIL, :SOLARARRAY, :BADDYBAD, :GLITZYGLOW])

###--------------------------------------OHKOMOVE-------------------------------------------------------------###
OHKOMOVE = arrayToConstant(PBMoves,[:FISSURE, :SHEERCOLD, :GUILLOTINE, :HORNDRILL])

#Moves that inflict statuses with at least a 50% chance of hitting
###--------------------------------------BURNMOVE---------------------------------------------------------------###
BURNMOVE = arrayToConstant(PBMoves,[:WILLOWISP, :SACREDFIRE, :INFERNO])

###--------------------------------------PARAMOVE---------------------------------------------------------------###
PARAMOVE = arrayToConstant(PBMoves,[:THUNDERWAVE, :STUNSPORE, :GLARE, :NUZZLE, :ZAPCANNON])

###--------------------------------------SLEEPMOVE--------------------------------------------------------------###
SLEEPMOVE = arrayToConstant(PBMoves,[:SPORE, :SLEEPPOWDER, :HYPNOSIS, :DARKVOID, :GRASSWHISTLE,
  :LOVELYKISS, :SING, :YAWN])

###--------------------------------------POISONMOVE-------------------------------------------------------------###
POISONMOVE = arrayToConstant(PBMoves,[:TOXIC, :POISONPOWDER, :POISONGAS, :TOXICTHREAD])

###--------------------------------------CONFUMOVE--------------------------------------------------------------###
CONFUMOVE = arrayToConstant(PBMoves,[:CONFUSERAY, :SUPERSONIC, :FLATTER, :SWAGGER, :SWEETKISS,
  :TEETERDANCE, :CHATTER, :DYNAMICPUNCH])

#all the status inflicting moves
###--------------------------------------STATUSCONDITIONMOVE----------------------------------------------------###
STATUSCONDITIONMOVE = arrayToConstant(PBMoves,[:WILLOWISP, :DARKVOID,:GRASSWHISTLE, :HYPNOSIS,
  :LOVELYKISS,:SING,:SLEEPPOWDER, :SPORE, :YAWN,:POISONGAS, :POISONPOWDER, :TOXIC, :NUZZLE,
  :STUNSPORE, :THUNDERWAVE])


#Odd groups of moves/effects with similar behavior
###--------------------------------------HEALFUNCTIONS----------------------------------------------------------###
HEALFUNCTIONS =[0xD5,0xD6,0xD7,0xD8,0xD9,0xDD,0xDE,0xDF,0xE3,0xE4,0x114,0x139,0x158,0x162,0x169,0x16C,0x172, 0x187,0x212,0x277,0x279, 0x804]

###--------------------------------------RATESHARERS------------------------------------------------------------###
RATESHARERS = arrayToConstant(PBMoves,[:PROTECT, :DETECT, :QUICKGUARD, :WIDEGUARD, :ENDURE,
  :KINGSSHIELD, :SPIKYSHIELD, :BANEFULBUNKER, :CRAFTYSHIELD, :OBSTRUCT, :SILKTRAP])

###--------------------------------------INVULEFFECTS-----------------------------------------------------------###
INVULEFFECTS = arrayToConstant(PBEffects,[:Protect, :Endure, :KingsShield, :SpikyShield,
  :MatBlock, :BanefulBunker, :Obstruct, :SilkTrap])

###--------------------------------------POWDERMOVES------------------------------------------------------------###
POWDERMOVES = arrayToConstant(PBMoves,[:COTTONSPORE, :SLEEPPOWDER, :STUNSPORE, :SPORE,
  :RAGEPOWDER, :POISONPOWDER, :POWDER])

###--------------------------------------AIRHITMOVES------------------------------------------------------------###
AIRHITMOVES = arrayToConstant(PBMoves,[:THUNDER, :HURRICANE, :GUST, :TWISTER, :SKYUPPERCUT,
  :SMACKDOWN, :THOUSANDARROWS])

# Blacklist stuff
###--------------------------------------NOCOPYMOVE-------------------------------------------------------------###
NOCOPYMOVE = arrayToConstant(PBMoves,[:ASSIST, :COPYCAT, :MEFIRST, :METRONOME, :MIMIC,
  :MIRRORMOVE, :NATUREPOWER, :SHELLTRAP, :SKETCH,:SLEEPTALK, :STRUGGLE, :BEAKBLAST,
  :FOCUSPUNCH, :TRANSFORM, :BELCH, :CHATTER, :KINGSSHIELD, :BANEFULBUNKER, :BESTOW, :COUNTER,
  :COVET, :DESTINYBOND, :DETECT, :ENDURE, :FEINT, :FOLLOWME, :HELPINGHAND, :MATBLOCK,
  :MIRRORCOAT, :PROTECT, :RAGEPOWDER, :SNATCH, :SPIKYSHIELD, :SPOTLIGHT, :SWITCHEROO, :THIEF,
  :TRICK, :SILKTRAP])

###--------------------------------------NOAUTOMOVE-------------------------------------------------------------###
NOAUTOMOVE = arrayToConstant(PBMoves,[:ASSIST, :COPYCAT, :MEFIRST, :METRONOME, :MIMIC,
  :MIRRORMOVE, :NATUREPOWER, :SHELLTRAP, :SKETCH, :SLEEPTALK, :STRUGGLE])

###--------------------------------------DELAYEDMOVE------------------------------------------------------------###
DELAYEDMOVE = arrayToConstant(PBMoves,[:BEAKBLAST, :FOCUSPUNCH])

###--------------------------------------TWOTURNMOVE------------------------------------------------------------###
TWOTURNMOVE = arrayToConstant(PBMoves,[:BOUNCE, :DIG, :DIVE, :FLY, :PHANTOMFORCE, :SHADOWFORCE, :SKYDROP])

###--------------------------------------FORCEOUTMOVE-----------------------------------------------------------###
FORCEOUTMOVE = arrayToConstant(PBMoves,[:CIRCLETHROW, :DRAGONTAIL, :ROAR, :WHIRLWIND])

###--------------------------------------REPEATINGMOVE----------------------------------------------------------###
REPEATINGMOVE = arrayToConstant(PBMoves,[:ICEBALL, :OUTRAGE, :PETALDANCE, :ROLLOUT, :THRASH, :RAGINGFURY])

###--------------------------------------CHARGEMOVE-------------------------------------------------------------###
CHARGEMOVE = arrayToConstant(PBMoves,[:BIDE, :GEOMANCY, :RAZORWIND, :SKULLBASH, :SKYATTACK,
  :SOLARBEAM, :SOLARBLADE, :FREEZESHOCK, :ICEBURN, :METEORBEAM])

###---------------------------------------ITEMLISTS-------------------------------------------------------------###
HPITEMS = arrayToConstant(PBItems,[:POTION,:SUPERPOTION,:ULTRAPOTION,:HYPERPOTION,:MAXPOTION,
  :FULLRESTORE, :BERRYJUICE, :RAGECANDYBAR, :SWEETHEART, :FRESHWATER, :SODAPOP, :LEMONADE,
  :BUBBLETEA, :MEMEONADE, :MOOMOOMILK, :ENERGYPOWDER, :ENERGYROOT, :ORANBERRY, :SITRUSBERRY,
  :CHOCOLATEIC,:VANILLAIC,:STRAWBIC,:BLUEMIC])

STATUSITEMS = arrayToConstant(PBItems,[:FULLRESTORE, :FULLHEAL, :MEDICINE, :LAVACOOKIE,
  :OLDGATEAU, :CASTELIACONE, :HEALPOWDER, :LUMBERRY, :LUMIOSEGALETTE, :BIGMALASADA])

BURNITEMS = STATUSITEMS | arrayToConstant(PBItems,[:BURNHEAL, :RAWSTBERRY, :SALTWATERTAFFY])

FREEZEITEMS = STATUSITEMS | arrayToConstant(PBItems,[:ICEHEAL, :ASPEARBERRY, :REDHOTS])

PARAITEMS = STATUSITEMS | arrayToConstant(PBItems,[:PARLYZHEAL, :CHERIBERRY, :CHEWINGGUM])

SLEEPITEMS = STATUSITEMS | arrayToConstant(PBItems,[:AWAKENING, :CHESTOBERRY, :POPROCKS, :BLUEFLUTE])

POISONITEMS = STATUSITEMS | arrayToConstant(PBItems,[:ANTIDOTE, :PECHABERRY, :PEPPERMINT])

CONFUITEMS = STATUSITEMS | arrayToConstant(PBItems,[:PERSIMBERRY, :YELLOWFLUTE])

REVIVEITEMS = arrayToConstant(PBItems,[:REVIVE,:MAXREVIVE,:REVIVALHERB,:COTTONCANDY])

PPITEMS = arrayToConstant(PBItems,[:ETHER,:MAXETHER,:ELIXIR,:MAXELIXIR,:LEPPABERRY])

INFATUATIONITEMS = arrayToConstant(PBItems, [:REDFLUTE])

###-------------------------------------------------------------------------------------------------------------###
BLACKLISTS = {
:MEFIRST => NOCOPYMOVE | arrayToConstant(PBMoves,[:METALBURST]),
###-------------------------------------------------------------------------------------------------------------###
:METRONOME => NOCOPYMOVE | arrayToConstant(PBMoves,[:AFTERYOU,
  :DIAMONDSTORM, :FLEURCANNON, :HYPERSPACEFURY, :HYPERSPACEHOLE, :MINDBLOWN, :PHOTONGEYSER,
  :PLASMAFISTS, :QUASH, :QUICKGUARD, :RELICSONG, :SECRETSWORD, :SNORE, :SPECTRALTHIEF,
  :STEAMERUPTION, :TECHNOBLAST, :THOUSANDARROWS, :THOUSANDWAVES, :VCREATE, :WIDEGUARD,
  :CRAFTYSHIELD, :INSTRUCT, :FREEZESHOCK, :ICEBURN, :SNARL, :CELEBRATE,
  :WEATHERBALLSUN,:WEATHERBALLRAIN, :WEATHERBALLHAIL, :WEATHERBALLSAND,
  :TECHNOBLASTELECTRIC, :TECHNOBLASTFIRE, :TECHNOBLASTICE, :TECHNOBLASTWATER,
  :MULTIATTACKBUG, :MULTIATTACKDARK, :MULTIATTACKDRAGON, :MULTIATTACKELECTRIC,
  :MULTIATTACKFAIRY, :MULTIATTACKFIGHTING, :MULTIATTACKFIRE, :MULTIATTACKFLYING,
  :MULTIATTACKGHOST, :MULTIATTACKGLITCH, :MULTIATTACKGRASS, :MULTIATTACKGROUND,
  :MULTIATTACKICE, :MULTIATTACKPOISON, :MULTIATTACKPSYCHIC, :MULTIATTACKROCK,
  :MULTIATTACKSTEEL, :MULTIATTACKWATER, :MULTIATTACKNUKE,
  :JUDGMENTBUG, :JUDGMENTDARK, :JUDGMENTDRAGON, :JUDGMENTELECTRIC, :JUDGMENTFAIRY,
  :JUDGMENTFIGHTING, :JUDGMENTFIRE, :JUDGMENTFLYING, :JUDGMENTGHOST, :JUDGMENTQMARKS,
  :JUDGMENTGRASS, :JUDGMENTGROUND, :JUDGMENTICE, :JUDGMENTPOISON, :JUDGMENTPSYCHIC,
  :JUDGMENTROCK, :JUDGMENTSTEEL, :JUDGMENTWATER, :JUDGMENTNUKE,
  :FUTUREDUMMY, :DOOMDUMMY]) | (PBMoves::HIDDENPOWERNOR..PBMoves::HIDDENPOWERFAI).to_a,
###-------------------------------------------------------------------------------------------------------------###
:COPYCAT => NOCOPYMOVE | FORCEOUTMOVE | arrayToConstant(PBMoves,[:CRAFTYSHIELD]),
###-------------------------------------------------------------------------------------------------------------###
:ASSIST => NOCOPYMOVE | FORCEOUTMOVE | TWOTURNMOVE,
###-------------------------------------------------------------------------------------------------------------###
:INSTRUCT => NOAUTOMOVE | DELAYEDMOVE| TWOTURNMOVE | REPEATINGMOVE |
  arrayToConstant(PBMoves,[:TRANSFORM, :BELCH, :KINGSSHIELD, :BIDE, :INSTRUCT]),
###-------------------------------------------------------------------------------------------------------------###
:SLEEPTALK => NOAUTOMOVE | DELAYEDMOVE| TWOTURNMOVE | CHARGEMOVE | arrayToConstant(PBMoves,[:BELCH,:CHATTER]),
###-------------------------------------------------------------------------------------------------------------###
:ENCORE => NOAUTOMOVE | arrayToConstant(PBMoves,[:TRANSFORM])
}

#massive arrays of stuff that no one wants to see
NATURALGIFTDAMAGE = pbHashConverter(PBItems,{
###-------------------------------------------------------------------------------------------------------------###
  100 => [:WATMELBERRY, :DURINBERRY,  :BELUEBERRY,  :LIECHIBERRY, :GANLONBERRY, :SALACBERRY,
          :PETAYABERRY, :APICOTBERRY, :LANSATBERRY, :STARFBERRY,  :ENIGMABERRY, :MICLEBERRY,
          :CUSTAPBERRY, :JABOCABERRY, :ROWAPBERRY],
###-------------------------------------------------------------------------------------------------------------###
   90 => [:BLUKBERRY,   :NANABBERRY,  :WEPEARBERRY, :PINAPBERRY,  :POMEGBERRY,  :KELPSYBERRY,
          :QUALOTBERRY, :HONDEWBERRY, :GREPABERRY,  :TAMATOBERRY, :CORNNBERRY,  :MAGOSTBERRY,
          :RABUTABERRY, :NOMELBERRY,  :SPELONBERRY, :PAMTREBERRY],
###-------------------------------------------------------------------------------------------------------------###
   80 => [:CHERIBERRY,  :CHESTOBERRY, :PECHABERRY,  :RAWSTBERRY,  :ASPEARBERRY, :LEPPABERRY,
          :ORANBERRY,   :PERSIMBERRY, :LUMBERRY,    :SITRUSBERRY, :FIGYBERRY,   :WIKIBERRY,
          :MAGOBERRY,   :AGUAVBERRY,  :IAPAPABERRY, :RAZZBERRY,   :OCCABERRY,   :PASSHOBERRY,
          :WACANBERRY,  :RINDOBERRY,  :YACHEBERRY,  :CHOPLEBERRY, :KEBIABERRY,  :SHUCABERRY,
          :COBABERRY,   :PAYAPABERRY, :TANGABERRY,  :CHARTIBERRY, :KASIBBERRY,  :HABANBERRY,
          :COLBURBERRY, :BABIRIBERRY, :CHILANBERRY, :ROSELIBERRY]})
###-------------------------------------------------------------------------------------------------------------###
NATURALGIFTTYPE = pbHashConverter(PBItems,{
  PBTypes::NORMAL   => [:CHILANBERRY],
  PBTypes::FIRE     => [:CHERIBERRY,  :BLUKBERRY,   :WATMELBERRY, :OCCABERRY],
  PBTypes::WATER    => [:CHESTOBERRY, :NANABBERRY,  :DURINBERRY,  :PASSHOBERRY],
  PBTypes::ELECTRIC => [:PECHABERRY,  :WEPEARBERRY, :BELUEBERRY,  :WACANBERRY],
  PBTypes::GRASS    => [:RAWSTBERRY,  :PINAPBERRY,  :RINDOBERRY,  :LIECHIBERRY],
  PBTypes::ICE      => [:ASPEARBERRY, :POMEGBERRY,  :YACHEBERRY,  :GANLONBERRY],
  PBTypes::FIGHTING => [:LEPPABERRY,  :KELPSYBERRY, :CHOPLEBERRY, :SALACBERRY],
  PBTypes::POISON   => [:ORANBERRY,   :QUALOTBERRY, :KEBIABERRY,  :PETAYABERRY],
  PBTypes::GROUND   => [:PERSIMBERRY, :HONDEWBERRY, :SHUCABERRY,  :APICOTBERRY],
  PBTypes::FLYING   => [:LUMBERRY,    :GREPABERRY,  :COBABERRY,   :LANSATBERRY],
  PBTypes::PSYCHIC  => [:SITRUSBERRY, :TAMATOBERRY, :PAYAPABERRY, :STARFBERRY],
  PBTypes::BUG      => [:FIGYBERRY,   :CORNNBERRY,  :TANGABERRY,  :ENIGMABERRY],
  PBTypes::ROCK     => [:WIKIBERRY,   :MAGOSTBERRY, :CHARTIBERRY, :MICLEBERRY],
  PBTypes::GHOST    => [:MAGOBERRY,   :RABUTABERRY, :KASIBBERRY,  :CUSTAPBERRY],
  PBTypes::DRAGON   => [:AGUAVBERRY,  :NOMELBERRY,  :HABANBERRY,  :JABOCABERRY],
  PBTypes::DARK     => [:IAPAPABERRY, :SPELONBERRY, :COLBURBERRY, :ROWAPBERRY],
  PBTypes::FAIRY    => [:ROSELIBERRY, :KEEBERRY],
  PBTypes::STEEL    => [:RAZZBERRY,   :PAMTREBERRY, :BABIRIBERRY]})

FLINGDAMAGE = pbHashConverter(PBItems,{
  300 => [:MEMEONADE],
  130 => [:IRONBALL,:AUSPICIOUSARMOR,:MALICIOUSARMOR],
  100 => [:ARMORFOSSIL, :CLAWFOSSIL, :COVERFOSSIL, :DOMEFOSSIL, :HARDSTONE, :HELIXFOSSIL,
          :OLDAMBER, :PLUMEFOSSIL, :RAREBONE, :ROOTFOSSIL, :SKULLFOSSIL,
          :LEADERSCREST, :TUSKFOSSIL, :HAIRFOSSIL, :GOLDFOSSIL],
   90 => [:DEEPSEATOOTH,:DRACOPLATE,:DREADPLATE,:EARTHPLATE,:FISTPLATE,:FLAMEPLATE,
          :GRIPCLAW,:ICICLEPLATE,:INSECTPLATE,:IRONPLATE,:MEADOWPLATE,:MINDPLATE,
          :SKYPLATE,:SPLASHPLATE,:SPOOKYPLATE,:STONEPLATE,:THICKCLUB,:TOXICPLATE,
          :ZAPPLATE,:ATOMICPLATE,:COSMICPLATE],
   80 => [:DAWNSTONE,:DUSKSTONE,:ELECTIRIZER,:MAGMARIZER,:ODDKEYSTONE,:OVALSTONE,
          :PROTECTOR,:QUICKCLAW,:RAZORCLAW,:SHINYSTONE,:STICKYBARB,:ASSAULTVEST,
          :HEAVYDUTYBOOTS,:UTILITYUMBRELLA,:BLACKAUGURITE,:PEATBLOCK],
   70 => [:BURNDRIVE,:CHILLDRIVE,:DOUSEDRIVE,:DRAGONFANG,:POISONBARB,:POWERANKLET,
          :POWERBAND,:POWERBELT,:POWERBRACER,:POWERLENS,:POWERWEIGHT,:SHOCKDRIVE],
   60 => [:ADAMANTORB,:DAMPROCK,:HEATROCK,:LUSTROUSORB,:MACHOBRACE,:ROCKYHELMET,
          :STICK,:AMPLIFIELDROCK,:ADRENALINEORB],
   50 => [:DUBIOUSDISC,:SHARPBEAK],
   40 => [:EVIOLITE,:ICYROCK,:LUCKYPUNCH,:PROTECTIVEPADS],
   30 => [:ABILITYURGE,:ABSORBBULB,:AMULETCOIN,:ANTIDOTE,:AWAKENING,:BALMMUSHROOM,
          :BERRYJUICE,:BIGMUSHROOM,:BIGNUGGET,:BIGPEARL,:BINDINGBAND,:BLACKBELT,
          :BLACKFLUTE,:BLACKGLASSES,:BLACKSLUDGE,:BLUEFLUTE,:BLUESHARD,:BUBBLETEA,:BURNHEAL,
          :CALCIUM,:CARBOS,:CASTELIACONE,:CELLBATTERY,:CHARCOAL,:CLEANSETAG,
          :COMETSHARD,:DAMPMULCH,:DEEPSEASCALE,:DIREHIT,:COCONUTMILK,:CARROTWINE,:ROYALJELLY,
          :DRAGONSCALE,:EJECTBUTTON,:ELIXIR,:ENERGYPOWDER,:ENERGYROOT,:ESCAPEROPE,
          :ETHER,:EVERSTONE,:EXPSHARE,:FIRESTONE,:FLAMEORB,:FLOATSTONE,:FLUFFYTAIL,
          :FRESHWATER,:FULLHEAL,:FULLRESTORE,:GOOEYMULCH,:GREENSHARD,:GROWTHMULCH,
          :GUARDSPEC,:HEALPOWDER,:HEARTSCALE,:HONEY,:HPUP,:HYPERPOTION,:ICEHEAL,
          :IRON,:ITEMDROP,:ITEMURGE,:KINGSROCK,:LAVACOOKIE,:LEAFSTONE,:LEMONADE,:AROMATICHERB,
          :LIFEORB,:LIGHTBALL,:LIGHTCLAY,:LUCKYEGG,:MAGNET,:MAGNETICLURE,:MAXELIXIR,:MAXETHER,
          :MAXPOTION,:MAXREPEL,:MAXREVIVE,:MEDICINE,:METALCOAT,:METRONOME,:MIRACLESEED,
          :MOOMOOMILK,:MOONSTONE,:MYSTICWATER,:NEVERMELTICE,:NUGGET,:OLDGATEAU,
          :PARLYZHEAL,:PEARL,:PEARLSTRING,:POKEDOLL,:POKETOY,:POTION,:PPALL,:PPMAX,:PPUP,
          :PRISMSCALE,:PROTEIN,:RAGECANDYBAR,:RARECANDY,:RAZORFANG,:REDFLUTE,
          :REDSHARD,:RELICBAND,:RELICCOPPER,:RELICCROWN,:RELICGOLD,:RELICSILVER,
          :RELICSTATUE,:RELICVASE,:REPEL,:RESETURGE,:REVIVALHERB,:REVIVE,:SACREDASH,
          :SCOPELENS,:SHELLBELL,:SHOALSALT,:SHOALSHELL,:SMOKEBALL,:SODAPOP,:SOULDEW,
          :SPELLTAG,:STABLEMULCH,:STARDUST,:STARPIECE,:SUNSTONE,:SUPERPOTION,:GALARICAWREATH,
          :SUPERREPEL,:SWEETHEART,:THUNDERSTONE,:TINYMUSHROOM,:TOXICORB,:GALARICACUFF,
          :TWISTEDSPOON,:UPGRADE,:WATERSTONE,:WHITEFLUTE,:XACCURACY,:XATTACK,:XDEFEND,
          :XSPDEF,:XSPECIAL,:XSPEED,:YELLOWFLUTE,:YELLOWSHARD,:ZINC,:BIGMALASADA,:ICESTONE],
   20 => [:CLEVERWING,:GENIUSWING,:HEALTHWING,:MUSCLEWING,:PRETTYWING,:RESISTWING,:SWIFTWING],
   10 => [:AIRBALLOON,:BIGROOT,:BLUESCARF,:BRIGHTPOWDER,:CHOICEBAND,:CHOICESCARF,
          :CHOICESPECS,:DESTINYKNOT,:EXPERTBELT,:FOCUSBAND,:FOCUSSASH,:FULLINCENSE,
          :GREENSCARF,:LAGGINGTAIL,:LAXINCENSE,:LEFTOVERS,:LUCKINCENSE,:MENTALHERB,
          :METALPOWDER,:MUSCLEBAND,:ODDINCENSE,:PINKSCARF,:POWERHERB,:PUREINCENSE,
          :QUICKPOWDER,:REAPERCLOTH,:REDCARD,:REDSCARF,:RINGTARGET,:ROCKINCENSE,
          :ROSEINCENSE,:SEAINCENSE,:SHEDSHELL,:SILKSCARF,:SILVERPOWDER,:SMOOTHROCK,
          :SOFTSAND,:SOOTHEBELL,:THROATSPRAY,:WAVEINCENSE,:WHITEHERB,:WIDELENS,:WISEGLASSES,
          :YELLOWSCARF,:ZOOMLENS,:BLUEMIC,:VANILLAIC,:STRAWBIC,:CHOCOLATEIC]})

STATUSDAMAGE = pbHashConverter(PBMoves,{
   0 => [:AFTERYOU,     :BESTOW,          :CRAFTYSHIELD,:LUCKYCHANT,:MEMENTO,:QUASH,:SAFEGUARD,
         :SPITE,        :SPLASH,          :SWEETSCENT,:TELEKINESIS,:TELEPORT],
   5 => [:ALLYSWITCH,   :AROMATICMIST,    :CAMOUFLAGE, :CONVERSION,:ENDURE,:ENTRAINMENT,:FLOWERSHIELD,
         :FORESIGHT,    :FORESTSCURSE,    :GRAVITY,:DEFOG,:GUARDSWAP,:HEALBLOCK,:IMPRISON,
         :INSTRUCT,     :FAIRYLOCK,       :LASERFOCUS,:HELPINGHAND,:MAGICROOM,:MAGNETRISE,:SOAK,
         :LOCKON,       :MINDREADER,      :MIRACLEEYE,:MUDSPORT,:NIGHTMARE,:ODORSLEUTH,:POWERSPLIT,
         :POWERSWAP,    :GRUDGE,          :GUARDSPLIT,:POWERTRICK,:QUICKGUARD,:RECYCLE,:REFLECTTYPE,
         :ROTOTILLER,   :SKILLSWAP,       :SNATCH,:MAGICCOAT,:SPEEDSWAP,:SPOTLIGHT,
         :SWALLOW,      :TEETERDANCE,     :WATERSPORT,:WIDEGUARD,:WONDERROOM],
  10 => [:ACIDARMOR,    :ACUPRESSURE,     :AGILITY,:AMNESIA,:AUTOTOMIZE,:BABYDOLLEYES,:BARRIER,:BELLYDRUM,:BULKUP,
         :CALMMIND,     :CAPTIVATE,:CHARGE,:CHARM,:COIL,:CONFIDE,:COSMICPOWER,:COTTONGUARD,
         :COTTONSPORE,  :CURSE,           :DEFENDORDER,:DEFENSECURL,:DRAGONDANCE,:DOUBLETEAM,:EERIEIMPULSE,:EMBARGO,
         :FAKETEARS,    :FEATHERDANCE,    :FLASH,:FOCUSENERGY,:GEOMANCY,:GROWL,:GROWTH,:GEARUP,:HARDEN,:HAZE,
         :HONECLAWS,    :HOWL,            :IRONDEFENSE,:KINESIS,:LEER,:MAGNETICFLUX,:MEDITATE,:METALSOUND,:MINIMIZE, :NASTYPLOT,
         :NOBLEROAR,    :PLAYNICE,        :POWDER,:PSYCHUP,:PROTECT,:QUIVERDANCE,:ROCKPOLISH,:SANDATTACK,:SCARYFACE,:SCREECH,
         :SHARPEN,      :SHELLSMASH,      :SHIFTGEAR,:SMOKESCREEN, :STOCKPILE, :STRINGSHOT,:SUPERSONIC,:SWORDSDANCE,:TAILGLOW,
         :TAILWHIP,     :TEARFULLOOK,     :TICKLE,:TORMENT,:VENOMDRENCH,:WISH,:WITHDRAW,:WORKUP],
  15 => [:ASSIST,       :BATONPASS,       :DARKVOID, :FLORALHEALING,:GRASSWHISTLE,:HEALPULSE, :HEALINGWISH,:HYPNOSIS,:INGRAIN,
         :LUNARDANCE,   :MEFIRST,:MIMIC,  :PARTINGSHOT,:POISONPOWDER,:REFRESH,:ROLEPLAY,:SING, :SKETCH,
         :TRICKORTREAT, :TOXICTHREAD,     :SANDSTORM,:HAIL,:SUNNYDAY,:RAINDANCE],
  20 => [:AQUARING,     :BLOCK,           :CONVERSION2, :DETECT, :ELECTRIFY,:FLATTER,:GASTROACID,:HEALORDER, :HEARTSWAP,
         :IONDELUGE,    :MEANLOOK,        :LOVELYKISS,:MILKDRINK,:METRONOME,:MOONLIGHT,  :MORNINGSUN,:COPYCAT,:MIRRORMOVE,:MIST,
         :PERISHSONG,   :RECOVER, :REST,:ROAR,     :ROOST, :SIMPLEBEAM,:SHOREUP,:SPIDERWEB,
         :SLEEPPOWDER,  :SLACKOFF,        :SOFTBOILED,:STRENGTHSAP, :SWAGGER, 
         :SWEETKISS,    :SYNTHESIS,        :POISONGAS, :TRANSFORM,:WHIRLWIND,:WORRYSEED,:YAWN],
  25 => [:ATTRACT,      :CONFUSERAY,      :DESTINYBOND, :DISABLE,:FOLLOWME, :LEECHSEED,
         :PAINSPLIT,    :PSYCHOSHIFT,:RAGEPOWDER, :STUNSPORE,
         :SUBSTITUTE,   :SWITCHEROO,      :TAUNT,:TOPSYTURVY, :TOXIC,:TRICK,:WILLOWISP],
  30 => [:ELECTRICTERRAIN, :ENCORE,:GLARE,
         :GRASSYTERRAIN,:MISTYTERRAIN,    :NATUREPOWER,:PSYCHICTERRAIN,:PURIFY,:SLEEPTALK,
         :SPIKES,       :STEALTHROCK,     :SPIKYSHIELD,:THUNDERWAVE,:TOXICSPIKES,:TRICKROOM, :DECRYSTALLIZATION],
  35 => [:AROMATHERAPY, :BANEFULBUNKER,   :HEALBELL,:KINGSSHIELD,:LIGHTSCREEN,:MATBLOCK,
         :REFLECT,      :TAILWIND],
  40 => [],
  60 => [:AURORAVEIL,:STICKYWEB,:SPORE,:SOLARARRAY]})

TYPETOZCRYSTAL = hashToConstant(PBItems,{
  PBTypes::NORMAL     => :NORMALIUMZ2,    PBTypes::FIGHTING   => :FIGHTINIUMZ2,
  PBTypes::FLYING     => :FLYINIUMZ2,     PBTypes::POISON     => :POISONIUMZ2, 
  PBTypes::GROUND     => :GROUNDIUMZ2,    PBTypes::ROCK       => :ROCKIUMZ2,
  PBTypes::BUG        => :BUGINIUMZ2,     PBTypes::GHOST      => :GHOSTIUMZ2,
  PBTypes::STEEL      => :STEELIUMZ2,     PBTypes::FIRE       => :FIRIUMZ2, 
  PBTypes::WATER      => :WATERIUMZ2,     PBTypes::GRASS      => :GRASSIUMZ2, 
  PBTypes::ELECTRIC   => :ELECTRIUMZ2,    PBTypes::PSYCHIC    => :PSYCHIUMZ2,
  PBTypes::ICE        => :ICIUMZ2,        PBTypes::DRAGON     => :DRAGONIUMZ2, 
  PBTypes::DARK       => :DARKINIUMZ2,    PBTypes::FAIRY      => :FAIRIUMZ2 
})

POKEMONTOMEGASTONE = hashArrayToConstant(PBItems,{
  PBSpecies::CHARIZARD   => [:CHARIZARDITEX,     :CHARIZARDITEY,   :CHARIZARDITEG],
  PBSpecies::MEWTWO      => [:MEWTWONITEX,       :MEWTWONITEY],
  PBSpecies::VENUSAUR    => [:VENUSAURITE,       :VENUSAURITEG], 
  PBSpecies::BLASTOISE   => [:BLASTOISINITE,     :BLASTOISINITEG],
  PBSpecies::ABOMASNOW   => [:ABOMASITE],        PBSpecies::ABSOL         => [:ABSOLITE],
  PBSpecies::AERODACTYL  => [:AERODACTYLITE],
  PBSpecies::AGGRON      => [:AGGRONITE,         :FUSIONREACTOR],
  PBSpecies::ALAKAZAM    => [:ALAKAZITE],
  PBSpecies::AMPHAROS    => [:AMPHAROSITE,       :FUSIONREACTOR],
  PBSpecies::BANETTE     => [:BANETTITEX,        :BANETTITEY],
  PBSpecies::BLAZIKEN    => [:BLAZIKENITE],      PBSpecies::GARCHOMP      => [:GARCHOMPITE],
  PBSpecies::GARDEVOIR   => [:GARDEVOIRITE,      :VOIDSTONE],
  PBSpecies::GENGAR      => [:GENGARITE,         :GENGARITEG],
  PBSpecies::GYARADOS    => [:GYARADOSITE,       :FUSIONREACTOR],
  PBSpecies::URSHIFU     => [:URSHIFITEX, 	     :URSHIFITEY],
  PBSpecies::BUTTERFREE  => [:BUTTERFREENITE],   PBSpecies::CORSOLA       => [:CORSOLITE],
  PBSpecies::INTELEON    => [:INTELEONITE],    	 PBSpecies::CINDERACE  		=> [:CINDERACITE],
  PBSpecies::RILLABOOM   => [:RILLABOOMITE],     PBSpecies::DURALUDON     => [:DURALUDONITE],
  PBSpecies::COPPERAJAH  => [:COPPERITE,         :FUSIONREACTOR],
  PBSpecies::ALCREMIE    => [:ALCREMITE],
  PBSpecies::GRIMMSNARL  => [:GRIMMSNARLITE,     :FUSIONREACTOR],
  PBSpecies::HATTERENE   => [:HATTERENITE],
  PBSpecies::CENTISKORCH => [:CENTISKORCHITE,    :FUSIONREACTOR],
  PBSpecies::TOXTRICITY  => [:TOXTRICITE],
  PBSpecies::SANDACONDA  => [:SANDACONDITE,      :FUSIONREACTOR],
  PBSpecies::APPLETUN    => [:APPLETUNITE],      PBSpecies::FLAPPLE       => [:FLAPPLETITE],
  PBSpecies::COALOSSAL   => [:COALOSSITE,        :FUSIONREACTOR],
  PBSpecies::DREDNAW     => [:DREDNAWTITE,       :FUSIONREACTOR],
  PBSpecies::ORBEETLE    => [:ORBEETITE],
  PBSpecies::CORVIKNIGHT => [:CORVINITE],    	   PBSpecies::MELMETAL   		=> [:MELMETALITE],
  PBSpecies::GARBODOR    => [:GARBODORITE,       :FUSIONREACTOR],
  PBSpecies::SNORLAX   	 => [:SNORLAXITE],
  PBSpecies::EEVEE       => [:EEVEETITE],    	   PBSpecies::LAPRAS     		=> [:LAPRASITE],
  PBSpecies::KINGLER     => [:KINGLERITE],    	 PBSpecies::MACHAMP      	=> [:MACHAMPITE],
  PBSpecies::MEOWTH      => [:MEOWTHITE],    	   PBSpecies::PIKACHU     	=> [:PIKACHUTITE],
  PBSpecies::HERACROSS   => [:HERACRONITE],
  PBSpecies::HOUNDOOM    => [:HOUNDOOMINITE,     :FUSIONREACTOR],
  PBSpecies::KANGASKHAN  => [:KANGASKHANITE],
  PBSpecies::LUCARIO     => [:LUCARIONITE,       :LUCARIONITER],
  PBSpecies::MANECTRIC   => [:MANECTITE],        PBSpecies::MAWILE        => [:MAWILITE],
  PBSpecies::MEDICHAM    => [:MEDICHAMITE],      PBSpecies::PINSIR        => [:PINSIRITE],  
  PBSpecies::SCIZOR      => [:SCIZORITE],
  PBSpecies::TYRANITAR   => [:TYRANITARITE,      :FUSIONREACTOR],
  PBSpecies::BEEDRILL    => [:BEEDRILLITE],      PBSpecies::PIDGEOT       => [:PIDGEOTITE],
  PBSpecies::SLOWBRO     => [:SLOWBRONITE],
  PBSpecies::STEELIX     => [:STEELIXITE,        :FUSIONREACTOR],
  PBSpecies::SCEPTILE    => [:SCEPTILITE,        :SCEPTILITER],
  PBSpecies::SWAMPERT    => [:SWAMPERTITE],
  PBSpecies::SHARPEDO    => [:SHARPEDONITE],     PBSpecies::SABLEYE       => [:SABLENITE],
  PBSpecies::CAMERUPT    => [:CAMERUPTITE,       :PULSEHOLD],
  PBSpecies::ALTARIA     => [:ALTARIANITE],
  PBSpecies::GLALIE      => [:GLALITITE,         :FUSIONREACTOR],
  PBSpecies::SALAMENCE   => [:SALAMENCITE],
  PBSpecies::METAGROSS   => [:METAGROSSITE],     PBSpecies::LOPUNNY       => [:LOPUNNITE],
  PBSpecies::GALLADE     => [:GALLADITE],        PBSpecies::AUDINO        => [:AUDINITE],
  PBSpecies::DIANCIE     => [:DIANCITE],
  PBSpecies::LATIAS      => [:LATIASITE],        PBSpecies::LATIOS        => [:LATIOSITE],
  PBSpecies::NINETALES   => [:NINETALITE],       PBSpecies::JUMPLUFF      => [:JUMPLUFFITE],
  PBSpecies::VILEPLUME   => [:VILEPLUMITE],      PBSpecies::SUNFLORA      => [:SUNFLORITE],
  PBSpecies::DUGTRIO     => [:DUGTRIONITE],      PBSpecies::SHUCKLE       => [:SHUCKLENITE],
  PBSpecies::ARCANINE    => [:ARCANITE],         PBSpecies::DELIBIRD      => [:DELIBIRDITE],
  PBSpecies::VICTREEBEL  => [:VICTREEBELITE,	:VICTREEBELITEZA],    PBSpecies::BRELOOM       => [:BRELOOMITE],
  PBSpecies::HYPNO       => [:HYPNOTITE,         :PULSEHOLD],
  PBSpecies::EXPLOUD     => [:EXPLOUDITE],
  PBSpecies::MAROWAK     => [:MAROWAKITE],       PBSpecies::ZANGOOSE      => [:ZANGOOSITE],
  PBSpecies::STARMIE     => [:STARMINITE,	:STARMINITEZA],       PBSpecies::MILOTIC       => [:MILOTICITE],
  PBSpecies::TYPHLOSION  => [:TYPHLOSINITEX,     :TYPHLOSINITEY],
  PBSpecies::MEGANIUM    => [:MEGANIUMITE,	:MEGANIUMITEZA],      PBSpecies::FERALIGATR    => [:FERALIGATITE,	:FERALIGITE],
  PBSpecies::NOCTOWL     => [:NOCTOWLITE],       PBSpecies::CHIMECHO      => [:CHIMECHONITE],
  PBSpecies::CLAYDOL     => [:CLAYDOLITE],       PBSpecies::SANDSLASH     => [:SANDSLASHNITE],
  PBSpecies::XATU        => [:XATUTITE],         PBSpecies::TORTERRA      => [:TORTERRANITE],
  PBSpecies::TORKOAL     => [:TORKOALITE],       PBSpecies::LANTURN       => [:LANTURNITE],
  PBSpecies::INFERNAPE   => [:INFERNAPITE],      PBSpecies::DUSKNOIR      => [:DUSKNOIRITE],
  PBSpecies::EMPOLEON    => [:EMPOLEONITE],      PBSpecies::FROSLASS      => [:FROSLASSITE,		:FROSLASSITEZA],
  PBSpecies::ROSERADE    => [:ROSERADITE],       PBSpecies::SCRAFTY       => [:SCRAFTINITE,		:SCRAFTINITEZA],
  PBSpecies::MOTHIM      => [:MOTHIMITE],        PBSpecies::COFAGRIGUS    => [:COFAGRIGITE],
  PBSpecies::MISMAGIUS   => [:MISMAGIUSITE],     PBSpecies::REUNICLUS     => [:REUNICLUSITE],
  PBSpecies::SAMUROTT    => [:SAMUROTTITE],      PBSpecies::EMBOAR        => [:EMBOARNITE,	:EMBOARITE],
  PBSpecies::SERPERIOR   => [:SERPERIORNITE],    PBSpecies::CACTURNE      => [:CACTURNITE],
  PBSpecies::BRONZONG    => [:BRONZONGITE],      PBSpecies::BARBARACLE    => [:BARBARACLITE],
  PBSpecies::WEAVILE     => [:WEAVILITE],        PBSpecies::GOURGEIST     => [:GOURGEISTITE],
  PBSpecies::TSAREENA    => [:TSAREENITE],
  PBSpecies::NIDOKING    => [:NIDOTITEX,         :NIDOTITEY],
  PBSpecies::NIDOQUEEN   => [:NIDOTITEX,         :NIDOTITEY],
  PBSpecies::KINGDRA     => [:KINGDRANITE],      PBSpecies::GARGRYPH      => [:GARGRYPHITE],
  PBSpecies::METALYNX    => [:METALYNXITE],      PBSpecies::NUCLEON       => [:NUCLEONITE],
  PBSpecies::ELECTRUXO   => [:ELECTRUXITE],
  PBSpecies::ARCHILLES   => [:ARCHILLITE],       PBSpecies::DRILGANN      => [:DRILGANNITE],
  PBSpecies::BAARIETTE   => [:BAARITITE,         :FUSIONREACTOR],
  PBSpecies::DRAMSAMA    => [:DRAMSAMITE],
  PBSpecies::ARBOK       => [:ARBOKITE,          :FUSIONREACTOR],
  PBSpecies::SYRENTIDE   => [:SYRENTITE],
  PBSpecies::INFLAGETAH  => [:INFLAGETITE,       :FUSIONREACTOR],
  PBSpecies::KIRICORN    => [:KIRICORNITE],
  PBSpecies::WHIMSICOTT  => [:WHIMSICOTTITE],    PBSpecies::S51A          => [:S51ITE],
  PBSpecies::INCINEROAR  => [:INCINEROARITE],
  PBSpecies::URAYNE      => [:FUSIONREACTOR],
  PBSpecies::OGERPON     => [:TEALMASK, :WELLSPRINGMASK, :HEARTHFLAMEMASK, :CORNERSTONEMASK, :MAJORAMASK],
  PBSpecies::GRENINJA    => [:GRENINJITE],
  PBSpecies::TEDDINOMO   => [:SAIYANITE],
  PBSpecies::PALDIATINA  => [:PULSEHOLD],
  PBSpecies::ZYGARDE  => [:ZYGARDITE],
  PBSpecies::DELPHOX   => [:DELPHOXITE],       PBSpecies::HAWLUCHA      => [:HAWLUCHANITE],
  PBSpecies::MALAMAR   => [:MALAMARITE],       PBSpecies::SKARMORY      => [:SKARMORITE],
  PBSpecies::FLOETTEETERNAL   => [:FLOETTITE], PBSpecies::CHANDELURE   => [:CHANDELURITE],
  PBSpecies::FALINKS      => [:FALINKSITE],	   PBSpecies::MAGEARNA      => [:MAGEARNITE],
  PBSpecies::ZACIAN    => [:RUSTEDSWORDSHINY],	PBSpecies::ZAMAZENTA    => [:RUSTEDSHIELDSHINY],
  PBSpecies::CALYREX    => [:REINSOFUNITYSHINY],	PBSpecies::CHROMARIDER      => [:CHROMARIDITE],
  
  #PULSES
  PBSpecies::TANGROWTH   => [:PULSEHOLD],        PBSpecies::MAGNEZONE     => [:PULSEHOLD],
  PBSpecies::AVALUGG     => [:PULSEHOLD],        PBSpecies::SWALOT        => [:PULSEHOLD],
  PBSpecies::MUK         => [:PULSEHOLD],        PBSpecies::ABRA          => [:PULSEHOLD],
  PBSpecies::MRMIME      => [:PULSEHOLD],        PBSpecies::CLAWITZER     => [:PULSEHOLD],
  PBSpecies::ARCEUS      => [:PULSEHOLD]
})
POKEMONTOMEGASTONE.default = []

LEGENDARYLIST =                [PBSpecies::CRESSELIA,     PBSpecies::REGICE,      PBSpecies::REGIROCK,
  PBSpecies::REGISTEEL,         PBSpecies::SUICUNE,       PBSpecies::ENTEI,       PBSpecies::RAIKOU,
  PBSpecies::MESPRIT,           PBSpecies::AZELF,         PBSpecies::UXIE,        PBSpecies::ARTICUNO,
  PBSpecies::ZAPDOS,            PBSpecies::MOLTRES,       PBSpecies::LANDORUS,    PBSpecies::THUNDURUS,
  PBSpecies::TORNADUS,          PBSpecies::TERRAKION,     PBSpecies::VIRIZION,    PBSpecies::COBALION,
  PBSpecies::KELDEO,            PBSpecies::REGIGIGAS,     PBSpecies::CELEBI,      PBSpecies::MELOETTA,
  PBSpecies::VICTINI,           PBSpecies::VOLCANION,     PBSpecies::HOOPA,       PBSpecies::ZERAORA,
  PBSpecies::MAGEARNA,          PBSpecies::ZYGARDE,       PBSpecies::TAPUBULU,    PBSpecies::TAPUKOKO,
  PBSpecies::TAPULELE,          PBSpecies::TAPUFINI,      PBSpecies::DIANCIE,     PBSpecies::JIRACHI,
  PBSpecies::HEATRAN,           PBSpecies::LATIAS,        PBSpecies::LATIOS,      PBSpecies::MANAPHY,
  PBSpecies::DARKRAI,           PBSpecies::MARSHADOW,     PBSpecies::SHAYMIN,     PBSpecies::MEW,
  PBSpecies::GENESECT,          PBSpecies::DIALGA,        PBSpecies::PALKIA,      PBSpecies::HOOH,
  PBSpecies::LUGIA,             PBSpecies::RESHIRAM,      PBSpecies::ZEKROM,      PBSpecies::KYUREM,
  PBSpecies::XERNEAS,           PBSpecies::YVELTAL,       PBSpecies::COSMOG,      PBSpecies::COSMOEM,
  PBSpecies::LUNALA,            PBSpecies::SOLGALEO,      PBSpecies::DEOXYS,      PBSpecies::GROUDON,
  PBSpecies::KYOGRE,            PBSpecies::GIRATINA,      PBSpecies::RAYQUAZA,    PBSpecies::NECROZMA,
  PBSpecies::MEWTWO,            PBSpecies::ARCEUS,        PBSpecies::CALYREX,     PBSpecies::SPECTRIER,
  PBSpecies::GLASTRIER,         PBSpecies::ZACIAN,        PBSpecies::KUBFU,		    PBSpecies::URSHIFU,
  PBSpecies::MELTAN,	          PBSpecies::MELMETAL,      PBSpecies::WOCHIEN,		  PBSpecies::CHIENPAO,
  PBSpecies::CHIYU,	            PBSpecies::TINGLU,        PBSpecies::MIRAIDON,		PBSpecies::KORAIDON,
  PBSpecies::MELTAN,	          PBSpecies::MELMETAL,      PBSpecies::ZAMAZENTA,   PBSpecies::SCREAMTAIL,
  PBSpecies::FLUTTERMANE,	      PBSpecies::SANDYSHOCKS,   PBSpecies::GREATTUSK,		PBSpecies::IRONTREADS,
  PBSpecies::IRONBUNDLE,	      PBSpecies::IRONTHORNS,    PBSpecies::IRONMOTH,    PBSpecies::SLITHERWING,
  PBSpecies::IRONHANDS,	        PBSpecies::IRONJUGULIS,   PBSpecies::BRUTEBONNET,	PBSpecies::ROARINGMOON,
  PBSpecies::IRONVALIANT,       PBSpecies::IRONLEAVES,    PBSpecies::WALKINGWAKE, PBSpecies::AOTIUS,
  PBSpecies::MUTIOS,            PBSpecies::URAYNE,        PBSpecies::URALPHA,     PBSpecies::ZEPHY,
  PBSpecies::KRAKANAO,          PBSpecies::BAITATAO,      PBSpecies::LANTHAN,		  PBSpecies::ACTAN,
  PBSpecies::LEVIATHAO,         PBSpecies::ARKHAOS,       PBSpecies::OCULEUS,		  PBSpecies::MEWTHREE,
  PBSpecies::MISSINGNO2,        PBSpecies::OGERPON,       PBSpecies::OKIDOGI,     PBSpecies::MUNKIDORI,
  PBSpecies::FEZANDIPITI]

SHORTCIRCUITROLLS = [0.8, 1.5, 0.5, 1.2, 2.0]

CCROLLS = [PBTypes::FIRE, PBTypes::WATER, PBTypes::GRASS, PBTypes::PSYCHIC]
end

class PBMoves
BREAKNECKBLITZ                 =10001
ALLOUTPUMMELING                =10002
SUPERSONICSKYSTRIKE            =10003
ACIDDOWNPOUR                   =10004
TECTONICRAGE                   =10005
CONTINENTALCRUSH               =10006
SAVAGESPINOUT                  =10007
NEVERENDINGNIGHTMARE           =10008
CORKSCREWCRASH                 =10009
INFERNOOVERDRIVE               =10010
HYDROVORTEX                    =10011
BLOOMDOOM                      =10012
GIGAVOLTHAVOC                  =10013
SHATTEREDPSYCHE                =10014
SUBZEROSLAMMER                 =10015
DEVASTATINGDRAKE               =10016
BLACKHOLEECLIPSE               =10017
TWINKLETACKLE                  =10018
STOKEDSPARKSURFER              =10019
SINISTERARROWRAID              =10020
MALICIOUSMOONSAULT             =10021
OCEANICOPERETTA                =10022
EXTREMEEVOBOOST                =10023
CATASTROPIKA                   =10024
PULVERIZINGPANCAKE             =10025
GENESISSUPERNOVA               =10026
GUARDIANOFALOLA                =10027
SOULSTEALING7STARSTRIKE        =10028
CLANGOROUSSOULBLAZE            =10029
SPLINTEREDSTORMSHARDS          =10030
LETSSNUGGLEFOREVER             =10031
SEARINGSUNRAZESMASH            =10032
MENACINGMOONRAZEMAELSTROM      =10033
LIGHTTHATBURNSTHESKY           =10034
end

class PBFields
  #PBStuff for field effects.
	CHESSMOVES = arrayToConstant(PBMoves,[:STRENGTH, :ANCIENTPOWER, :PSYCHIC, :CONTINENTALCRUSH,
    :SECRETPOWER, :SHATTEREDPSYCHE, :EERIESPELL])

	STRIKERMOVES = arrayToConstant(PBMoves,[:STRENGTH, :WOODHAMMER, :DUALCHOP, :HEATCRASH,
  :SKYDROP, :BULLDOZE, :POUND, :ICICLECRASH, :BODYSLAM, :STOMP, :SLAM, :GIGAIMPACT, :SMACKDOWN,
  :IRONTAIL, :METEORMASH, :DRAGONRUSH, :CRABHAMMER, :BOUNCE, :HEAVYSLAM, :MAGNITUDE,
  :EARTHQUAKE, :STOMPINGTANTRUM, :BRUTALSWING, :HIGHHORSEPOWER, :ICEHAMMER, :DRAGONHAMMER,
  :BLAZEKICK, :DOUBLEIRONBASH, :HEADLONGRUSH])

	WINDMOVES = arrayToConstant(PBMoves,[:OMINOUSWIND, :ICYWIND, :SILVERWIND, :TWISTER,
  :RAZORWIND,:FAIRYWIND,:GUST, :BLEAKWINDSTORM,:SANDSEARSTORM,:SPRINGTIDESTORM,:WILDBOLTSTORM])

	MIRRORMOVES = arrayToConstant(PBMoves,[:CHARGEBEAM, :SOLARBEAM, :PSYBEAM, :TRIATTACK,
    :BUBBLEBEAM, :HYPERBEAM, :ICEBEAM, :ORIGINPULSE, :MOONGEISTBEAM, :FLEURCANNON])

	BLINDINGMOVES = arrayToConstant(PBMoves,[:AURORABEAM, :SIGNALBEAM, :FLASHCANNON,
    :LUSTERPURGE, :DAZZLINGGLEAM, :TECHNOBLAST, :DOOMDUMMY, :PRISMATICLASER, :PHOTONGEYSER,
    :LIGHTTHATBURNSTHESKY])

	IGNITEMOVES = arrayToConstant(PBMoves,[:HEATWAVE, :ERUPTION, :SEARINGSHOT, :FLAMEBURST, 
    :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE,
    :INFERNALFIREBLAST, :INFERNALWATERBLAST])

	BLOWMOVES = arrayToConstant(PBMoves,[:WHIRLWIND, :GUST, :RAZORWIND, :DEFOG, :HURRICANE, 
    :TWISTER, :TAILWIND, :SUPERSONICSKYSTRIKE])

	GROWMOVES = arrayToConstant(PBMoves,[:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,
    :INGRAIN,:WATERSPORT])

	MAXGARDENMOVES = PBStuff::POWDERMOVES + arrayToConstant(PBMoves,[:PETALDANCE,:PETALBLIZZARD])

	QUAKEMOVES = arrayToConstant(PBMoves,[:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE])

	NONE = 0
	ELECTRICT = 1
	GRASSYT = 2
	MISTYT = 3
	DARKCRYSTALC = 4
	CHESSB = 5
	BIGTOPA = 6
	BURNINGF = 7
	SWAMPF = 8
	RAINBOWF = 9
	CORROSIVEF = 10
	CORROSIVEMISTF = 11
	DESERTF = 12
	ICYF = 13
	ROCKYF = 14
	FORESTF = 15
	SUPERHEATEDF = 16
	FACTORYF = 17
	SHORTCIRCUITF = 18
	WASTELAND = 19
	ASHENB = 20
	WATERS = 21
	UNDERWATER = 22
	CAVE = 23
	GLITCHF = 24
	CRYSTALC = 25
	MURKWATERS = 26
	MOUNTAIN = 27
	SNOWYM = 28
	HOLYF = 29
	MIRRORA = 30
	FAIRYTALEF = 31
	DRAGONSD = 32
	FLOWERGARDENF = 33
	STARLIGHTA = 34
	NEWW = 35
	INVERSEF = 36
	PSYCHICT = 37
	INDOORA = 38
	INDOORB = 39
	INDOORC = 40
	CITY = 41
	CITYNEW = 42
  GUFIELD = 43
  DWORLD = 44
  FALLOUT = 45
end
