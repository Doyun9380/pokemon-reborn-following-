class PokemonOptions
  #####MODDED
  attr_accessor :amb_rockSmashChance
  
  def amb_rockSmashChance
	  @amb_rockSmashChance = 25 if !@amb_rockSmashChance
	  return @amb_rockSmashChance
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new option
$amb_addOpt_Options["Rock Smash Encounter %"] = NumberOption.new(_INTL("Rock Smash Encounter %"),_INTL("Type %d"),0,100,
							                                          proc { $idk[:settings].amb_rockSmashChance },
							                                          proc {|value|  $idk[:settings].amb_rockSmashChance=value },
							                                          "Base chance to encounter wild pokémon when using Rock Smash."
							                                        )
#####/MODDED

def pbRockSmashRandomEncounter
  #####MODDED
  encounterChance = rand(100)
  if encounterChance < 25 || (defined?($idk[:settings].amb_rockSmashChance) && encounterChance < $idk[:settings].amb_rockSmashChance)
  #####/MODDED
    pbEncounter(EncounterTypes::RockSmash)
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

amb_checkDependencies("AMB - AddOpt_RockSmashEncounters", ["AMB - AddOpt.rb"])
#####/MODDED