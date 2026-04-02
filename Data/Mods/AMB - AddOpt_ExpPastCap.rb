class PokemonOptions
  #####MODDED
  attr_accessor :amb_expPastCap
  
  def amb_expPastCap
    @amb_expPastCap = 0 if !@amb_expPastCap
    return @amb_expPastCap
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new options
$amb_addOpt_Options["Exp. Gain Past Cap"] = EnumOption.new(_INTL("Exp. Gain Past Cap"),[_INTL("Zero"),_INTL("One")],
                                                    proc { $idk[:settings].amb_expPastCap },
                                                    proc {|value|  $idk[:settings].amb_expPastCap=value },
                                                    "Amount of battle experience that a pokémon at the level cap gains while the hard cap is active."
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

amb_checkDependencies("AMB - AddOpt_ExpPastCap", ["AMB - AddOpt.rb", "AMB - MonkeyPatched_PokeBattle_Battle_pbGainEXP.rb"])
#####/MODDED