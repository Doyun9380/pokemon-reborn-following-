class PokemonOptionScene
  #####MODDED
  def amb_addAdditionalOptions
	  #We're using a global var so that it doesn't get stored in the savegame
    $amb_addOpt_Options = {} if !defined?($amb_addOpt_Options)
    $amb_addOpt_Conditions = {} if !defined?($amb_addOpt_Conditions)
    
	  #Cosmetic, separator from other options
    OptionList.push(EnumOption.new(_INTL("Additional Options"),[_INTL(""),_INTL("by Aironfaar")],
							                          nil,
                                        nil,
                                        "Thank you for using my mod pack. Enjoy!"
						                          )) unless $amb_addOpt_Options.empty? || OptionList.any? {|opt| opt.name == "Additional Options" }
	  #Actually add the options
	  for iOpt in $amb_addOpt_Options.keys
      if $amb_addOpt_Conditions[iOpt].nil? || $amb_addOpt_Conditions[iOpt].call
        OptionList.push($amb_addOpt_Options[iOpt]) unless OptionList.any? {|opt| opt.name == iOpt }
      end
	  end
  end
  #####/MODDED
  
  def pbStartScene
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites["title"]=Window_UnformattedTextPokemon.newWithSize(
       _INTL("Options"),0,0,Graphics.width,64,@viewport)
    @sprites["textbox"]=Kernel.pbCreateMessageWindow
    @sprites["textbox"].letterbyletter=false
    #@sprites["textbox"].text=_INTL("Speech frame {1}.",1+$idk[:settings].textskin)
    # These are the different options in the game.  To add an option, define a
    # setter and a getter for that option.  To delete an option, comment it out
    # or delete it.  The game's options may be placed in any order.
    ### YUMIL - 30 - BEGIN - BRAVELY DEFAULT-STYLE ENCOUNTER RATE
    if $game_switches && $game_switches[:Unreal_Time] == true
      utOpt1 = EnumOption.new(_INTL("Unreal Time"),[_INTL("Off"),_INTL("On")],
        proc { $idk[:settings].unrealTimeDiverge},
        proc {|value|  $idk[:settings].unrealTimeDiverge=value },
        "Uses in-game time instead of computer clock."
      )
      utOpt2 = EnumOption.new(_INTL("Show Clock"),[_INTL("Always"),_INTL("Menu"),_INTL("Gear")],
        proc { $idk[:settings].unrealTimeClock},
        proc {|value|  $idk[:settings].unrealTimeClock=value },
        "Shows an in-game clock that displays the current time."
      )
      utOpt3 = NumberOption.new(_INTL("Unreal Time Scale"),_INTL("Type %d"),1,60,
        proc { $idk[:settings].unrealTimeTimeScale-1 },
        proc {|value|  $idk[:settings].unrealTimeTimeScale=value+1 },
        "Sets the rate at which unreal time passes."
      )
      unless OptionList.any? {|opt| opt.name == "Unreal Time" }
        OptionList.push(utOpt1)
        OptionList.push(utOpt2)
        OptionList.push(utOpt3)
      end
    end
    if Desolation
      OptionList.push(NumberOption2.new(_INTL("Encounter Rate"),$EncounterValues,
         proc {if ! defined?($encountermultiplier)
         $encountermultiplier=1
         end
         $EncounterValues.index((($encountermultiplier*100).to_i).to_s)},
         proc {|value|  
         $encountermultiplier=($EncounterValues[value].to_f/100).to_f
         if defined?($game_map.map_id)
           $PokemonEncounters.setup($game_map.map_id)
         end
        } 
        ### YUMIL - 30 - END
      ))
    end
    #####MODDED
    self.amb_addAdditionalOptions
    #####/MODDED
    @sprites["option"]=Window_PokemonOption.new(OptionList,0,
       @sprites["title"].height,Graphics.width,
       Graphics.height-@sprites["title"].height-@sprites["textbox"].height)
    @sprites["option"].viewport=@viewport
    @sprites["option"].visible=true
    # Get the values of each option
    for i in 0...OptionList.length
      @sprites["option"][i]=(OptionList[i].get || 0)
    end
    pbDeactivateWindows(@sprites)
    pbFadeInAndShow(@sprites) { pbUpdate }
  end
end