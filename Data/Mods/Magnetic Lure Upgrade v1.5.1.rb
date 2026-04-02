CosmeticForms = [PBSpecies::FLABEBE, PBSpecies::FLOETTE, PBSpecies::FLORGES, PBSpecies::SHELLOS, PBSpecies::GASTRODON, PBSpecies::DEERLING, PBSpecies::SAWSBUCK, PBSpecies::UNOWN, PBSpecies::BURMY, PBSpecies::MINIOR, PBSpecies::SINISTEA, PBSpecies::POLTEAGEIST]
# For Gen 9 mods
CosmeticForms.push(PBSpecies::DUDUNSPARCE) rescue nil
CosmeticForms.push(PBSpecies::MAUSHOLD) rescue nil
CosmeticForms.push(PBSpecies::POLTCHAGEIST) rescue nil
CosmeticForms.push(PBSpecies::SINISTCHA) rescue nil
CosmeticForms.push(PBSpecies::MISSINGNO) rescue nil

def mlu_hasRelevantForms?(species)
  return false if !PokemonForms[species]
  return false if !PokemonForms[species][:OnCreation]
  return false if CosmeticForms.include?(species)
  return true
end

def mlu_getPossibleForms(species)
  return Array(0..27) if species==PBSpecies::UNOWN
  possibleForms = []
  number = CosmeticForms.include?(species) ? 106 : 50 #the species in CosmeticForms usually have more forms
  number.times do
    v = PokemonForms[species][:OnCreation].call
    v = 0 if v==nil #should never happen though
    possibleForms.push(v)
  end
  possibleForms.uniq!
  return possibleForms
end
# There's a (really small) chance that this fails to get all the possible forms, which might at most cause an encounter row to be skipped when it shouldn't

def mlu_recordForm(pokemon)
  if pokemon.is_a?(PokeBattle_Pokemon)
    return if pokemon.isEgg?
    species = pokemon.species
    form = pokemon.form
  elsif pokemon.is_a?(String) || pokemon.is_a?(Symbol)
    species = getID(PBSpecies,pokemon)
    form = 0
  elsif pokemon.is_a?(Integer)
    species = pokemon
    form = 0
  end
  if mlu_hasRelevantForms?(species)
    $Trainer.mlu_formsowned = {} if !$Trainer.mlu_formsowned
    $Trainer.mlu_formsowned[species] = [] if !$Trainer.mlu_formsowned[species]
    $Trainer.mlu_formsowned[species].push(form) if !$Trainer.mlu_formsowned[species].include?(form)
  end
end

$mlu_speciesToForceFormsFor = []



# PokeBattle_Trainer.rb
class PokeBattle_Trainer
  attr_accessor(:mlu_formsowned)
end



# PokeBattle_Battle.rb
# This handles Pokemon caught in battle, i.e., wild Pokemon (doesn't handle snagged Pokemon but eh)
module PokeBattle_BattleCommon
  alias pbStorePokemon_mlu pbStorePokemon
  def pbStorePokemon(pokemon)
    mlu_recordForm(pokemon)
    pbStorePokemon_mlu(pokemon)
  end
end


# PokemonUtilities.rb
# These handle gift Pokemon
# pbNicknameAndStore takes care of both pbAddPokemon and pbAddToParty
alias pbNicknameAndStore_mlu pbNicknameAndStore
def pbNicknameAndStore(pokemon)
  mlu_recordForm(pokemon)
  pbNicknameAndStore_mlu(pokemon)
end

alias pbAddPokemonSilent_mlu pbAddPokemonSilent
def pbAddPokemonSilent(pokemon,level=nil,seeform=true,originaltime=nil)
  v = pbAddPokemonSilent_mlu(pokemon,level,seeform,originaltime)
  mlu_recordForm(pokemon) if v
  return v
end

alias pbAddToPartySilent_mlu pbAddToPartySilent
def pbAddToPartySilent(pokemon,level=nil,seeform=true)
  v = pbAddToPartySilent_mlu(pokemon,level,seeform)
  mlu_recordForm(pokemon) if v
  return v
end

alias pbAddForeignPokemon_mlu pbAddForeignPokemon
def pbAddForeignPokemon(pokemon,level=nil,ownerName=nil,nickname=nil,ownerGender=0,seeform=true)
  v = pbAddForeignPokemon_mlu(pokemon,level,ownerName,nickname,ownerGender,seeform)
  mlu_recordForm(pokemon) if v
  return v
end


# PokemonTrading.rb
class PokemonTradeScene
  alias pbTrade_mlu pbTrade
  def pbTrade
    pbTrade_mlu
    mlu_recordForm(@pokemon2)
  end
end


# PokemonEggHatching.rb
alias pbHatch_mlu pbHatch
def pbHatch(pokemon)
  pbHatch_mlu(pokemon)
  mlu_recordForm(pokemon)
end


# PokemonEvolution.rb
class PokemonEvolutionScene
  alias pbEvolution_mlu pbEvolution
  def pbEvolution(cancancel=true)
    pbEvolution_mlu(cancancel)
    mlu_recordForm(@pokemon) #don't care about Shedinja for now
  end
end



# PokemonEncounters.rb
class PokemonEncounters
  # Yeah this one had to be overwritten...
  def pbFilterKnownPkmnFromEncounter(chances, encounters)
    uncaptured=[]
    for i in 0...encounters.length
      # First, filter out the mons that have no chance of spawning
      # Just in case...
      next if !chances[i]
      next if chances[i] <= 0
      # Then filter out all captured mons
      enc=encounters[i]
      next if !enc
      ####MODDED
      if mlu_hasRelevantForms?(enc[0])
        if $Trainer.mlu_formsowned && $Trainer.mlu_formsowned[enc[0]]
          possibleForms = mlu_getPossibleForms(enc[0])
          if possibleForms.length == 1
            next if $Trainer.mlu_formsowned[enc[0]].include?(possibleForms[0])
          else #for randomly generated forms
            next if (possibleForms - $Trainer.mlu_formsowned[enc[0]]).empty? #i.e., if mlu_formsowned includes all items in possibleForms
            $mlu_speciesToForceFormsFor.push(enc[0])
          end
        end
      else
        next if $Trainer.owned[enc[0]]
      end
      ####/MODDED
      uncaptured.push(enc)
    end
    return nil if uncaptured.length <= 0
    randId=rand(uncaptured.length)
    return uncaptured[randId]
  end

  alias pbGenerateEncounter_mlu pbGenerateEncounter
  def pbGenerateEncounter(enctype)
    v = pbGenerateEncounter_mlu(enctype)
    $mlu_speciesToForceFormsFor.clear if v==nil
    return v
  end
end



# PokeBattle_Pokemon.rb, PokemonMultipleForms.rb, RandomizedChallenge.rb
class PokeBattle_Pokemon
  alias initialize_mlu initialize
  def initialize(*args)
    initialize_mlu(*args)
    if $mlu_speciesToForceFormsFor.include?(@species)
      v = self.form
      1000.times do #failsafe
        break if !$Trainer.mlu_formsowned[@species].include?(v)
        v = PokemonForms[@species][:OnCreation].call
      end
      self.form = v
      self.resetMoves
    end
    $mlu_speciesToForceFormsFor.clear
  end
end