# Adding the ability Battle Bond
#$aephiex_battle_bond_id = PBAbilities.maxValue + 1
#$aephiex_new_abil_count = PBAbilities.getCount + 1
/
class PBAbilities
  BATTLEBOND = $aephiex_battle_bond_id
  def PBAbilities.getCount
    return $aephiex_new_abil_count
  end
  def PBAbilities.maxValue
    return $aephiex_battle_bond_id
  end
end
/
/alias pbGetMessage_AephiexAshGreninja pbGetMessage
def pbGetMessage(type,id)
  if type == MessageTypes::Abilities
    return _INTL("Battle Bond") if id == $aephiex_battle_bond_id
  elsif type == MessageTypes::AbilityDescs
    return _INTL("Transforms upon defeating a Pokémon.") if id == $aephiex_battle_bond_id
  end
  return pbGetMessage_AephiexAshGreninja(type,id)
end
/
/
class PBStuff
  ABILITYBLACKLIST.push($aephiex_battle_bond_id)
  FIXEDABILITIES.push($aephiex_battle_bond_id)
end
/
# Adding the forms for Greninja to be in and to transform to
/
PokemonForms.store(
  PBSpecies::FROAKIE, {
    :FormName => {1 => "BB"},
    :OnCreation => proc{rand(2)},

    "BB" => {:Ability => PBAbilities::BATTLEBOND}
  }
)
PokemonForms.store(
  PBSpecies::FROGADIER, {
    :FormName => {1 => "BB"},
    :OnCreation => proc{rand(2)},

    "BB" => {:Ability => PBAbilities::BATTLEBOND}
  }
)
/
PokemonForms.store(
  PBSpecies::GRENINJA, {
    :FormName => {3 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 3,
	
    "Mega" => {
      :BaseStats => [72,125,77,142,133,81],
	  :BattlerPlayerY => 120,
      :Ability => PBAbilities::PROTEAN
	  
    }
	
  }
)
/
PokemonForms.store(
  PBSpecies::CINDERACE, {
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
	
  }
)
/
/
# Making Greninja transform
class PokeBattle_Battler
  @@aephiex_ashgre_flag = {}

  # Becoming Ash-Greninja
  alias pbEODD_AephiexAshGreninja pbEffectsOnDealingDamage
  def pbEffectsOnDealingDamage(move,user,target,damage,innards)
    pbEODD_AephiexAshGreninja(move,user,target,damage,innards)
    if !@@aephiex_ashgre_flag[user.pokemon] && user.species == PBSpecies::GRENINJA && user.hasWorkingAbility(:BATTLEBOND) && user.form != 2 && !user.effects[PBEffects::Transform] && user.hp > 0 && target.hp <= 0 && !@battle.pbAllFainted?(@battle.pbParty(target.index))
      @battle.pbDisplay(_INTL("{1} became fully charged due to its bond with its Trainer!",user.pbThis))
      @battle.pbCommonAnimation("MegaEvolution",user,nil)
      user.form = 2
      user.pbUpdate(true)
      @battle.scene.pbChangePokemon(user,user.pokemon) if user.effects[PBEffects::Substitute] == 0
      @battle.pbDisplay(_INTL("{1} transformed into Ash-Greninja!",user.pbThis))
      @@aephiex_ashgre_flag[user.pokemon] = true
    end
  end

  # Reverting back to usual form on fainting
  alias pbFaint_AephiexAshGreninja pbFaint
  def pbFaint(*args)
    v = pbFaint_AephiexAshGreninja(*args)
    self.form = 1 if @@aephiex_ashgre_flag[@pokemon]
    return v
  end

  # Note that Water Shuriken boosts can't be copied by Transform
  def water_shuriken_boosted?
    return @@aephiex_ashgre_flag[@pokemon] && self.form==2
  end

  # To revert all Ash-Greninja after battle
  def self.revert_all_ash_greninja
    @@aephiex_ashgre_flag.keys.each {|pkmn| pkmn.form = 1 }
    @@aephiex_ashgre_flag.clear
  end
end

# Reverting back to usual form after battle
class PokeBattle_Battle
  alias pbEndOfBattle_AephiexAshGreninja pbEndOfBattle
  def pbEndOfBattle(*args)
    v = pbEndOfBattle_AephiexAshGreninja(*args)
    PokeBattle_Battler.revert_all_ash_greninja
    return v
  end
end
/
/
class PokeBattle_Move_00A < PokeBattle_Move
  def pbBaseDamage(basedmg,attacker,opponent)
    return 160 if @id == PBMoves::PYROBALL && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
    return basedmg
  end
end

class PokeBattle_Move_00F < PokeBattle_Move
  def pbBaseDamage(basedmg,attacker,opponent)
    return 130 if @id == PBMoves::IRONHEAD && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
    return basedmg
  end
  
  def pbAddleffect(addleffect,attacker,opponent)
	return 100 if @id == PBMoves::IRONHEAD && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
	return addleffect
  end
  
end

class PokeBattle_Move_0CC < PokeBattle_Move
  def pbBaseDamage(basedmg,attacker,opponent)
    return 130 if @id == PBMoves::BOUNCE && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
    return basedmg
  end
  
  def pbAddleffect(addleffect,attacker,opponent)
	return 100 if @id == PBMoves::BOUNCE && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
	return addleffect
  end
  
end

class PokeBattle_Move_10B < PokeBattle_Move
  def pbBaseDamage(basedmg,attacker,opponent)
    return 95 if @id == PBMoves::HIJUMPKICK && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
    return basedmg
  end
  
  def pbAddleffect(addleffect,attacker,opponent)
	return 100 if @id == PBMoves::HIJUMPKICK && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
	return addleffect
  end
  
  def pbAdditionalEffect(attacker,opponent)
  if @id == PBMoves::HIJUMPKICK && (attacker.species == PBSpecies::CINDERACE) && (attacker.form == 2)
    if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,abilitymessage:false)
      attacker.pbIncreaseStat(PBStats::ATTACK,1,abilitymessage:false)
	  attacker.pbPartner.pbIncreaseStat(PBStats::ATTACK,1,abilitymessage:false)
    end
    return true
  end
  end
end
/
# Water Shuriken changes
class PokeBattle_Move_0C0 < PokeBattle_Move
  def pbBaseDamage(basedmg,attacker,opponent)
    return 30 if @id == PBMoves::WATERSHURIKEN && (attacker.species == PBSpecies::GRENINJA) && (attacker.form == 3)
    return basedmg
  end

  alias pbNumHits_AephiexAshGreninja pbNumHits
  def pbNumHits(attacker)
    return 3 if @id == PBMoves::WATERSHURIKEN && (attacker.species == PBSpecies::GRENINJA) && (attacker.form == 3)
    return pbNumHits_AephiexAshGreninja(attacker)
  end
end
/
# Changing forms with an item
ItemHandlers::UseOnPokemon.add(:REDHOTS,proc{|item,pokemon,scene|
   if pokemon.hp<=0 || pokemon.status!=PBStatuses::FROZEN
     if [PBSpecies::FROAKIE,PBSpecies::FROGADIER,PBSpecies::GRENINJA].include?(pokemon.species)
       if pokemon.form == 0
         pokemon.form = 1
         scene.pbDisplay(_INTL("{1} acquired Battle Bond!",pokemon.name))
         next true
       else
         pokemon.form = 0
         scene.pbDisplay(_INTL("{1} acquired {2}!", pokemon.name, PBAbilities.getName(pokemon.ability)))
         next true
       end
     else
       scene.pbDisplay(_INTL("It won't have any effect."))
       next false
     end
   else
     pokemon.status=0
     pokemon.statusCount=0
     pokemon.changeHappiness("candy")
     scene.pbRefresh
     scene.pbDisplay(_INTL("{1} thawed out.",pokemon.name))
     next true
   end
})
/