class PokemonOptions
  #####MODDED
  attr_accessor :amb_pickupChance
  
  def amb_pickupChance
    @amb_pickupChance = 10 if !@amb_pickupChance
    return @amb_pickupChance
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new options
$amb_addOpt_Options["Pickup Chance"] = NumberOption.new(_INTL("Pickup Chance"),_INTL("Type %d"),0,100,
							                                 proc { $idk[:settings].amb_pickupChance },
							                                 proc {|value|  $idk[:settings].amb_pickupChance=value },
							                                 "Chance for the Pickup ability to trigger at the end of battle."
							                               )
#####/MODDED

def Kernel.pbPickup(pokemon)
  return if !(pokemon.ability == PBAbilities::PICKUP || pokemon.ability == PBAbilities::STARFALLGRACE) || pokemon.isEgg?
  return if pokemon.item!=0
  #####MODDED
  return if rand(100) >= (defined?($idk[:settings].amb_pickupChance) ? $idk[:settings].amb_pickupChance : 10)
  #####/MODDED
  pickupList=pbDynamicItemList(
     :ORANBERRY,
     :GREATBALL,
     :SUPERREPEL,
     :POKESNAX,
     :CHOCOLATEIC,
     :BLASTPOWDER,
     :DUSKBALL,
     :ULTRAPOTION,
     :MAXREPEL,
     :FULLRESTORE,
     :REVIVE,
     :ETHER,
     :PPUP,
     :HEARTSCALE,
     :ABILITYCAPSULE,
     :HEARTSCALE,
     :BIGNUGGET,
     :SACREDASH
  )

  pickupListRare=pbDynamicItemList(
     :NUGGET,
     :STRAWBIC,
     :NUGGET,
     :RARECANDY,
     :BLUEMIC,
     :RARECANDY,
     :BLUEMIC,
     :BIGNUGGET,
     :LEFTOVERS,
     :LUCKYEGG,
     :LEFTOVERS
  )
  return if pickupList.length!=18
  return if pickupListRare.length!=11
  randlist=[30,10,10,10,10,10,10,4,4,1,1]
  items=[]
  plevel=[100,pokemon.level].min
  rnd=rand(100)
  itemstart=(plevel-1)/10
  itemstart=0 if itemstart<0
  for i in 0...9
    items.push(pickupList[i+itemstart])
  end
  items.push(pickupListRare[itemstart])
  items.push(pickupListRare[itemstart+1])
  cumnumber=0
  for i in 0...11
    cumnumber+=randlist[i]
    if rnd<cumnumber
      if $PokemonBag.pbCanStore?(items[i])
        $PokemonBag.pbStoreItem(items[i])
      else
        pokemon.setItem(items[i])
      end
      itemname = PBItems.getName(items[i])
      if itemname =~ /\A[aeiou]/
        Kernel.pbMessage(_INTL("{1} picked up an {2}!", pokemon.name, itemname))
      else
        Kernel.pbMessage(_INTL("{1} picked up a {2}!", pokemon.name, itemname))
      end
      break
    end
  end
end

#####MODDED
def amb_checkDependencies(modName, dependencies)
  dependenciesFulfilled = true
  for i in dependencies
    dependenciesFulfilled = dependenciesFulfilled && File.exists?("Data/Mods/" + i)
  end
  if !dependenciesFulfilled
    Kernel.pbMessage(_INTL("The mod #{modName} requires additional files to function."))
    Kernel.pbMessage(_INTL("Their names will appear in a popup after this message. Please make sure to extract them to the Data/Mods/ folder, and don't rename them."))
    dependencyString = ""
    for i in 0...dependencies.length
      dependencyString += dependencies[i]
      dependencyString += "\n" if i+1 < dependencies.length
    end
    print(dependencyString)
    Kernel.pbMessage(_INTL("The game will now close. Once you have added the required files to your Data/Mods/ folder, you can restart the game."))
    exit
  end
end

amb_checkDependencies("AMB - AddOpt_PickupChance", ["AMB - AddOpt.rb"])
#####/MODDED