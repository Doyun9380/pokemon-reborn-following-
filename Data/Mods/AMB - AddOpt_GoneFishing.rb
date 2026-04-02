class PokemonOptions
  #####MODDED
  attr_accessor :amb_baseBiteChance
  attr_accessor :amb_autoHookFishing
  
  def amb_baseBiteChance
	  @amb_baseBiteChance = 50 if !@amb_baseBiteChance
	  return @amb_baseBiteChance
  end
  
  def amb_autoHookFishing
    @amb_autoHookFishing = ((FISHINGAUTOHOOK) ? 1 : 0) if !@amb_autoHookFishing
    return @amb_autoHookFishing
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new option
$amb_addOpt_Options["Fishing Base Bite %"] = NumberOption.new(_INTL("Fishing Base Bite %"),_INTL("Type %d"),0,100,
							                                       proc { $idk[:settings].amb_baseBiteChance },
							                                       proc {|value|  $idk[:settings].amb_baseBiteChance=value },
							                                       "Base chance for fish to bite. Can be increased with rods and abilities."
							                                     )
$amb_addOpt_Options["Auto-Hook Fishing"] = EnumOption.new(_INTL("Auto-Hook Fishing"),[_INTL("Off"),_INTL("On")],
                                                   proc { $idk[:settings].amb_autoHookFishing },
                                                   proc {|value|  $idk[:settings].amb_autoHookFishing=value },
                                                   "Automatically reel in hooked pokémon while fishing."
                                                 )
#####/MODDED

def pbFishing(hasencounter,rodtype=1)
  #####MODDED
  basebitechance=defined?($idk[:settings].amb_baseBiteChance) ? $idk[:settings].amb_baseBiteChance : 50
  bitechance=basebitechance+(15*rodtype)   # 65, 80, 95
  #####/MODDED
  if $Trainer.party.length>0 && !$Trainer.party[0].isEgg?
    bitechance*=2 if ($Trainer.party[0].ability == PBAbilities::STICKYHOLD)
    bitechance*=2 if ($Trainer.party[0].ability == PBAbilities::SUCTIONCUPS)
  end
  hookchance=100
  oldpattern=$game_player.fullPattern
  pbFishingBegin
  msgwindow=Kernel.pbCreateMessageWindow
  loop do
    time=2+rand(10)
    message=""
    time.times do 
      message+=".  "
    end
    if pbWaitMessage(msgwindow,time)
      pbFishingEnd
      $game_player.setDefaultCharName(nil,oldpattern)
      Kernel.pbMessageDisplay(msgwindow,_INTL("Not even a nibble..."))
      Kernel.pbDisposeMessageWindow(msgwindow)
      return false
    end
    if rand(100)<bitechance && hasencounter
      frames=rand(21)+25
      #####MODDED
      if !pbWaitForInput(msgwindow,message+_INTL("\r\nOh!  A bite!"),frames) && !(defined?($idk[:settings].amb_autoHookFishing) && $idk[:settings].amb_autoHookFishing == 1)
      #####/MODDED
        pbFishingEnd
        $game_player.setDefaultCharName(nil,oldpattern)
        Kernel.pbMessageDisplay(msgwindow,_INTL("The Pokémon got away..."))
        Kernel.pbDisposeMessageWindow(msgwindow)
        return false
      end
      if rand(100)<hookchance || FISHINGAUTOHOOK
        Kernel.pbMessageDisplay(msgwindow,_INTL("Landed a Pokémon!"))
        Kernel.pbDisposeMessageWindow(msgwindow)
        pbFishingEnd
        $game_player.setDefaultCharName(nil,oldpattern)
        return true
      end
    else
      pbFishingEnd
      $game_player.setDefaultCharName(nil,oldpattern)
      Kernel.pbMessageDisplay(msgwindow,_INTL("Not even a nibble..."))
      Kernel.pbDisposeMessageWindow(msgwindow)
      return false
    end
  end
  Kernel.pbDisposeMessageWindow(msgwindow)
  return false
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

amb_checkDependencies("AMB - AddOpt_GoneFishing", ["AMB - AddOpt.rb"])
#####/MODDED