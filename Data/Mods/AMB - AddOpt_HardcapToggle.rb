#####MODDED
def amb_flipHardcap(to)
  return unless $game_switches
  $game_switches[:Hard_Level_Cap] = to == 1
end

#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)
$amb_addOpt_Conditions={} if !defined?($amb_addOpt_Conditions)

#Record the new options
$amb_addOpt_Options["Hard Level Cap"] = EnumOption.new(_INTL("Hard Level Cap"),[_INTL("Off"),_INTL("On")],
							                                    proc { $game_switches && $game_switches[:Hard_Level_Cap] ? 1 : 0 },
							                                    proc {|value|  amb_flipHardcap(value) },
							                                    "Toggles the hardcap password without consuming a data chip."
							                                  )
$amb_addOpt_Conditions["Hard Level Cap"] = proc {!$game_switches.nil? && pbLoadKnownPasswords[:Hard_Level_Cap]}
                                                    
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

amb_checkDependencies("AMB - AddOpt_HardcapToggle", ["AMB - AddOpt.rb"])
#####/MODDED