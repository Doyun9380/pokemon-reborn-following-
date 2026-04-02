class PokemonOptions
  #####MODDED
  attr_accessor :amb_expFactor
  attr_accessor :amb_expDivisor

  def amb_expFactor
    @amb_expFactor = 1 if !@amb_expFactor
	  return @amb_expFactor
  end

  def amb_expDivisor
	  @amb_expDivisor = 0 if !@amb_expDivisor
	  return @amb_expDivisor
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new options
$amb_addOpt_Options["Exp. Scaling: Factor"] = NumberOption.new(_INTL("Exp. Scaling: Factor"),_INTL("Type %d"),0,100,
                                                      proc { $idk[:settings].amb_expFactor },
                                                      proc {|value|  $idk[:settings].amb_expFactor=value },
                                                      "Multiplies battle experience gained by the chosen factor."
                                                    )
$amb_addOpt_Options["Exp. Scaling: Divisor"] = NumberOption.new(_INTL("Exp. Scaling: Divisor"),_INTL("Type %d"),1,100,
                                                       proc { $idk[:settings].amb_expDivisor },
                                                       proc {|value|  $idk[:settings].amb_expDivisor=value },
                                                       "Divides battle experience gained by the chosen divisor."
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

amb_checkDependencies("AMB - AddOpt_ExpScale", ["AMB - AddOpt.rb", "AMB - MonkeyPatched_PokeBattle_Battle_pbGainEXP.rb"])
#####/MODDED