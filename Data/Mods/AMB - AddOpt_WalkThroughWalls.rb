class PokemonOptions
  #####MODDED
  attr_accessor :amb_walkThroughWalls
  
  def amb_walkThroughWalls
	  @amb_walkThroughWalls = 0 if !@amb_walkThroughWalls
	  return @amb_walkThroughWalls
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new option
$amb_addOpt_Options["Walk Through Walls"] = EnumOption.new(_INTL("Walk Through Walls"),[_INTL("Off"),_INTL("CTRL"),_INTL("On")],
							                                      proc { $idk[:settings].amb_walkThroughWalls },
							                                      proc {|value|  $idk[:settings].amb_walkThroughWalls=value },
							                                      "Walk where you shouldn't, always or while holding CTRL."
							                                    )
#####/MODDED

class Game_Player
  def passable?(x, y, d)
    # Get new coordinates
    new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
    new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
    # If coordinates are outside of map
    unless $game_map.validLax?(new_x, new_y)
      # Impassable
      return false
    end
    if !$game_map.valid?(new_x, new_y)
      return false if !$MapFactory
      return $MapFactory.isPassableFromEdge?(new_x, new_y)
    end
    # If debug mode is ON and ctrl key was pressed
    #####MODDED
    if ($DEBUG && Input.press?(Input::CTRL)) || (defined?($idk[:settings].amb_walkThroughWalls) && (($idk[:settings].amb_walkThroughWalls == 1 && Input.press?(Input::CTRL)) || $idk[:settings].amb_walkThroughWalls == 2))
    #####/MODDED
      # Passable
      return true
    end
    super
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

amb_checkDependencies("AMB - AddOpt_WalkThroughWalls", ["AMB - AddOpt.rb"])
#####/MODDED