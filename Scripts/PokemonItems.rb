ITEMID        = 0
ITEMNAME      = 1
ITEMPOCKET    = 2
ITEMPRICE     = 3
ITEMDESC      = 4
ITEMUSE       = 5
ITEMBATTLEUSE = 6
ITEMTYPE      = 7
ITEMMACHINE   = 8


SEEDS = [PBItems::ELEMENTALSEED,PBItems::MAGICALSEED,PBItems::TELLURICSEED,PBItems::SYNTHETICSEED]
GEMS = [PBItems::FIREGEM,PBItems::WATERGEM,PBItems::ELECTRICGEM,PBItems::GRASSGEM,
  PBItems::ICEGEM,PBItems::FIGHTINGGEM,PBItems::POISONGEM,PBItems::GROUNDGEM,
  PBItems::FLYINGGEM,PBItems::PSYCHICGEM,PBItems::BUGGEM,PBItems::ROCKGEM,
  PBItems::GHOSTGEM,PBItems::DRAGONGEM,PBItems::DARKGEM,PBItems::STEELGEM,
  PBItems::NORMALGEM,PBItems::FAIRYGEM,PBItems::NUCLEARGEM,PBItems::COSMICGEM]
EVOSTONES = [PBItems::FIRESTONE,PBItems::THUNDERSTONE,PBItems::WATERSTONE,
  PBItems::LEAFSTONE,PBItems::MOONSTONE,PBItems::SUNSTONE,PBItems::DUSKSTONE,
  PBItems::DAWNSTONE,PBItems::SHINYSTONE,PBItems::LINKSTONE,PBItems::ICESTONE,PBItems::ABYSSALCORE]
MULCH = [PBItems::GROWTHMULCH,PBItems::DAMPMULCH,PBItems::STABLEMULCH,PBItems::GOOEYMULCH]

def pbIsHiddenMove?(move)
  return false if !$cache.items
  for i in 0...$cache.items.length
    next if !$cache.items[i]
    next if !pbIsHiddenMachine?(i)
    atk=$cache.items[i][ITEMMACHINE]
    return true if move==atk
  end
  return false
end

def pbGetPrice(item)
  return $cache.items[item][ITEMPRICE]
end

def pbGetPocket(item)
  return $cache.items[item][ITEMPOCKET]
end

# Important items can't be sold, given to hold, or tossed.
def pbIsImportantItem?(item)
  return $cache.items[item] && (pbIsKeyItem?(item) || pbIsHiddenMachine?(item) ||
                             (INFINITETMS && pbIsTechnicalMachine?(item)) ||
                             pbIsZCrystal2?(item))
end

def pbIsMachine?(item)
  return $cache.items[item] && (pbIsTechnicalMachine?(item) || pbIsHiddenMachine?(item))
end

def pbIsTechnicalMachine?(item)
  return $cache.items[item] && ($cache.items[item][ITEMUSE]==3)
end

def pbIsHiddenMachine?(item)
  return $cache.items[item] && ($cache.items[item][ITEMUSE]==4)
end

def pbIsMail?(item)
  return $cache.items[item] && ($cache.items[item][ITEMTYPE]==1 || $cache.items[item][ITEMTYPE]==2)
end

def pbIsSnagBall?(item)
  return $cache.items[item] && ($cache.items[item][ITEMTYPE]==3 ||
                            ($cache.items[item][ITEMTYPE]==4 && $PokemonGlobal.snagMachine))
end

def pbIsPokeBall?(item)
  return $cache.items[item] && ($cache.items[item][ITEMTYPE]==3 || $cache.items[item][ITEMTYPE]==4)
end

def pbIsBerry?(item)
  return $cache.items[item] && ($cache.items[item][ITEMTYPE]==5)
end

def pbIsSeed?(item)
  return true if SEEDS.include?(item)
  return false  
end

def pbIsTypeGem?(item)
  return true if GEMS.include?(item)
  return false
end

def pbIsKeyItem?(item)
  return $cache.items[item] && ($cache.items[item][ITEMTYPE]==6)
end

def pbIsZCrystal?(item)
  return $cache.items[item] && ($cache.items[item][ITEMTYPE]==7)
end

def pbIsZCrystal2?(item)
  return $cache.items[item] && ($cache.items[item][ITEMTYPE]==8)
end

def pbIsBattleEndingItem?(item)
  return false
end

def pbIsEvolutionStone?(item)
  return true if EVOSTONES.include?(item)
  return false
end

def pbIsMulch?(item)
  return true if MULCH.include?(item)
  return false
end

def pbIsGoodItem(item)
  return [PBItems::CHOICEBAND,PBItems::CHOICESCARF,PBItems::CHOICESPECS,PBItems::FOCUSSASH,
          PBItems::LUCKYEGG,PBItems::EXPSHARE,PBItems::LIFEORB,PBItems::LEFTOVERS,PBItems::EVIOLITE,
          PBItems::ASSAULTVEST,PBItems::ROCKYHELMET].include?(item) || pbGetMegaStoneList.include?(item)
end

def pbTopRightWindow(text)
  window=Window_AdvancedTextPokemon.new(text)
  window.z=99999
  window.width=198
  window.y=0
  window.x=Graphics.width-window.width
  pbPlayDecisionSE()
  loop do
    Graphics.update
    Input.update
    window.update
    if Input.trigger?(Input::C)
      break
    end
  end
  window.dispose
end

class ItemHandlerHash < HandlerHash
  def initialize
    super(:PBItems)
  end
end

module ItemHandlers
  UseFromBag=ItemHandlerHash.new
  UseInField=ItemHandlerHash.new
  UseOnPokemon=ItemHandlerHash.new
  BattleUseOnBattler=ItemHandlerHash.new
  BattleUseOnPokemon=ItemHandlerHash.new
  UseInBattle=ItemHandlerHash.new
  MultipleAtOnce=arrayToConstant(PBItems,[:EXPCANDYL,:EXPCANDYXL,:EXPCANDYM,:EXPCANDYS,:EXPCANDYXS, :RARECANDY])

  def self.addUseFromBag(item,proc)
    UseFromBag.add(item,proc)
  end

  def self.addUseInField(item,proc)
    UseInField.add(item,proc)
  end

  def self.addUseOnPokemon(item,proc)
    UseOnPokemon.add(item,proc)
  end

  def self.addBattleUseOnBattler(item,proc)
    BattleUseOnBattler.add(item,proc)
  end

  def self.addBattleUseOnPokemon(item,proc)
    BattleUseOnPokemon.add(item,proc)
  end

  def self.hasOutHandler(item)                       # Shows "Use" option in Bag
    return UseFromBag[item]!=nil || UseOnPokemon[item]!=nil
  end

  def self.hasKeyItemHandler(item)              # Shows "Register" option in Bag
    return UseInField[item]!=nil
  end

  def self.hasBattleUseOnBattler(item)
    return BattleUseOnBattler[item]!=nil
  end

  def self.hasBattleUseOnPokemon(item)
    return BattleUseOnPokemon[item]!=nil
  end

  def self.hasUseInBattle(item)
    return UseInBattle[item]!=nil
  end

  def self.triggerUseFromBag(item)
    # Return value:
    # 0 - Item not used
    # 1 - Item used, don't end screen
    # 2 - Item used, end screen
    # 3 - Item used, consume item
    # 4 - Item used, end screen, consume item
    if !UseFromBag[item]
      # Check the UseInField handler if present
      if UseInField[item]
        UseInField.trigger(item)
        return 1 # item was used
      end
      return 0 # item was not used
    else
      UseFromBag.trigger(item)
    end
  end

  def self.triggerUseInField(item)
    # No return value
    if !UseInField[item]
      return false
    else
      UseInField.trigger(item)
      return true
    end
  end

  def self.triggerUseOnPokemon(item,pokemon,scene)
    # Returns whether item was used
    if !UseOnPokemon[item]
      return false
    else
      return UseOnPokemon.trigger(item,pokemon,scene)
    end
  end

  def self.triggerBattleUseOnBattler(item,battler,scene)
    # Returns whether item was used
    if !BattleUseOnBattler[item]
      return false
    else
      return BattleUseOnBattler.trigger(item,battler,scene)
    end
  end

  def self.triggerBattleUseOnPokemon(item,pokemon,battler,scene)
    # Returns whether item was used
    if !BattleUseOnPokemon[item]
      return false
    else
      return BattleUseOnPokemon.trigger(item,pokemon,battler,scene)
    end
  end

  def self.triggerUseInBattle(item,battler,battle)
    # Returns whether item was used
    if !UseInBattle[item]
      return
    else
      UseInBattle.trigger(item,battler,battle)
    end
  end
end



def pbItemRestoreHP(pokemon,restorehp)
  newhp=pokemon.hp+restorehp
  newhp=pokemon.totalhp if newhp>pokemon.totalhp
  hpgain=newhp-pokemon.hp
  pokemon.hp=newhp
  return hpgain
end

def pbHPItem(pokemon,restorehp,scene)
  if pokemon.hp<=0 || pokemon.hp==pokemon.totalhp || pokemon.isEgg?
    scene.pbDisplay(_INTL("It won't have any effect."))
    return false
  else
    hpgain=pbItemRestoreHP(pokemon,restorehp)
    scene.pbRefresh
    scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.",pokemon.name,hpgain))
    return true
  end
end

def pbBattleHPItem(pokemon,battler,restorehp,scene)
  if pokemon.hp<=0 || pokemon.hp==pokemon.totalhp || pokemon.isEgg?
    scene.pbDisplay(_INTL("But it had no effect!"))
    return false
  else
    hpgain=pbItemRestoreHP(pokemon,restorehp)
    battler.hp=pokemon.hp if battler
    scene.pbRefresh
    scene.pbDisplay(_INTL("{1}'s HP was restored.",pokemon.name,hpgain))
    return true
  end
end

def pbJustRaiseEffortValues(pokemon,ev,evgain)
  totalev=0
  for i in 0...6
    totalev+=pokemon.ev[i]
  end
  if totalev+evgain>510 && !$game_switches[:No_Total_EV_Cap]
    # Bug Fix: must use "-=" instead of "="
    evgain-=totalev+evgain-510
  end
  if pokemon.ev[ev]+evgain>252
    # Bug Fix: must use "-=" instead of "="
    evgain-=pokemon.ev[ev]+evgain-252
  end
  if evgain>0
    pokemon.ev[ev]+=evgain
    pokemon.calcStats
  end
  return evgain
end

def pbRaiseEffortValues(pokemon,ev,evgain=32,evlimit=true)
 # if pokemon.ev[ev]>=100 && evlimit
 #   return 0
 # end
  totalev=0
  for i in 0...6
    totalev+=pokemon.ev[i]
  end
  if totalev+evgain>510 && !$game_switches[:No_Total_EV_Cap]
    evgain=510-totalev
  end
  if pokemon.ev[ev]+evgain>252
    evgain=252-pokemon.ev[ev]
  end
  #if evlimit && pokemon.ev[ev]+evgain>100
  #  evgain=100-pokemon.ev[ev]
  #end
  if evgain>0
    pokemon.ev[ev]+=evgain
    pokemon.calcStats
  end
  return evgain
end

def pbRestorePP(pokemon,move,pp)
  return 0 if pokemon.moves[move].id==0
  return 0 if pokemon.moves[move].totalpp==0
  newpp=pokemon.moves[move].pp+pp
  if newpp>pokemon.moves[move].totalpp
    newpp=pokemon.moves[move].totalpp
  end
  oldpp=pokemon.moves[move].pp
  pokemon.moves[move].pp=newpp
  return newpp-oldpp
end

def pbBattleRestorePP(pokemon,battler,move,pp)
  ret=pbRestorePP(pokemon,move,pp)
  if ret>0
    battler.pbSetPP(battler.moves[move],pokemon.moves[move].pp) if battler
  end
  return ret
end

def pbBikeCheck
  if $PokemonGlobal.surfing ||
     (!$PokemonGlobal.bicycle && (pbGetTerrainTag==PBTerrain::TallGrass || pbGetTerrainTag==PBTerrain::SandDune))
    Kernel.pbMessage(_INTL("Can't use that here."))
    return false
  end
  if $game_player.pbHasDependentEvents?
    Kernel.pbMessage(_INTL("It can't be used when you have someone with you."))
    return false
  end
  if $PokemonGlobal.bicycle
    if pbGetMetadata($game_map.map_id,MetadataBicycleAlways)
      Kernel.pbMessage(_INTL("You can't dismount your Bike here."))
      return false
    end
    return true
  else
    val=pbGetMetadata($game_map.map_id,MetadataBicycle)
    val=pbGetMetadata($game_map.map_id,MetadataOutdoor) if val==nil
    if !val
      Kernel.pbMessage(_INTL("Can't use that here."))
      return false
    end
    return true
  end
end

def pbClosestHiddenItem
  result = []
  playerX=$game_player.x
  playerY=$game_player.y
  for event in $game_map.events.values
    next if event.name!="HiddenItem"
    next if (playerX-event.x).abs>=8
    next if (playerY-event.y).abs>=6
    next if $game_self_switches[[$game_map.map_id,event.id,"A"]]
    next if $game_self_switches[[$game_map.map_id,event.id,"B"]]
    next if $game_self_switches[[$game_map.map_id,event.id,"C"]]
    next if $game_self_switches[[$game_map.map_id,event.id,"D"]]
    result.push(event)
  end
  return nil if result.length==0
  ret=nil
  retmin=0
  for event in result
    dist=(playerX-event.x).abs+(playerY-event.y).abs
    if !ret || retmin>dist
      ret=event
      retmin=dist
    end
  end
  return ret
end

def Kernel.pbUseKeyItemInField(item)
  if !ItemHandlers.triggerUseInField(item)
    Kernel.pbMessage(_INTL("Can't use that here.")) if $game_switches[:Application_Applied] === false
  end
end

def pbSpeciesCompatible?(species,move,pokemon)  
  ret=false
  return false if species<=0
  case species
    when PBSpecies::CHARIZARD #Charizard
      if pokemon.form==0
        if (move == PBMoves::AGILITY) || (move == PBMoves::DRACOMETEOR) ||
          (move == PBMoves::SHADOWBALL) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::THUNDERBOLT) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::AGILITY) || (move == PBMoves::DRACOMETEOR) ||
          (move == PBMoves::SHADOWBALL) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::THUNDERBOLT) || (move == PBMoves::VOLTSWITCH)
        end 
      end
    when PBSpecies::RATTATA #Rattata
      if pokemon.form==0
        if (move == PBMoves::TORMENT) ||
          (move == PBMoves::QUASH) || (move == PBMoves::EMBARGO) ||
          (move == PBMoves::SHADOWCLAW) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::SNATCH)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::WORKUP) || (move == PBMoves::CHARGEBEAM) ||
          (move == PBMoves::WILDCHARGE)
        end 
      end
    when PBSpecies::RATICATE #Raticate
      if pokemon.form==0
        if (move == PBMoves::TORMENT) ||
          (move == PBMoves::QUASH) || (move == PBMoves::EMBARGO) ||
          (move == PBMoves::SHADOWCLAW) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::BULKUP) ||
          (move == PBMoves::VENOSHOCK) || (move == PBMoves::SLUDGEWAVE) || 
          (move == PBMoves::SNATCH) || (move == PBMoves::KNOCKOFF)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::WORKUP) || (move == PBMoves::CHARGEBEAM) ||
          (move == PBMoves::WILDCHARGE)
          return false
        end 
      end      
    when PBSpecies::RAICHU #Raichu
      if pokemon.form==0
        if (move == PBMoves::PSYSHOCK) || (move == PBMoves::TELEPORT) ||
          (move == PBMoves::SAFEGUARD) || (move == PBMoves::PSYCHIC) ||
          (move == PBMoves::MAGICCOAT) || (move == PBMoves::PSYCHICNOISE) ||
          (move == PBMoves::MAGICROOM) || (move == PBMoves::RECYCLE) ||
          (move == PBMoves::TELEKINESIS) || (move == PBMoves::ALLYSWITCH) ||
	        (move == PBMoves::FUTURESIGHT) || (move == PBMoves::STOREDPOWER) ||
	        (move == PBMoves::SKILLSWAP) || (move == PBMoves::PSYCHICTERRAIN) ||
	        (move == PBMoves::EXPANDINGFORCE) || (move == PBMoves::SPEEDSWAP)
          return false
        end
      elsif pokemon.form==1
	      if (move == PBMoves::HORNDRILL) || (move == PBMoves::BRUTALSWING)
	        return false
	      end
      end     
    when PBSpecies::SANDSHREW #Sandshrew
      if pokemon.form==0
        if (move == PBMoves::HAIL) || (move == PBMoves::BLIZZARD) || (move == PBMoves::ICESPINNER) ||
          (move == PBMoves::FROSTBREATH) || (move == PBMoves::IRONHEAD) || (move == PBMoves::FLASHCANNON) ||
          (move == PBMoves::ICEPUNCH) || (move == PBMoves::IRONDEFENSE) || (move == PBMoves::AVALANCHE) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::AQUATAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::ICEBALL) || (move == PBMoves::AURORAVEIL) || (move == PBMoves::SNOWSCAPE) ||
	        (move == PBMoves::STEELBEAM) || (move == PBMoves::TRIPLEAXEL) || (move == PBMoves::ICICLESPEAR)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SANDSTORM) || (move == PBMoves::SMACKDOWN) || (move == PBMoves::STONEEDGE) ||
          (move == PBMoves::EARTHPOWER) || (move == PBMoves::STOMPINGTANTRUM) || (move == PBMoves::MUDSHOT) ||
	        (move == PBMoves::FALSESWIPE) || (move == PBMoves::AGILITY) || (move == PBMoves::SPIKES) ||
	        (move == PBMoves::HIGHHORSEPOWER) || (move == PBMoves::SCORCHINGSANDS)
          return false
        end  
      end      
    when PBSpecies::SANDSLASH #Sandslash
      if pokemon.form==0
        if (move == PBMoves::HAIL) || (move == PBMoves::BLIZZARD) || (move == PBMoves::ICESPINNER) ||
          (move == PBMoves::FROSTBREATH) || (move == PBMoves::IRONHEAD) || (move == PBMoves::FLASHCANNON) ||
          (move == PBMoves::ICEPUNCH) || (move == PBMoves::IRONDEFENSE) || (move == PBMoves::AVALANCHE) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::AQUATAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::ICEBALL) || (move == PBMoves::AURORAVEIL) || (move == PBMoves::SNOWSCAPE) ||
	        (move == PBMoves::STEELBEAM) || (move == PBMoves::TRIPLEAXEL) || (move == PBMoves::ICICLESPEAR)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SANDSTORM) || (move == PBMoves::SMACKDOWN) || (move == PBMoves::GUNKSHOT) ||
          (move == PBMoves::EARTHPOWER) || (move == PBMoves::STOMPINGTANTRUM) || (move == PBMoves::MUDSHOT) ||
	        (move == PBMoves::HIGHHORSEPOWER) || (move == PBMoves::SCORCHINGSANDS)
          return false
        end  
      end      
    when PBSpecies::VULPIX #Vulpix
      if pokemon.form==0
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) || (move == PBMoves::CHILLINGWATER) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::RAINDANCE) || (move == PBMoves::DISARMINGVOICE) ||
          (move == PBMoves::AURORAVEIL) || (move == PBMoves::FROSTBREATH) || (move == PBMoves::FAKETEARS) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::AQUATAIL) || (move == PBMoves::POWDERSNOW) ||
          (move == PBMoves::HEALBELL) || (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::SNOWSCAPE) ||
	        (move == PBMoves::STOREDPOWER) || (move == PBMoves::PLAYROUGH) || (move == PBMoves::MISTYTERRAIN) ||
	        (move == PBMoves::ICICLESPEAR) || (move == PBMoves::CELEBRATE) || (move == PBMoves::ICEFANG) ||
	        (move == PBMoves::DRAININGKISS)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SUNNYDAY) || (move == PBMoves::FLAMECHARGE) || (move == PBMoves::REVERSAL) ||
          (move == PBMoves::OVERHEAT) || (move == PBMoves::POUNCE) || (move == PBMoves::FUTURESIGHT) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::OMINOUSWIND) || (move == PBMoves::SACREDFIRE) ||
	        (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::FLAREBLITZ) || (move == PBMoves::SNARL) ||
	        (move == PBMoves::BURNINGJEALOUSY) || (move == PBMoves::FLAMEWHEEL)
          return false
        end  
      elsif pokemon.form==2
         if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) || (move == PBMoves::CHILLINGWATER) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::RAINDANCE) || (move == PBMoves::DISARMINGVOICE) ||
          (move == PBMoves::AURORAVEIL) || (move == PBMoves::FROSTBREATH) || (move == PBMoves::FAKETEARS) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::AQUATAIL) || (move == PBMoves::POWDERSNOW) ||
          (move == PBMoves::HEALBELL) || (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::SNOWSCAPE) ||
	        (move == PBMoves::STOREDPOWER) || (move == PBMoves::PLAYROUGH) || (move == PBMoves::MISTYTERRAIN) ||
	        (move == PBMoves::ICICLESPEAR) || (move == PBMoves::CELEBRATE) || (move == PBMoves::ICEFANG) ||
	        (move == PBMoves::DRAININGKISS)
          return false
        end
	    elsif pokemon.form==2
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
          (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARFANGS) ||
          (move == PBMoves::EXPUNGE)
          return true
        end
      end      
    when PBSpecies::NINETALES #Ninetales
      if pokemon.form==0
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) || (move == PBMoves::CHILLINGWATER) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::RAINDANCE) || (move == PBMoves::DISARMINGVOICE) ||
          (move == PBMoves::AURORAVEIL) || (move == PBMoves::FROSTBREATH) || (move == PBMoves::AVALANCHE) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::AQUATAIL) || (move == PBMoves::POWDERSNOW) ||
          (move == PBMoves::HEALBELL) || (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::SNOWSCAPE) ||
	        (move == PBMoves::PLAYROUGH) || (move == PBMoves::MISTYTERRAIN) || (move == PBMoves::WONDERROOM) ||
	        (move == PBMoves::ICICLESPEAR) || (move == PBMoves::CELEBRATE) || (move == PBMoves::ICEFANG) ||
	        (move == PBMoves::DRAININGKISS) || (move == PBMoves::TRIPLEAXEL)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SUNNYDAY) || (move == PBMoves::FLAMECHARGE) || (move == PBMoves::REVERSAL) ||
          (move == PBMoves::OVERHEAT) || (move == PBMoves::POUNCE) || (move == PBMoves::FUTURESIGHT) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::OMINOUSWIND) || (move == PBMoves::SACREDFIRE) ||
	        (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::FLAREBLITZ) || (move == PBMoves::SNARL) ||
	        (move == PBMoves::BURNINGJEALOUSY) || (move == PBMoves::FLAMEWHEEL) || (move == PBMoves::PSYCHIC) ||
	        (move == PBMoves::SOLARBEAM) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::NIGHTSHADE) ||
	        (move == PBMoves::SCORCHINGSANDS)
          return false
        end 
      elsif pokemon.form==2
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
          (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARFANGS) ||
          (move == PBMoves::EXPUNGE)
          return true
      elsif pokemon.form==2
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) || (move == PBMoves::CHILLINGWATER) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::RAINDANCE) || (move == PBMoves::DISARMINGVOICE) ||
          (move == PBMoves::AURORAVEIL) || (move == PBMoves::FROSTBREATH) || (move == PBMoves::AVALANCHE) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::AQUATAIL) || (move == PBMoves::POWDERSNOW) ||
          (move == PBMoves::HEALBELL) || (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::SNOWSCAPE) ||
	        (move == PBMoves::PLAYROUGH) || (move == PBMoves::MISTYTERRAIN) || (move == PBMoves::WONDERROOM) ||
	        (move == PBMoves::ICICLESPEAR) || (move == PBMoves::CELEBRATE) || (move == PBMoves::ICEFANG) ||
	        (move == PBMoves::DRAININGKISS) || (move == PBMoves::TRIPLEAXEL)
          end
        end
      end  
    when PBSpecies::DIGLETT #Diglett
      if pokemon.form==0
        if (move == PBMoves::FLASHCANNON) || (move == PBMoves::SCARYFACE) || (move == PBMoves::METALSOUND) ||
          (move == PBMoves::IRONDEFENSE) || (move == PBMoves::IRONHEAD) || (move == PBMoves::METALCLAW) ||
	        (move == PBMoves::STEELBEAM)
          return false
        end
      elsif pokemon.form==1
	      if (move == PBMoves::THROATCHOP) || (move == PBMoves::ENDEAVOR) || (move == PBMoves::ZAPCANNON) ||
	        (move == PBMoves::LOCKON) || (move == PBMoves::SPIKES) || (move == PBMoves::CURSE)
	        return false
	      end
      end       
    when PBSpecies::DUGTRIO #Dugtrio
      if pokemon.form==0
        if (move == PBMoves::FLASHCANNON) || (move == PBMoves::SCARYFACE) || (move == PBMoves::METALSOUND) ||
          (move == PBMoves::IRONDEFENSE) || (move == PBMoves::IRONHEAD) || (move == PBMoves::METALCLAW) ||
	        (move == PBMoves::STEELBEAM)
          return false
        end
      elsif pokemon.form==1
	      if (move == PBMoves::ZAPCANNON) || (move == PBMoves::LOCKON) || (move == PBMoves::SPIKES)
	      return false
	    end
    end      
    when PBSpecies::MEOWTH #Meowth
      if pokemon.form==0
        if (move == PBMoves::QUASH) || (move == PBMoves::EMBARGO) || (move == PBMoves::FLASHCANNON) ||
          (move == PBMoves::SWORDSDANCE) || (move == PBMoves::CRUNCH) || (move == PBMoves::METRONOME) ||
          (move == PBMoves::IRONDEFENSE) || (move == PBMoves::GYROBALL) || (move == PBMoves::FLING) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::METALSOUND) || (move == PBMoves::BRICKBREAK) ||
	        (move == PBMoves::XSCISSOR) || (move == PBMoves::STEALTHROCK) || (move == PBMoves::STEELBEAM) ||
	        (move == PBMoves::CONFUSERAY)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SWORDSDANCE) || (move == PBMoves::CRUNCH) || (move == PBMoves::FLING) ||
          (move == PBMoves::IRONDEFENSE) || (move == PBMoves::GYROBALL) || (move == PBMoves::BRICKBREAK) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::HONECLAWS) || (move == PBMoves::METALSOUND) ||
	        (move == PBMoves::FALSESWIPE) || (move == PBMoves::METRONOME) || (move == PBMoves::FLASHCANNON) ||
	        (move == PBMoves::XSCISSOR) || (move == PBMoves::STEALTHROCK) || (move == PBMoves::STEELBEAM)
          return false
        end
      elsif pokemon.form==2
        if (move == PBMoves::ICYWIND) || (move == PBMoves::CHARM) || (move == PBMoves::TOXIC) ||
          (move == PBMoves::SWIFT) || (move == PBMoves::QUASH) || (move == PBMoves::HYPNOSIS) ||
	        (move == PBMoves::BUBBLEBEAM)|| (move == PBMoves::SPIKES) || (move == PBMoves::PERISHSONG) ||
	        (move == PBMoves::EMBARGO) || (move == PBMoves::PSYCHUP) || (move == PBMoves::DREAMEATER) ||
	        (move == PBMoves::SWIFT) || (move == PBMoves::CONFIDE) || (move == PBMoves::WATERGUN) ||
	        (move == PBMoves::AGILITY) || (move == PBMoves::CONFUSERAY) || (move == PBMoves::CHILLINGWATER) ||
	        (move == PBMoves::SNARL) || (move == PBMoves::THUNDERWAVE) || (move == PBMoves::SNATCH) ||
	        (move == PBMoves::LASTRESORT) || (move == PBMoves::WATERPULSE) || (move == PBMoves::QUICKATTACK) ||
	        (move == PBMoves::ENCORE) || (move == PBMoves::NIGHTMARE) || (move == PBMoves::TORMENT) ||
	        (move == PBMoves::FLASH) || (move == PBMoves::POUNCE) || (move == PBMoves::LUNGE)
          return false
        end
      end 
    when PBSpecies::PERSIAN #Persian
      if pokemon.form==0
        if (move == PBMoves::QUASH) || (move == PBMoves::SMACKDOWN) || (move == PBMoves::CONFUSERAY) ||
          (move == PBMoves::BURNINGJEALOUSY) || (move == PBMoves::BEATUP)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::HONECLAWS) || (move == PBMoves::FALSESWIPE)
          return false
        end
      end 
    when PBSpecies::GEODUDE #Geodude
      if pokemon.form==0
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) || (move == PBMoves::SUPERCELLSLAM) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::THUNDERWAVE) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::VOLTSWITCH) || (move == PBMoves::MAGNETRISE) || (move == PBMoves::SCREECH) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::CHARGE) || (move == PBMoves::SPARK) ||
	        (move == PBMoves::ZAPCANNON)
          return false
        end
      elsif pokemon.form==1
	      if (move == PBMoves::INCINERATE) || (move == PBMoves::SCARYFACE) || (move == PBMoves::STOMPINGTANTRUM) ||
	        (move == PBMoves::REFLECT) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::ROAR)
	        return false
	      end
      end   
    when PBSpecies::GRAVELER #Graveler
      if pokemon.form==0
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) || (move == PBMoves::SUPERCELLSLAM) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::THUNDERWAVE) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::VOLTSWITCH) || (move == PBMoves::MAGNETRISE) || (move == PBMoves::ELECTRICTERRAIN) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::CHARGE) || (move == PBMoves::SPARK) ||
	        (move == PBMoves::ZAPCANNON) || (move == PBMoves::ALLYSWITCH) || (move == PBMoves::SHOCKWAVE)
          return false
        end
      elsif pokemon.form==1
	      if (move == PBMoves::INCINERATE) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::BODYPRESS) ||
	        (move == PBMoves::REFLECT) || (move == PBMoves::IRONHEAD) || (move == PBMoves::FISSURE) ||
	        (move == PBMoves::ROAR)
	        return false
	      end
      end      
    when PBSpecies::GOLEM #Golem
      if pokemon.form==0
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) || (move == PBMoves::SUPERCELLSLAM) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::THUNDERWAVE) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::VOLTSWITCH) || (move == PBMoves::MAGNETRISE) || (move == PBMoves::ELECTRICTERRAIN) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::CHARGE) || (move == PBMoves::SPARK) ||
	        (move == PBMoves::ZAPCANNON) || (move == PBMoves::ALLYSWITCH) || (move == PBMoves::SHOCKWAVE) ||
	        (move == PBMoves::ECHOEDVOICE) || (move == PBMoves::METEORBEAM)
          return false
        end
      elsif pokemon.form==1
	      if (move == PBMoves::INCINERATE) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::ROAR) ||
	        (move == PBMoves::REFLECT) || (move == PBMoves::FISSURE) || (move == PBMoves::AVALANCHE)
	        return false
	      end
      end    
    when PBSpecies::GRIMER #Grimer
      if pokemon.form==0
        if (move == PBMoves::SPITE) || (move == PBMoves::QUASH) || (move == PBMoves::SWIFT) ||
          (move == PBMoves::EMBARGO) || (move == PBMoves::ROCKPOLISH) || (move == PBMoves::DARKPULSE) ||
          (move == PBMoves::STONEEDGE) || (move == PBMoves::SNARL) || (move == PBMoves::GIGAIMPACT) ||
          (move == PBMoves::POISONFANG) || (move == PBMoves::GASTROACID) || (move == PBMoves::HYPERBEAM) ||
	        (move == PBMoves::CRUNCH)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::INCINERATE)
          return false
        end
      elsif pokemon.form==3
        if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARFANGS) ||
           (move == PBMoves::HALFLIFE) || (move == PBMoves::EXPUNGE) || (move == PBMoves::ATOMICPUNCH) ||
           (move == PBMoves::MELTDOWN) || (move == PBMoves::BLASTWAVE)
          return true
        end
      elsif pokemon.form==4 #Egho
        if (move == PBMoves::BRUTALSWING) || (move == PBMoves::QUASH) ||
          (move == PBMoves::EMBARGO) || (move == PBMoves::ROCKPOLISH) ||
          (move == PBMoves::STONEEDGE) || (move == PBMoves::SNARL) ||
          (move == PBMoves::KNOCKOFF) || (move == PBMoves::GASTROACID) ||
          (move == PBMoves::SPITE) ||
          (move == PBMoves::SOLARBEAM) || (move == PBMoves::SMACKDOWN) ||
          (move == PBMoves::EARTHQUAKE) || (move == PBMoves::BULLDOZE) ||
          (move == PBMoves::DRAINPUNCH) || (move == PBMoves::EARTHPOWER) ||
          (move == PBMoves::STEALTHROCK) || (move == PBMoves::FIRESPIN) ||
          (move == PBMoves::SANDTOMB) || (move == PBMoves::POWERGEM) ||
          (move == PBMoves::STEELROLLER)
          return true
        end
      elsif pokemon.form==4 #Egho
        if (move == PBMoves::RAINDANCE) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::INFESTATION) ||
          (move == PBMoves::GASTROACID) || (move == PBMoves::GIGADRAIN) ||
          (move == PBMoves::ICEPUNCH) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::CRUNCH)
          return false
        end
      end 
    when PBSpecies::MUK #Muk
      if pokemon.form==0
        if (move == PBMoves::POISONFANG) || (move == PBMoves::QUASH) || (move == PBMoves::RECYCLE) ||
          (move == PBMoves::EMBARGO) || (move == PBMoves::ROCKPOLISH) || (move == PBMoves::FOULPLAY) ||
          (move == PBMoves::STONEEDGE) || (move == PBMoves::SNARL) || (move == PBMoves::CRUNCH) ||
          (move == PBMoves::GASTROACID)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::INCINERATE) || (move == PBMoves::TOXICSPIKES) || (move == PBMoves::LUNGE)
          return false
        end
      elsif pokemon.form==3
        if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARFANGS) ||
          (move == PBMoves::HALFLIFE) || (move == PBMoves::EXPUNGE) || (move == PBMoves::ATOMICPUNCH) ||
          (move == PBMoves::MELTDOWN) || (move == PBMoves::BLASTWAVE)
          return true
        end
      elsif pokemon.form==4 #Egho
        if (move == PBMoves::BRUTALSWING) || (move == PBMoves::QUASH) ||
          (move == PBMoves::EMBARGO) || (move == PBMoves::ROCKPOLISH) ||
          (move == PBMoves::STONEEDGE) || (move == PBMoves::SNARL) ||
          (move == PBMoves::KNOCKOFF) || (move == PBMoves::GASTROACID) ||
          (move == PBMoves::SPITE) || (move == PBMoves::RECYCLE) ||
          (move == PBMoves::SOLARBEAM) || (move == PBMoves::SMACKDOWN) ||
          (move == PBMoves::EARTHQUAKE) || (move == PBMoves::BULLDOZE) ||
          (move == PBMoves::DRAINPUNCH) || (move == PBMoves::EARTHPOWER) ||
          (move == PBMoves::STEALTHROCK) || (move == PBMoves::FIRESPIN) ||
          (move == PBMoves::SANDTOMB) || (move == PBMoves::POWERGEM) ||
          (move == PBMoves::STEELROLLER)
          return true
        end
      elsif pokemon.form==4 #Egho
        if (move == PBMoves::RAINDANCE) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::INFESTATION) ||
          (move == PBMoves::GASTROACID) || (move == PBMoves::GIGADRAIN) ||
          (move == PBMoves::ICEPUNCH) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::CRUNCH) || (move == PBMoves::FOULPLAY) ||
          (move == PBMoves::VENOMDRENCH)
          return false
        end
      end
    when PBSpecies::EXEGGUTOR # Exeggutor
      if pokemon.form==0
        if (move == PBMoves::DRACOMETEOR) || (move == PBMoves::BRICKBREAK) || (move == PBMoves::BREAKINGSWIPE) ||
          (move == PBMoves::FLAMETHROWER) || (move == PBMoves::BRUTALSWING) || (move == PBMoves::TRAILBLAZE) ||
          (move == PBMoves::OUTRAGE) || (move == PBMoves::DRAGONTAIL) || (move == PBMoves::DRAGONCHEER) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::SUPERPOWER) ||
          (move == PBMoves::DRAGONPULSE) || (move == PBMoves::IRONTAIL) ||
          (move == PBMoves::KNOCKOFF)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::PSYCHOCUT) || (move == PBMoves::FUTURESIGHT) || (move == PBMoves::EXPANDINGFORCE)
          return false
        end
      end
    when PBSpecies::MAROWAK # Marowak
      if pokemon.form==0
        if (move == PBMoves::RAINDANCE) || (move == PBMoves::THUNDERBOLT) || (move == PBMoves::FLAMEWHEEEL) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::FIRESPIN) ||
          (move == PBMoves::FLAMECHARGE) || (move == PBMoves::WILLOWISP) || (move == PBMoves::HEX) ||
          (move == PBMoves::DREAMEATER) || (move == PBMoves::DARKPULSE) || (move == PBMoves::FLAREBLITZ) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::PAINSPLIT) || (move == PBMoves::IMPRISON) ||
          (move == PBMoves::SPITE) || (move == PBMoves::ALLYSWITCH) || (move == PBMoves::BURNINGJEALOUSY) ||
          (move == PBMoves::POLTERGEIST)
          return false
        end
      end
    when PBSpecies::MISDREAVUS # Misdreavus -- Aevian
      if pokemon.form==0
        if (move == PBMoves::WORKUP) || (move == PBMoves::VENOSHOCK) ||
          (move == PBMoves::SOLARBEAM) || (move == PBMoves::SWORDSDANCE) ||
          (move == PBMoves::INFESTATION) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::LEECHLIFE) ||
          (move == PBMoves::CUT) || (move == PBMoves::BIND) ||
          (move == PBMoves::WORRYSEED) || (move == PBMoves::GIGADRAIN) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WATERPULSE) ||
          (move == PBMoves::SEEDBOMB) || (move == PBMoves::GASTROACID) ||
          (move == PBMoves::THROATCHOP) || (move == PBMoves::GUNKSHOT) ||
          (move == PBMoves::KNOCKOFF) 
          return false
        end
      elsif pokemon.form==1
        if arrayToConstant(PBMoves,[# TMs
          :WORKUP,:TOXIC,:VENOSHOCK,:HIDDENPOWER,:SUNNYDAY,:TAUNT,
          :PROTECT,:RAINDANCE,:SECRETPOWER,:FRUSTRATION,:SOLARBEAM,
          :RETURN,:SHADOWBALL,:DOUBLETEAM,:AERIALACE,:FACADE,:REST,
          :ATTRACT,:ROUND,:ECHOEDVOICE,:ENERGYBALL,:QUASH,:WILLOWISP,
          :EMBARGO,:SWORDSDANCE,:PSYCHUP,:INFESTATION,:GRASSKNOT,
          :SWAGGER,:SLEEPTALK,:SUBSTITUTE,:NATUREPOWER,:CONFIDE,
          :LEECHLIFE,:PINMISSILE,:MAGICALLEAF,:SCREECH,:SCARYFACE,
          :BULLETSEED,:CROSSPOISON,:HEX,:PHANTOMFORCE,:DRAININGKISS,
          :SUCKERPUNCH,:CUT,
          # Move Tutors
          :SNORE,:HEALBELL,:UPROAR,:BIND,:WORRYSEED,:SNATCH,:SPITE,
          :GIGADRAIN,:SYNTHESIS,:ALLYSWITCH,:WATERPULSE,:PAINSPLIT,
          :SEEDBOMB,:LASERFOCUS,:TRICK,:MAGICROOM,:WONDERROOM,
          :GASTROACID,:THROATCHOP,:SKILLSWAP,:HYPERVOICE,:SPIKES,
          :ENDURE,:BATONPASS,:FUTURESIGHT,:LEAFBLADE,:TOXICSPIKES,
          :POWERGEM,:NASTYPLOT,:LEAFSTORM,:POWERWHIP,:VENOMDRENCH]).include?(move)
          return true
        end
        if (move == PBMoves::CALMMIND) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::PSYCHIC) ||
          (move == PBMoves::TORMENT) || (move == PBMoves::THIEF) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::DREAMEATER) ||
          (move == PBMoves::TRICKROOM) || (move == PBMoves::DARKPULSE) ||
          (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::FLASH) 
          (move == PBMoves::FOULPLAY) || (move == PBMoves::HEADBUTT) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::ROLEPLAY) ||
          (move == PBMoves::SHOCKWAVE) || (move == PBMoves::TELEKINESIS) 
          return false  
        end
      end
    when PBSpecies::MISMAGIUS # Mismagius -- Aevian
      if pokemon.form==0
        if (move == PBMoves::HONECLAWS) || (move == PBMoves::WORKUP) ||
          (move == PBMoves::VENOSHOCK) || (move == PBMoves::SOLARBEAM) ||
          (move == PBMoves::SWORDSDANCE) || (move == PBMoves::INFESTATION) ||
          (move == PBMoves::GRASSKNOT) || (move == PBMoves::NATUREPOWER) ||
          (move == PBMoves::LEECHLIFE) ||  (move == PBMoves::CUT) ||
          (move == PBMoves::STRENGTH) || (move == PBMoves::BIND) ||
          (move == PBMoves::WORRYSEED) || (move == PBMoves::GIGADRAIN) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WATERPULSE) ||
          (move == PBMoves::SEEDBOMB) || (move == PBMoves::GASTROACID) ||
          (move == PBMoves::THROATCHOP) || (move == PBMoves::GUNKSHOT) ||
          (move == PBMoves::KNOCKOFF)
          return false
        end
      elsif pokemon.form==1
        if arrayToConstant(PBMoves, 
          # TMs
          [:WORKUP,:TOXIC,:VENOSHOCK,:HIDDENPOWER,:SUNNYDAY,:TAUNT,:HYPERBEAM,:PROTECT,:RAINDANCE,:SECRETPOWER,:FRUSTRATION,:SOLARBEAM,:SMACKDOWN,
            :RETURN,:SHADOWBALL,:DOUBLETEAM,:SLUDGEWAVE,:ROCKTOMB,:AERIALACE,:FACADE,:REST,:ATTRACT,:ROUND,:ECHOEDVOICE,:ENERGYBALL,:QUASH,:WILLOWISP,
            :ACROBATICS,:EMBARGO,:SHADOWCLAW,:GIGAIMPACT,:SWORDSDANCE,:PSYCHUP,:XSCISSOR,:INFESTATION,:POISONJAB,:GRASSKNOT,:SWAGGER,:SLEEPTALK,
            :SUBSTITUTE,:NATUREPOWER,:CONFIDE,:LEECHLIFE,:PINMISSILE,:MAGICALLEAF,:SOLARBLADE,:SCREECH,:SCARYFACE,:BULLETSEED,:CROSSPOISON,:HEX,
            :PHANTOMFORCE,:DRAININGKISS,:GRASSYTERRAIN,:HONECLAWS,:SUCKERPUNCH,:CUT,:STRENGTH,
          # Move Tutors
          :SNORE,:HEALBELL,:UPROAR,:BIND,:WORRYSEED,:SNATCH,:SPITE,:GIGADRAIN,:SYNTHESIS,:ALLYSWITCH,:WATERPULSE,:PAINSPLIT,:SEEDBOMB,:LASERFOCUS,:TRICK,
          :MAGICROOM,:WONDERROOM,:GASTROACID,:THROATCHOP,:SKILLSWAP,:GUNKSHOT,:HYPERVOICE,:KNOCKOFF,:SPIKES,:ENDURE,:BATONPASS,:FUTURESIGHT,:MUDDYWATER,
          :LEAFBLADE,:TOXICSPIKES,:POWERGEM,:NASTYPLOT,:LEAFSTORM,:POWERWHIP,:VENOMDRENCH]).include?(move)
          return true
        end
        if (move == PBMoves::CALMMIND) || (move == PBMoves::HYPERBEAM) ||
          (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) ||
          (move == PBMoves::PSYCHIC) || (move == PBMoves::TORMENT) ||
          (move == PBMoves::THIEF) || (move == PBMoves::CHARGEBEAM) ||
          (move == PBMoves::PAYBACK) || (move == PBMoves::GIGAIMPACT) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::DREAMEATER) ||
          (move == PBMoves::TRICKROOM) || (move == PBMoves::DARKPULSE) ||
          (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::FLASH) ||
          (move == PBMoves::FOULPLAY) || (move == PBMoves::HEADBUTT) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::ROLEPLAY) ||
          (move == PBMoves::SHOCKWAVE) || (move == PBMoves::TELEKINESIS) 
          return false
        end
      end
    when PBSpecies::PONYTA # Ponyta
      if pokemon.form==0
        if (move == PBMoves::IMPRISON) || (move == PBMoves::PSYCHIC) || (move == PBMoves::HORNDRILL) ||
          (move == PBMoves::FUTURESIGHT) || (move == PBMoves::CALMMIND) || (move == PBMoves::EXPANDINGFORCE) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::STOREDPOWER) || (move == PBMoves::PSYBEAM) ||
          (move == PBMoves::DAZZLINGGLEAM)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SOLARBEAM) || (move == PBMoves::SOLARBLADE) || (move == PBMoves::TOXIC) ||
          (move == PBMoves::SUNNYDAY) || (move == PBMoves::HEATWAVE) || (move == PBMoves::INCINERATE) ||
          (move == PBMoves::WILLOWISP) || (move == PBMoves::FLAMETHROWER) || (move == PBMoves::FLAMEWHEEEL) ||
          (move == PBMoves::OVERHEAT)
          return false
        end
      end
    when PBSpecies::RAPIDASH # Rapidash
      if pokemon.form==0
        if (move == PBMoves::IMPRISON) || (move == PBMoves::PSYCHIC) || (move == PBMoves::PSYCHOCUT) ||
          (move == PBMoves::FUTURESIGHT) || (move == PBMoves::CALMMIND) || (move == PBMoves::TRICKROOM) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::STOREDPOWER) || (move == PBMoves::WONDERROOM) ||
          (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::PSYBEAM) || (move == PBMoves::EXPANDINGFORCE) ||
	        (move == PBMoves::MAGICROOM) || (move == PBMoves::MISTYTERRAIN) || (move == PBMoves::PSYCHICTERRAIN)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SOLARBEAM) || (move == PBMoves::SOLARBLADE) || (move == PBMoves::TOXIC) ||
          (move == PBMoves::SUNNYDAY) || (move == PBMoves::HEATWAVE) || (move == PBMoves::POISONJAB) ||
          (move == PBMoves::WILLOWISP) || (move == PBMoves::FLAMETHROWER) || (move == PBMoves::SCORCHINGSANDS) ||
          (move == PBMoves::OVERHEAT) || (move == PBMoves::FLAMEWHEEEL) || (move == PBMoves::INCINERATE)
          return false
        end
      end
    when PBSpecies::SLOWPOKE
      if pokemon.form==0
        if (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::BRUTALSWING) ||
          (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::POISONJAB) || 
          (move == PBMoves::VENOSHOCK)
          return false
        end
      end
      if pokemon.form==2
        if (move == PBMoves::FISSURE) || (move == PBMoves::ZAPCANNON) || (move == PBMoves::OCTAZOOKA) ||
          (move == PBMoves::LUNGE) || (move == PBMoves::MEGAPUNCH) || (move == PBMoves::ICEPUNCH) ||
	        (move == PBMoves::SEISMICTOSS)
          return false
        end
      end
  when PBSpecies::SLOWBRO
      if pokemon.form==0
        if (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::BRUTALSWING) || (move == PBMoves::SCARYFACE) ||
          (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::POISONJAB) || (move == PBMoves::ICEFANG) ||
          (move == PBMoves::VENOSHOCK) || (move == PBMoves::ACIDSPRAY) || (move == PBMoves::SANDSTORM) ||
	        (move == PBMoves::ROCKBLAST) || (move == PBMoves::POWERGEM) || (move == PBMoves::GUNKSHOT) ||
	        (move == PBMoves::HAZE) || (move == PBMoves::SMACKDOWN)
          return false
        end
      end
      if pokemon.form==2
        if (move == PBMoves::FISSURE) || (move == PBMoves::ZAPCANNON) || (move == PBMoves::OCTAZOOKA) ||
          (move == PBMoves::AERIALACE) || (move == PBMoves::PSYCHICNOISE) || (move == PBMoves::LUNGE)
          return false
        end
      end
  when PBSpecies::SLOWKING
      if pokemon.form==0
        if (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::BRUTALSWING) || (move == PBMoves::VENOMDRENCH) ||
          (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::POISONJAB) || (move == PBMoves::SCARYFACE) ||
          (move == PBMoves::VENOSHOCK) || (move == PBMoves::HEX) || (move == PBMoves::ACIDSPRAY) ||
	        (move == PBMoves::SNARL) || (move == PBMoves::LOWSWEEP) || (move == PBMoves::STOMPINGTANTRUM) ||
	        (move == PBMoves::TAUNT) || (move == PBMoves::TOXICSPIKES) || (move == PBMoves::GUNKSHOT)
          return false
        end
      elsif pokemon.form==2
        if (move == PBMoves::FISSURE) || (move == PBMoves::ZAPCANNON) || (move == PBMoves::OCTAZOOKA) ||
          (move == PBMoves::ROCKTOMB) || (move == PBMoves::ROCKSLIDE) || (move == PBMoves::PSYCHICNOISE) ||
	        (move == PBMoves::LUNGE) || (move == PBMoves::QUASH) || (move == PBMoves::DRAGONTAIL) ||
	        (move == PBMoves::POWERUPPUNCH)
          return false
        end
      end
    when PBSpecies::FARFETCHD # Farfetch'd
      if pokemon.form==0
        if (move == PBMoves::BRICKBREAK) || (move == PBMoves::ASSURANCE) || (move == PBMoves::IRONDEFENSE) ||
          (move == PBMoves::SUPERPOWER) || (move == PBMoves::ROCKSMASH)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::FLY) || (move == PBMoves::THIEF) || (move == PBMoves::AERIALACE) ||
          (move == PBMoves::SWIFT) || (move == PBMoves::UTURN) || (move == PBMoves::RAZORWIND) ||
          (move == PBMoves::ACROBATICS) || (move == PBMoves::BATONPASS) || (move == PBMoves::WHIRLWIND) ||
	        (move == PBMoves::IRONTAIL) || (move == PBMoves::UPROAR) || (move == PBMoves::REFLECT) ||
	        (move == PBMoves::HEATWAVE) || (move == PBMoves::AIRCUTTER) || (move == PBMoves::ROOST) ||
	        (move == PBMoves::MUDSLAP)
          return false
        end
      end
    when PBSpecies::SHUCKLE
      if pokemon.form==1
        if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||  (move == PBMoves::IONICSTRAIN) || 
          (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) || (move == PBMoves::MELTDOWN) || 
          (move == PBMoves::NUCLEARWASTE)
             return true
        end
      end
    when PBSpecies::SNEASEL
      if pokemon.form==2
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) || (move == PBMoves::ATOMICPUNCH) || 
          (move == PBMoves::HALFLIFE) || (move == PBMoves::EMERGENCYEXIT)
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) || (move == PBMoves::ATOMICPUNCH) || 
          (move == PBMoves::HALFLIFE) || (move == PBMoves::EMERGENCYEXIT) 
          return true
        end
      elsif pokemon.form==0
        if (move == PBMoves::CLOSECOMBAT) || (move == PBMoves::ACIDSPRAY) || (move == PBMoves::POISONTAIL) ||
          (move == PBMoves::VENOSHOCK) || (move == PBMoves::BULKUP) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::TOXICSPIKES) || (move == PBMoves::GUNKSHOT) || (move == PBMoves::SLUDGEBOMB) ||
          (move == PBMoves::FOCUSBLAST) || (move == PBMoves::VACUUMWAVE) || (move == PBMoves::COACHING) ||
          (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::DRAINPUNCH)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::EMBARGO) || (move == PBMoves::ASSURANCE) || (move == PBMoves::ICYWIND) ||
          (move == PBMoves::FEINTATTACK) || (move == PBMoves::SNATCH) || (move == PBMoves::BEATUP) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::BLIZZARD) || (move == PBMoves::DREAMEATER) ||
          (move == PBMoves::SURF) || (move == PBMoves::HAIL) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::ICEPUNCH) || (move == PBMoves::ICEBEAM) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::AVALANCHE) || (move == PBMoves::WHIRLPOOL) || (move == PBMoves::REFLECT) ||
          (move == PBMoves::PSYCHOCUT) || (move == PBMoves::FOULPLAY) || (move == PBMoves::SCARYFACE) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::HELPINGHAND) || (move == PBMoves::KNOCKOFF) ||
          (move == PBMoves::ICICLESPEAR) || (move == PBMoves::TRIPLEAXEL) || (move == PBMoves::UPPERHAND) ||
          (move == PBMoves::NIGHTMARE)
          return false
        end
      end
    when PBSpecies::WEAVILE
      if pokemon.form==2
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) || (move == PBMoves::ATOMICPUNCH) ||  (move == PBMoves::EMERGENCYEXIT) || 
          (move == PBMoves::HALFLIFE)
          return true
        end
      end
    when PBSpecies::SNEASLER
      if pokemon.form==3
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) || (move == PBMoves::ATOMICPUNCH) || 
          (move == PBMoves::HALFLIFE) || (move == PBMoves::EMERGENCYEXIT)
          return true
        end
      end
    when PBSpecies::TEDDIURSA
      if pokemon.form==1
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || 
          (move == PBMoves::RADIOACID) || (move == PBMoves::OVERDOSAGE) ||  
          (move == PBMoves::NUCLEARSLASH)
          return true
        end
      end
    when PBSpecies::URSARING
      if pokemon.form==1
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || 
          (move == PBMoves::RADIOACID) || (move == PBMoves::OVERDOSAGE) || 
          (move == PBMoves::NUCLEARSLASH)
          return true
        end
      end
    when PBSpecies::URSALUNA
      if pokemon.form==1
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || 
          (move == PBMoves::RADIOACID) || (move == PBMoves::OVERDOSAGE) || 
          (move == PBMoves::NUCLEARSLASH)
          return true
        end
      elsif pokemon.form==0
        if (move == PBMoves::SNARL) || (move == PBMoves::MUDSHOT) || (move == PBMoves::CALMMIND) ||
          (move == PBMoves::VACUUMWAVE)
          return false
        end
      elsif pokemon.form==2
        if (move == PBMoves::DRAINPUNCH) || (move == PBMoves::SUPERCELLSLAM) || (move == PBMoves::HEAVYSLAM)
          return false
        end
      end
    when PBSpecies::SKARMORY
      if pokemon.form==1
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::IONICSTRAIN) || 
          (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::BLASTWAVE) || 
          (move == PBMoves::NUCLEARWIND)
          return true
        end
      end
    when PBSpecies::HOUNDOUR
      if pokemon.form==2
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::NUCLEARFANGS) || 
          (move == PBMoves::RADIOACID) || (move == PBMoves::BLASTWAVE) || 
          (move == PBMoves::EXPUNGE)
          return true
        end
      end
    when PBSpecies::HOUNDOOM
      if pokemon.form==2
        if (move == PBMoves::GAMMARAY) || (move == PBMoves::BLASTWAVE) || 
          (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARFANGS) || 
          (move == PBMoves::EXPUNGE)
          return true
        end
      end
    when PBSpecies::LARVITAR
      if pokemon.form==2
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
          (move == PBMoves::ATOMICPUNCH) ||  (move == PBMoves::NUCLEARFANGS) ||  (move == PBMoves::MELTDOWN) || 
        (move == PBMoves::HALFLIFE)
          return true
        end
      end
    when PBSpecies::PUPITAR
      if pokemon.form==2
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
          (move == PBMoves::ATOMICPUNCH) ||  (move == PBMoves::NUCLEARFANGS) ||  (move == PBMoves::MELTDOWN) || 
          (move == PBMoves::HALFLIFE)
          return true
        end
      end
    when PBSpecies::TYRANITAR
      if pokemon.form==2
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
          (move == PBMoves::ATOMICPUNCH) ||  (move == PBMoves::NUCLEARFANGS) ||  (move == PBMoves::MELTDOWN) || 
          (move == PBMoves::HALFLIFE)
          return true
        end
      end
    when PBSpecies::BALTOY
      if pokemon.form==1
        if (move == PBMoves::DIG) || (move == PBMoves::TOXIC) || (move == PBMoves::WILLOWISP) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::REFLECT) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::SAFEGUARD) || (move == PBMoves::REST) || (move == PBMoves::ROCKSLIDE) || (move == PBMoves::ROCKTOMB) || (move == PBMoves::SNORE) || (move == PBMoves::PROTECT) || (move == PBMoves::SANDSTORM) || (move == PBMoves::FACADE) || (move == PBMoves::IMPRISON) || (move == PBMoves::SANDTOMB) || (move == PBMoves::POWERSWAP) || (move == PBMoves::GUARDSWAP) || (move == PBMoves::TRICKROOM) || (move == PBMoves::WONDERROOM) || (move == PBMoves::ROUND) || (move == PBMoves::HEX) || (move == PBMoves::EARTHQUAKE) || (move == PBMoves::SUBSTITUTE) || (move == PBMoves::ENDURE) || (move == PBMoves::SLEEPTALK) || (move == PBMoves::SKILLSWAP) || (move == PBMoves::COSMICPOWER) || (move == PBMoves::CALMMIND) || (move == PBMoves::NASTYPLOT) || (move == PBMoves::GYROBALL) || (move == PBMoves::STEALTHROCK) || (move == PBMoves::EARTHPOWER) || (move == PBMoves::DARKPULSE) || (move == PBMoves::GIGADRAIN) || (move == PBMoves::KNOCKOFF) || (move == PBMoves::GRAVITY) || (move == PBMoves::UPROAR) || (move == PBMoves::SIGNALBEAM) || (move == PBMoves::POWERGEM) || (move == PBMoves::FOULPLAY)
          return true
        end
      end
    when PBSpecies::CLAYDOL
      if pokemon.form==1
        if (move == PBMoves::DIG) || (move == PBMoves::TOXIC) || (move == PBMoves::WILLOWISP) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::REFLECT) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::SAFEGUARD) || (move == PBMoves::REST) || (move == PBMoves::ROCKSLIDE) || (move == PBMoves::ROCKTOMB) || (move == PBMoves::SNORE) || (move == PBMoves::PROTECT) || (move == PBMoves::SANDSTORM) || (move == PBMoves::FACADE) || (move == PBMoves::IMPRISON) || (move == PBMoves::SANDTOMB) || (move == PBMoves::POWERSWAP) || (move == PBMoves::GUARDSWAP) || (move == PBMoves::TRICKROOM) || (move == PBMoves::WONDERROOM) || (move == PBMoves::ROUND) || (move == PBMoves::HEX) || (move == PBMoves::EARTHQUAKE) || (move == PBMoves::SUBSTITUTE) || (move == PBMoves::ENDURE) || (move == PBMoves::SLEEPTALK) || (move == PBMoves::SKILLSWAP) || (move == PBMoves::COSMICPOWER) || (move == PBMoves::CALMMIND) || (move == PBMoves::NASTYPLOT) || (move == PBMoves::GYROBALL) || (move == PBMoves::STEALTHROCK) || (move == PBMoves::EARTHPOWER) || (move == PBMoves::DARKPULSE) || (move == PBMoves::GIGADRAIN) || (move == PBMoves::KNOCKOFF) || (move == PBMoves::GRAVITY) || (move == PBMoves::UPROAR) || (move == PBMoves::SIGNALBEAM) || (move == PBMoves::POWERGEM) || (move == PBMoves::FOULPLAY) || (move == PBMoves::DREAMEATER) || (move == PBMoves::NIGHTMARE)
          return true
        end
      end
    when PBSpecies::SABLEYE
      if pokemon.form==2
        if (move == PBMoves::TAKEDOWN) || (move == PBMoves::PROTECT) || (move == PBMoves::SUBSTITUTE) || (move == PBMoves::CONFUSERAY) || (move == PBMoves::THIEF) || (move == PBMoves::FACADE) || (move == PBMoves::HEX) || (move == PBMoves::SNARL) || (move == PBMoves::NIGHTSHADE) || (move == PBMoves::FLING) || (move == PBMoves::ENDURE) || (move == PBMoves::BRICKBREAK) || (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::FOULPLAY) || (move == PBMoves::BULKUP) || (move == PBMoves::BODYSLAM) || (move == PBMoves::FIREPUNCH) || (move == PBMoves::THUNDERPUNCH) || (move == PBMoves::ICEPUNCH) || (move == PBMoves::SLEEPTALK) || (move == PBMoves::DRAINPUNCH) || (move == PBMoves::REST) || (move == PBMoves::SNORE) || (move == PBMoves::REFLECT) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::POISONJAB) || (move == PBMoves::TAUNT) || (move == PBMoves::DARKPULSE) || (move == PBMoves::POWERGEM) || (move == PBMoves::WILLOWISP) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::TRICK) || (move == PBMoves::ENCORE) || (move == PBMoves::CALMMIND) || (move == PBMoves::NASTYPLOT) || (move == PBMoves::HELPINGHAND) || (move == PBMoves::TOXIC) || (move == PBMoves::DRAININGKISS) || (move == PBMoves::AMNESIA) || (move == PBMoves::PAINSPLIT) || (move == PBMoves::BATONPASS) || (move == PBMoves::BURNINGJEALOUSY) || (move == PBMoves::SWIFT) || (move == PBMoves::PLAYROUGH) || (move == PBMoves::VICTORYDANCE) || (move == PBMoves::POWERUPPUNCH)
          return true
        else
          return false #? i want to lock all the other TMs of Normal Sableye from this form.
        end
      end
    when PBSpecies::KOFFING
      if pokemon.form==2
        if (move == PBMoves::SCREECH) || (move == PBMoves::REST) || (move == PBMoves::TOXIC) || (move == PBMoves::SELFDESTRUCT) || (move == PBMoves::AMNESIA) || (move == PBMoves::PSYSHOCK) || (move == PBMoves::SNORE) || (move == PBMoves::CALMMIND) || (move == PBMoves::PROTECT) || (move == PBMoves::WILLOWISP) || (move == PBMoves::FACADE) || (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::VENOSHOCK) || (move == PBMoves::ROUND) || (move == PBMoves::THUNDERBOLT) || (move == PBMoves::FIREBLAST) || (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::SUBSTITUTE) || (move == PBMoves::SLEEPTALK) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::UPROAR) || (move == PBMoves::PSYCHIC) || (move == PBMoves::TOXICSPIKES) || (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::DARKPULSE) || (move == PBMoves::VENOMDRENCH) || (move == PBMoves::SKILLSWAP) || (move == PBMoves::COSMICPOWER) || (move == PBMoves::AURASPHERE) || (move == PBMoves::MAGICALLEAF) || (move == PBMoves::REFLECT) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::SWIFT) || (move == PBMoves::DEFOG) || (move == PBMoves::PAINSPLIT) || (move == PBMoves::GASTROACID)
          return true
        end
      end
    when PBSpecies::WEEZING # Weezing
      if pokemon.form==0
        if (move == PBMoves::WONDERROOM) || (move == PBMoves::MISTYTERRAIN) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::BRUTALSWING) || (move == PBMoves::OVERHEAT) || (move == PBMoves::MISTYEXPLOSION) ||
          (move == PBMoves::PLAYROUGH) || (move == PBMoves::DAZZLINGGLEAM) || (move == DOUBLEEDGE)
          return false
        end
      elsif pokemon.form==2
        if (move == PBMoves::SCREECH) || (move == PBMoves::REST) || (move == PBMoves::TOXIC) || (move == PBMoves::SELFDESTRUCT) || (move == PBMoves::AMNESIA) || (move == PBMoves::PSYSHOCK) || (move == PBMoves::SNORE) || (move == PBMoves::CALMMIND) || (move == PBMoves::PROTECT) || (move == PBMoves::WILLOWISP) || (move == PBMoves::FACADE) || (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::VENOSHOCK) || (move == PBMoves::ROUND) || (move == PBMoves::THUNDERBOLT) || (move == PBMoves::FIREBLAST) || (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::SUBSTITUTE) || (move == PBMoves::SLEEPTALK) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::UPROAR) || (move == PBMoves::PSYCHIC) || (move == PBMoves::TOXICSPIKES) || (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::DARKPULSE) || (move == PBMoves::VENOMDRENCH) || (move == PBMoves::SKILLSWAP) || (move == PBMoves::COSMICPOWER) || (move == PBMoves::AURASPHERE) || (move == PBMoves::MAGICALLEAF) || (move == PBMoves::REFLECT) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::SWIFT) || (move == PBMoves::DEFOG) || (move == PBMoves::PAINSPLIT) || (move == PBMoves::GASTROACID)
          return true
        end
      elsif pokemon.form==2
        if (move == PBMoves::WONDERROOM) || (move == PBMoves::MISTYTERRAIN) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::BRUTALSWING) || (move == PBMoves::OVERHEAT) || (move == PBMoves::MISTYEXPLOSION) ||
          (move == PBMoves::PLAYROUGH) || (move == PBMoves::DAZZLINGGLEAM) || (move == DOUBLEEDGE)
          return false
        end
      end
    when PBSpecies::MRMIME # Mr Mime
      if pokemon.form==0
        if (move == PBMoves::SCREECH) || (move == PBMoves::HAIL) || 
          (move == PBMoves::ICICLESPEAR) || (move == PBMoves::AVALANCHE) || 
          (move == PBMoves::STOMPINGTANTRUM) || (move == PBMoves::ICEBEAM) || 
          (move == PBMoves::BLIZZARD)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::FIREPUNCH) || (move == PBMoves::THUNDERPUNCH) || (move == PBMoves::CURSE) ||
          (move == PBMoves::MAGICALLEAF) || (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::NIGHTMARE) ||
          (move == PBMoves::AERIALACE) || (move == PBMoves::POWERUPPUNCH)
          return true
        end
      elsif pokemon.form==2
        if (move == PBMoves::FIREPUNCH) || (move == PBMoves::THUNDERPUNCH) || (move == PBMoves::CURSE) ||
          (move == PBMoves::MAGICALLEAF) || (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::NIGHTMARE) ||
          (move == PBMoves::AERIALACE) || (move == PBMoves::POWERUPPUNCH)
          return false
        end
      end
    when PBSpecies::STUNFISK 
      if pokemon.form==0
        if (move == PBMoves::SCREECH) || (move == PBMoves::ICEFANG) || (move == PBMoves::METALCLAW) ||
          (move == PBMoves::CRUNCH) ||  (move == PBMoves::IRONDEFENSE) || (move == PBMoves::METALSOUND) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::BIND) || (move == PBMoves::COUNTER) ||
          (move == PBMoves::STEELBEAM) || (move == PBMoves::TERRAINPULSE)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::ELECTROWEB) || (move == PBMoves::ELECTRICTERRAIN) || (move == PBMoves::CHARGE) ||
          (move == PBMoves::EERIEIMPULSE) || (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) ||
          (move == PBMoves::TOXIC) || (move == PBMoves::FLASH) || (move == PBMoves::INFESTATION) ||
          (move == PBMoves::SHOCKWAVE) || (move == PBMoves::SPARK) || (move == PBMoves::MAGNETRISE)
          return false
        end
      end
    when  PBSpecies::NIDORANfE
      if pokemon.form==1 
       if (move == PBMoves::RADIOACID) || (move == PBMoves::IONICSTRAIN) ||
           (move == PBMoves::HALFLIFE) || (move == PBMoves::OVERDOSAGE) ||
           (move == PBMoves::EXPUNGE)
           return true
         end
       end
      when  PBSpecies:: NIDORINA
        if pokemon.form==1 
       if (move == PBMoves::RADIOACID) || (move == PBMoves::IONICSTRAIN) ||
           (move == PBMoves::HALFLIFE) || (move == PBMoves::OVERDOSAGE) ||
           (move == PBMoves::EXPUNGE)
           return true
         end
       end
       when  PBSpecies:: NIDOQUEEN
         if pokemon.form==1 
       if (move == PBMoves::RADIOACID) || (move == PBMoves::IONICSTRAIN) ||
           (move == PBMoves::HALFLIFE) || (move == PBMoves::OVERDOSAGE) ||
           (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARFANGS) 
           return true
         end
       end
       when  PBSpecies:: NIDORANmA
         if pokemon.form==1 
       if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) ||
           (move == PBMoves::RADIOACID) || 
           (move == PBMoves::EXPUNGE)
           return true
         end
       end
       when  PBSpecies:: NIDORINO
         if pokemon.form==1 
       if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) ||
           (move == PBMoves::RADIOACID) || 
           (move == PBMoves::EXPUNGE)
           return true
         end
       end
       when  PBSpecies::NIDOKING
         if pokemon.form==1 
       if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) ||
           (move == PBMoves::RADIOACID) || (move == PBMoves::ATOMICPUNCH) ||
           (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARFANGS) 
           return true
         end
       end
       when  PBSpecies::ZUBAT
         if pokemon.form==1 
       if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARFANGS) ||
           (move == PBMoves::HALFLIFE) ||  (move == PBMoves::OVERDOSAGE) ||
           (move == PBMoves::NUCLEARWIND)
           return true
         end
       end
       when  PBSpecies::GOLBAT
         if pokemon.form==1 
       if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARFANGS) ||
           (move == PBMoves::HALFLIFE) || (move == PBMoves::OVERDOSAGE) ||
           (move == PBMoves::NUCLEARWIND)
           return true
         end
       end
       when  PBSpecies::CROBAT
         if pokemon.form==1 
       if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARFANGS) ||
           (move == PBMoves::HALFLIFE) || (move == PBMoves::OVERDOSAGE) ||
           (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT)
           return true
         end
        end
    when PBSpecies::MOLTRES
      if pokemon.form==1
        if (move == PBMoves::FIRESPIN) || (move == PBMoves::INCINERATE) || (move == PBMoves::FLAMETHROWER) ||
          (move == PBMoves::SACREDFIRE) || (move == PBMoves::SOLARBEAM) || (move == PBMoves::FIREBLAST) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::OVERHEAT) || (move == PBMoves::REFLECT) ||
          (move == PBMoves::WILLOWISP) || (move == PBMoves::FLAMECHARGE) || (move == PBMoves::MYSTICALFIRE) ||
          (move == PBMoves::FLAREBLITZ) || (move == PBMoves::BURNINGJEALOUSY) || (moves == PBMoves::TEMPERFLARE) ||
          (move == PBMoves::SCORCHINGSANDS)
        return false
        end
      elsif pokemon.form=0
        if (move == PBMoves::TAUNT) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::SUCKERPUNCH) ||
          (move == PBMoves::PAYBACK) || (move == PBMoves::SNARL) || (move == PBMoves::AFTERYOU) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::FOULPLAY) || (move == PBMoves::ASSURANCE) ||
          (move == PBMoves::HYPERVOICE) || (move == PBMoves::SCARYFACE) || (move == PBMoves::THIEF) ||
          (move == PBMoves::IMPRISON) || (move == PBMoves::HEX) || (move == PBMoves::SPITE) ||
          (move == PBMoves::NASTYPLOT) || (move == PBMoves::LASHOUT) || (move == PBMoves:: PAINSPLIT)
        return false
        end
      end
    when PBSpecies::ZAPDOS
      if pokemon.form==1
        if (move == PBMoves::THUNDERWAVE) || (move == PBMoves::CHARGE) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::ZAPCANNON) || (move == PBMoves::RISINGVOLTAGE) ||
          (move == PBMoves::FLASH) || (move == PBMoves::SHOCKWAVE) || (move == PBMoves::CHARGEBEAM) ||
          (move == PBMoves::VOLTSWITCH) || (move == PBMoves::WILDCHARGE) || (move == PBMoves::EERIEIMPULSE) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::ELECTROBALL) || (move == PBMoves::ELECTRICTERRAIN) ||
          (move == PBMoves::SUPERCELLSLAM) || (move == PBMoves::METALSOUND)
          return false
        end
      elsif pokemon.form==0
      if (move == PBMoves::ENDEAVOR) || (move == PBMoves::BULKUP) || (move == PBMoves::ASSURANCE) ||
        (move == PBMoves::TAUNT) || (move == PBMoves::BRICKBREAK) || (move == PBMoves::COUNTER) ||
        (move == PBMoves::LOWSWEEP) || (move == PBMoves::COACHING) || (move == PBMoves::REVERSAL) ||
        (move == PBMoves::PAYBACK) || (move == PBMoves::BOUNCE) || (move == PBMoves::MEGAKICK) ||
        (move == PBMoves::LOWKICK) || (move == PBMoves::STOMPINGTANTRUM) || (move == PBMoves::RETALIATE) ||
        (move == PBMoves::SUPERPOWER) || (move == PBMoves::THROATCHOP) || (move == PBMoves::TRAILBLAZE) ||
        (move == PBMoves::CLOSECOMBAT) || (move == PBMoves::REVENGE) || (move == PBMoves::KNOCKOFF) ||
        (move == PBMoves::BLAZEKICK)
          return false
        end
      end
    when PBSpecies::ARTICUNO
      if pokemon.form==1
        if (move == PBMoves::HAZE) || (move == PBMoves::HAIL) || (move == PBMoves::SANDSTORM) ||
          (move == PBMoves::ICEBEAM) || (move == PBMoves::BLIZZARD) || (move == PBMoves::BUBBLEBEAM) ||
          (move == PBMoves::WATERGUN) || (move == PBMoves::WATERPULSE) || (move == PBMoves::AVALANCHE) ||
          (move == PBMoves::FROSTBREATH) || (move == PBMoves::AURORAVEIL) || (move == PBMoves::ICICLESPEAR) ||
          (move == PBMoves::ICESPINNER) || (move == PBMoves::TRIPLEAXEL)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::PSYSHOCK) || (move == PBMoves::CALMMIND) || (move == PBMoves::DREAMEATER) ||
          (move == PBMoves::PSYCHIC) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::FUTURESIGHT) ||
          (move == PBMoves::TRICKROOM) || (move == PBMoves::ALLYSWITCH) || (move == PBMoves::PSYBEAM) ||
          (move == PBMoves::HYPERVOICE) || (move == PBMoves::SKILLSWAP) || (move == PBMoves::TRICK) ||
          (move == PBMoves::SCARYFACE) || (move == PBMoves::IMPRISON) || (move == PBMoves::PSYCHICNOISE) ||
          (move == PBMoves::POWERSWAP) || (move == PBMoves::GUARDSWAP) || (move == PBMoves::HYPNOSIS) ||
          (move == PBMoves::PSYCHOCUT) || (move == PBMoves::STOREDPOWER) || (move == PBMoves::EXPANDINGFORCE)
          return false
        end
      end
    when PBSpecies::CORSOLA # Corsola
      if pokemon.form==0
        if (move == PBMoves::GIGADRAIN) || (move == PBMoves::WILLOWISP) || (move == PBMoves::DESTINYBOND) ||
          (move == PBMoves::HEX) || (move == PBMoves::PERISHSONG) || (move == PBMoves::SPITE) ||
          (move == PBMoves::NIGHTSHADE) || (move == PBMoves::HAZE) || (move == PBMoves::OMINOUSWIND)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::ENDEAVOR) || (move == PBMoves::TOXIC) || (move == PBMoves::EXPLOSION) ||
          (move == PBMoves::ROCKPOLISH)
          return false
        end
      elsif pokemon.form==2
        if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::IONICSTRAIN) || 
          (move == PBMoves::RADIOACID) || (move == PBMoves::OVERDOSAGE) || 
          (move == PBMoves::HALFLIFE) ||
          (move == PBMoves::EXPUNGE)
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) || 
          (move == PBMoves::RADIOACID) || (move == PBMoves::IONICSTRAIN) || 
          (move == PBMoves::HALFLIFE) ||
          (move == PBMoves::EXPUNGE)
          return true
        end
      end
    when PBSpecies::CORSOREEF
      if pokemon.form==2
        if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::OVERDOSAGE) || 
          (move == PBMoves::HALFLIFE) || (move == PBMoves::IONICSTRAIN)
          return true
        end
      end
    when PBSpecies::CURSOLA
      if pokemon.form==3
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) || (move == PBMoves::OVERDOSAGE) || 
          (move == PBMoves::HALFLIFE) || (move == PBMoves::IONICSTRAIN)
          return true
        end
      end
    when PBSpecies::ZIGZAGOON 
      if pokemon.form==0
        if (move == PBMoves::SCREECH) || (move == PBMoves::SCARYFACE) || (move == PBMoves::COUNTER) ||
          (move == PBMoves::FAKETEARS) || (move == PBMoves::PAYBACK) || (move == PBMoves::KNOCKOFF) ||
          (move == PBMoves::ASSURANCE) || (move == PBMoves::SNARL) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::LASHOUT)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::CHARM) || (move == PBMoves::TAILSLAP) || (move == PBMoves::EXTREMESPEED) ||
          (move == PBMoves::TOXIC) || (move == PBMoves::COVET)
          return false
        end
      end
    when PBSpecies::LINOONE 
      if pokemon.form==0
        if (move == PBMoves::SCREECH) || (move == PBMoves::SCARYFACE) || (move == PBMoves::COUNTER) ||
          (move == PBMoves::FAKETEARS) || (move == PBMoves::PAYBACK) || (move == PBMoves::KNOCKOFF) ||
          (move == PBMoves::ASSURANCE) || (move == PBMoves::SNARL) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::LASHOUT) || (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::BODYPRESS)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::CHARM) || (move == PBMoves::TAILSLAP) || (move == PBMoves::EXTREMESPEED) ||
          (move == PBMoves::TOXIC) || (move == PBMoves::COVET) || (move == PBMoves::PLAYROUGH)
          return false
        end
      end
    when PBSpecies::WORMADAM 
      if pokemon.form==0    # Plant Cloak
        if (move == PBMoves::EARTHQUAKE) || (move == PBMoves::SANDSTORM) || (move == PBMoves::ROCKBLAST) ||
          (move == PBMoves::ROCKTOMB) || (move == PBMoves::BULLDOZE) || (move == PBMoves::METALSOUND) ||
          (move == PBMoves::EARTHPOWER) || (move == PBMoves::STEALTHROCK) || (move == PBMoves::FISSURE) ||
          (move == PBMoves::GYROBALL) || (move == PBMoves::FLASHCANNON) || (move == PBMoves::MUDSLAP) ||
          (move == PBMoves::GUNKSHOT) || (move == PBMoves::MAGNETRISE) || (move == PBMoves::IRONHEAD)
          (move == PBMoves::ROLLOUT) || (move == PBMoves::STEELBEAM)
          return false
        end
      elsif pokemon.form==1   # Sandy Cloak
        if (move == PBMoves::METALSOUND) || (move == PBMoves::ENERGYBALL) || (move == PBMoves::MAGICALLEAF) ||
          (move == PBMoves::GRASSKNOT) || (move == PBMoves::BULLETSEED) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WORRYSEED) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::GUNKSHOT) || (move == PBMoves::MAGNETRISE) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::STEELBEAM)
          return false
        end
      elsif pokemon.form==2   # Trash Cloak
        if (move == PBMoves::FISSURE) || (move == PBMoves::ENERGYBALL) || (move == PBMoves::ROCKBLAST) ||
          (move == PBMoves::GRASSKNOT) || (move == PBMoves::BULLETSEED) || (move == PBMoves::LEAFSTORM) ||
          (move == PBMoves::SEEDBOMB) || (move == PBMoves::SYNTHESIS) || (move == PBMoves::MUDSLAP) ||
          (move == PBMoves::WORRYSEED) || (move == PBMoves::EARTHQUAKE) || (move == PBMoves::ROLLOUT) ||
          (move == PBMoves::SANDSTORM) || (move == PBMoves::ROCKTOMB) || (move == PBMoves::MAGICALLEAF) ||
          (move == PBMoves::BULLDOZE) || (move == PBMoves::EARTHPOWER) 
          return false
        end
      end 
    when PBSpecies::DARUMAKA # Darumaka
      if pokemon.form==0
        if (move == PBMoves::ICEPUNCH) || (move == PBMoves::AVALANCHE) || (move == PBMoves::POWDERSNOW) ||
          (move == PBMoves::ICEFANG) || (move == PBMoves::ICEBEAM) || (move == PBMoves::BLIZZARD) 
          return false
        end
      elsif pokemon.form==2
        if (move == PBMoves::TOXIC) || (move == PBMoves::ROAR) || (move == PBMoves::FLAMECHARGE) ||
          (move == PBMoves::SNATCH) || (move == PBMoves::ENDEAVOR)
          return false
        end
      end
    when PBSpecies::DARMANITAN # Darmanitan
      if pokemon.form==0
        if (move == PBMoves::ICEPUNCH) || (move == PBMoves::AVALANCHE) || (move == PBMoves::POWDERSNOW) ||
          (move == PBMoves::ICEFANG) || (move == PBMoves::ICEBEAM) || (move == PBMoves::BLIZZARD) 
          return false
        end
      elsif pokemon.form==2
        if (move == PBMoves::TOXIC) || (move == PBMoves::ROAR) || (move == PBMoves::FLAMECHARGE) ||
          (move == PBMoves::SNATCH) || (move == PBMoves::ENDEAVOR) || (move == PBMoves::SMACKDOWN) ||
          (move == PBMoves::TORMENT) || (move == PBMoves::POWERSWAP) || (move == PBMoves::GUARDSWAP) ||
          (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::FUTURESIGHT) || (move == PBMoves::TRICK) ||
          (move == PBMoves::EXPANDINGFORCE)
          return false
        end
      end
    when PBSpecies::YAMASK # Yamask
      if pokemon.form==0
        if (move == PBMoves::ROCKSLIDE) || (move == PBMoves::SANDSTORM) || (move == PBMoves::ROCKTOMB) ||
          (move == PBMoves::BRUTALSWING) || (move == PBMoves::EARTHQUAKE) || (move == PBMoves::EARTHPOWER)
          return false
        end
        elsif pokemon.form==2
          if (move == PBMoves::EXPUNGE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::OVERDOSAGE) ||
            (move == PBMoves::HALFLIFE)
            return false
          end
      elsif pokemon.form==3
        if (move == PBMoves::EXPUNGE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::OVERDOSAGE) ||
          (move == PBMoves::HALFLIFE)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SHOCKWAVE) || (move == PBMoves::TELEKINESIS) || (move == PBMoves::EMBARGO) ||
          (move == PBMoves::SWAGGER) || (move == PBMoves::INFESTATION)
          return false
        end
      end
        when PBSpecies::VAPOREON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
  when PBSpecies::JOLTEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
end
when PBSpecies::FLAREON
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
  (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
  return true
end
end
when PBSpecies::LEAFEON
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
  (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
  return true
end
end
when PBSpecies::GLACEON
    if pokemon.form==2
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
  (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
  return true
end
end
when PBSpecies::UMBREON
    if pokemon.form==2
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
  (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
  return true
end
end
when PBSpecies::ESPEON
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
  (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
  return true
end
    end
  when PBSpecies::SYLVEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::EEVEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::HAWKEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::MANEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::BRISTLEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::TITANEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::ZIRCONEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::TOXEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::EPHEMEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::KITSUNEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
when PBSpecies::DREKEON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
    (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE)
    return true
  end
  end
  when PBSpecies::OWTEN
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::GAMMARAY) 
        return true
      end
    end
  when PBSpecies::ESHOUTEN
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::NUCLEARWIND) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::PAHAR
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::PALIJ
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::PAJAY
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::TRACTON
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::HALFLIFE) ||  (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::IONICSTRAIN) ||  (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::PARAUDIO
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::PARABOOM
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::JERBOLTA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::TITANICE
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||  (move == PBMoves::EMERGENCYEXIT) ||  (move == PBMoves::BLASTWAVE) ||  (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID) ||  (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::COSTRAW
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::RADIOACID) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::TRAWPINT
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::RADIOACID) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::NUPIN
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::GELLIN
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::HAGOOP
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::IONICSTRAIN) ||
        (move == PBMoves::RADIOACID) ||  (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when  PBSpecies::HAAGROSS
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::EKANS
    if pokemon.form==2
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::RADIOACID) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::ARBOK
    if pokemon.form==2
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::RADIOACID) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::GYARADOS
    if pokemon.form==2
      if (move == PBMoves::HALFLIFE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::IONICSTRAIN) ||
        (move == PBMoves::RADIOACID) || (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::BLASTWAVE) 
        return true
      end
    end
  when PBSpecies::HAZMA
    if pokemon.form==0
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::GEIGEROACH
    if pokemon.form==0
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::NUCLEON
    if pokemon.form==0
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::XENOGEN
    if pokemon.form==0
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::XENOMITE
    if pokemon.form==0
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::XENOQUEEN
    if pokemon.form==0
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when  PBSpecies::CORPHISH
    if pokemon.form==0
      if (move == PBMoves::SURF) || (move == PBMoves::WATERFALL)
        return false
      end
    elsif pokemon.form==1
      if (move == PBMoves::NATUREPOWER) || (move == PBMoves::VENOSHOCK) || (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::SHADOWCLAW) || (move == PBMoves::POISONJAB)
        return true
      end
    end
  when  PBSpecies::CRAWDAUNT
    if pokemon.form==0
      if (move == PBMoves::SURF) || (move == PBMoves::WATERFALL)
        return false
      end
    elsif pokemon.form==2
      if (move == PBMoves::NATUREPOWER) || (move == PBMoves::VENOSHOCK) || (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::SHADOWBALL) || (move == PBMoves::SHADOWCLAW) || (move == PBMoves::BRUTALSWING) || (move == PBMoves::POISONJAB)
        return true
      end
    end
  when  PBSpecies::GLIGAR
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when  PBSpecies::GLISCOR
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when  PBSpecies::BUIZEL
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when  PBSpecies::FLOATZEL
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when  PBSpecies::CHYINMUNK
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) || 
        (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::KINETMUNK
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::IONICSTRAIN) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when  PBSpecies::BIRBIE
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when  PBSpecies::AVEDEN
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::SPLENDIFOWL
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when  PBSpecies::TONEMY
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::TOFURANG
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::BRAILIP
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::BRAINOAR
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::TANCOON
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::TANSCURE
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::BAASHAUN
    if pokemon.form==2
      if (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::BAASCHAF
    if pokemon.form==2
      if (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when  PBSpecies::BAARIETTE
    if pokemon.form==2
      if (move == PBMoves::RADIOACID) || (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when  PBSpecies::TUBJAW
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when  PBSpecies::TUBAREEL
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::BARAND
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::CHIMICAL
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||  (move == PBMoves::OVERDOSAGE) ||  (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::CHIMACONDA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||  (move == PBMoves::NUCLEARFANGS) ||  (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::UNYMPH
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::HALFLIFE) || 
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::HARPTERA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||  (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::FLAGER
    if pokemon.form==2
      if (move == PBMoves::GAMMARAY) || (move == PBMoves::NUCLEARSLASH) ||  (move == PBMoves::HALFLIFE) ||
        (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::INFLAGETAH
    if pokemon.form==2
      if  (move == PBMoves::GAMMARAY) || (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::HALFLIFE) ||  (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::FRYNAI
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::SAIDINE
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::DAIKATUNA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::CHUPACHO
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::LUCHABRA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::SHRIMPUTY
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::EMERGENCYEXIT)
        return true
      end
    end
  when PBSpecies::KRILVOLVER
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::LAVENT
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::BLASTWAVE) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::GARLIKID
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) ||  (move == PBMoves::ATOMICPUNCH) ||  (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
    ######################################################################################
    # New Nuclear Altforms
    ######################################################################################
  when PBSpecies::GRANBULL
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) ||
         (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::SNUBBULL
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) || 
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::WOBBUFFET
    if pokemon.form==1
      if (move == PBMoves::HALFLIFE) || (move == PBMoves::MELTDOWN)
        return true
      end
    end
  when PBSpecies::WYNAUT
    if pokemon.form==1
      if (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::SURSKIT
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::GAMMARAY) 
        return true
      end
    end
  when PBSpecies::MASQUERAIN
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::NINCADA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::NINJASK
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::SHEDINJA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::NOSEPASS
    if pokemon.form==1
      if (move == PBMoves::GAMMARAY) || 
        (move == PBMoves::OVERDOSAGE) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::PROBOPASS
    if pokemon.form==1
      if (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::OVERDOSAGE) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::ARON
    if pokemon.form==2
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::HALFLIFE)  ||
        (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::LAIRON
    if pokemon.form==2
      if (move == PBMoves::NUCLEARSLASH) ||  (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::HALFLIFE)  ||
        (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::AGGRON
    if pokemon.form==2
      if (move == PBMoves::NUCLEARSLASH) ||  (move == PBMoves::OVERDOSAGE) ||  (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::HALFLIFE)  ||  (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::SPOINK
    if pokemon.form==1
      if (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::IONICSTRAIN) ||  (move == PBMoves::OVERDOSAGE) ||  (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::GRUMPIG
    if pokemon.form==1
      if (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::IONICSTRAIN) ||  (move == PBMoves::OVERDOSAGE) ||  (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::RADIOACID) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::FLYGON
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARWIND) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::NUCLEARFANGS) ||  (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::VIBRAVA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARFANGS) ||  (move == PBMoves::EMERGENCYEXIT) ||
         (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::TRAPINCH
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARFANGS) ||  (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::ZANGOOSE
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::OVERDOSAGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) ||
         (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::SEVIPER
    if pokemon.form==1
      if(move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::MILOTIC
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) || (move == PBMoves::OVERDOSAGE) ||
         (move == PBMoves::EXPUNGE) || (move == PBMoves::MELTDOWN) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::SNORUNT
    if pokemon.form==2
      if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::GLALIE
    if pokemon.form==2
      if (move == PBMoves::NUCLEARWIND) || 
        (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::FROSLASS
    if pokemon.form==2
       if (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
            return true
      end
    end
  when PBSpecies::KECLEON
    if pokemon.form==2
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::GAMMARAY) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::SHINX
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::LUXIO
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::LUXRAY
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) ||  
         (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::CRANIDOS
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::OVERDOSAGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::MELTDOWN) ||
         (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::RAMPARDOS
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::OVERDOSAGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::BASTIODON
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::SHIELDON
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::NUCLEARFANGS) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::DRIFLOON
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
    return true
  end
  end
  when PBSpecies::DRIFBLIM
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) ||
    (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
    return true
  end
end
when PBSpecies::BRONZOR
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::HALFLIFE) || 
  (move == PBMoves::RADIOACID) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE)
  return true
end
end
when PBSpecies::BRONZONG
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::HALFLIFE) ||  
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::HIPPOPOTAS
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARFANGS)
  return true
end
end
when PBSpecies::HIPPOWDON
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARFANGS)
  return true
end
    end
  when PBSpecies::MAREEP
    if pokemon.form==2
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::FLAAFFY
    if pokemon.form==2
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::AMPHAROS
    if pokemon.form==2
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) || 
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::ATOMICPUNCH)
        return true
      end
    end
  when PBSpecies::YANMA
      if pokemon.form==1
  if  (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || 
    (move == PBMoves::GAMMARAY)
    return true
  end
  end
  when PBSpecies::YANMEGA
      if pokemon.form==1
  if  (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || 
    (move == PBMoves::GAMMARAY)
    return true
  end
end
  when PBSpecies::ROGGENROLA
       if pokemon.form==1
           if  (move == PBMoves::GAMMARAY) || (move == PBMoves::BLASTWAVE) ||  (move == PBMoves::RADIOACID) 
             return true
           end
  end
  when PBSpecies::BOLDORE
      if pokemon.form==1
  if (move == PBMoves::GAMMARAY) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::RADIOACID)
    return true
  end
      end
  when PBSpecies::GIGALITH
      if pokemon.form==1
  if (move == PBMoves::GAMMARAY) || (move == PBMoves::BLASTWAVE) ||  (move == PBMoves::RADIOACID)
    return true
  end
  end
  when PBSpecies::THROH
      if pokemon.form==1
  if  (move == PBMoves::EXPUNGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::HALFLIFE)
    return true
  end
end
when PBSpecies::SAWK
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::HALFLIFE)
  return true
end
    end
  when PBSpecies::SCRAGGY
      if pokemon.form==1
  if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::HALFLIFE) ||  (move == PBMoves::NUCLEARFANGS) ||
    (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::RADIOACID)
    return true
  end
  end
  when PBSpecies::SCRAFTY
      if pokemon.form==1
  if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::HALFLIFE) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::ATOMICPUNCH) ||
    (move == PBMoves::RADIOACID)
    return true
  end
end
when  PBSpecies::TRUBBISH
  if pokemon.form==2
    if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EXPUNGE) ||
      (move == PBMoves::OVERDOSAGE) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::MELTDOWN) ||
      (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
      return true
    end
  elsif pokemon.form==4 #Egho
		if (move == PBMoves::TAUNT) || (move == PBMoves::ROCKTOMB) ||
			(move == PBMoves::GYROBALL) || (move == PBMoves::FLASHCANNON) ||
			(move == PBMoves::ROCKSMASH) || (move == PBMoves::BLOCK) ||
			(move == PBMoves::IRONDEFENSE) || (move == PBMoves::IRONHEAD) ||
			(move == PBMoves::SHOCKWAVE) || (move == PBMoves::SIGNALBEAM) ||
			(move == PBMoves::SUPERPOWER) || (move == PBMoves::TRIATTACK) ||
			(move == PBMoves::MUDDYWATER) || (move == PBMoves::HEAVYSLAM) ||
			(move == PBMoves::STEELBEAM)
      return false
    end
  elsif pokemon.form==4 #Egho
		if (move == PBMoves::SUNNYDAY)
      return false
    end
  end
when  PBSpecies::GARBODOR
  if pokemon.form==2
    if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EXPUNGE) ||
      (move == PBMoves::OVERDOSAGE) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::MELTDOWN) ||
      (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
      return true
    end
  elsif pokemon.form==4 #Egho
		if (move == PBMoves::TAUNT) || (move == PBMoves::SHADOWBALL) ||
			(move == PBMoves::FLAMETHROWER) || (move == PBMoves::FIREBLAST) ||
			(move == PBMoves::ROCKTOMB) || (move == PBMoves::GYROBALL) ||
			(move == PBMoves::BULLDOZE) || (move == PBMoves::ROCKSLIDE) ||
			(move == PBMoves::FLASHCANNON) || (move == PBMoves::ROCKSMASH) ||
			(move == PBMoves::BLOCK) || (move == PBMoves::IRONDEFENSE) ||
			(move == PBMoves::IRONHEAD) || (move == PBMoves::SHOCKWAVE) ||
			(move == PBMoves::SIGNALBEAM) || (move == PBMoves::SUPERPOWER) ||
			(move == PBMoves::THUNDERPUNCH) || (move == PBMoves::TRIATTACK) ||
			(move == PBMoves::MUDDYWATER) || (move == PBMoves::HEAVYSLAM) ||
			(move == PBMoves::STEELROLLER) || (move == PBMoves::STEELBEAM)
      return false
    end
  elsif pokemon.form==4 #Egho
		if (move == PBMoves::SUNNYDAY) || (move == PBMoves::ROCKPOLISH)
      return false
    end
  end
when PBSpecies::SOLOSIS
    if pokemon.form==1
if  (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::DUOSION
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
return true
end
end
when PBSpecies::REUNICLUS
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) ||  (move == PBMoves::OVERDOSAGE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::VANILLITE
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::VANILLISH
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::VANILLUXE
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::EELEKTRIK
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || 
  (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::EELEKTROSS
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) ||
  (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::MIENFOO
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::HALFLIFE)
  return true
end
end
when PBSpecies::MIENSHAO
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::HALFLIFE)
  return true
end
end
when PBSpecies::FLETCHLING
    if pokemon.form==1
if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::NUCLEARSLASH) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::FLETCHINDER
    if pokemon.form==1
if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::NUCLEARSLASH) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::TALONFLAME
    if pokemon.form==1
if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::NUCLEARSLASH) ||
  (move == PBMoves::GAMMARAY)
  return true
end
    end
  when PBSpecies::RUNERIGUS
    if pokemon.form==3
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
        return true
      end
    end
      when PBSpecies::COFAGRIGUS
      if pokemon.form==2
        if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
          (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE)
          return true
        end
      end
  when PBSpecies::ESPURR
      if pokemon.form==1
  if (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) 
    return true
  end
  end
  when PBSpecies::MEOWSTIC
      if pokemon.form==1
  if (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) 
    return true
  end
end
when PBSpecies::SWIRLIX
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
   (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::SLURPUFF
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::DEDENNE
    if pokemon.form==2
if (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || 
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::EMERGENCYEXIT) 
  return true
end
end
when PBSpecies::INKAY
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::GAMMARAY)  || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::MALAMAR
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::GAMMARAY)  || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::RADIOACID) || (move == PBMoves::BLASTWAVE) 
  return true
end
end
when PBSpecies::HELIOPTILE
    if pokemon.form==1
if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::HELIOLISK
    if pokemon.form==1
if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::HAWLUCHA
    if pokemon.form==1
if (move == PBMoves::NUCLEARWIND) || (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::ATOMICPUNCH)
  return true
end
end
  when PBSpecies::CARBINK
      if pokemon.form==1
  if (move == PBMoves::EXPUNGE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::IONICSTRAIN) 
    return true
  end
      end
  when PBSpecies::KLEFKI
    if pokemon.form==1
      if (move == PBMoves::HALFLIFE) || (move == PBMoves::NUCLEARWASTE)
        return true
      end
    end
  when PBSpecies::NOIVERN
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) ||  (move == PBMoves::EMERGENCYEXIT) ||
    (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::NUCLEARFANGS) ||
    (move == PBMoves::RADIOACID)
    return true
  end
end
when PBSpecies::NOIBAT
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARWIND) || 
  (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::NUCLEARFANGS) ||
  (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::PYROAR
    if pokemon.form==1
if (move == PBMoves::NUCLEARSLASH) || 
  (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::LITLEO
    if pokemon.form==1
if (move == PBMoves::NUCLEARSLASH) || 
  (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::SKIDDO
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EMERGENCYEXIT) ||
  (move == PBMoves::HALFLIFE)
  return true
end
end
when PBSpecies::GOGOAT
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::EMERGENCYEXIT) ||
  (move == PBMoves::HALFLIFE)
  return true
end
    end
  when PBSpecies::GRUBBIN
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
    (move == PBMoves::RADIOACID)
    return true
  end
  end
  when PBSpecies::CHARJABUG
      if pokemon.form==1
  if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
    (move == PBMoves::RADIOACID)
    return true
  end
end
when PBSpecies::VIKAVOLT
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::GAMMARAY) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
  (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::RADIOACID)
  return true
end
    end
  when PBSpecies::KOMALA
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::MELTDOWN) || (move == PBMoves::GAMMARAY)
        return true
      end
    end
when PBSpecies::MORELULL
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::SHIINOTIC
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::SALANDIT
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) ||
    (move == PBMoves::NUCLEARSLASH) ||
    (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::SALAZZLE
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::NUCLEARSLASH) ||
  (move == PBMoves::RADIOACID)
  return true
end
    end
  when PBSpecies::ORANGURU
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWIND) ||
        (move == PBMoves::OVERDOSAGE) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::MELTDOWN) ||
         (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::PASSIMIAN
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::GOLISOPOD
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE)  || (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::GAMMARAY) || (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::DRAMPA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::NUCLEARWIND)
        return true
      end
    end
  when PBSpecies::PYUKUMUKU
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || 
        (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::MELTDOWN) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::DHELMISE
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) ||  (move == PBMoves::EXPUNGE) ||
        (move == PBMoves::RADIOACID)
        return true
      end
    end
  when PBSpecies::JANGMOO
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::KOMMOO
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::HAKAMOO
    if pokemon.form==1
      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::ATOMICPUNCH) ||
        (move == PBMoves::HALFLIFE)
        return true
      end
    end
  when PBSpecies::BOUNSWEET
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::TSAREENA
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::STEENEE
    if pokemon.form==1
      if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::EMERGENCYEXIT) ||
        (move == PBMoves::EXPUNGE)
        return true
      end
    end
  when PBSpecies::COMFEY
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
    end
  when PBSpecies::GOSSIFLEUR
    if pokemon.form==1
      if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
        (move == PBMoves::GAMMARAY)
        return true
      end
  end
  when PBSpecies::ELDEGOSS
      if pokemon.form==1
  if (move == PBMoves::EXPUNGE) || (move == PBMoves::OVERDOSAGE) ||
    (move == PBMoves::GAMMARAY)
    return true
  end
end
when PBSpecies::WOOLOO
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::DUBWOOL
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) ||
  (move == PBMoves::GAMMARAY)
  return true
end
end
when PBSpecies::YAMPER
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::BOLTUND
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::NUCLEARFANGS) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::ROLYCOLY
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::CARKOL
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::COALOSSAL
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::GAMMARAY) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::SILICOBRA
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARFANGS) ||
  (move == PBMoves::HALFLIFE)
  return true
end
end
when PBSpecies::SANDACONDA
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::NUCLEARFANGS) ||
  (move == PBMoves::HALFLIFE)
  return true
end
end
when PBSpecies::SIZZLIPEDE
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::HALFLIFE)
  return true
end
end
when PBSpecies::CENTISKORCH
    if pokemon.form==1
if (move == PBMoves::EXPUNGE) || (move == PBMoves::EMERGENCYEXIT) || (move == PBMoves::BLASTWAVE) || (move == PBMoves::MELTDOWN) ||
  (move == PBMoves::HALFLIFE)
  return true
end
end
when PBSpecies::IMPIDIMP
    if pokemon.form==1
if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::MORGREM
    if pokemon.form==1
if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::OVERDOSAGE) ||
  (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::GRIMMSNARL
    if pokemon.form==1
if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::OVERDOSAGE) || (move == PBMoves::ATOMICPUNCH) ||
   (move == PBMoves::HALFLIFE) || (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::CUFANT
    if pokemon.form==1
if (move == PBMoves::HALFLIFE) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::MELTDOWN)
  return true
end
end
when PBSpecies::COPPERAJAH
    if pokemon.form==1
if (move == PBMoves::HALFLIFE) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::MELTDOWN)
  return true
end
    end
  when PBSpecies::FALINKS
      if pokemon.form==1
  if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::ATOMICPUNCH) || (move == PBMoves::EMERGENCYEXIT) ||
    (move == PBMoves::EXPUNGE)
    return true
  end
end
when PBSpecies::CHEWTLE
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::EMERGENCYEXIT)
  (move == PBMoves::RADIOACID)
  return true
end
end
when PBSpecies::DREDNAW
    if pokemon.form==1
if (move == PBMoves::NUCLEARWASTE) || (move == PBMoves::NUCLEARFANGS) || (move == PBMoves::EMERGENCYEXITs)
  (move == PBMoves::RADIOACID)
  return true
end
end
# Hisui
    when  PBSpecies::TYPHLOSION
      if pokemon.form==1
        if (move == PBMoves::DYNAMICPUNCH) || (move == PBMoves::SCORCHINGSANDS) || (move == PBMoves::SEISMICTOSS)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::OMINOUSWIND) || (move == PBMoves::HEX) || (move == PBMoves::NIGHTSHADE) ||
          (move == PBMoves::CALMMIND) || (move == PBMoves::CONFUSERAY) || (move == PBMoves::SPITE) ||
          (move == PBMoves::POLTERGEIST)
          return false
        end
      end
    when  PBSpecies::DECIDUEYE
      if pokemon.form==1
        if (move == PBMoves::SPITE) || (move == PBMoves::PHANTOMFORCE) || (move == PBMoves::SHADOWBALL) ||
          (move == PBMoves::ACROBATICS) || (move == PBMoves::SOLARBLADE) || (moves == PBMoves::IMPRISON) ||
          (move == PBMoves::HEX) || (move == PBMoves::HURRICANE) || (move == PBMoves::POLTERGEIST) ||
          (move == PBMoves::SKITTERSMACK)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::UPPERHAND) || (move == PBMoves::BULKUP) || (move == PBMoves::ROCKSMASH) ||
          (move == PBMoves::AURASPHERE) || (move == PBMoves::SPIKES) || (move == PBMoves::SCARYFACE) ||
          (move == PBMoves::ROCKTOMB) || (move == PBMoves::BRICKBREAK) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::REVERSAL) || (move == PBMoves::FOCUSBLAST) || (move == PBMoves::CLOSECOMBAT) ||
          (move == PBMoves::FOCUSPUNCH) || (move == PBMoves::COACHING)
          return false
        end
      end
    when  PBSpecies::SAMUROTT
      if pokemon.form==1
        if (move == PBMoves::DRAGONTAIL) || (move == PBMoves::SUPERPOWER)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::DARKPULSE) || (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::PSYCHOCUT) ||
          (move == PBMoves::POISONJAB) || (move == PBMoves::SNARL) || (move == PBMoves::LASHOUT) ||
          (move == PBMoves::THROATCHOP)
          return false
        end
      end
    when  PBSpecies::QWILFISH
      if pokemon.form==1
        if (move == PBMoves::THUNDERWAVE) || (move == PBMoves::FLIPTURN) || (move == PBMoves::EXPLOSION) ||
          (move == PBMoves::SHOCKWAVE) || (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::SCALD) ||
          (move == PBMoves::BOUNCE) || (move == PBMoves::PSYBEAM) || (move == PBMoves::SPARK)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::DARKPULSE) || (move == PBMoves::LASHOUT)
          return false
        end
      end
    when PBSpecies::VOLTORB
      if  pokemon.form==1
        if (move == PBMoves::CURSE) || (move == PBMoves::EERIEIMPULSE) || (move == PBMoves::MAGNETRISE) ||
          (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::TELEPORT) || (move == PBMoves::METALSOUND) ||
          (move == PBMoves::ASSURANCE) || (move == PBMoves::TRIATTACK) || (move == PBMoves::SAFEGUARD)
          return false
          end
      elsif pokemon.form==0
        if (move == PBMoves::MAGICALLEAF) || (move == PBMoves::BULLETSEED) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::ENERGYBALL) || (move == PBMoves::GRASSYTERRAIN) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::GIGADRAIN) || (move == PBMoves::LEAFSTORM) || (move == PBMoves::SOLARBEAM) ||
          (move == PBMoves::GRASSYGLIDE) || (move == PBMoves::WORRYSEED)
          return false
        end
      end
    when PBSpecies::ELECTRODE
      if  pokemon.form==1
        if (move == PBMoves::SAFEGUARD) || (move == PBMoves::EERIEIMPULSE) || (move == PBMoves::MAGNETRISE) ||
          (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::TELEPORT) || (move == PBMoves::METALSOUND) ||
          (move == PBMoves::ASSURANCE) || (move == PBMoves::TRIATTACK)
          return false
          end
      elsif pokemon.form==0
        if (move == PBMoves::MAGICALLEAF) || (move == PBMoves::BULLETSEED) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::ENERGYBALL) || (move == PBMoves::GRASSYTERRAIN) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::GIGADRAIN) || (move == PBMoves::LEAFSTORM) || (move == PBMoves::SOLARBEAM) ||
          (move == PBMoves::GRASSYGLIDE) || (move == PBMoves::WORRYSEED)
          return false
        end
      end
    when  PBSpecies::GROWLITHE
      if pokemon.form==2
        if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
          (move == PBMoves::GAMMARAY) || (move == PBMoves::NUCLEARFANGS) ||
          (move == PBMoves::RADIOACID) 
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::LUNGE) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::TOXIC) ||
	        (move == PBMoves::REFLECT)
          return false
        end
      elsif pokemon.form==0
	      if (move == PBMoves::ROCKSLIDE) || (move == PBMoves::ROCKTOMB) || (move == PBMoves::SANDSTORM) ||
	        (move == PBMoves::SMARTSTRIKE) || (move == PBMoves::ROCKBLAST) || (move == PBMoves::POWERGEM) ||
	        (move == PBMoves::STEALTHROCK) || (move == PBMoves::STONEEDGE) || (move == PBMoves::SMACKDOWN) ||
	        (move == PBMoves::SCORCHINGSANDS)
	        return false
	      end
      end
    when  PBSpecies::ARCANINE
      if pokemon.form==2
	      if (move == PBMoves::NUCLEARSLASH) || (move == PBMoves::IONICSTRAIN) || (move == PBMoves::BLASTWAVE) ||
          (move == PBMoves::GAMMARAY) || (move == PBMoves::NUCLEARFANGS) ||
          (move == PBMoves::RADIOACID)
          return true
	      end
      elsif pokemon.form==1
        if (move == PBMoves::LUNGE) || (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::TOXIC) ||
	        (move == PBMoves::REFLECT)
          return false
        end
      elsif pokemon.form==0
	      if (move == PBMoves::ROCKSLIDE) || (move == PBMoves::ROCKTOMB) || (move == PBMoves::SANDSTORM) ||
	        (move == PBMoves::SMARTSTRIKE) || (move == PBMoves::ROCKBLAST) || (move == PBMoves::POWERGEM) ||
	        (move == PBMoves::STEALTHROCK) || (move == PBMoves::STONEEDGE) || (move == PBMoves::SMACKDOWN)
	        return false
	      end
      end
    when  PBSpecies::LILLIGANT
      if pokemon.form==2 #? Hisui
        if (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::ALLURINGVOICE)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::AERIALACE) || (move == PBMoves::DRAINPUNCH) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::FOCUSENERGY) || (move == PBMoves::POISONJAB) || (move == PBMoves::MEGAKICK) ||
          (move == PBMoves::ROCKSMASH) || (move == PBMoves::CLOSECOMBAT) || (move == PBMoves::ACROBATICS) ||
          (move == PBMoves::AIRSLASH) || (move == PBMoves::TAKEDOWN) || (move == PBMoves::LOWKICK) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::RAINDANCE) || (move == PBMoves::BRICKBREAK) ||
          (move == PBMoves::METRONOME) || (move == PBMoves::ICESPINNER) || (move == PBMoves::HURRICANE) ||
          (move == PBMoves::VACUUMWAVE) || (move == PBMoves::TRIPLEAXEL) || (move == PBMoves::COACHING) ||
          (move == PBMoves::UPPERHAND)
          return false
        end  
      end
      if pokemon.form==3 || pokemon.form==4 #? Alolan
        if [PBMoves::CALMMIND, PBMoves::TOXIC, PBMoves::HIDDENPOWER, PBMoves::CONFIDE, PBMoves::SUNNYDAY, PBMoves::HYPERBEAM, PBMoves::PROTECT, PBMoves::RAINDANCE, PBMoves::SAFEGUARD, PBMoves::FRUSTRATION, PBMoves::SOLARBEAM, PBMoves::RETURN, PBMoves::DOUBLETEAM, PBMoves::FLAMETHROWER, PBMoves::FIREBLAST, PBMoves::TORMENT, PBMoves::FACADE, PBMoves::REST, PBMoves::ATTRACT, PBMoves::OVERHEAT, PBMoves::FOCUSBLAST, PBMoves::ENERGYBALL, PBMoves::SCALD, PBMoves::FLING, PBMoves::WILLOWISP, PBMoves::GIGAIMPACT, PBMoves::SWORDSDANCE, PBMoves::PSYCHUP, PBMoves::DREAMEATER, PBMoves::GRASSKNOT, PBMoves::SLEEPTALK, PBMoves::SUBSTITUTE, PBMoves::SECRETPOWER, PBMoves::NATUREPOWER, PBMoves::PINMISSILE, PBMoves::MAGICALLEAF, PBMoves::SOLARBLADE, PBMoves::FIRESPIN, PBMoves::SCREECH, PBMoves::CHARM, PBMoves::WHIRLPOOL, PBMoves::WEATHERBALL, PBMoves::SANDTOMB, PBMoves::BULLETSEED, PBMoves::MUDSHOT, PBMoves::BRINE, PBMoves::SPEEDSWAP, PBMoves::LEAFBLADE, PBMoves::DRAININGKISS, PBMoves::GRASSYTERRAIN, PBMoves::BODYSLAM, PBMoves::HYDROPUMP, PBMoves::POWERWHIP, PBMoves::FLAREBLITZ, PBMoves::LEAFSTORM, PBMoves::AGILITY, PBMoves::FOCUSENERGY, PBMoves::METRONOME, PBMoves::AMNESIA, PBMoves::TRIATTACK, PBMoves::ENDURE, PBMoves::ENCORE, PBMoves::MUDDYWATER, PBMoves::AURASPHERE, PBMoves::NASTYPLOT, PBMoves::POLLENPUFF, PBMoves::TRAILBLAZE, PBMoves::CHILLINGWATER, PBMoves::SWIFT, PBMoves::SNORE, PBMoves::BIND, PBMoves::WORRYSEED, PBMoves::HELPINGHAND, PBMoves::ALLYSWITCH, PBMoves::AFTERYOU, PBMoves::GIGADRAIN, PBMoves::RECYCLE, PBMoves::COVET, PBMoves::LASERFOCUS, PBMoves::SKILLSWAP, PBMoves::WATERPULSE, PBMoves::HEADBUTT, PBMoves::HEALBELL, PBMoves::FIREPUNCH, PBMoves::SYNTHESIS, PBMoves::AQUATAIL, PBMoves::SEEDBOMB, PBMoves::HEATWAVE, PBMoves::TERRAINPULSE, PBMoves::SCORCHINGSANDS, PBMoves::GRASSYGLIDE, PBMoves::MIMIC].include?(move)
          return true
        end
      end
      if pokemon.form==5 #? Rebornian
        if [PBMoves::AFTERYOU, PBMoves::ALLYSWITCH, PBMoves::AMNESIA, PBMoves::ASSURANCE, PBMoves::ATTRACT, PBMoves::AURASPHERE, PBMoves::AURORAVEIL, PBMoves::AVALANCHE, PBMoves::BIND, PBMoves::BLIZZARD, PBMoves::BLOCK, PBMoves::BREAKINGSWIPE, PBMoves::BULLDOZE, PBMoves::CALMMIND, PBMoves::CHARGEBEAM, PBMoves::CHARM, PBMoves::CHILLINGWATER, PBMoves::COSMICPOWER, PBMoves::COVET, PBMoves::CROSSPOISON, PBMoves::DARKPULSE, PBMoves::DAZZLINGGLEAM, PBMoves::DEFOG, PBMoves::DOUBLETEAM, PBMoves::DRAGONDANCE, PBMoves::DRAININGKISS, PBMoves::DREAMEATER, PBMoves::EARTHPOWER, PBMoves::ECHOEDVOICE, PBMoves::EERIEIMPULSE, PBMoves::ENCORE, PBMoves::ENDEAVOR, PBMoves::ENDURE, PBMoves::ENERGYBALL, PBMoves::EXPLOSION, PBMoves::FAKETEARS, PBMoves::FLASHCANNON, PBMoves::FLING, PBMoves::FOCUSBLAST, PBMoves::FOCUSENERGY, PBMoves::FOULPLAY, PBMoves::FROSTBREATH, PBMoves::FRUSTRATION, PBMoves::FUTURESIGHT, PBMoves::GASTROACID, PBMoves::GIGADRAIN, PBMoves::GIGAIMPACT, PBMoves::GRASSKNOT, PBMoves::GRAVITY, PBMoves::GYROBALL, PBMoves::HAIL, PBMoves::HEALBELL, PBMoves::HELPINGHAND, PBMoves::HEX, PBMoves::HIDDENPOWER, PBMoves::HYPERBEAM, PBMoves::HYPERVOICE, PBMoves::ICEBALL, PBMoves::ICEBEAM, PBMoves::ICEFANG, PBMoves::ICESPINNER, PBMoves::ICICLESPEAR, PBMoves::ICYWIND, PBMoves::IMPRISON, PBMoves::INFESTATION, PBMoves::IRONDEFENSE, PBMoves::LASERFOCUS, PBMoves::LASHOUT, PBMoves::LEAFBLADE, PBMoves::LEAFSTORM, PBMoves::LIGHTSCREEN, PBMoves::MAGICALLEAF, PBMoves::MAGICCOAT, PBMoves::MAGICROOM, PBMoves::MAGNETRISE, PBMoves::METEORBEAM, PBMoves::METRONOME, PBMoves::MIMIC, PBMoves::MISTYTERRAIN, PBMoves::MOUNTAINGALE, PBMoves::MUDSHOT, PBMoves::MYSTICALFIRE, PBMoves::MYSTICALPOWER, PBMoves::NASTYPLOT, PBMoves::NATUREPOWER, PBMoves::PAINSPLIT, PBMoves::PAYBACK, PBMoves::PHANTOMFORCE, PBMoves::PINMISSILE, PBMoves::POISONJAB, PBMoves::POLLENPUFF, PBMoves::POWERSHIFT, PBMoves::PROTECT, PBMoves::PSYCHIC, PBMoves::PSYCHICTERRAIN, PBMoves::PSYCHUP, PBMoves::PSYSHOCK, PBMoves::RECYCLE, PBMoves::REFLECT, PBMoves::REST, PBMoves::RETURN, PBMoves::REVERSAL, PBMoves::ROCKPOLISH, PBMoves::ROLEPLAY, PBMoves::ROUND, PBMoves::SAFEGUARD, PBMoves::SCALD, PBMoves::SCARYFACE, PBMoves::SCREECH, PBMoves::SECRETPOWER, PBMoves::SEEDBOMB, PBMoves::SELFDESTRUCT, PBMoves::SHADOWBALL, PBMoves::SHADOWCLAW, PBMoves::SHOCKWAVE, PBMoves::SIGNALBEAM, PBMoves::SKILLSWAP, PBMoves::SKITTERSMACK, PBMoves::SLEEPTALK, PBMoves::SLUDGEBOMB, PBMoves::SLUDGEWAVE, PBMoves::SNARL, PBMoves::SNATCH, PBMoves::SNORE, PBMoves::SNOWSCAPE, PBMoves::SPITE, PBMoves::STOREDPOWER, PBMoves::SUBSTITUTE, PBMoves::SWAGGER, PBMoves::SWIFT, PBMoves::SYNTHESIS, PBMoves::TELEKINESIS, PBMoves::TERRAINPULSE, PBMoves::THIEF, PBMoves::THUNDER, PBMoves::THUNDERBOLT, PBMoves::THUNDERWAVE, PBMoves::TORMENT, PBMoves::TOXIC, PBMoves::TRIATTACK, PBMoves::TRICK, PBMoves::TRICKROOM, PBMoves::TRIPLEAXEL, PBMoves::UPROAR, PBMoves::UTURN, PBMoves::VENOSHOCK, PBMoves::WATERPULSE, PBMoves::WEATHERBALL, PBMoves::WILLOWISP, PBMoves::WONDERROOM, PBMoves::WORRYSEED].include?(move)
          return true
        else
          return false
        end
      end
      if pokemon.form==6 #? Celestial
        if [PBMoves::ACID, PBMoves::AFTERYOU, PBMoves::AQUATAIL, PBMoves::ATTRACT, PBMoves::AURASPHERE, PBMoves::AURORAVEIL, PBMoves::BEATUP, PBMoves::BIND, PBMoves::BLAZEKICK, PBMoves::BLIZZARD, PBMoves::BODYPRESS, PBMoves::BODYSLAM, PBMoves::BOUNCE, PBMoves::BRAVEBIRD, PBMoves::BREAKINGSWIPE, PBMoves::BRICKBREAK, PBMoves::BRUTALSWING, PBMoves::BUGBITE, PBMoves::BULKUP, PBMoves::BULLDOZE, PBMoves::BURNINGJEALOUSY, PBMoves::CALMMIND, PBMoves::CHARGEBEAM, PBMoves::CHARM, PBMoves::CHILLINGWATER, PBMoves::CLOSECOMBAT, PBMoves::COACHING, PBMoves::CONFIDE, PBMoves::COSMICPOWER, PBMoves::COVET, PBMoves::CROSSPOISON, PBMoves::CRUNCH, PBMoves::DARKESTLARIAT, PBMoves::DARKPULSE, PBMoves::DAZZLINGGLEAM, PBMoves::DEFOG, PBMoves::DIG, PBMoves::DOUBLETEAM, PBMoves::DRACOMETEOR, PBMoves::DRAGONCLAW, PBMoves::DRAGONDANCE, PBMoves::DRAGONPULSE, PBMoves::DRAGONTAIL, PBMoves::DRAININGKISS, PBMoves::DRAINPUNCH, PBMoves::DREAMEATER, PBMoves::DRILLRUN, PBMoves::DUALCHOP, PBMoves::DUALWINGBEAT, PBMoves::EARTHQUAKE, PBMoves::ECHOEDVOICE, PBMoves::EERIEIMPULSE, PBMoves::ELECTROBALL, PBMoves::EMBARGO, PBMoves::ENCORE, PBMoves::ENDEAVOR, PBMoves::ENDURE, PBMoves::ENERGYBALL, PBMoves::ESPERWING, PBMoves::EXPANDINGFORCE, PBMoves::EXTREMESPEED, PBMoves::FACADE, PBMoves::FAENGRUSH, PBMoves::FALSESWIPE, PBMoves::FIREBLAST, PBMoves::FIREFANG, PBMoves::FIREPLEDGE, PBMoves::FIREPUNCH, PBMoves::FIRESPIN, PBMoves::FLAMECHARGE, PBMoves::FLAMETHROWER, PBMoves::FLAREBLITZ, PBMoves::FLASHCANNON, PBMoves::FLING, PBMoves::FLIPTURN, PBMoves::FOCUSBLAST, PBMoves::FOCUSENERGY, PBMoves::FOCUSPUNCH, PBMoves::FOULPLAY, PBMoves::FROSTBREATH, PBMoves::FRUSTRATION, PBMoves::FUTURESIGHT, PBMoves::GASTROACID, PBMoves::GIGADRAIN, PBMoves::GIGAIMPACT, PBMoves::GRASSKNOT, PBMoves::GRASSPLEDGE, PBMoves::GRASSYGLIDE, PBMoves::GRAVITY, PBMoves::GUNKSHOT, PBMoves::HAIL, PBMoves::HEADBUTT, PBMoves::HEALBELL, PBMoves::HEATCRASH, PBMoves::HEATWAVE, PBMoves::HEAVYSLAM, PBMoves::HELPINGHAND, PBMoves::HIDDENPOWER, PBMoves::HIGHHORSEPOWER, PBMoves::HURRICANE, PBMoves::HYDROPUMP, PBMoves::HYPERBEAM, PBMoves::HYPERVOICE, PBMoves::ICEBALL, PBMoves::ICEBEAM, PBMoves::ICEFANG, PBMoves::ICEPUNCH, PBMoves::ICESPINNER, PBMoves::ICYWIND, PBMoves::IRONHEAD, PBMoves::IRONTAIL, PBMoves::KNOCKOFF, PBMoves::LASERFOCUS, PBMoves::LASHOUT, PBMoves::LASTRESORT, PBMoves::LEAFBLADE, PBMoves::LEAFSTORM, PBMoves::LEECHLIFE, PBMoves::LIGHTSCREEN, PBMoves::LIQUIDATION, PBMoves::LOWKICK, PBMoves::LOWSWEEP, PBMoves::MAGICALLEAF, PBMoves::MAGICROOM, PBMoves::MAGNETRISE, PBMoves::MEGAHORN, PBMoves::MEGAKICK, PBMoves::MEGAPUNCH, PBMoves::METEORBEAM, PBMoves::METRONOME, PBMoves::MIMIC, PBMoves::MUDSHOT, PBMoves::MYSTICALFIRE, PBMoves::MYSTICALPOWER, PBMoves::NASTYPLOT, PBMoves::NATUREPOWER, PBMoves::OUTRAGE, PBMoves::OVERHEAT, PBMoves::PAINSPLIT, PBMoves::PAYBACK, PBMoves::PHANTOMFORCE, PBMoves::PINMISSILE, PBMoves::PLAYROUGH, PBMoves::POISONJAB, PBMoves::POWERSHIFT, PBMoves::POWERSWAP, PBMoves::POWERUPPUNCH, PBMoves::POWERWHIP, PBMoves::PROTECT, PBMoves::PSYCHIC, PBMoves::PSYCHICFANGS, PBMoves::PSYCHUP, PBMoves::QUASH, PBMoves::RAGINGFURY, PBMoves::RAINDANCE, PBMoves::RECYCLE, PBMoves::REFLECT, PBMoves::REST, PBMoves::RETALIATE, PBMoves::REVERSAL, PBMoves::ROAR, PBMoves::ROCKSLIDE, PBMoves::ROCKTOMB, PBMoves::ROLEPLAY, PBMoves::ROOST, PBMoves::ROUND, PBMoves::SAFEGUARD, PBMoves::SANDSTORM, PBMoves::SANDTOMB, PBMoves::SCALESHOT, PBMoves::SCARYFACE, PBMoves::SCORCHINGSANDS, PBMoves::SCREECH, PBMoves::SECRETPOWER, PBMoves::SEEDBOMB, PBMoves::SELFDESTRUCT, PBMoves::SHADOWBALL, PBMoves::SHADOWCLAW, PBMoves::SHOCKWAVE, PBMoves::SIGNALBEAM, PBMoves::SKILLSWAP, PBMoves::SKITTERSMACK, PBMoves::SKYATTACK, PBMoves::SKYDROP, PBMoves::SLEEPTALK, PBMoves::SLUDGEBOMB, PBMoves::SMARTSTRIKE, PBMoves::SNARL, PBMoves::SNATCH, PBMoves::SNORE, PBMoves::SOLARBEAM, PBMoves::SOLARBLADE, PBMoves::SPITE, PBMoves::STEELBEAM, PBMoves::STEELROLLER, PBMoves::STEELWING, PBMoves::STOMPINGTANTRUM, PBMoves::STONEEDGE, PBMoves::STOREDPOWER, PBMoves::SUBSTITUTE, PBMoves::SUCKERPUNCH, PBMoves::SUNNYDAY, PBMoves::SUPERFANG, PBMoves::SUPERPOWER, PBMoves::SWAGGER, PBMoves::SWIFT, PBMoves::SWORDSDANCE, PBMoves::SYNTHESIS, PBMoves::TAILSLAP, PBMoves::TAILWIND, PBMoves::TAUNT, PBMoves::TELEKINESIS, PBMoves::TERRAINPULSE, PBMoves::THIEF, PBMoves::THROATCHOP, PBMoves::THUNDER, PBMoves::THUNDERBOLT, PBMoves::THUNDERFANG, PBMoves::THUNDERPUNCH, PBMoves::THUNDERWAVE, PBMoves::TORMENT, PBMoves::TOXIC, PBMoves::TOXICSPIKES, PBMoves::TRAILBLAZE, PBMoves::TRIATTACK, PBMoves::TRICK, PBMoves::TRICKROOM, PBMoves::TRIPLEAXEL, PBMoves::UPROAR, PBMoves::UTURN, PBMoves::VENOSHOCK, PBMoves::VOLTTACKLE, PBMoves::WATERPLEDGE, PBMoves::WATERPULSE, PBMoves::WAVECRASH, PBMoves::WEATHERBALL, PBMoves::WILDCHARGE, PBMoves::WILLOWISP, PBMoves::WONDERROOM, PBMoves::WORKUP, PBMoves::WORRYSEED, PBMoves::XSCISSOR, PBMoves::ZENHEADBUTT].include?(move)
          return true
        else
          return false
        end
      end
      if pokemon.form==7 #? Cosmic
        if [PBMoves::ABSORB, PBMoves::ACCELEROCK, PBMoves::AGILITY, PBMoves::ALLYSWITCH, PBMoves::AMNESIA, PBMoves::ASTRALSHOT, PBMoves::ATTRACT, PBMoves::BARRAGE, PBMoves::BUGBITE, PBMoves::BULLETSEED, PBMoves::CALMMIND, PBMoves::CAUSTICBREATH, PBMoves::CHARM, PBMoves::CLOSECOMBAT, PBMoves::COMETPUNCH, PBMoves::COMETSHOWER, PBMoves::CONFIDE, PBMoves::COSMICBARRAGE, PBMoves::COSMICPOWER, PBMoves::COSMICRAY, PBMoves::DECRYSTALLIZATION, PBMoves::DOUBLETEAM, PBMoves::DRAININGKISS, PBMoves::DREAMEATER, PBMoves::EARTHPOWER, PBMoves::EARTHQUAKE, PBMoves::ENDURE, PBMoves::ENERGYBALL, PBMoves::EXPLOSION, PBMoves::FELLSTINGER, PBMoves::FIREBLAST, PBMoves::FIRSTIMPRESSION, PBMoves::FLING, PBMoves::FOCUSBLAST, PBMoves::FOCUSENERGY, PBMoves::FURYATTACK, PBMoves::FURYCUTTER, PBMoves::GEMSTONEGLIMMER, PBMoves::GIGADRAIN, PBMoves::GIGAIMPACT, PBMoves::GRASSKNOT, PBMoves::GRAVITY, PBMoves::GUARDSWAP, PBMoves::HELPINGHAND, PBMoves::HIDDENPOWER, PBMoves::HYPERBEAM, PBMoves::HYPERVOICE, PBMoves::ICEBALL, PBMoves::INFESTATION, PBMoves::IRONDEFENSE, PBMoves::LEAFAGE, PBMoves::LEAFBLADE, PBMoves::LEECHLIFE, PBMoves::LIGHTSCREEN, PBMoves::MAGICALLEAF, PBMoves::MEGADRAIN, PBMoves::MEGAHORN, PBMoves::METEORBEAM, PBMoves::METRONOME, PBMoves::MOONLIGHT, PBMoves::MORNINGSUN, PBMoves::MUDSHOT, PBMoves::NATUREPOWER, PBMoves::OVERHEAT, PBMoves::PAINSPLIT, PBMoves::PETALDANCE, PBMoves::PHANTOMFORCE, PBMoves::PINMISSILE, PBMoves::POISONPOWDER, PBMoves::POLLENPUFF, PBMoves::POWERGEM, PBMoves::POWERSHIFT, PBMoves::POWERSWAP, PBMoves::POWERWHIP, PBMoves::PROTECT, PBMoves::PSYCHUP, PBMoves::QUIVERDANCE, PBMoves::RAINDANCE, PBMoves::RECOVER, PBMoves::RECYCLE, PBMoves::REFLECT, PBMoves::REST, PBMoves::RETURN, PBMoves::ROCKBLAST, PBMoves::ROCKPOLISH, PBMoves::ROCKSLIDE, PBMoves::ROCKTOMB, PBMoves::SAFEGUARD, PBMoves::SALTCURE, PBMoves::SANDSTORM, PBMoves::SANDTOMB, PBMoves::SCORCHINGSANDS, PBMoves::SCREECH, PBMoves::SECRETPOWER, PBMoves::SEEDBOMB, PBMoves::SELFDESTRUCT, PBMoves::SIGNALBEAM, PBMoves::SLEEPPOWDER, PBMoves::SLEEPTALK, PBMoves::SMACKDOWN, PBMoves::SMARTSTRIKE, PBMoves::SNORE, PBMoves::SOLARBEAM, PBMoves::SPEEDSWAP, PBMoves::SPIKECANNON, PBMoves::SPIKES, PBMoves::STEALTHROCK, PBMoves::STEAMROLLER, PBMoves::STONEEDGE, PBMoves::STOREDPOWER, PBMoves::STRENGTHSAP, PBMoves::STRUGGLEBUG, PBMoves::STUNSPORE, PBMoves::SUBSTITUTE, PBMoves::SUNNYDAY, PBMoves::SUPERPOWER, PBMoves::SWAGGER, PBMoves::SWIFT, PBMoves::SYNTHESIS, PBMoves::THUNDER, PBMoves::TOXIC, PBMoves::TOXICSPIKES, PBMoves::TRIATTACK, PBMoves::TWINEEDLE, PBMoves::UTURN, PBMoves::VICTORYDANCE, PBMoves::WEATHERBALL, PBMoves::WIDEGUARD, PBMoves::WORRYSEED, PBMoves::XSCISSOR].include?(move)
          return true
        else
          return false
        end
      end
      if pokemon.form==8 #? Paldean
        if [PBMoves::WORKUP, PBMoves::CALMMIND, PBMoves::TOXIC, PBMoves::BULKUP, PBMoves::HIDDENPOWER, PBMoves::CONFIDE, PBMoves::SUNNYDAY, PBMoves::TAUNT, PBMoves::HYPERBEAM, PBMoves::PROTECT, PBMoves::RAINDANCE, PBMoves::FRUSTRATION, PBMoves::SMACKDOWN, PBMoves::RETURN, PBMoves::BRICKBREAK, PBMoves::DOUBLETEAM, PBMoves::ROCKTOMB, PBMoves::AERIALACE, PBMoves::FACADE, PBMoves::REST, PBMoves::ATTRACT, PBMoves::THIEF, PBMoves::LOWSWEEP, PBMoves::ECHOEDVOICE, PBMoves::FOCUSBLAST, PBMoves::FALSESWIPE, PBMoves::FLING, PBMoves::SKYDROP, PBMoves::BRUTALSWING, PBMoves::ACROBATICS, PBMoves::SHADOWCLAW, PBMoves::PAYBACK, PBMoves::SMARTSTRIKE, PBMoves::GIGAIMPACT, PBMoves::STONEEDGE, PBMoves::SWORDSDANCE, PBMoves::PSYCHUP, PBMoves::BULLDOZE, PBMoves::ROCKSLIDE, PBMoves::POISONJAB, PBMoves::GRASSKNOT, PBMoves::SWAGGER, PBMoves::SLEEPTALK, PBMoves::UTURN, PBMoves::SUBSTITUTE, PBMoves::SECRETPOWER, PBMoves::SNARL, PBMoves::NATUREPOWER, PBMoves::POWERUPPUNCH, PBMoves::MEGAPUNCH, PBMoves::MEGAKICK, PBMoves::PAYDAY, PBMoves::MAGICALLEAF, PBMoves::SOLARBLADE, PBMoves::DIG, PBMoves::SCREECH, PBMoves::CHARM, PBMoves::BEATUP, PBMoves::REVENGE, PBMoves::IMPRISON, PBMoves::WEATHERBALL, PBMoves::FAKETEARS, PBMoves::ROCKBLAST, PBMoves::MUDSHOT, PBMoves::ASSURANCE, PBMoves::POWERSWAP, PBMoves::GUARDSWAP, PBMoves::SPEEDSWAP, PBMoves::CROSSPOISON, PBMoves::LEAFBLADE, PBMoves::TAILSLAP, PBMoves::DRAININGKISS, PBMoves::GRASSYTERRAIN, PBMoves::MISTYTERRAIN, PBMoves::BREAKINGSWIPE, PBMoves::BODYSLAM, PBMoves::HURRICANE, PBMoves::POWERWHIP, PBMoves::CLOSECOMBAT, PBMoves::BRAVEBIRD, PBMoves::AGILITY, PBMoves::FOCUSENERGY, PBMoves::ENDURE, PBMoves::METRONOME, PBMoves::REVERSAL, PBMoves::ENCORE, PBMoves::BLAZEKICK, PBMoves::AURASPHERE, PBMoves::HEATCRASH, PBMoves::HEAVYSLAM, PBMoves::PLAYROUGH, PBMoves::DARKESTLARIAT, PBMoves::HIGHHORSEPOWER, PBMoves::BODYPRESS, PBMoves::RETALIATE, PBMoves::SWIFT, PBMoves::FAENGRUSH, PBMoves::WAVECRASH, PBMoves::COACHING, PBMoves::LASHOUT, PBMoves::GRASSYGLIDE, PBMoves::SUCKERPUNCH, PBMoves::EXTREMESPEED, PBMoves::SNORE, PBMoves::BIND, PBMoves::GRAVITY, PBMoves::SNATCH, PBMoves::ALLYSWITCH, PBMoves::AFTERYOU, PBMoves::ENDEAVOR, PBMoves::ROLEPLAY, PBMoves::COVET, PBMoves::TRICK, PBMoves::LASERFOCUS, PBMoves::LASTRESORT, PBMoves::HEADBUTT, PBMoves::BOUNCE, PBMoves::DUALCHOP, PBMoves::THUNDERPUNCH, PBMoves::FIREPUNCH, PBMoves::ICEPUNCH, PBMoves::UPROAR, PBMoves::HYPERVOICE, PBMoves::STOMPINGTANTRUM, PBMoves::LOWKICK, PBMoves::IRONTAIL, PBMoves::SYNTHESIS, PBMoves::KNOCKOFF, PBMoves::IRONHEAD, PBMoves::THROATCHOP, PBMoves::DRAINPUNCH, PBMoves::ZENHEADBUTT, PBMoves::SEEDBOMB, PBMoves::FOULPLAY, PBMoves::SUPERPOWER].include?(move)
          return true
        else
          return false
        end
      end
      if pokemon.form==9 #? Delta 1
        if [PBMoves::ACID, PBMoves::AFTERYOU, PBMoves::AQUATAIL, PBMoves::ATTRACT, PBMoves::BIND, PBMoves::BRINE, PBMoves::CALMMIND, PBMoves::CAPTIVATE, PBMoves::CHARGEBEAM, PBMoves::CONFIDE, PBMoves::DAZZLINGGLEAM, PBMoves::DIVE, PBMoves::DOUBLETEAM, PBMoves::EARTHPOWER, PBMoves::ENDEAVOR, PBMoves::ENDURE, PBMoves::ENERGYBALL, PBMoves::FACADE, PBMoves::FIREBLAST, PBMoves::FLAMECHARGE, PBMoves::FLAMETHROWER, PBMoves::FRUSTRATION, PBMoves::GASTROACID, PBMoves::GIGADRAIN, PBMoves::GIGAIMPACT, PBMoves::HEALBELL, PBMoves::HEATWAVE, PBMoves::HIDDENPOWER, PBMoves::HYPERBEAM, PBMoves::INCINERATE, PBMoves::LIGHTSCREEN, PBMoves::MAGICCOAT, PBMoves::MIMIC, PBMoves::OVERHEAT, PBMoves::PAINSPLIT, PBMoves::POISONJAB, PBMoves::PROTECT, PBMoves::RAINDANCE, PBMoves::REST, PBMoves::RETURN, PBMoves::ROUND, PBMoves::SAFEGUARD, PBMoves::SCALD, PBMoves::SECRETPOWER, PBMoves::SHOCKWAVE, PBMoves::SIGNALBEAM, PBMoves::SLEEPTALK, PBMoves::SLUDGEBOMB, PBMoves::SNORE, PBMoves::SOLARBEAM, PBMoves::SPITE, PBMoves::SUBSTITUTE, PBMoves::SUNNYDAY, PBMoves::SURF, PBMoves::SWAGGER, PBMoves::THUNDERBOLT, PBMoves::THUNDERWAVE, PBMoves::TOXIC, PBMoves::VENOSHOCK, PBMoves::WATERFALL, PBMoves::WATERPULSE, PBMoves::WHIRLPOOL, PBMoves::WILLOWISP].include?(move)
          return true
        else
          return false
        end
      end
      if pokemon.form==10 #? Delta 2
        if [PBMoves::CALMMIND, PBMoves::TOXIC, PBMoves::HIDDENPOWER, PBMoves::SUNNYDAY, PBMoves::HYPERBEAM, PBMoves::LIGHTSCREEN, PBMoves::PROTECT, PBMoves::SAFEGUARD, PBMoves::FRUSTRATION, PBMoves::THUNDERBOLT, PBMoves::THUNDER, PBMoves::RETURN, PBMoves::PSYCHIC, PBMoves::DOUBLETEAM, PBMoves::REFLECT, PBMoves::AERIALACE, PBMoves::FACADE, PBMoves::REST, PBMoves::ATTRACT, PBMoves::RECYCLE, PBMoves::ROOST, PBMoves::FOCUSBLAST, PBMoves::CHARGEBEAM, PBMoves::PSYSHOCK, PBMoves::SKILLSWAP, PBMoves::GIGAIMPACT, PBMoves::PSYCHUP, PBMoves::THUNDERWAVE, PBMoves::SHOCKWAVE, PBMoves::DREAMEATER, PBMoves::GRASSKNOT, PBMoves::SWAGGER, PBMoves::UTURN, PBMoves::SUBSTITUTE, PBMoves::TRICKROOM, PBMoves::SLEEPTALK, PBMoves::STEELWING, PBMoves::ACROBATICS, PBMoves::DAZZLINGGLEAM, PBMoves::SILVERWIND, PBMoves::SKYDROP, PBMoves::ALLYSWITCH, PBMoves::ECHOEDVOICE, PBMoves::ROUND, PBMoves::CAPTIVATE, PBMoves::CONFIDE, PBMoves::SECRETPOWER, PBMoves::FLASH, PBMoves::WORKUP, PBMoves::FLY, PBMoves::BABYDOLLEYES, PBMoves::CHARM, PBMoves::DISARMINGVOICE, PBMoves::ENTRAINMENT, PBMoves::MISTYTERRAIN, PBMoves::WHIRLWIND, PBMoves::ACID, PBMoves::AFTERYOU, PBMoves::AIRCUTTER, PBMoves::AURASPHERE, PBMoves::BOUNCE, PBMoves::DEFOG, PBMoves::ENDEAVOR, PBMoves::ENDURE, PBMoves::HEALBELL, PBMoves::HEATWAVE, PBMoves::HELPINGHAND, PBMoves::HURRICANE, PBMoves::HYPERVOICE, PBMoves::ICYWIND, PBMoves::LASTRESORT, PBMoves::MAGICCOAT, PBMoves::MAGICROOM, PBMoves::MIMIC, PBMoves::ROLEPLAY, PBMoves::SKYATTACK, PBMoves::SNORE, PBMoves::SWIFT, PBMoves::TAILWIND, PBMoves::TWISTER, PBMoves::WONDERROOM].include?(move)
          return true
        else
          return false
        end
      end
    when  PBSpecies::ZORUA
      if pokemon.form==0
        if (move == PBMoves::CURSE) || (move == PBMoves::ICYWIND) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::WILLOWISP) || (move == PBMoves::PHANTOMFORCE) || (move == PBMoves::HYPERBEAM) ||
          (move == PBMoves::GIGAIMPACT) || (move == PBMoves::FOCUSPUNCH) || (move == PBMoves::OMINOUSWIND)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::SCARYFACE) || (move == PBMoves::EMBARGO) || (move == PBMoves::TOXIC) ||
          (move == PBMoves::SUNNYDAY) || (move == PBMoves::AERIALACE) || (move == PBMoves::INCINERATE) ||
          (move == PBMoves::GRASSKNOT) || (move == PBMoves::BOUNCE) || (move == PBMoves::SWORDSDANCE) ||
          (move == PBMoves::HYPERVOICE) || (move == PBMoves::ENCORE) || (move == PBMoves::HELPINGHAND) ||
          (move == PBMoves::SNATCH) || (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::COUNTER) ||
          (move == PBMoves::LUNGE) || (move == PBMoves::POUNCE)
          return false
        end
      end
    when  PBSpecies::ZOROARK
      if pokemon.form==0
        if (move == PBMoves::CURSE) || (move == PBMoves::ICYWIND) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::WILLOWISP) || (move == PBMoves::PHANTOMFORCE) || (move == PBMoves::FOCUSPUNCH) ||
          (move == PBMoves::HAPPYHOUR) || (move == PBMoves::OMINOUSWIND) || (move == PBMoves::POLTERGEIST)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::POUNCE) || (move == PBMoves::EMBARGO) || (move == PBMoves::TOXIC) ||
          (move == PBMoves::SUNNYDAY) || (move == PBMoves::LUNGE) || (move == PBMoves::INCINERATE) ||
          (move == PBMoves::SNATCH) || (move == PBMoves::BOUNCE) || (move == PBMoves::COUNTER) ||
          (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::ENCORE)
          return false
        end
      end
    when  PBSpecies::BRAVIARY
      if pokemon.form==1
        if (move == PBMoves::IRONHEAD)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::MYSTICALFIRE) || (move == PBMoves::PSYCHIC) ||
          (move == PBMoves::POWERSHIFT) || (move == PBMoves::PSYWAVE) || (move == PBMoves::PSYBEAM) ||
          (move == PBMoves::CONFUSERAY) || (move == PBMoves::SNARL) || (move == PBMoves::ICYWIND) ||
          (move == PBMoves::STOREDPOWER) || (move == PBMoves::NIGHTSHADE) || (move == PBMoves::PSYSHOCK) ||
          (move == PBMoves::SHADOWBALL) || (move == PBMoves::HYPERVOICE) || (move == PBMoves::CALMMIND) ||
          (move == PBMoves::PSYCHICTERRAIN) || (move == PBMoves::VACUUMWAVE) || (move == PBMoves::PSYCHUP) ||
          (move == PBMoves::FUTURESIGHT) || (move == PBMoves::EXPANDINGFORCE) || (move == PBMoves::PSYCHICNOISE)
          return false
        end
      end
    when  PBSpecies::SLIGGOO
      if pokemon.form==0
        if (move == PBMoves::STEELBEAM) || (move == PBMoves::IRONHEAD) || (move == PBMoves::FLASHCANNON) ||
          (move == PBMoves::ICESPINNER) || (move == PBMoves::ROCKTOMB) || (move == PBMoves::SANDSTORM) ||
          (move == PBMoves::GYROBALL)
          return false
        end
      end
    when  PBSpecies::GOODRA
      if pokemon.form==1
        if (move == PBMoves::AQUATAIL) || (move == PBMoves::POWERWHIP) || (move == PBMoves::HAIL) ||
          (move == PBMoves::INCINERATE) || (move == PBMoves::BRUTALSWING) || (move == PBMoves::ASSURANCE) ||
          (move == PBMoves::FOCUSPUNCH) || (move == PBMoves::SCALD) || (move == PBMoves::SUPERPOWER)
          return false
        end
      elsif pokemon.form==0
        if (move == PBMoves::STEELBEAM) || (move == PBMoves::IRONHEAD) || (move == PBMoves::FLASHCANNON) ||
          (move == PBMoves::ICESPINNER) || (move == PBMoves::ROCKTOMB) || (move == PBMoves::SANDSTORM) ||
          (move == PBMoves::GYROBALL) || (move == PBMoves::HEAVYSLAM) || (move == PBMoves::SCARYFACE) ||
          (move == PBMoves::LASHOUT)
          return false
        end
      end
    when  PBSpecies::AVALUGG
      if pokemon.form==0
        if (move == PBMoves::EARTHPOWER) || (move == PBMoves::POWERSHIFT) || (move == PBMoves::SANDSTORM) ||
          (move == PBMoves::DIG) || (move == PBMoves::ROCKBLAST) || (move == PBMoves::STEALTHROCK) ||
          (move == PBMoves::METEORBEAM) || (move == PBMoves::HARDPRESS)
          return false
        end
      elsif pokemon.form==1
        if (move == PBMoves::HYDROPUMP) || (move == PBMoves::SUPERPOWER)
          return false
        end
      end
    # Infinity Forms
    when  PBSpecies::BULBASAUR
      if pokemon.form==3
        if (move == PBMoves::SMACKDOWN) || (move == PBMoves::SANDSTORM) ||
            (move == PBMoves::ROCKTOMB) || (move == PBMoves::ROCKPOLISH) ||
            (move == PBMoves::STONEEDGE) || (move == PBMoves::ROCKSLIDE) ||
            (move == PBMoves::POISONJAB) || (move == PBMoves::ANCIENTPOWER) ||
            (move == PBMoves::STEALTHROCK) || (move == PBMoves::SOLARBLADE) ||
            (move == PBMoves::DIG) || (move == PBMoves::SCARYFACE) ||
            (move == PBMoves::SANDTOMB) || (move == PBMoves::ROCKBLAST) ||
            (move == PBMoves::SPIKES) || (move == PBMoves::TOXICSPIKES) ||
            (move == PBMoves::POWERGEM) || 
            (move == PBMoves::BULLDOZE) || (move == PBMoves::EARTHPOWER)
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::VENOSHOCK) || (move == PBMoves::STRINGSHOT) ||
            (move == PBMoves::MAGICALLEAF) || (move == PBMoves::CHARM) ||
            (move == PBMoves::LEAFSTORM)
          return false
        end
      end  
    when  PBSpecies::IVYSAUR
      if pokemon.form==3
        if (move == PBMoves::SMACKDOWN) || (move == PBMoves::SANDSTORM) ||
            (move == PBMoves::ROCKTOMB) || (move == PBMoves::ROCKPOLISH) ||
            (move == PBMoves::STONEEDGE) || (move == PBMoves::ROCKSLIDE) ||
            (move == PBMoves::POISONJAB) || (move == PBMoves::ANCIENTPOWER) ||
            (move == PBMoves::STEALTHROCK) || (move == PBMoves::SOLARBLADE) ||
            (move == PBMoves::DIG) || (move == PBMoves::SCARYFACE) ||
            (move == PBMoves::SANDTOMB) || (move == PBMoves::ROCKBLAST) ||
            (move == PBMoves::POWERGEM) || 
            (move == PBMoves::BULLDOZE) || (move == PBMoves::EARTHPOWER)
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::VENOSHOCK) || (move == PBMoves::STRINGSHOT) ||
            (move == PBMoves::MAGICALLEAF) || (move == PBMoves::CHARM) ||
            (move == PBMoves::LEAFSTORM)
          return false
        end
      end 
    when  PBSpecies::VENUSAUR
      if pokemon.form==3
        if (move == PBMoves::SMACKDOWN) || (move == PBMoves::SANDSTORM) ||
            (move == PBMoves::ROCKTOMB) || (move == PBMoves::ROCKPOLISH) ||
            (move == PBMoves::STONEEDGE) || (move == PBMoves::ROCKSLIDE) ||
            (move == PBMoves::POISONJAB) || (move == PBMoves::ANCIENTPOWER) ||
            (move == PBMoves::STEALTHROCK) || (move == PBMoves::SOLARBLADE) ||
            (move == PBMoves::DIG) || (move == PBMoves::SCARYFACE) ||
            (move == PBMoves::SANDTOMB) || (move == PBMoves::ROCKBLAST) ||
            (move == PBMoves::SCORCHINGSANDS)  
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::VENOSHOCK) || (move == PBMoves::STRINGSHOT) ||
            (move == PBMoves::MAGICALLEAF) || (move == PBMoves::CHARM) ||
            (move == PBMoves::LEAFSTORM)
          return false
        end
      end 
    when  PBSpecies::CHARMANDER
      if pokemon.form==5
        if (move == PBMoves::TWISTER) || (move == PBMoves::TORMENT) ||
          (move == PBMoves::DRAGONTAIL) || (move == PBMoves::DUALCHOP) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::THUNDERFANG) ||
          (move == PBMoves::BREAKINGSWIPE) || (move == PBMoves::SCALESHOT)
          return true
        end
      elsif pokemon.form==5
        if (move == PBMoves::BRICKBREAK) || (move == PBMoves::THUNDERPUNCH) ||
          (move == PBMoves::MEGAKICK)
          return false
        end
      elsif pokemon.form==6
        if [PBMoves::MEGAPUNCH,PBMoves::FIREPUNCH,PBMoves::THUNDERPUNCH,PBMoves::PINMISSILE,PBMoves::FIRESPIN,PBMoves::DIG,PBMoves::SCREECH,PBMoves::REST,PBMoves::ROCKSLIDE,PBMoves::THIEF,PBMoves::PROTECT,PBMoves::SCARYFACE,PBMoves::RAINDANCE,PBMoves::SUNNYDAY,PBMoves::BEATUP,PBMoves::WILLOWISP,PBMoves::FACADE,PBMoves::HELPINGHAND,PBMoves::REVENGE,PBMoves::BRICKBREAK,PBMoves::FAKETEARS,PBMoves::ROCKTOMB,PBMoves::FLING,PBMoves::DRAINPUNCH,PBMoves::SHADOWCLAW,PBMoves::THUNDERFANG,PBMoves::FIREFANG,PBMoves::CROSSPOISON,PBMoves::VENOSHOCK,PBMoves::LOWSWEEP,PBMoves::TAILSLAP,PBMoves::MYSTICALFIRE,PBMoves::FALSESWIPE,PBMoves::BRUTALSWING,PBMoves::STOMPINGTANTRUM,PBMoves::BLASTBURN,PBMoves::DUALCHOP,PBMoves::FIREPLEDGE,PBMoves::GASTROACID,PBMoves::GIGADRAIN,PBMoves::HEATWAVE,PBMoves::GUNKSHOT,PBMoves::IRONTAIL,PBMoves::KNOCKOFF,PBMoves::OUTRAGE,PBMoves::STEALTHROCK,PBMoves::SUPERFANG,PBMoves::SUPERPOWER,PBMoves::UPROAR,PBMoves::ATOMICPUNCH,PBMoves::NUCLEARSLASH,PBMoves::RADIOACID,PBMoves::NUCLEARFANGS,PBMoves::EMERGENCYEXIT].include?(move)
          return true
        else
          return false
        end
      end
    when  PBSpecies::CHARMELEON
      if pokemon.form==5
        if (move == PBMoves::TWISTER) || (move == PBMoves::TORMENT) ||
          (move == PBMoves::DRAGONTAIL) || (move == PBMoves::DUALCHOP) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::THUNDERFANG) ||
          (move == PBMoves::BREAKINGSWIPE) || (move == PBMoves::SCALESHOT)
          return true
        end
      elsif pokemon.form==5
        if (move == PBMoves::BRICKBREAK) || (move == PBMoves::THUNDERPUNCH) ||
          (move == PBMoves::MEGAKICK)
          return false
        end
      elsif pokemon.form==6
        if [PBMoves::MEGAPUNCH,PBMoves::FIREPUNCH,PBMoves::THUNDERPUNCH,PBMoves::PINMISSILE,PBMoves::FIRESPIN,PBMoves::DIG,PBMoves::SCREECH,PBMoves::REST,PBMoves::ROCKSLIDE,PBMoves::THIEF,PBMoves::PROTECT,PBMoves::SCARYFACE,PBMoves::RAINDANCE,PBMoves::SUNNYDAY,PBMoves::BEATUP,PBMoves::WILLOWISP,PBMoves::FACADE,PBMoves::HELPINGHAND,PBMoves::REVENGE,PBMoves::BRICKBREAK,PBMoves::FAKETEARS,PBMoves::ROCKTOMB,PBMoves::FLING,PBMoves::DRAINPUNCH,PBMoves::SHADOWCLAW,PBMoves::THUNDERFANG,PBMoves::FIREFANG,PBMoves::CROSSPOISON,PBMoves::VENOSHOCK,PBMoves::LOWSWEEP,PBMoves::TAILSLAP,PBMoves::MYSTICALFIRE,PBMoves::FALSESWIPE,PBMoves::BRUTALSWING,PBMoves::STOMPINGTANTRUM,PBMoves::BLASTBURN,PBMoves::DUALCHOP,PBMoves::FIREPLEDGE,PBMoves::GASTROACID,PBMoves::GIGADRAIN,PBMoves::HEATWAVE,PBMoves::GUNKSHOT,PBMoves::IRONTAIL,PBMoves::KNOCKOFF,PBMoves::OUTRAGE,PBMoves::STEALTHROCK,PBMoves::SUPERFANG,PBMoves::SUPERPOWER,PBMoves::UPROAR,PBMoves::ATOMICPUNCH,PBMoves::NUCLEARSLASH,PBMoves::RADIOACID,PBMoves::NUCLEARFANGS,PBMoves::EMERGENCYEXIT].include?(move)
          return true
        else
          return false
        end
      end
    when  PBSpecies::CHARIZARD
      if pokemon.form==5
        if (move == PBMoves::DUALCHOP) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::THUNDERFANG)
          return true
        end
      elsif pokemon.form==5
        if (move == PBMoves::BRICKBREAK) || (move == PBMoves::THUNDERPUNCH) ||
          (move == PBMoves::MEGAKICK) ||(move == PBMoves::STEELWING) ||
          (move == PBMoves::AIRCUTTER) ||(move == PBMoves::DEFOG) ||
          (move == PBMoves::OMINOUSWIND) || (move == PBMoves::TAILWIND) ||
          (move == PBMoves::AIRSLASH) || (move == PBMoves::BLAZEKICK) ||
          (move == PBMoves::DUALWINGBEAT) || (move == PBMoves::DUALWINGBEAT)
          return false
        end
      elsif pokemon.form==6
        if [PBMoves::MEGAPUNCH,PBMoves::FIREPUNCH,PBMoves::THUNDERPUNCH,PBMoves::PINMISSILE,PBMoves::FIRESPIN,PBMoves::DIG,PBMoves::SCREECH,PBMoves::REST,PBMoves::ROCKSLIDE,PBMoves::THIEF,PBMoves::PROTECT,PBMoves::SCARYFACE,PBMoves::RAINDANCE,PBMoves::SUNNYDAY,PBMoves::BEATUP,PBMoves::WILLOWISP,PBMoves::FACADE,PBMoves::HELPINGHAND,PBMoves::REVENGE,PBMoves::BRICKBREAK,PBMoves::FAKETEARS,PBMoves::ROCKTOMB,PBMoves::FLING,PBMoves::DRAINPUNCH,PBMoves::SHADOWCLAW,PBMoves::THUNDERFANG,PBMoves::FIREFANG,PBMoves::CROSSPOISON,PBMoves::VENOSHOCK,PBMoves::LOWSWEEP,PBMoves::TAILSLAP,PBMoves::MYSTICALFIRE,PBMoves::FALSESWIPE,PBMoves::BRUTALSWING,PBMoves::STOMPINGTANTRUM,PBMoves::BLASTBURN,PBMoves::DUALCHOP,PBMoves::FIREPLEDGE,PBMoves::GASTROACID,PBMoves::GIGADRAIN,PBMoves::HEATWAVE,PBMoves::GUNKSHOT,PBMoves::IRONTAIL,PBMoves::KNOCKOFF,PBMoves::OUTRAGE,PBMoves::STEALTHROCK,PBMoves::SUPERFANG,PBMoves::SUPERPOWER,PBMoves::UPROAR,PBMoves::ATOMICPUNCH,PBMoves::NUCLEARSLASH,PBMoves::RADIOACID,PBMoves::NUCLEARFANGS,PBMoves::EMERGENCYEXIT,PBMoves::FLY,PBMoves::STEELWING,PBMoves::BOUNCE,PBMoves::ACROBATICS,PBMoves::AIRSLASH,PBMoves::SKYATTACK].include?(move)
          return true
        else
          return false
        end
      end
    when  PBSpecies::SQUIRTLE
      if pokemon.form==3
        if (move == PBMoves::AERIALACE) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::TWISTER) || (move == PBMoves::ICEBALL)
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::BRICKBREAK) || (move == PBMoves::DRAGONPULSE) ||
          (move == PBMoves::ROLLOUT) || (move == PBMoves::AURASPHERE)
          return false
        end
      end  
    when  PBSpecies::WARTORTLE
      if pokemon.form==3
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) ||
          (move == PBMoves::AERIALACE) || (move == PBMoves::FLY) ||
          (move == PBMoves::DEFOG) || (move == PBMoves::TAILWIND) ||
          (move == PBMoves::TWISTER) || (move == PBMoves::AVALANCHE) ||
          (move == PBMoves::AIRSLASH) || (move == PBMoves::HURRICANE) ||
          (move == PBMoves::ICEBALL)
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::BRICKBREAK) || (move == PBMoves::DRAGONPULSE) ||
          (move == PBMoves::ROLLOUT) || (move == PBMoves::AURASPHERE)
          return false
        end
      end 
    when  PBSpecies::BLASTOISE
      if pokemon.form==3
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) ||
          (move == PBMoves::AERIALACE) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::FLY) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::TAILWIND) || (move == PBMoves::TWISTER) ||
          (move == PBMoves::AIRSLASH) || (move == PBMoves::HURRICANE) ||
          (move == PBMoves::ICEBALL)
          return true
        end
      elsif pokemon.form==3
        if (move == PBMoves::BRICKBREAK) || (move == PBMoves::DRAGONPULSE) ||
          (move == PBMoves::LIQUIDATION) || (move == PBMoves::ROLLOUT) ||
          (move == PBMoves::SIGNALBEAM) || (move == PBMoves::AURASPHERE) ||
          (move == PBMoves::TERRAINPULSE)
          return false
        end
      end 
    when  PBSpecies::SPEAROW
      if pokemon.form==1
        if (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::TORMENT) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::SHADOWCLAW) ||
          (move == PBMoves::STONEEDGE) || (move == PBMoves::SWORDSDANCE) ||
          (move == PBMoves::XSCISSOR) || (move == PBMoves::ROCKSMASH) ||
          (move == PBMoves::BOUNCE) || (move == PBMoves::DUALCHOP) ||
          (move == PBMoves::FURYCUTTER) || (move == PBMoves::LOWKICK) ||
          (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::THROATCHOP) ||
          (move == PBMoves::BEATUP) || (move == PBMoves::CRUNCH) ||
          (move == PBMoves::LEAFBLADE) || (move == PBMoves::LASHOUT) ||
          (move == PBMoves::RETALIATE) || (move == PBMoves::POUNCE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::FLY) || (move == PBMoves::AIRCUTTER) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::OMINOUSWIND) ||
          (move == PBMoves::SKYATTACK) || (move == PBMoves::TAILWIND) ||
          (move == PBMoves::TWISTER)
          return false
        end
      end  
    when  PBSpecies::FEAROW
      if pokemon.form==1
        if (move == PBMoves::SHADOWBALL) || (move == PBMoves::SLUDGEBOMB) ||
          (move == PBMoves::TORMENT) || (move == PBMoves::LOWSWEEP) ||
          (move == PBMoves::SHADOWCLAW) || (move == PBMoves::STONEEDGE) ||
          (move == PBMoves::SWORDSDANCE) || (move == PBMoves::XSCISSOR) ||
          (move == PBMoves::ROCKSMASH) || (move == PBMoves::BOUNCE) ||
          (move == PBMoves::DUALCHOP) || (move == PBMoves::FURYCUTTER) ||
          (move == PBMoves::LOWKICK) || (move == PBMoves::SUCKERPUNCH) ||
          (move == PBMoves::BEATUP) || (move == PBMoves::CROSSPOISON) ||
          (move == PBMoves::CRUNCH) || (move == PBMoves::LEAFBLADE) ||
          (move == PBMoves::LASHOUT) || (move == PBMoves::RETALIATE) ||
          (move == PBMoves::POUNCE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::FLY) || (move == PBMoves::AIRCUTTER) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::OMINOUSWIND) ||
          (move == PBMoves::SKYATTACK) || (move == PBMoves::TAILWIND) ||
          (move == PBMoves::TWISTER)
          return false
        end
      end 
    when  PBSpecies::SHELLDER
      if pokemon.form==1
        if (move == PBMoves::VENOSHOCK) || (move == PBMoves::LEECHLIFE) ||
          (move == PBMoves::ROCKTOMB) || (move == PBMoves::TORMENT) ||
          (move == PBMoves::FALSESWIPE) || (move == PBMoves::SCALD) ||
          (move == PBMoves::EMBARGO) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::SWORDSDANCE) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::DARKPULSE) ||
          (move == PBMoves::CUT) || (move == PBMoves::ROCKSMASH) ||
          (move == PBMoves::DRILLRUN) || (move == PBMoves::GIGADRAIN) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::KNOCKOFF) ||
          (move == PBMoves::SNATCH) || (move == PBMoves::SPITE) ||
          (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::SUPERFANG) ||
          (move == PBMoves::ICEFANG) || (move == PBMoves::CRUNCH) ||
          (move == PBMoves::POWERWHIP) || (move == PBMoves::HEAVYSLAM) ||
          (move == PBMoves::LASHOUT)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::ICEBEAM) || (move == PBMoves::BLIZZARD) ||
          (move == PBMoves::REFLECT) || (move == PBMoves::AVALANCHE) ||
          (move == PBMoves::SNOWSCAPE) || (move == PBMoves::ICESPINNER)
          return false
        end
      end 
    when  PBSpecies::HOOTHOOT
      if pokemon.form==1
        if (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::TRICKROOM) || (move == PBMoves::SNARL) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::DAZZLINGGLEAM) ||
          (move == PBMoves::FLASH) || (move == PBMoves::SNATCH) ||
          (move == PBMoves::ASSURANCE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::TRICKROOM) || (move == PBMoves::SNARL) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::DAZZLINGGLEAM) ||
          (move == PBMoves::FLASH) || (move == PBMoves::SNATCH) ||
          (move == PBMoves::ASSURANCE)
          return false
        end
      end
    when  PBSpecies::NOCTOWL
      if pokemon.form==1
        if (move == PBMoves::LIGHTSCREEN) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::TRICKROOM) || (move == PBMoves::SNARL) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::DAZZLINGGLEAM) ||
          (move == PBMoves::FLASH) || (move == PBMoves::SNATCH) ||
          (move == PBMoves::ASSURANCE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::PSYCHUP) || (move == PBMoves::MAGICCOAT) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::IMPRISON) ||
          (move == PBMoves::STOREDPOWER) || (move == PBMoves::BRAINSTORM)
          return false
        end
      end
    when  PBSpecies::AZURILL
      if pokemon.form==1
        if (move == PBMoves::BULKUP) || (move == PBMoves::SUNNYDAY) ||
          (move == PBMoves::SAFEGUARD) || (move == PBMoves::SANDSTORM) ||
          (move == PBMoves::ROCKTOMB) || (move == PBMoves::ROCKPOLISH) ||
          (move == PBMoves::DRAGONTAIL) || (move == PBMoves::LOWKICK) ||
          (move == PBMoves::STEALTHROCK) || (move == PBMoves::ROCKBLAST)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::LIGHTSCREEN) ||
          (move == PBMoves::SCALD) || (move == PBMoves::SURF) ||
          (move == PBMoves::WATERFALL) || (move == PBMoves::BOUNCE) ||
          (move == PBMoves::HYPERVOICE) || (move == PBMoves::ICYWIND) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::DRAININGKISS) ||
          (move == PBMoves::MUDDYWATER) || (move == PBMoves::WHIRLPOOL)
          return false
        end
      end
    when  PBSpecies::MARILL
      if pokemon.form==1
        if (move == PBMoves::BULKUP) || (move == PBMoves::SUNNYDAY) ||
          (move == PBMoves::SAFEGUARD) || (move == PBMoves::SANDSTORM) ||
          (move == PBMoves::ROCKTOMB) || (move == PBMoves::ROCKPOLISH) ||
          (move == PBMoves::STONEEDGE) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::BULLDOZE) || (move == PBMoves::ROCKSLIDE) ||
          (move == PBMoves::DRAGONTAIL) || (move == PBMoves::LOWSWEEP) ||
          (move == PBMoves::SMACKDOWN) || (move == PBMoves::POWERUPPUNCH) ||
          (move == PBMoves::DRAINPUNCH) || (move == PBMoves::LOWKICK) ||
          (move == PBMoves::STEALTHROCK) || (move == PBMoves::REVENGE) ||
          (move == PBMoves::ROCKBLAST) || (move == PBMoves::BODYPRESS) ||
          (move == PBMoves::RETALIATE) || (move == PBMoves::THUNDERPUNCH)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::LIGHTSCREEN) ||
          (move == PBMoves::SCALD) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::SURF) || (move == PBMoves::WATERFALL) ||
          (move == PBMoves::BOUNCE) || (move == PBMoves::HYPERVOICE) ||
          (move == PBMoves::ICEPUNCH) || (move == PBMoves::ICYWIND) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::DRAININGKISS) ||
          (move == PBMoves::MISTYTERRAIN) || (move == PBMoves::HYDROPUMP) ||
          (move == PBMoves::AMNESIA) || (move == PBMoves::FUTURESIGHT) ||
          (move == PBMoves::MUDDYWATER) || (move == PBMoves::PLAYROUGH) ||
          (move == PBMoves::MISTYEXPLOSION) || (move == PBMoves::WHIRLPOOL) ||
          (move == PBMoves::CHILLINGWATER) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::ICESPINNER) 
          return false
        end
      end
    when  PBSpecies::AZUMARILL
      if pokemon.form==1
        if (move == PBMoves::BULKUP) || (move == PBMoves::SUNNYDAY) ||
          (move == PBMoves::SAFEGUARD) || (move == PBMoves::SANDSTORM) ||
          (move == PBMoves::ROCKTOMB) || (move == PBMoves::ROCKPOLISH) ||
          (move == PBMoves::STONEEDGE) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::ROCKSLIDE) || (move == PBMoves::DRAGONTAIL) ||
          (move == PBMoves::DRAINPUNCH) || (move == PBMoves::LOWSWEEP) ||
          (move == PBMoves::SMACKDOWN) || (move == PBMoves::EARTHQUAKE) ||
          (move == PBMoves::LOWKICK) || (move == PBMoves::STEALTHROCK) ||
          (move == PBMoves::REVENGE) || (move == PBMoves::ROCKBLAST) ||
          (move == PBMoves::BODYPRESS) || (move == PBMoves::RETALIATE) ||
          (move == PBMoves::THUNDERPUNCH)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::LIGHTSCREEN) ||
          (move == PBMoves::SCALD) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::SURF) || (move == PBMoves::WATERFALL) ||
          (move == PBMoves::BOUNCE) || (move == PBMoves::FOCUSBLAST) ||
          (move == PBMoves::HYPERVOICE) || (move == PBMoves::ICEPUNCH) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::LIQUIDATION) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::DRAININGKISS) ||
          (move == PBMoves::MISTYTERRAIN) || (move == PBMoves::HYDROPUMP) ||
          (move == PBMoves::AMNESIA) || (move == PBMoves::FUTURESIGHT) ||
          (move == PBMoves::MUDDYWATER) || (move == PBMoves::PLAYROUGH) ||
          (move == PBMoves::MISTYEXPLOSION) || (move == PBMoves::WHIRLPOOL) ||
          (move == PBMoves::CHILLINGWATER) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::ICESPINNER) || (move == PBMoves::FLASHFLOOD)  
          return false
        end
      end
    when  PBSpecies::SWABLU
      if pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::BLIZZARD) ||
          (move == PBMoves::AURORAVEIL) || (move == PBMoves::FROSTBREATH) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::ICYWIND) ||
          (move == PBMoves::WEATHERBALL) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::FREEZEDRY)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::SUNNYDAY) || (move == PBMoves::HEATWAVE) ||
          (move == PBMoves::PLAYROUGH)
          return false
        end
      end
    when  PBSpecies::ALTARIA
      if pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::BLIZZARD) ||
          (move == PBMoves::SHADOWBALL) || (move == PBMoves::FOCUSBLAST) ||
          (move == PBMoves::AURORAVEIL) || (move == PBMoves::FROSTBREATH) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::ICYWIND) ||
          (move == PBMoves::SIGNALBEAM) || (move == PBMoves::WEATHERBALL) ||
          (move == PBMoves::FREEZEDRY)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::DRAGONCLAW) || (move == PBMoves::SUNNYDAY) ||
          (move == PBMoves::FLAMETHROWER) || (move == PBMoves::FIREBLAST) ||
          (move == PBMoves::HEATWAVE) || (move == PBMoves::FIRESPIN) ||
          (move == PBMoves::PLAYROUGH)
          return false
        end
      end
    when  PBSpecies::LOTAD
      if pokemon.form==1
        if (move == PBMoves::WORKUP) || (move == PBMoves::FLAMETHROWER) ||
          (move == PBMoves::FIREBLAST) || (move == PBMoves::FLAMECHARGE) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::OVERHEAT) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::HEATWAVE) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::RECYCLE) ||
          (move == PBMoves::SHOCKWAVE) || (move == PBMoves::FIRESPIN) ||
          (move == PBMoves::SCORCHINGSANDS) || (move == PBMoves::STEELBEAM)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::SURF) ||
          (move == PBMoves::GIGADRAIN) || (move == PBMoves::ICYWIND) ||
          (move == PBMoves::SEEDBOMB) || (move == PBMoves::SYNTHESIS) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::MUDDYWATER) ||
          (move == PBMoves::GRASSYGLIDE) || (move == PBMoves::WHIRLPOOL)
          return false
        end
      end
    when  PBSpecies::LOMBRE
      if pokemon.form==1
        if (move == PBMoves::WORKUP) || (move == PBMoves::FLAMETHROWER) ||
          (move == PBMoves::FIREBLAST) || (move == PBMoves::FLAMECHARGE) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::OVERHEAT) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::HEATWAVE) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::RECYCLE) ||
          (move == PBMoves::SHOCKWAVE) || (move == PBMoves::FIRESPIN) ||
          (move == PBMoves::SCORCHINGSANDS) || (move == PBMoves::STEELBEAM)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::SURF) ||
          (move == PBMoves::WATERFALL) || (move == PBMoves::DIVE) ||
          (move == PBMoves::GIGADRAIN) || (move == PBMoves::ICEPUNCH) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WATERPULSE) ||
          (move == PBMoves::HYDROPUMP) || (move == PBMoves::MUDDYWATER) ||
          (move == PBMoves::GRASSYGLIDE) || (move == PBMoves::WHIRLPOOL) ||
          (move == PBMoves::CHILLINGWATER)
          return false
        end
      end
    when  PBSpecies::LUDICOLO
      if pokemon.form==1
        if (move == PBMoves::WORKUP) || (move == PBMoves::FLAMETHROWER) ||
          (move == PBMoves::FIREBLAST) || (move == PBMoves::FLAMECHARGE) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::OVERHEAT) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::HEATWAVE) ||
          (move == PBMoves::IRONHEAD) || (move == PBMoves::RECYCLE) ||
          (move == PBMoves::SHOCKWAVE) || (move == PBMoves::FIRESPIN) ||
          (move == PBMoves::SCORCHINGSANDS) || (move == PBMoves::STEELBEAM) ||
          (move == PBMoves::HEAVYSLAM)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::SURF) ||
          (move == PBMoves::WATERFALL) || (move == PBMoves::DIVE) ||
          (move == PBMoves::GIGADRAIN) || (move == PBMoves::ICEPUNCH) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WATERPULSE) ||
          (move == PBMoves::HYDROPUMP) || (move == PBMoves::MUDDYWATER) ||
          (move == PBMoves::GRASSYGLIDE) || (move == PBMoves::WHIRLPOOL) ||
          (move == PBMoves::CHILLINGWATER) || (move == PBMoves::LEAFSTORM) 
          return false
        end
      end
    when  PBSpecies::MAGNEMITE
      if pokemon.form==2
        if (move == PBMoves::SOLARBEAM) || (move == PBMoves::SWORDSDANCE) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::ROCKTOMB) ||
          (move == PBMoves::ENERGYBALL) || (move == PBMoves::UTURN) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WORRYSEED) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::MAGICALLEAF) ||
          (move == PBMoves::SOLARBLADE) || (move == PBMoves::BULLETSEED) ||
          (move == PBMoves::SPIKES) || (move == PBMoves::LEAFSTORM) ||
          (move == PBMoves::GRASSYGLIDE)
          return true
        end
      elsif pokemon.form==2
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::ELECTROBALL) ||
          (move == PBMoves::RISINGVOLTAGE)
          return false
        end
      end
    when  PBSpecies::MAGNETON
      if pokemon.form==2
        if (move == PBMoves::SOLARBEAM) || (move == PBMoves::SWORDSDANCE) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::ROCKTOMB) ||
          (move == PBMoves::ENERGYBALL) || (move == PBMoves::UTURN) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WORRYSEED) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::MAGICALLEAF) ||
          (move == PBMoves::SOLARBLADE) || (move == PBMoves::BULLETSEED) ||
          (move == PBMoves::SPIKES) || (move == PBMoves::LEAFSTORM) ||
          (move == PBMoves::GRASSYGLIDE) || (move == PBMoves::BULLDOZE) ||
          (move == PBMoves::ROCKSLIDE) || (move == PBMoves::EARTHPOWER) ||
          (move == PBMoves::ROCKBLAST) || (move == PBMoves::GRASSYTERRAIN)
          return true
        end
      elsif pokemon.form==2
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::ELECTROBALL) ||
          (move == PBMoves::RISINGVOLTAGE) || (move == PBMoves::ELECTRICTERRAIN)
          return false
        end
      end
    when  PBSpecies::MAGNEZONE
      if pokemon.form==2
        if (move == PBMoves::SOLARBEAM) || (move == PBMoves::SWORDSDANCE) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::ROCKTOMB) ||
          (move == PBMoves::ENERGYBALL) || (move == PBMoves::UTURN) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WORRYSEED) ||
          (move == PBMoves::ZENHEADBUTT) || (move == PBMoves::MAGICALLEAF) ||
          (move == PBMoves::SOLARBLADE) || (move == PBMoves::BULLETSEED) ||
          (move == PBMoves::SPIKES) || (move == PBMoves::LEAFSTORM) ||
          (move == PBMoves::GRASSYGLIDE) || (move == PBMoves::BULLDOZE) ||
          (move == PBMoves::ROCKSLIDE) || (move == PBMoves::EARTHPOWER) ||
          (move == PBMoves::ROCKBLAST) || (move == PBMoves::GRASSYTERRAIN)
          return true
        end
      elsif pokemon.form==2
        if (move == PBMoves::THUNDERBOLT) || (move == PBMoves::THUNDER) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::ELECTROBALL) ||
          (move == PBMoves::RISINGVOLTAGE) || (move == PBMoves::ELECTRICTERRAIN)
          return false
        end
      end
    when  PBSpecies::TANGELA
      if pokemon.form==4
        if (move == PBMoves::CALMMIND) || (move == PBMoves::RAINDANCE) ||
          (move == PBMoves::SMACKDOWN) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::FLAMECHARGE) ||
          (move == PBMoves::OVERHEAT) || (move == PBMoves::CHARGEBEAM) ||
          (move == PBMoves::EXPLOSION) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::DRAINPUNCH) || (move == PBMoves::ELECTROWEB) ||
          (move == PBMoves::MAGNETRISE) || (move == PBMoves::SIGNALBEAM) ||
          (move == PBMoves::SWIFT) || (move == PBMoves::THUNDERPUNCH) ||
          (move == PBMoves::SELFDESTRUCT) || (move == PBMoves::BULLETSEED) ||
          (move == PBMoves::ELECTRICTERRAIN) || (move == PBMoves::EERIEIMPULSE) ||
          (move == PBMoves::SPIKES) || (move == PBMoves::POWERGEM) ||
          (move == PBMoves::ELECTROBALL) || (move == PBMoves::RISINGVOLTAGE) ||
          (move == PBMoves::STEELBEAM)
          return true
        end
      elsif pokemon.form==4
        if (move == PBMoves::SOLARBEAM) || (move == PBMoves::REFLECT) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::INFESTATION) ||
          (move == PBMoves::GRASSKNOT) || (move == PBMoves::NATUREPOWER) ||
          (move == PBMoves::SEEDBOMB) || (move == PBMoves::SYNTHESIS) ||
          (move == PBMoves::WORRYSEED) || (move == PBMoves::GRASSYTERRAIN) ||
          (move == PBMoves::LEAFSTORM) || (move == PBMoves::GRASSYGLIDE)
          return false
        end
      end
    when  PBSpecies::TANGROWTH
      if pokemon.form==4
        if (move == PBMoves::CALMMIND) || (move == PBMoves::RAINDANCE) ||
          (move == PBMoves::SMACKDOWN) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::FLAMECHARGE) ||
          (move == PBMoves::OVERHEAT) || (move == PBMoves::CHARGEBEAM) ||
          (move == PBMoves::EXPLOSION) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::GYROBALL) ||
          (move == PBMoves::FLASHCANNON) || (move == PBMoves::WILDCHARGE) ||
          (move == PBMoves::DRAINPUNCH) || (move == PBMoves::ELECTROWEB) ||
          (move == PBMoves::MAGNETRISE) || (move == PBMoves::SIGNALBEAM) ||
          (move == PBMoves::SWIFT) || (move == PBMoves::THUNDERPUNCH) ||
          (move == PBMoves::SELFDESTRUCT) || (move == PBMoves::BULLETSEED) ||
          (move == PBMoves::ELECTRICTERRAIN) || (move == PBMoves::EERIEIMPULSE) ||
          (move == PBMoves::SPIKES) || (move == PBMoves::POWERGEM) ||
          (move == PBMoves::ELECTROBALL) || (move == PBMoves::RISINGVOLTAGE) ||
          (move == PBMoves::STEELBEAM)
          return true
        end
      elsif pokemon.form==4
        if (move == PBMoves::SOLARBEAM) || (move == PBMoves::REFLECT) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::INFESTATION) ||
          (move == PBMoves::GRASSKNOT) || (move == PBMoves::NATUREPOWER) ||
          (move == PBMoves::SEEDBOMB) || (move == PBMoves::SYNTHESIS) ||
          (move == PBMoves::WORRYSEED) || (move == PBMoves::GRASSYTERRAIN) ||
          (move == PBMoves::LEAFSTORM) || (move == PBMoves::GRASSYGLIDE) ||
          (move == PBMoves::POISONJAB) || (move == PBMoves::AERIALACE) ||
          (move == PBMoves::SOLARBLADE)
          return false
        end
      end
    when  PBSpecies::HAPPINY
      if pokemon.form==1
        if (move == PBMoves::BULKUP) || (move == PBMoves::SMACKDOWN) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::OVERHEAT) ||
          (move == PBMoves::PAYBACK) || (move == PBMoves::LOWKICK) ||
          (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::SUPERPOWER) ||
          (move == PBMoves::THROATCHOP) || (move == PBMoves::DIG) ||
          (move == PBMoves::BEATUP) || (move == PBMoves::REVENGE) ||
          (move == PBMoves::BULLETSEED) || (move == PBMoves::MEGAHORN) ||
          (move == PBMoves::PLAYROUGH) ||
          (move == PBMoves::BRICKBREAK) || (move == PBMoves::POWERUPPUNCH) ||
          (move == PBMoves::DAZZLINGGLEAM) || (move == PBMoves::ROCKSMASH) ||
          (move == PBMoves::FIREPUNCH) || (move == PBMoves::FOCUSPUNCH) ||
          (move == PBMoves::ICEPUNCH) || (move == PBMoves::MEGAPUNCH) ||
          (move == PBMoves::MEGAKICK) || (move == PBMoves::RETALIATE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::LIGHTSCREEN) ||
          (move == PBMoves::SOLARBEAM) || (move == PBMoves::PSYCHIC) ||
          (move == PBMoves::SHADOWBALL) || (move == PBMoves::THUNDERWAVE) ||
          (move == PBMoves::DREAMEATER) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::GRAVITY) || (move == PBMoves::HYPERVOICE) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::CHARM) ||
          (move == PBMoves::METRONOME) || (move == PBMoves::SNOWSCAPE)
          return false
        end
      end
    when  PBSpecies::CHANSEY
      if pokemon.form==1
        if (move == PBMoves::BULKUP) || (move == PBMoves::SMACKDOWN) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::OVERHEAT) ||
          (move == PBMoves::PAYBACK) || (move == PBMoves::LOWKICK) ||
          (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::SUPERPOWER) ||
          (move == PBMoves::THROATCHOP) || (move == PBMoves::DIG) ||
          (move == PBMoves::BEATUP) || (move == PBMoves::REVENGE) ||
          (move == PBMoves::BULLETSEED) || (move == PBMoves::MEGAHORN) ||
          (move == PBMoves::PLAYROUGH) || (move == PBMoves::OUTRAGE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::LIGHTSCREEN) ||
          (move == PBMoves::SOLARBEAM) || (move == PBMoves::PSYCHIC) ||
          (move == PBMoves::SHADOWBALL) || (move == PBMoves::THUNDERWAVE) ||
          (move == PBMoves::DREAMEATER) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::GRAVITY) || (move == PBMoves::HYPERVOICE) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::CHARM) ||
          (move == PBMoves::METRONOME) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::CALMMIND) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::EARTHQUAKE) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::ALLYSWITCH) ||
          (move == PBMoves::SKILLSWAP) || (move == PBMoves::TELEKINESIS) ||
          (move == PBMoves::CHILLINGWATER)
          return false
        end
      end
    when  PBSpecies::BLISSEY
      if pokemon.form==1
        if (move == PBMoves::BULKUP) || (move == PBMoves::SMACKDOWN) ||
          (move == PBMoves::LOWSWEEP) || (move == PBMoves::OVERHEAT) ||
          (move == PBMoves::PAYBACK) || (move == PBMoves::LOWKICK) ||
          (move == PBMoves::SUCKERPUNCH) || (move == PBMoves::SUPERPOWER) ||
          (move == PBMoves::THROATCHOP) || (move == PBMoves::DIG) ||
          (move == PBMoves::BEATUP) || (move == PBMoves::REVENGE) ||
          (move == PBMoves::BULLETSEED) || (move == PBMoves::MEGAHORN) ||
          (move == PBMoves::PLAYROUGH) || (move == PBMoves::OUTRAGE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::HAIL) || (move == PBMoves::LIGHTSCREEN) ||
          (move == PBMoves::SOLARBEAM) || (move == PBMoves::PSYCHIC) ||
          (move == PBMoves::SHADOWBALL) || (move == PBMoves::THUNDERWAVE) ||
          (move == PBMoves::DREAMEATER) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::GRAVITY) || (move == PBMoves::HYPERVOICE) ||
          (move == PBMoves::ICYWIND) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::WATERPULSE) || (move == PBMoves::CHARM) ||
          (move == PBMoves::METRONOME) || (move == PBMoves::SNOWSCAPE) ||
          (move == PBMoves::CALMMIND) || (move == PBMoves::ICEBEAM) ||
          (move == PBMoves::BLIZZARD) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::EARTHQUAKE) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::ALLYSWITCH) ||
          (move == PBMoves::SKILLSWAP) || (move == PBMoves::TELEKINESIS) ||
          (move == PBMoves::CHILLINGWATER)
          return false
        end
      end
    when  PBSpecies::ODDISH
      if pokemon.form==1
        if (move == PBMoves::TAUNT) || (move == PBMoves::SHADOWBALL) ||
          (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::TORMENT) ||
          (move == PBMoves::THIEF) || (move == PBMoves::ECHOEDVOICE) ||
          (move == PBMoves::WILLOWISP) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::DREAMEATER) || (move == PBMoves::TRICKROOM) ||
          (move == PBMoves::FOULPLAY) || (move == PBMoves::HYPERVOICE) ||
          (move == PBMoves::OMINOUSWIND) || (move == PBMoves::PAINSPLIT) ||
          (move == PBMoves::SIGNALBEAM) || (move == PBMoves::SNATCH) ||
          (move == PBMoves::SPITE) || (move == PBMoves::SCARYFACE) ||
          (move == PBMoves::PHANTOMFORCE) || (move == PBMoves::TOXICSPIKES) ||
          (move == PBMoves::NASTYPLOT) || (move == PBMoves::VENOMDRENCH)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::SUNNYDAY) || (move == PBMoves::SOLARBEAM) ||
          (move == PBMoves::REFLECT) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::DAZZLINGGLEAM) ||
          (move == PBMoves::AFTERYOU) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WORRYSEED) ||
          (move == PBMoves::CHARM) || (move == PBMoves::BULLETSEED) ||
          (move == PBMoves::GRASSYTERRAIN) || (move == PBMoves::GRASSYGLIDE)
          return false
        end
      end
    when  PBSpecies::GLOOM
      if pokemon.form==1
        if (move == PBMoves::TAUNT) || (move == PBMoves::SHADOWBALL) ||
          (move == PBMoves::SLUDGEWAVE) || (move == PBMoves::TORMENT) ||
          (move == PBMoves::THIEF) || (move == PBMoves::ECHOEDVOICE) ||
          (move == PBMoves::WILLOWISP) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::DREAMEATER) || (move == PBMoves::TRICKROOM) ||
          (move == PBMoves::FOULPLAY) || (move == PBMoves::HYPERVOICE) ||
          (move == PBMoves::OMINOUSWIND) || (move == PBMoves::PAINSPLIT) ||
          (move == PBMoves::SIGNALBEAM) || (move == PBMoves::SNATCH) ||
          (move == PBMoves::SPITE) || (move == PBMoves::SCARYFACE) ||
          (move == PBMoves::PHANTOMFORCE) || (move == PBMoves::TOXICSPIKES) ||
          (move == PBMoves::NASTYPLOT) || (move == PBMoves::VENOMDRENCH)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::SUNNYDAY) || (move == PBMoves::SOLARBEAM) ||
          (move == PBMoves::REFLECT) || (move == PBMoves::GRASSKNOT) ||
          (move == PBMoves::NATUREPOWER) || (move == PBMoves::DAZZLINGGLEAM) ||
          (move == PBMoves::AFTERYOU) || (move == PBMoves::SEEDBOMB) ||
          (move == PBMoves::SYNTHESIS) || (move == PBMoves::WORRYSEED) ||
          (move == PBMoves::CHARM) || (move == PBMoves::BULLETSEED) ||
          (move == PBMoves::GRASSYTERRAIN) || (move == PBMoves::GRASSYGLIDE) ||
          (move == PBMoves::FLING) || (move == PBMoves::DRAINPUNCH)
          return false
        end
      end
    when  PBSpecies::CHIKORITA
      if pokemon.form==1
        if (move == PBMoves::FLASHCANNON) || (move == PBMoves::AQUATAIL) ||
          (move == PBMoves::DRACOMETEOR) || (move == PBMoves::DRAGONPULSE) ||
          (move == PBMoves::PAINSPLIT) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::TWISTER) || (move == PBMoves::TRIATTACK) ||
          (move == PBMoves::OUTRAGE)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::LIGHTSCREEN)
          return false
        end
      end  
    when  PBSpecies::BAYLEEF
      if pokemon.form==1
        if (move == PBMoves::FLASHCANNON) || (move == PBMoves::AQUATAIL) ||
          (move == PBMoves::DRACOMETEOR) || (move == PBMoves::DRAGONPULSE) ||
          (move == PBMoves::PAINSPLIT) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::TWISTER) || (move == PBMoves::TRIATTACK) ||
          (move == PBMoves::OUTRAGE) ||
          (move == PBMoves::FLAMETHROWER) || (move == PBMoves::FIREBLAST)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::LIGHTSCREEN)
          return false
        end
      end 
    when  PBSpecies::MEGANIUM
      if pokemon.form==1
        if (move == PBMoves::FLASHCANNON) || (move == PBMoves::AQUATAIL) ||
          (move == PBMoves::DRACOMETEOR) || (move == PBMoves::DRAGONPULSE) ||
          (move == PBMoves::PAINSPLIT) || (move == PBMoves::SHOCKWAVE) ||
          (move == PBMoves::TWISTER) || (move == PBMoves::TRIATTACK) ||
          (move == PBMoves::FLAMETHROWER) || (move == PBMoves::FIREBLAST)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::LIGHTSCREEN)
          return false
        end
      end 
    when  PBSpecies::CYNDAQUIL
      if pokemon.form==2
        if (move == PBMoves::RAINDANCE) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::REFLECT) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::MAGNETRISE) ||
          (move == PBMoves::TAILWIND) || (move == PBMoves::WEATHERBALL) ||
          (move == PBMoves::ELECTROBALL) || (move == PBMoves::RISINGVOLTAGE)
          return true
        end
      end  
    when  PBSpecies::QUILAVA
      if pokemon.form==2
        if (move == PBMoves::RAINDANCE) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::REFLECT) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::MAGNETRISE) ||
          (move == PBMoves::TAILWIND) || (move == PBMoves::WEATHERBALL) ||
          (move == PBMoves::ELECTROBALL) || (move == PBMoves::RISINGVOLTAGE)
          return true
        end
      end 
    when  PBSpecies::TYPHLOSION
      if pokemon.form==2
        if (move == PBMoves::RAINDANCE) || (move == PBMoves::THUNDERBOLT) ||
          (move == PBMoves::THUNDER) || (move == PBMoves::REFLECT) ||
          (move == PBMoves::CHARGEBEAM) || (move == PBMoves::VOLTSWITCH) ||
          (move == PBMoves::THUNDERWAVE) || (move == PBMoves::DEFOG) ||
          (move == PBMoves::ELECTROWEB) || (move == PBMoves::MAGNETRISE) ||
          (move == PBMoves::TAILWIND) || (move == PBMoves::WEATHERBALL) ||
          (move == PBMoves::ELECTROBALL) || (move == PBMoves::RISINGVOLTAGE)
          return true
        end
      end 
    when  PBSpecies::TOTODILE
      if pokemon.form==1
        if (move == PBMoves::VENOSHOCK) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::LEECHLIFE) || (move == PBMoves::SLUDGEWAVE) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::POISONJAB) || (move == PBMoves::SNARL) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::FOULPLAY) ||
          (move == PBMoves::GASTROACID) || (move == PBMoves::SUCKERPUNCH) ||
          (move == PBMoves::SUPERFANG) || (move == PBMoves::THUNDERFANG) ||
          (move == PBMoves::FIREFANG) || (move == PBMoves::CROSSPOISON) ||
          (move == PBMoves::TOXICSPIKES) || (move == PBMoves::AURASPHERE) ||
          (move == PBMoves::NASTYPLOT) || (move == PBMoves::SKITTERSMACK) ||
          (move == PBMoves::POISONTAIL) || (move == PBMoves::DRAGONTAIL)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::ICEPUNCH) || (move == PBMoves::SUPERPOWER) ||
          (move == PBMoves::DRAGONDANCE)
          return false
        end
      end  
    when  PBSpecies::CROCONAW
      if pokemon.form==1
        if (move == PBMoves::VENOSHOCK) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::LEECHLIFE) || (move == PBMoves::SLUDGEWAVE) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::POISONJAB) || (move == PBMoves::SNARL) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::FOULPLAY) ||
          (move == PBMoves::GASTROACID) || (move == PBMoves::SUCKERPUNCH) ||
          (move == PBMoves::SUPERFANG) || (move == PBMoves::THUNDERFANG) ||
          (move == PBMoves::FIREFANG) || (move == PBMoves::CROSSPOISON) ||
          (move == PBMoves::TOXICSPIKES) || (move == PBMoves::AURASPHERE) ||
          (move == PBMoves::NASTYPLOT) || (move == PBMoves::SKITTERSMACK) ||
          (move == PBMoves::POISONTAIL) || (move == PBMoves::DRAGONTAIL) ||
          (move == PBMoves::MUDDYWATER)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::ICEPUNCH) || (move == PBMoves::SUPERPOWER) ||
          (move == PBMoves::DRAGONDANCE)
          return false
        end
      end 
    when  PBSpecies::FERALIGATR
      if pokemon.form==1
        if (move == PBMoves::VENOSHOCK) || (move == PBMoves::TAUNT) ||
          (move == PBMoves::LEECHLIFE) || (move == PBMoves::SLUDGEWAVE) ||
          (move == PBMoves::SLUDGEBOMB) || (move == PBMoves::PAYBACK) ||
          (move == PBMoves::POISONJAB) || (move == PBMoves::SNARL) ||
          (move == PBMoves::DARKPULSE) || (move == PBMoves::FOULPLAY) ||
          (move == PBMoves::GASTROACID) || (move == PBMoves::SUCKERPUNCH) ||
          (move == PBMoves::SUPERFANG) || (move == PBMoves::THUNDERFANG) ||
          (move == PBMoves::FIREFANG) || (move == PBMoves::CROSSPOISON) ||
          (move == PBMoves::TOXICSPIKES) || (move == PBMoves::AURASPHERE) ||
          (move == PBMoves::NASTYPLOT) || (move == PBMoves::SKITTERSMACK) ||
          (move == PBMoves::POISONTAIL)
          return true
        end
      elsif pokemon.form==1
        if (move == PBMoves::ICEPUNCH) || (move == PBMoves::SUPERPOWER) ||
          (move == PBMoves::DRAGONDANCE) || (move == PBMoves::PSYCHICFANGS)
          return false
        end
      end 


  end    
  return false if !$cache.tm_data[move]
  return $cache.tm_data[move].any? {|item| item==species }
end

def pbForgetMove(pokemon,moveToLearn)
  ret=-1
  pbFadeOutIn(99999){
     scene=PokemonSummaryScene.new
     screen=PokemonSummary.new(scene)
     ret=screen.pbStartForgetScreen([pokemon],0,moveToLearn)
  }
  return ret
end

def pbLearnMove(pokemon,move,ignoreifknown=false,bymachine=false)
  return false if !pokemon
  movename=PBMoves.getName(move)
  if pokemon.isEgg? && !$DEBUG
    Kernel.pbMessage(_INTL("{1} can't be taught to an Egg.",movename))
    return false
  end
  if pokemon.respond_to?("isShadow?") && pokemon.isShadow?
    Kernel.pbMessage(_INTL("{1} can't be taught to this Pokémon.",movename))
    return false
  end
  pkmnname=pokemon.name
  for i in 0...4
    if pokemon.moves[i].id==move
      Kernel.pbMessage(_INTL("{1} already knows\r\n{2}.",pkmnname,movename)) if !ignoreifknown
      return false
    end
    if pokemon.moves[i].id==0
      pokemon.moves[i]=PBMove.new(move)
      Kernel.pbMessage(_INTL("{1} learned {2}!\\se[itemlevel]",pkmnname,movename))
      return true
    end
  end
  loop do
    Kernel.pbMessage(_INTL("{1} is trying to\r\nlearn {2}.\1",pkmnname,movename))
    Kernel.pbMessage(_INTL("But {1} can't learn more than four moves.\1",pkmnname))
    if Kernel.pbConfirmMessage(_INTL("Delete a move to make\r\nroom for {1}?",movename))
      Kernel.pbMessage(_INTL("Which move should be forgotten?"))
      forgetmove=pbForgetMove(pokemon,move)
      if forgetmove>=0
        oldmovename=PBMoves.getName(pokemon.moves[forgetmove].id)
        oldmovepp=pokemon.moves[forgetmove].pp
        pokemon.moves[forgetmove]=PBMove.new(move) # Replaces current/total PP
        pokemon.moves[forgetmove].pp=[oldmovepp,pokemon.moves[forgetmove].totalpp].min if bymachine
        Kernel.pbMessage(_INTL("\\se[]1,\\wt[4] 2,\\wt[4] and...\\wt[8] ...\\wt[8] ...\\wt[8] Poof!\\se[balldrop]\1"))
        Kernel.pbMessage(_INTL("{1} forgot how to\r\nuse {2}.\1",pkmnname,oldmovename))
        Kernel.pbMessage(_INTL("And...\1"))
        Kernel.pbMessage(_INTL("\\se[]{1} learned {2}!\\se[itemlevel]",pkmnname,movename))
        return true
      elsif Kernel.pbConfirmMessage(_INTL("Should {1} stop learning {2}?",pkmnname,movename))
        Kernel.pbMessage(_INTL("{1} did not learn {2}.",pkmnname,movename))
        return false
      end
    elsif Kernel.pbConfirmMessage(_INTL("Should {1} stop learning {2}?",pkmnname,movename))
      Kernel.pbMessage(_INTL("{1} did not learn {2}.",pkmnname,movename))
      return false
    end
  end
end

def pbCheckUseOnPokemon(item,pokemon,screen)
  return pokemon && !pokemon.isEgg?
end

def pbConsumeItemInBattle(bag,item)
  if item!=0 && $cache.items[item][ITEMBATTLEUSE]!=3 && $cache.items[item][ITEMBATTLEUSE]!=4 && $cache.items[item][ITEMBATTLEUSE]!=0
    # Delete the item just used from stock
    $PokemonBag.pbDeleteItem(item)
  end
end

def pbUseItemOnPokemon(item,pokemon,scene)
  if $cache.items[item][ITEMUSE]==3 || $cache.items[item][ITEMUSE]==4    # TM or HM
    machine=$cache.items[item][ITEMMACHINE]
    return false if machine==nil
    movename=PBMoves.getName(machine)
    if (pokemon.isShadow? rescue false)
      Kernel.pbMessage(_INTL("Shadow Pokémon can't be taught any moves."))
    elsif !pokemon.isCompatibleWithMove?(machine)
      Kernel.pbMessage(_INTL("{1} and {2} are not compatible.",pokemon.name,movename))
      Kernel.pbMessage(_INTL("{1} can't be learned.",movename))
    else
      if pbIsHiddenMachine?(item)
        Kernel.pbMessage(_INTL("\\se[accesspc]Booted up a TMX."))
        Kernel.pbMessage(_INTL("It contained {1}.\1",movename))
      else
        Kernel.pbMessage(_INTL("\\se[accesspc]Booted up a TM."))
        Kernel.pbMessage(_INTL("It contained {1}.\1",movename))
      end
      if Kernel.pbConfirmMessage(_INTL("Teach {1} to {2}?",movename,pokemon.name))
        if pbLearnMove(pokemon,machine,false,true)
          $PokemonBag.pbDeleteItem(item) if pbIsTechnicalMachine?(item) && !INFINITETMS
          return true
        end
      end
    end
    return false
  else
    ret=ItemHandlers.triggerUseOnPokemon(item,pokemon,scene)
    if ret && $cache.items[item][ITEMUSE]==1 # Usable on Pokémon, consumed
      $PokemonBag.pbDeleteItem(item)
    end
    if $PokemonBag.pbQuantity(item)<=0
      Kernel.pbMessage(_INTL("You used your last {1}.",PBItems.getName(item)))
    end
    return ret
  end
  Kernel.pbMessage(_INTL("Can't use that on {1}.",pokemon.name))
  return false
end

def pbUseItem(bag,item,bagscene=nil)
  found=false
  if $cache.items[item][ITEMUSE]==3 || $cache.items[item][ITEMUSE]==4    # TM or HM
    machine=$cache.items[item][ITEMMACHINE]
    ret=true
    return 0 if machine==nil
    if $Trainer.pokemonCount==0
      Kernel.pbMessage(_INTL("There is no Pokémon."))
      return 0
    end
    movename=PBMoves.getName(machine)
    if pbIsHiddenMachine?(item)
      Kernel.pbMessage(_INTL("\\se[accesspc]Booted up a TMX."))
      Kernel.pbMessage(_INTL("It contained {1}.\1",movename))
    else
      Kernel.pbMessage(_INTL("\\se[accesspc]Booted up a TM."))
      Kernel.pbMessage(_INTL("It contained {1}.\1",movename))
    end
    if !Kernel.pbConfirmMessage(_INTL("Teach {1} to a Pokémon?",movename))
      return 0
    elsif pbMoveTutorChoose(machine,nil,true)
      bag.pbDeleteItem(item) if pbIsTechnicalMachine?(item) && !INFINITETMS
      return 1
    else
      return 0
    end
  elsif $cache.items[item][ITEMUSE]==1 || $cache.items[item][ITEMUSE]==5 # Item is usable on a Pokémon
    if $Trainer.pokemonCount==0
      Kernel.pbMessage(_INTL("There is no Pokémon."))
      return 0
    end
    ret=false
    annot=nil
    if pbIsEvolutionStone?(item)
      annot=[]
      for pkmn in $Trainer.party
        if item != PBItems::LINKSTONE
          elig=(pbCheckEvolution(pkmn,item)>0)
          annot.push(elig ? _INTL("ABLE") : _INTL("NOT ABLE"))
        else
          elig =(pbTradeCheckEvolution(pkmn,item,true)>0)
          annot.push(elig ? _INTL("ABLE") : _INTL("NOT ABLE"))
        end
      end
    end     
    pbFadeOutIn(99999){
      scene=PokemonScreen_Scene.new
      screen=PokemonScreen.new(scene,$Trainer.party)
      screen.pbStartScene(_INTL("Use on which Pokémon?"),false,annot)
      loop do
        scene.pbSetHelpText(_INTL("Use on which Pokémon?"))
        chosen=screen.pbChoosePokemon
        if chosen>=0
          pokemon=$Trainer.party[chosen]
          if !pbCheckUseOnPokemon(item,pokemon,screen)
            pbPlayBuzzerSE()
            next
          end
          # Option to use multiple of the item at once
          if ItemHandlers::MultipleAtOnce.include?(item)
            # Asking how many
            viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
            viewport.z=99999
            helpwindow=Window_UnformattedTextPokemon.new("")
            helpwindow.viewport=viewport
            amount=UIHelper.pbChooseNumber(helpwindow,'How many do you want to use?',bag.pbQuantity(item))
            helpwindow.dispose
            viewport.dispose
            ret=true

            # Applying it 
            ret, amount_consumed=ItemHandlers::UseOnPokemon.trigger(item,pokemon,scene,amount)
            if ret && $cache.items[item][ITEMUSE]==1 # Usable on Pokémon, consumed
              bag.pbDeleteItem(item, amount_consumed)
            end
            if bag.pbQuantity(item)<=0
              Kernel.pbMessage(_INTL("You used your last {1}.",
                PBItems.getName(item))) if bag.pbQuantity(item)<=0
              break
            end
            break if !ret
          else
            ret=ItemHandlers.triggerUseOnPokemon(item,pokemon,screen)
            if ret && $cache.items[item][ITEMUSE]==1 # Usable on Pokémon, consumed
              bag.pbDeleteItem(item)
            end
            if bag.pbQuantity(item)<=0
              Kernel.pbMessage(_INTL("You used your last {1}.",
                PBItems.getName(item))) if bag.pbQuantity(item)<=0
              break
            end
          end
        else
          ret=false
          break
        end
      end
      screen.pbEndScene
      bagscene.pbRefresh if bagscene
    }
    return ret ? 1 : 0
  elsif $cache.items[item][ITEMUSE]==2 # Item is usable from bag
    intret=ItemHandlers.triggerUseFromBag(item)
    case intret
      when 0
        return 0
      when 1 # Item used
        return 1
      when 2 # Item used, end screen
        return 2
      when 3 # Item used, consume item
        bag.pbDeleteItem(item)
        return 1
      when 4 # Item used, end screen and consume item
        bag.pbDeleteItem(item)
        return 2
      else
        Kernel.pbMessage(_INTL("Can't use that here."))
        return 0
    end
  else
    Kernel.pbMessage(_INTL("Can't use that here."))
    return 0
  end
end

def Kernel.pbChooseItem(var=0)
  ret=0
  scene=PokemonBag_Scene.new
  screen=PokemonBagScreen.new(scene,$PokemonBag)
  pbFadeOutIn(99999) { 
    ret=screen.pbChooseItemScreen
  }
  $game_variables[var]=ret if var>0
  return ret
end

# Shows a list of items to choose from, with the chosen item's ID being stored
# in the given Global Variable. Only items which the player has are listed.
def pbChooseItemFromList(message,variable,*args)
  commands=[]
  itemid=[]
  for item in args
    if hasConst?(PBItems,item)
      id=getConst(PBItems,item)
      if $PokemonBag.pbQuantity(id)>0
        commands.push(PBItems.getName(id))
        itemid.push(id)
      end
    end
  end
  if commands.length==0
    $game_variables[variable]=0
    return 0
  end
  commands.push(_INTL("Cancel"))
  itemid.push(0)
  ret=Kernel.pbMessage(message,commands,-1)
  if ret<0 || ret>=commands.length-1
    $game_variables[variable]=-1
    return -1
  else
    $game_variables[variable]=itemid[ret]
    return itemid[ret]
  end
end
