
=begin
def pbStorePokemon(pokemon)
  if pbBoxesFull?
    Kernel.pbMessage(_INTL("There's no more room for Pokémon!\1"))
    Kernel.pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
    return
  end
  pokemon.pbRecordFirstMoves
  if false
    $Trainer.party[$Trainer.party.length]=pokemon
  else
    monsent=false
    while !monsent
      if false
        iMon = -2 
        unusablecount = 0
        for i in $Trainer.party
          next if i.isEgg?
          next if i.hp<1
          unusablecount += 1
        end
        pbFadeOutIn(99999){
          scene=PokemonScreen_Scene.new
          screen=PokemonScreen.new(scene,$Trainer.party)
          screen.pbStartScene(_INTL("Choose a Pokémon."),false)
          loop do
            iMon=screen.pbChoosePokemon
            if iMon>=0 && ($Trainer.party[iMon].knowsMove?(:CUT) || $Trainer.party[iMon].knowsMove?(:ROCKSMASH) || $Trainer.party[iMon].knowsMove?(:STRENGTH) || $Trainer.party[iMon].knowsMove?(:SURF) || $Trainer.party[iMon].knowsMove?(:WATERFALL) || $Trainer.party[iMon].knowsMove?(:DIVE) || $Trainer.party[iMon].knowsMove?(:ROCKCLIMB) || $Trainer.party[iMon].knowsMove?(:FLASH) || $Trainer.party[iMon].knowsMove?(:FLY))
              Kernel.pbMessage("You can't return a Pokémon that knows a TMX move to the PC.") 
              iMon=-2
            elsif unusablecount<=1 && !($Trainer.party[iMon].isEgg?) && $Trainer.party[iMon].hp>0 && pokemon.isEgg?
              Kernel.pbMessage("That's your last Pokémon!") 
            else
              screen.pbEndScene
              break
            end
          end
        }
        if !(iMon < 0)    
          iBox = $PokemonStorage.pbStoreCaught($Trainer.party[iMon])
          if iBox >= 0
            monsent=true
            $Trainer.party[iMon].heal
            Kernel.pbMessage(_INTL("{1} was sent to {2}.", $Trainer.party[iMon].name, $PokemonStorage[iBox].name))
            $Trainer.party[iMon] = nil
            $Trainer.party.compact!
            $Trainer.party[$Trainer.party.length]=pokemon
          else
            Kernel.pbMessage("No space left in the PC")
            return false
          end
        end      
      else
        monsent=true
        oldcurbox=$PokemonStorage.currentBox
        storedbox=$PokemonStorage.pbStoreCaught(pokemon)
        curboxname=$PokemonStorage[oldcurbox].name
        boxname=$PokemonStorage[storedbox].name
        creator=nil
        creator=Kernel.pbGetStorageCreator if $PokemonGlobal.seenStorageCreator
        if storedbox!=oldcurbox
          if creator
            Kernel.pbMessage(_INTL("Box \"{1}\" on {2}'s PC was full.\1",curboxname,creator))
          else
            Kernel.pbMessage(_INTL("Box \"{1}\" on someone's PC was full.\1",curboxname))
          end
          Kernel.pbMessage(_INTL("{1} was transferred to box \"{2}.\"",pokemon.name,boxname))
        else
          if creator
            Kernel.pbMessage(_INTL("{1} was transferred to {2}'s PC.\1",pokemon.name,creator))
          else
            Kernel.pbMessage(_INTL("{1} was transferred to someone's PC.\1",pokemon.name))
          end
          Kernel.pbMessage(_INTL("It was stored in box \"{1}\".",boxname))
        end
      end    
    end
  end
end



def pbAddPokemonSilent(pokemon,level=nil,seeform=true,originaltime=nil)
  return false if !pokemon || pbBoxesFull? || !$Trainer
  if pokemon.is_a?(String) || pokemon.is_a?(Symbol)
    pokemon=getID(PBSpecies,pokemon)
  end
  if pokemon.is_a?(Integer) && level.is_a?(Integer)
    pokemon=PokeBattle_Pokemon.new(pokemon,level,$Trainer)
  end
  if pokemon.ot == ""
    pokemon.ot = $Trainer.name 
    pokemon.trainerID = $Trainer.id
  end  
  if pokemon.eggsteps<=0
    $Trainer.seen[pokemon.species]=true
    $Trainer.owned[pokemon.species]=true
    pbSeenForm(pokemon) if seeform
  end
  pokemon.timeReceived = originaltime == nil ? Time.new : originaltime
  pokemon.pbRecordFirstMoves
  if false
    $Trainer.party[$Trainer.party.length]=pokemon
  else
    monsent=false
    while !monsent
      if false
        iMon = -2 
        unusablecount = 0
        for i in $Trainer.party
          next if i.isEgg?
          next if i.hp<1
          unusablecount += 1
        end
        pbFadeOutIn(99999){
          scene=PokemonScreen_Scene.new
          screen=PokemonScreen.new(scene,$Trainer.party)
          screen.pbStartScene(_INTL("Choose a Pokémon."),false)
          loop do
            iMon=screen.pbChoosePokemon
            if iMon>=0 && ($Trainer.party[iMon].knowsMove?(:CUT) || $Trainer.party[iMon].knowsMove?(:ROCKSMASH) || $Trainer.party[iMon].knowsMove?(:STRENGTH) || $Trainer.party[iMon].knowsMove?(:SURF) || $Trainer.party[iMon].knowsMove?(:WATERFALL) || $Trainer.party[iMon].knowsMove?(:DIVE) || $Trainer.party[iMon].knowsMove?(:ROCKCLIMB) || $Trainer.party[iMon].knowsMove?(:FLASH) || $Trainer.party[iMon].knowsMove?(:FLY))
              Kernel.pbMessage("You can't return a Pokémon that knows a TMX move to the PC.") 
              iMon=-2
            elsif unusablecount<=1 && !($Trainer.party[iMon].isEgg?) && $Trainer.party[iMon].hp>0 && pokemon.isEgg?
              Kernel.pbMessage("That's your last Pokémon!") 
            else
              screen.pbEndScene
              break
            end
          end
        }
        if !(iMon < 0)
          iBox = $PokemonStorage.pbStoreCaught($Trainer.party[iMon])
          if iBox >= 0
            monsent=true
            Kernel.pbMessage(_INTL("{1} was sent to {2}.", $Trainer.party[iMon].name, $PokemonStorage[iBox].name))
            $Trainer.party[iMon] = nil
            $Trainer.party.compact!
            $Trainer.party[$Trainer.party.length]=pokemon
          else
            Kernel.pbMessage("No space left in the PC.")
            return false
          end
        end      
      else
        monsent=true
        storedbox = $PokemonStorage.pbStoreCaught(pokemon)
        if pokemon.isEgg?
         oldcurbox=$PokemonStorage.currentBox
         #storedbox=$PokemonStorage.pbStoreCaught(pokemon)
         curboxname=$PokemonStorage[oldcurbox].name
         boxname=$PokemonStorage[storedbox].name
         creator=nil
         creator=Kernel.pbGetStorageCreator if $PokemonGlobal.seenStorageCreator
          if storedbox!=oldcurbox
            if creator
              Kernel.pbMessage(_INTL("Box \"{1}\" on {2}'s PC was full.\1",curboxname,creator))
            else
              Kernel.pbMessage(_INTL("Box \"{1}\" on someone's PC was full.\1",curboxname))
            end
            Kernel.pbMessage(_INTL("{1} was transferred to box \"{2}.\"",pokemon.name,boxname))
          else
            if creator
              Kernel.pbMessage(_INTL("{1} was transferred to {2}'s PC.\1",pokemon.name,creator))
            else
              Kernel.pbMessage(_INTL("{1} was transferred to someone's PC.\1",pokemon.name))
            end
            Kernel.pbMessage(_INTL("It was stored in box \"{1}\".",boxname))
          end
        end
      end
    end    
  end
  return true
end


=end
class PokeBattle_RealBattlePeer
  def pbStorePokemon(player,pokemon)
    if false
      player.party[player.party.length]=pokemon
      return -1
    else
      monsent=false
      while !monsent
        if false
          iMon = -2 
          unusablecount = 0
          for i in $Trainer.party
            next if i.isEgg?
            next if i.hp < 1
            unusablecount += 1
          end
          pbFadeOutIn(99999){
            scene=PokemonScreen_Scene.new
            screen=PokemonScreen.new(scene,player.party)
            screen.pbStartScene(_INTL("Choose a Pokémon."),false)
            loop do
              iMon=screen.pbChoosePokemon
              if iMon < 0
                screen.pbEndScene
                break
              end
              if iMon>=0 && [:CUT, :ROCKSMASH, :STRENGTH, :SURF, :WATERFALL, :DIVE, :ROCKCLIMB, :FLASH, :FLY].any? {|tmmove| $Trainer.party[iMon].knowsMove?(tmmove)} && !$game_switches[:EasyHMs_Password]
                Kernel.pbMessage("You can't return a Pokémon that knows a TMX move to the PC.") 
                iMon=-2
              elsif unusablecount<=1 && !($Trainer.party[iMon].isEgg?) && $Trainer.party[iMon].hp>0 && pokemon.isEgg?
                Kernel.pbMessage("That's your last Pokémon!") 
              else
                if $Trainer.party[iMon].item != 0
                  if Kernel.pbConfirmMessage("This Pokémon is holding an item. Do you want to remove it?")
                    $PokemonBag.pbStoreItem($Trainer.party[iMon].item)
                    $Trainer.party[iMon].item=0
                    $Trainer.party[iMon].form=0 if ($Trainer.party[iMon].species==PBSpecies::ARCEUS || $Trainer.party[iMon].species==PBSpecies::GENESECT || $Trainer.party[iMon].species==PBSpecies::SILVALLY)
                  end
                end
                screen.pbEndScene
                break
              end
            end
          }
          if !(iMon < 0)
            iBox = $PokemonStorage.pbStoreCaught($Trainer.party[iMon])
            if iBox >= 0
              monsent=true
              player.party[iMon].heal
              Kernel.pbMessage(_INTL("{1} was sent to {2}.", player.party[iMon].name, $PokemonStorage[iBox].name))
              player.party[iMon] = nil
              player.party.compact!
              player.party[player.party.length]=pokemon
              return -1
            else
              Kernel.pbMessage("No space left in the PC")
              return false
            end
          end      
        else
          monsent=true
          pokemon.heal
          oldcurbox=$PokemonStorage.currentBox
          storedbox=$PokemonStorage.pbStoreCaught(pokemon)
          if storedbox<0
            pbDisplayPaused(_INTL("Can't catch any more..."))
            return oldcurbox
          else
            return storedbox
          end
        end
      end      
    end
  end

end