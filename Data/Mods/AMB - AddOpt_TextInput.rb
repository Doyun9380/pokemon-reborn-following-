class PokemonOptions
  #####MODDED
  attr_accessor :amb_keyboardInput
  
  def amb_keyboardInput
	  @amb_keyboardInput = ((USEKEYBOARDTEXTENTRY) ? 0 : 1) if !@amb_keyboardInput
	  return @amb_keyboardInput
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new option
$amb_addOpt_Options["Text Input Style"] = EnumOption.new(_INTL("Text Input Style"),[_INTL("Keyboard"),_INTL("Classic")],
							                                    proc { $idk[:settings].amb_keyboardInput },
							                                    proc {|value|  $idk[:settings].amb_keyboardInput=value },
							                                    "Use the keyboard or the classic symbol selection for text input."
							                                  )
#####/MODDED

class PokemonEntryScene
  def pbStartScene(helptext,minlength,maxlength,initialText,subject=0,pokemon=nil)
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    #####MODDED
    amb_usekeyboard=USEKEYBOARD
    if defined?($idk[:settings].amb_keyboardInput)
      amb_usekeyboard=$idk[:settings].amb_keyboardInput==0
    end
    if amb_usekeyboard
    #####/MODDED
      @sprites["entry"]=Window_TextEntry_Keyboard.new(initialText,
         0,0,400-112,96,helptext,true)
         Input.text_input = true
    else
      @sprites["entry"]=Window_TextEntry.new(initialText,0,0,400,96,helptext,true)
    end
    @sprites["entry"].x=(Graphics.width/2)-(@sprites["entry"].width/2)+32
    @sprites["entry"].viewport=@viewport
    @sprites["entry"].visible=true
    @minlength=minlength
    @maxlength=maxlength
    @symtype=0
    @sprites["entry"].maxlength=maxlength
    #####MODDED
    if !amb_usekeyboard
    #####/MODDED
      @sprites["entry2"]=Window_CharacterEntry.new(@@Characters[@symtype][0])
      @sprites["entry2"].setOtherCharset(@@Characters[@symtype][1])
      @sprites["entry2"].viewport=@viewport
      @sprites["entry2"].visible=true
      @sprites["entry2"].x=(Graphics.width/2)-(@sprites["entry2"].width/2)
    end
    if minlength==0
      @sprites["helpwindow"]=Window_UnformattedTextPokemon.newWithSize(
         _INTL("Enter text using the keyboard.  Press\nESC to cancel, or ENTER to confirm."),
         32,Graphics.height-96,Graphics.width-64,96,@viewport
      )
    else
      @sprites["helpwindow"]=Window_UnformattedTextPokemon.newWithSize(
         _INTL("Enter text using the keyboard.\nPress ENTER to confirm."),
         32,Graphics.height-96,Graphics.width-64,96,@viewport
      )
    end
    @sprites["helpwindow"].letterbyletter=false
    @sprites["helpwindow"].viewport=@viewport
    #####MODDED
    @sprites["helpwindow"].visible=amb_usekeyboard
    #####/MODDED
    @sprites["helpwindow"].baseColor=Color.new(16,24,32)
    @sprites["helpwindow"].shadowColor=Color.new(168,184,184)
    addBackgroundPlane(@sprites,"background","naming2bg",@viewport)
    case subject
      when 1   # Player
        meta=pbGetMetadata(0,MetadataPlayerA+$PokemonGlobal.playerID)
        if meta
          @sprites["shadow"]=IconSprite.new(0,0,@viewport)
          @sprites["shadow"].setBitmap("Graphics/Pictures/namingShadow")
          @sprites["shadow"].x=33*2
          @sprites["shadow"].y=32*2
          filename=pbGetPlayerCharset(meta,1)
          @sprites["subject"]=TrainerWalkingCharSprite.new(filename,@viewport)
          charwidth=@sprites["subject"].bitmap.width
          charheight=@sprites["subject"].bitmap.height
          @sprites["subject"].x = 44*2 - charwidth/8
          @sprites["subject"].y = 38*2 - charheight/4
        end
      when 2   # Pokémon
        if pokemon
          @sprites["shadow"]=IconSprite.new(0,0,@viewport)
          @sprites["shadow"].setBitmap("Graphics/Pictures/namingShadow")
          @sprites["shadow"].x=33*2
          @sprites["shadow"].y=32*2
          @sprites["subject"]=PokemonIconSprite.new(pokemon,@viewport)
          @sprites["subject"].x=56
          @sprites["subject"].y=14
          @sprites["gender"]=BitmapSprite.new(32,32,@viewport)
          @sprites["gender"].x=430
          @sprites["gender"].y=54
          @sprites["gender"].bitmap.clear
          pbSetSystemFont(@sprites["gender"].bitmap)
          textpos=[]
          if pokemon.isMale?
            textpos.push([_INTL("♂"),0,0,false,Color.new(0,128,248),Color.new(168,184,184)])
          elsif pokemon.isFemale?
            textpos.push([_INTL("♀"),0,0,false,Color.new(248,24,24),Color.new(168,184,184)])
          end
          pbDrawTextPositions(@sprites["gender"].bitmap,textpos)
        end
      when 3   # Storage box
        @sprites["subject"]=IconSprite.new(0,0,@viewport)
        @sprites["subject"].setBitmap("Graphics/Pictures/namingStorage")
        @sprites["subject"].x=68
        @sprites["subject"].y=32
    end
    pbFadeInAndShow(@sprites)
  end
  
  def pbEntry
    #####MODDED
    amb_usekeyboard=USEKEYBOARD
    if defined?($idk[:settings].amb_keyboardInput)
      amb_usekeyboard=$idk[:settings].amb_keyboardInput==0
    end
    return amb_usekeyboard ? pbEntry1 : pbEntry2
    #####/MODDED
  end

  def pbEndScene
    #####MODDED
    amb_usekeyboard=USEKEYBOARD
    if defined?($idk[:settings].amb_keyboardInput)
      amb_usekeyboard=$idk[:settings].amb_keyboardInput==0
    end
    Input.text_input = false if amb_usekeyboard
    #####/MODDED
    pbFadeOutAndHide(@sprites)
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
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

amb_checkDependencies("AMB - AddOpt_TextInput", ["AMB - AddOpt.rb"])
#####/MODDED