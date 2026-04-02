class PokemonOptions
  #####MODDED
  attr_accessor :amb_expAllEV
  
  def amb_expAllEV
    @amb_expAllEV = 0 if !@amb_expAllEV
    return @amb_expAllEV
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new options
$amb_addOpt_Options["EV from Exp. All"] = EnumOption.new(_INTL("EV from Exp. All"),[_INTL("Off"),_INTL("On")],
							                                    proc { $idk[:settings].amb_expAllEV },
							                                    proc {|value|  $idk[:settings].amb_expAllEV=value },
							                                    "Controls whether a pokémon that gains experience from Exp. All also gains EV."
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

amb_checkDependencies("AMB - AddOpt_ExpAllEV", ["AMB - AddOpt.rb", "AMB - MonkeyPatched_PokeBattle_Battle_pbGainEXP.rb"])
#####/MODDED