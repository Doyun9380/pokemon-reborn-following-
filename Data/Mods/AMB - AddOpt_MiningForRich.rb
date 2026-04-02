class PokemonOptions
  #####MODDED
  attr_accessor :amb_additionalMiningCost
  
  def amb_additionalMiningCost
    @amb_additionalMiningCost = 10 if !@amb_additionalMiningCost
	  return @amb_additionalMiningCost
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new options
$amb_addOpt_Options["Additional Mining Cost"] = NumberOption.new(_INTL("Additional Mining Cost"),_INTL("Type %d"),0,100,
                                                        proc { $idk[:settings].amb_additionalMiningCost },
                                                        proc {|value|  $idk[:settings].amb_additionalMiningCost=value },
                                                        "Base cost per additional mining hit when using Waynolt's Mining For Rich mod."
                                                      )

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

amb_checkDependencies("AMB - AddOpt_MiningForRich", ["AMB - AddOpt.rb"])
#####/MODDED