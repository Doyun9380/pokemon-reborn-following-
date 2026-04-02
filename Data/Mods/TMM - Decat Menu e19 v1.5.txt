#####MODDED


#Start of Debug "main"
#Tag SUBFUNCTION to go where the functions are

class PokemonMenu_Scene
  def pbShowCommands(commands)
    ret=-1
    cmdwindow=@sprites["cmdwindow"]
    cmdwindow.viewport=@viewport
    cmdwindow.index=$PokemonTemp.menuLastChoice
    cmdwindow.resizeToFit(commands)
    cmdwindow.commands=commands
    cmdwindow.x=Graphics.width-cmdwindow.width
    cmdwindow.y=0
    cmdwindow.visible=true
    loop do
      cmdwindow.update
      Graphics.update
      Input.update
      pbUpdateSceneMap
      if Input.trigger?(Input::B)
        ret=-1
        break
      end
      if Input.trigger?(Input::C)
        ret=cmdwindow.index
        $PokemonTemp.menuLastChoice=ret
        break
      end
    end
    return ret
  end

  def pbShowInfo(text)
    @sprites["infowindow"].resizeToFit(text,Graphics.height)
    @sprites["infowindow"].text=text
    @sprites["infowindow"].visible=true
    @infostate=true
  end

  def pbShowHelp(text)
    @sprites["helpwindow"].resizeToFit(text,Graphics.height)
    @sprites["helpwindow"].text=text
    @sprites["helpwindow"].visible=true
    @helpstate=true
    pbBottomLeft(@sprites["helpwindow"])
  end

  def pbStartScene
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites={}
    @sprites["cmdwindow"]=Window_CommandPokemon.new([])
    @sprites["infowindow"]=Window_UnformattedTextPokemon.newWithSize("",0,0,32,32,@viewport)
    @sprites["infowindow"].visible=false
    @sprites["helpwindow"]=Window_UnformattedTextPokemon.newWithSize("",0,0,32,32,@viewport)
    @sprites["helpwindow"].visible=false
    @sprites["cmdwindow"].visible=false
    @infostate=false
    @helpstate=false
    $game_temp.in_menu = true
    pbSEPlay("menu")
  end

  def pbHideMenu
    @sprites["cmdwindow"].visible=false
    @sprites["infowindow"].visible=false
    @sprites["helpwindow"].visible=false
  end

  def pbShowMenu
    @sprites["cmdwindow"].visible=true
    @sprites["infowindow"].visible=@infostate
    @sprites["helpwindow"].visible=@helpstate
  end

  def pbEndScene
    pbDisposeSpriteHash(@sprites)
    $game_temp.in_menu = false
    pbSEPlay("menuclose")
    @viewport.dispose
  end

  def pbRefresh
  end
end



class PokemonMenu
  def initialize(scene)
    @scene=scene
  end

  def pbShowMenu
    @scene.pbRefresh
    @scene.pbShowMenu
  end

  def pbStartPokemonMenu
    @scene.pbStartScene
    endscene=true
    pbSetViableDexes
    commands=[]
    cmdPokedex=-1
    cmdPokemon=-1
    cmdBag=-1
    cmdTrainer=-1
    cmdSave=-1
    cmdOption=-1
    cmdPokegear=-1
    cmdControls=-1
    cmdDebug=-1
    cmdQuit=-1
    cmdEndGame=-1
    if !$Trainer
      if $DEBUG
        Kernel.pbMessage(_INTL("The player trainer was not defined, so the menu can't be displayed."))
        Kernel.pbMessage(_INTL("Please see the documentation to learn how to set up the trainer player."))
      end
      return
    end
    commands[cmdPokedex=commands.length]=_INTL("Pokédex") if $Trainer.pokedex && $PokemonGlobal.pokedexViable.length>0
    commands[cmdPokemon=commands.length]=_INTL("Pokémon") if $Trainer.party.length>0
    commands[cmdBag=commands.length]=_INTL("Bag")
    commands[cmdPokegear=commands.length]=_INTL("Pokégear") if $Trainer.pokegear
    commands[cmdTrainer=commands.length]=$Trainer.name
    if pbInSafari?
      if SAFARISTEPS<=0
        @scene.pbShowInfo(_INTL("Balls: {1}",pbSafariState.ballcount))
      else
        @scene.pbShowInfo(_INTL("Steps: {1}/{2}\nBalls: {3}",pbSafariState.steps,SAFARISTEPS,pbSafariState.ballcount))
      end
      commands[cmdQuit=commands.length]=_INTL("Quit")
    else
      commands[cmdSave=commands.length]=_INTL("Save") if !$game_system || !$game_system.save_disabled
    end
    commands[cmdOption=commands.length]=_INTL("Options")
    commands[cmdControls=commands.length]=_INTL("Controls")    
    commands[cmdDebug=commands.length]=_INTL("Debug")
    commands[cmdEndGame=commands.length]=_INTL("Quit Game")
    loop do
      command=@scene.pbShowCommands(commands)
      if cmdPokedex>=0 && command==cmdPokedex
        if DEXDEPENDSONLOCATION
          pbFadeOutIn(99999) {
             scene=PokemonPokedexScene.new
             screen=PokemonPokedex.new(scene)
             screen.pbStartScreen
             @scene.pbRefresh
          }
        else
          if $PokemonGlobal.pokedexViable.length==1
            $PokemonGlobal.pokedexDex=$PokemonGlobal.pokedexViable[0]
            $PokemonGlobal.pokedexDex=-1 if $PokemonGlobal.pokedexDex==$PokemonGlobal.pokedexUnlocked.length-1
            pbFadeOutIn(99999) {
               scene=PokemonPokedexScene.new
               screen=PokemonPokedex.new(scene)
               screen.pbStartScreen
               @scene.pbRefresh
            }
          else
            pbLoadRpgxpScene(Scene_PokedexMenu.new)
          end
        end
      elsif cmdPokegear>=0 && command==cmdPokegear
        pbLoadRpgxpScene(Scene_Pokegear.new)
      elsif cmdPokemon>=0 && command==cmdPokemon
        sscene=PokemonScreen_Scene.new
        sscreen=PokemonScreen.new(sscene,$Trainer.party)
        hiddenmove=nil
        pbFadeOutIn(99999) { 
           hiddenmove=sscreen.pbPokemonScreen
           if hiddenmove
             @scene.pbEndScene
           else
             @scene.pbRefresh
           end
        }
        if hiddenmove
          Kernel.pbUseHiddenMove(hiddenmove[0],hiddenmove[1])
          return
        end
      elsif cmdBag>=0 && command==cmdBag
        item=0
        scene=PokemonBag_Scene.new
        screen=PokemonBagScreen.new(scene,$PokemonBag)
        pbFadeOutIn(99999) { 
           item=screen.pbStartScreen 
           if item>0
             @scene.pbEndScene
           else
             @scene.pbRefresh
           end
        }
        if item>0
          Kernel.pbUseKeyItemInField(item)
          return
        end
      elsif cmdTrainer>=0 && command==cmdTrainer
        PBDebug.logonerr {
           scene=PokemonTrainerCardScene.new
           screen=PokemonTrainerCard.new(scene)
           pbFadeOutIn(99999) { 
              screen.pbStartScreen
              @scene.pbRefresh
           }
        }
      elsif cmdQuit>=0 && command==cmdQuit
        @scene.pbHideMenu
        if pbInSafari?
          if Kernel.pbConfirmMessage(_INTL("Would you like to leave the Safari Game right now?"))
            @scene.pbEndScene
            pbSafariState.decision=1
            pbSafariState.pbGoToStart
            return
          else
            pbShowMenu
          end
        end
      elsif cmdSave>=0 && command==cmdSave
        @scene.pbHideMenu
        scene=PokemonSaveScene.new
        screen=PokemonSave.new(scene)
        if screen.pbSaveScreen
          @scene.pbEndScene
          endscene=false
          break
        else
          pbShowMenu
        end
      elsif cmdDebug>=0 && command==cmdDebug
        pbFadeOutIn(99999) { 
           pbDebugMenu
           @scene.pbRefresh
        }
     elsif cmdControls>=0 && command==cmdControls
       System.show_settings       
      elsif cmdOption>=0 && command==cmdOption
        scene=PokemonOptionScene.new
        screen=PokemonOption.new(scene)
        pbFadeOutIn(99999) {
           screen.pbStartScreen
           pbUpdateSceneMap
           @scene.pbRefresh
        }
      elsif cmdEndGame>=0 && command==cmdEndGame
        @scene.pbHideMenu
        if Kernel.pbConfirmMessage(_INTL("Are you sure you want to quit the game?"))
          scene=PokemonSaveScene.new
          screen=PokemonSave.new(scene)
          if screen.pbSaveScreen
            @scene.pbEndScene
          end
          @scene.pbEndScene
          $scene=nil
          return
        else
          pbShowMenu
        end        
      else
        break
      end
    end
    @scene.pbEndScene if endscene
  end  
end



def pbDebugMenu
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  sprites={}
  commands=CommandList.new
  commands.add("usepc",_INTL("Use PC"))
  commands.add("healparty",_INTL("Heal Party"))
  commands.add("additem",_INTL("Add Item"))
  commands.add("addbundle",_INTL("Add Item Bundle"))
  commands.add("addlegalitems",_INTL("Grab all legal items"))
  commands.add("pcadvanced",_INTL("Save/Load Teams in Box 47"))
  commands.add("setpartyhealth",_INTL("Set Party Health %"))
  commands.add("setpartylevel",_INTL("Set Party Level"))
  commands.add("madness",_INTL("Madness Options"))
  commands.add("switches",_INTL("Switches"))
  commands.add("variables",_INTL("Variables"))
  #commands.add("refreshmap",_INTL("Refresh Map"))
  commands.add("warp",_INTL("Warp to Map (press A for map id)"))
  #commands.add("clearbag",_INTL("Empty Bag"))
  commands.add("addpokemon",_INTL("Add Pokémon"))
  commands.add("addpresetmon",_INTL("Add Preset Pokémon"))
  commands.add("orderboxes",_INTL("Order PC Boxes"))
  commands.add("teamyeet",_INTL("Export my team to text"))
  #commands.add("fullopponentyeet",_INTL("Export trainers to text"))
  #commands.add("setplayer",_INTL("Set Player Character"))
  #commands.add("renameplayer",_INTL("Rename Player"))
  #commands.add("randomid",_INTL("Randomise Player's ID"))
  #commands.add("changeoutfit",_INTL("Change Player Outfit"))
  commands.add("setmoney",_INTL("Set Money"))
  commands.add("setcoins",_INTL("Set Coins"))
  #commands.add("setbadges",_INTL("Set Badges"))
  #commands.add("toggleshoes",_INTL("Toggle Running Shoes Ownership"))
  #commands.add("togglepokegear",_INTL("Toggle Pokégear Ownership"))
  #commands.add("togglepokedex",_INTL("Toggle Pokédex Ownership"))
  #commands.add("dexlists",_INTL("Dex List Accessibility"))
  commands.add("daycare",_INTL("Day Care Options..."))
  commands.add("quickhatch",_INTL("Quick Hatch"))
  #commands.add("roamerstatus",_INTL("Roaming Pokémon Status"))
  #commands.add("roam",_INTL("Advance Roaming"))
  #commands.add("terraintags",_INTL("Set Terrain Tags"))
  commands.add("testwildbattle",_INTL("Test Wild Battle"))
  commands.add("testdoublewildbattle",_INTL("Test Double Wild Battle"))
  commands.add("testtrainerbattle",_INTL("Test Trainer Battle"))
  commands.add("testtrainerdoublebattle",_INTL("Test Trainer Double Battle"))
  commands.add("testdoubletrainerbattle",_INTL("Test Double Trainer Battle"))
  #commands.add("relicstone",_INTL("Relic Stone"))
  #commands.add("purifychamber",_INTL("Purify Chamber"))
  #commands.add("extracttext",_INTL("Extract Text"))
  #commands.add("compiletext",_INTL("Compile Text"))
  #commands.add("compiletrainers", _INTL("Compile Trainers"))
  commands.add("compiledata",_INTL("Compile All Data"))
  #commands.add("mapconnections",_INTL("Map Connections"))
  #commands.add("animeditor",_INTL("Animation Editor"))
  #commands.add("togglelogging",_INTL("Toggle Battle Logging"))
  #commands.add("scriptedbattle",_INTL("Start Scripted Battle"))
  #commands.add("debugbattle",_INTL("Battle The Debug Trainer"))
  commands.add("stealtrainer",_INTL("Get Trainer team in Box 48"))
  #commands.add("allbattles",_INTL("Mandatory Battle Testing"))
  commands.add("e20shortcut",_INTL("Fight specific fights (postgame)!"))
  commands.add("e19shortcut",_INTL("Fight specific fights (e19)!"))
  #commands.add("torresworkshop",_INTL("Torre stuff. Blobspy."))
  sprites["cmdwindow"]=Window_CommandPokemon.new(commands.list)
  cmdwindow=sprites["cmdwindow"]
  cmdwindow.viewport=viewport
  cmdwindow.resizeToFit(cmdwindow.commands)
  cmdwindow.height=Graphics.height if cmdwindow.height>Graphics.height
  cmdwindow.x=0
  cmdwindow.y=0
  cmdwindow.visible=true
  pbFadeInAndShow(sprites)
  ret=-1
  loop do
    loop do
      cmdwindow.update
      Graphics.update
      Input.update
      if Input.trigger?(Input::B)
        ret=-1
        break
      end
      if Input.trigger?(Input::C)
        ret=cmdwindow.index
        break
      end
    end
    break if ret==-1
    cmd=commands.getCommand(ret)
    if cmd=="switches"
      pbFadeOutIn(99999) { pbDebugScreen(0) }
    elsif cmd=="variables"
      pbFadeOutIn(99999) { pbDebugScreen(1) }
    elsif cmd=="refreshmap"
      $game_map.need_refresh = true; Kernel.pbMessage(_INTL("The map will refresh."))
    elsif cmd=="warp"
		  map=pbWarpToMap()
		  if map
			pbFadeOutAndHide(sprites)
			pbDisposeSpriteHash(sprites)
			viewport.dispose
			if $scene.is_a?(Scene_Map)
			  $game_temp.player_new_map_id=map[0]
			  $game_temp.player_new_x=map[1]
			  $game_temp.player_new_y=map[2]
			  $game_temp.player_new_direction=2
			  $scene.transfer_player
			  $game_map.refresh
			else
			  Kernel.pbCancelVehicles
			  $MapFactory.setup(map[0])
			  $game_player.moveto(map[1],map[2])
			  $game_player.turn_down
			  $game_map.update
			  $game_map.autoplay
			  $game_map.refresh
			end
	return
  end
    elsif cmd=="healparty"
		torDebugHealParty
    elsif cmd=="setpartyhealth"
		torDebugSetPartyHealth
    elsif cmd=="setpartylevel"
		torDebugSetPartyLevel
	elsif cmd=="additem"
		torDebugAddItem
    elsif cmd=="clearbag"
      $PokemonBag.clear; Kernel.pbMessage(_INTL("The Bag was cleared."))
    elsif cmd=="addpokemon"
		torDebugAddPokemon
    elsif cmd=="usepc"
      pbPokeCenterPC
    elsif cmd=="teamyeet"
      torselfteamtotext
    elsif cmd=="fullopponentyeet"
      torallopponentsteamtotext
    elsif cmd=="setplayer"
    elsif cmd=="renameplayer"
		torDebugRenamePlayer
    elsif cmd=="randomid"
		torDebugRandomID
    elsif cmd=="changeoutfit"
    elsif cmd=="setmoney"
		torDebugSetMoney
    elsif cmd=="setcoins"
		torDebugSetCoins
    elsif cmd=="setbadges"
   elsif cmd=="toggleshoes"
      $PokemonGlobal.runningShoes=!$PokemonGlobal.runningShoes
      Kernel.pbMessage(_INTL("Gave Running Shoes.")) if $PokemonGlobal.runningShoes
      Kernel.pbMessage(_INTL("Lost Running Shoes.")) if !$PokemonGlobal.runningShoes
    elsif cmd=="togglepokegear"
      $Trainer.pokegear=!$Trainer.pokegear
      Kernel.pbMessage(_INTL("Gave Pokégear.")) if $Trainer.pokegear
      Kernel.pbMessage(_INTL("Lost Pokégear.")) if !$Trainer.pokegear
    elsif cmd=="togglepokedex"
      $Trainer.pokedex=!$Trainer.pokedex
      Kernel.pbMessage(_INTL("Gave Pokédex.")) if $Trainer.pokedex
      Kernel.pbMessage(_INTL("Lost Pokédex.")) if !$Trainer.pokedex
    elsif cmd=="dexlists"
    elsif cmd=="daycare"
		torDebugDaycare
    elsif cmd=="quickhatch"
		torDebugQuickhatch
    elsif cmd=="roamerstatus"
    elsif cmd=="roam"
    elsif cmd=="terraintags"
    elsif cmd=="testwildbattle"
		torDebugWildSingles
    elsif cmd=="testdoublewildbattle"
		torDebugWildDoubles
    elsif cmd=="testtrainerbattle"
		torDebug1v1
    elsif cmd=="testtrainerdoublebattle"
		torDebug2v2
    elsif cmd=="testdoubletrainerbattle"
		torDebug1v2
    elsif cmd=="relicstone"
    elsif cmd=="purifychamber"
    elsif cmd=="extracttext"
    elsif cmd=="compiletext"
      pbCompileTextUI
    elsif cmd=="compiletrainers"
      begin
        pbCompileTrainers
        $cache.trainers=load_data("Data/trainers.dat")
        Kernel.pbMessage(_INTL("Trainers have been compiled."))
      rescue
        pbPrintException($!)
      end
    elsif cmd=="compiledata"
      msgwindow=Kernel.pbCreateMessageWindow
      pbCompileAllData(true) {|msg| Kernel.pbMessageDisplay(msgwindow,msg,false) }
      Kernel.pbMessageDisplay(msgwindow,_INTL("All game data was compiled."))
      Kernel.pbDisposeMessageWindow(msgwindow)
    elsif cmd=="mapconnections"
    elsif cmd=="animeditor"
    elsif cmd=="togglelogging"
    elsif cmd=="scriptedbattle"
    elsif cmd=="stealtrainer"
		torDebugStealTrainer
	elsif cmd=="debugbattle"
      begin
        pbDebugTestBattle
      rescue
        pbPrintException($!)
      end
	elsif cmd=="allbattles"
	elsif cmd=="e20shortcut"
		torDebuge20shortcut
	elsif cmd=="e19shortcut"
		torDebuge19shortcut
	elsif cmd=="orderboxes"
		torDebugOrderBoxes
	elsif cmd=="addpresetmon"
		torDebugAddMoPreset
	elsif cmd=="addbundle"
		torDebugAddItBundle
	elsif cmd=="addlegalitems"
		torDebugAddLegalItems
	elsif cmd=="madness"
		torDebugMadness
	elsif cmd=="pcadvanced"
		torDebugAdvancedPC
	elsif cmd=="torresworkshop"
		torPersonalWorkshop
	end
  end
  pbFadeOutAndHide(sprites)
  pbDisposeSpriteHash(sprites)
  viewport.dispose
end

#End of Debug "main", start of sub functions
#Tag SUBFUNCTION

def torPersonalWorkshop
txtstring=Kernel.pbMessageFreeText("Name?",_INTL(""),false,12)
txtascii=txtstring.ord
  Kernel.pbMessage(_INTL("The text is {1} and in ascii it's {2}.",txtstring,txtascii))


end

def torDebugMenuWarp
  map=pbWarpToMap()
  if map
	pbFadeOutAndHide(sprites)
	pbDisposeSpriteHash(sprites)
	viewport.dispose
	if $scene.is_a?(Scene_Map)
	  $game_temp.player_new_map_id=map[0]
	  $game_temp.player_new_x=map[1]
	  $game_temp.player_new_y=map[2]
	  $game_temp.player_new_direction=2
	  $scene.transfer_player
	  $game_map.refresh
	else
	  Kernel.pbCancelVehicles
	  $MapFactory.setup(map[0])
	  $game_player.moveto(map[1],map[2])
	  $game_player.turn_down
	  $game_map.update
	  $game_map.autoplay
	  $game_map.refresh
	end
	return
  end
end

def torDebugHealParty
	for i in $Trainer.party
	i.heal
	end
	Kernel.pbMessage(_INTL("Your Pokémon were healed."))

end

def torDebugSetPartyHealth

params=ChooseNumberParams.new
params.setRange(0,100)
params.setDefaultValue(25)
newhp=Kernel.pbMessageChooseNumber(_INTL("Set the Pokémon's HP ratio (max 100)."),params) 
	  for i in $Trainer.party
		i.hp=((newhp*i.totalhp)/100).ceil
	end

end

def torDebugSetPartyLevel
  leadersDefeated = $Trainer.numbadges
  lcap=LEVELCAPS[leadersDefeated] + $game_variables[595]
  if lcap>100
  lcap=lcap-50
  end
	  for i in $Trainer.party
		i.level=lcap
		i.calcStats
	end
i.calcStats
Kernel.pbMessage(_INTL("Your Pokémon were set to level cap."))
end

def torDebugAddItem
  item=pbListScreen(_INTL("ADD ITEM"),ItemLister.new(0))
  if item && item>0
	params=ChooseNumberParams.new
	params.setRange(1,BAGMAXPERSLOT)
	params.setInitialValue(1)
	params.setCancelValue(0)
	qty=Kernel.pbMessageChooseNumber(
	   _INTL("Choose the number of items."),params
	)
	if qty>0
	  if qty==1
		Kernel.pbReceiveItem(item)
	  else
		Kernel.pbMessage(_INTL("The item was added."))
		$PokemonBag.pbStoreItem(item,qty)
	  end
	end
  end
end

def torDebugAddPokemon
  species=pbChooseSpeciesOrdered(1)
  if species!=0
	params=ChooseNumberParams.new
	params.setRange(1,PBExperience::MAXLEVEL)
	params.setInitialValue(5)
	params.setCancelValue(0)
	level=Kernel.pbMessageChooseNumber(
	   _INTL("Set the Pokémon's level."),params)
	if level>0
	  pbAddPokemon(species,level,false,true)
	end
  end
end

def torDebugRenamePlayer
  trname=pbEnterPlayerName("Your name?",0,12,$Trainer.name)
  if trname==""
	trainertype=pbGetPlayerTrainerType
	gender=pbGetTrainerTypeGender(trainertype) 
	trname=pbSuggestTrainerName(gender)
  end
  $Trainer.name=trname
  Kernel.pbMessage(_INTL("The player's name was changed to {1}.",$Trainer.name))
end

def torDebugAddItBundle
	bundlecmd=0
		loop do
			bundlecmds=[
				_INTL("TMs"),
				_INTL("Berries"),
				_INTL("Held items"),
				_INTL("Mega Stones"),
				_INTL("Crystals"),
				_INTL("Nothing")
				]
			bundlecmd=Kernel.pbShowCommands(nil,bundlecmds,-1,bundlecmd)
			break if bundlecmd<0
				case bundlecmd
				when 0
				tmcmd=0
					loop do
						tmcmds=[
						_INTL("E2"),
						_INTL("E3"),
						_INTL("E4"),
						_INTL("E5"),
						_INTL("E6"),
						_INTL("E7"),
						_INTL("E8"),
						_INTL("E9"),
						_INTL("E10"),
						_INTL("E11"),
						_INTL("E12"),
						_INTL("E13"),
						_INTL("E14"),
						_INTL("E15"),
						_INTL("E16"),
						_INTL("E17"),
						_INTL("E18"),
						_INTL("E19"),
						_INTL("E20"),
						]
					tmcmd=Kernel.pbShowCommands(nil,tmcmds,-1,tmcmd)
					break if tmcmd<0
						case tmcmd
						when 0
						$PokemonBag.pbStoreItem(PBItems::TM57); $PokemonBag.pbStoreItem(PBItems::TM60); $PokemonBag.pbStoreItem(PBItems::TM42); 
						$PokemonBag.pbStoreItem(PBItems::TM45); $PokemonBag.pbStoreItem(PBItems::TM54); $PokemonBag.pbStoreItem(PBItems::TM63); 
						$PokemonBag.pbStoreItem(PBItems::TM90); 
						when 1
						$PokemonBag.pbStoreItem(PBItems::TM96); $PokemonBag.pbStoreItem(PBItems::TM100); $PokemonBag.pbStoreItem(PBItems::TM20); 
						$PokemonBag.pbStoreItem(PBItems::TM77); $PokemonBag.pbStoreItem(PBItems::TM88);
						when 2
						$PokemonBag.pbStoreItem(PBItems::TM17); $PokemonBag.pbStoreItem(PBItems::TM46); $PokemonBag.pbStoreItem(PBItems::TM56); 
						$PokemonBag.pbStoreItem(PBItems::TM07); $PokemonBag.pbStoreItem(PBItems::TM21); $PokemonBag.pbStoreItem(PBItems::TM41); 
						$PokemonBag.pbStoreItem(PBItems::TM69); 
						when 3
						$PokemonBag.pbStoreItem(PBItems::TM76); $PokemonBag.pbStoreItem(PBItems::TM05); $PokemonBag.pbStoreItem(PBItems::TM48); 
						when 4
						$PokemonBag.pbStoreItem(PBItems::TM65); $PokemonBag.pbStoreItem(PBItems::TM49); 
						when 5
						$PokemonBag.pbStoreItem(PBItems::TM83); 
						$PokemonBag.pbStoreItem(PBItems::TM66); $PokemonBag.pbStoreItem(PBItems::TM09);
						when 6
						$PokemonBag.pbStoreItem(PBItems::TM34); $PokemonBag.pbStoreItem(PBItems::TM12); $PokemonBag.pbStoreItem(PBItems::TM37); 
						$PokemonBag.pbStoreItem(PBItems::TM94); $PokemonBag.pbStoreItem(PBItems::TM44); $PokemonBag.pbStoreItem(PBItems::TM32); 
						$PokemonBag.pbStoreItem(PBItems::TM85); 
						when 7
						$PokemonBag.pbStoreItem(PBItems::TM70); 
						when 8
						$PokemonBag.pbStoreItem(PBItems::TM10); $PokemonBag.pbStoreItem(PBItems::TM40); $PokemonBag.pbStoreItem(PBItems::TM51); 
						$PokemonBag.pbStoreItem(PBItems::TM86); $PokemonBag.pbStoreItem(PBItems::TM23);
						when 9
						$PokemonBag.pbStoreItem(PBItems::TM11); $PokemonBag.pbStoreItem(PBItems::TM18); $PokemonBag.pbStoreItem(PBItems::TM64); 
						$PokemonBag.pbStoreItem(PBItems::TM92); 
						when 10
						$PokemonBag.pbStoreItem(PBItems::TM97); $PokemonBag.pbStoreItem(PBItems::TM87);
						when 11
						$PokemonBag.pbStoreItem(PBItems::TM31); $PokemonBag.pbStoreItem(PBItems::TM39); $PokemonBag.pbStoreItem(PBItems::TM43); 
						$PokemonBag.pbStoreItem(PBItems::TM58); 
						when 12
						$PokemonBag.pbStoreItem(PBItems::TM35); $PokemonBag.pbStoreItem(PBItems::TM79); $PokemonBag.pbStoreItem(PBItems::TM95); 
						$PokemonBag.pbStoreItem(PBItems::TM82); 
						when 13
						$PokemonBag.pbStoreItem(PBItems::TM78); $PokemonBag.pbStoreItem(PBItems::TM01); $PokemonBag.pbStoreItem(PBItems::TM03); 
						$PokemonBag.pbStoreItem(PBItems::TM47); $PokemonBag.pbStoreItem(PBItems::TM74); $PokemonBag.pbStoreItem(PBItems::TM93); 
						$PokemonBag.pbStoreItem(PBItems::TM67); 
						when 14
						#Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						$PokemonBag.pbStoreItem(PBItems::TM62); $PokemonBag.pbStoreItem(PBItems::TM06); $PokemonBag.pbStoreItem(PBItems::TM22); 
						$PokemonBag.pbStoreItem(PBItems::TM27); $PokemonBag.pbStoreItem(PBItems::TM30); $PokemonBag.pbStoreItem(PBItems::TM33); 
						$PokemonBag.pbStoreItem(PBItems::TM50); $PokemonBag.pbStoreItem(PBItems::TM61); $PokemonBag.pbStoreItem(PBItems::TM68); 
						$PokemonBag.pbStoreItem(PBItems::TM81); $PokemonBag.pbStoreItem(PBItems::TM89); $PokemonBag.pbStoreItem(PBItems::TM59); 
						$PokemonBag.pbStoreItem(PBItems::TM16); $PokemonBag.pbStoreItem(PBItems::TM98); $PokemonBag.pbStoreItem(PBItems::TM15); 
						Kernel.pbMessage(_INTL("To use Hyper Beam, you need to be able to beat Mc Krezzy!"))
						Kernel.pbMessage(_INTL("To use Shadow Ball, you need to be able to beat the Kecleons!"))
						when 15
						$PokemonBag.pbStoreItem(PBItems::TM99); $PokemonBag.pbStoreItem(PBItems::TM84); $PokemonBag.pbStoreItem(PBItems::TM72); 
						$PokemonBag.pbStoreItem(PBItems::TM71); $PokemonBag.pbStoreItem(PBItems::TM36); $PokemonBag.pbStoreItem(PBItems::TM04); 
						$PokemonBag.pbStoreItem(PBItems::TM08); $PokemonBag.pbStoreItem(PBItems::TM75); $PokemonBag.pbStoreItem(PBItems::TM19); 
						$PokemonBag.pbStoreItem(PBItems::TM91); 
						when 16
						$PokemonBag.pbStoreItem(PBItems::TM55); $PokemonBag.pbStoreItem(PBItems::TM28); $PokemonBag.pbStoreItem(PBItems::TM52); 
						$PokemonBag.pbStoreItem(PBItems::TM53); $PokemonBag.pbStoreItem(PBItems::TM73); $PokemonBag.pbStoreItem(PBItems::TM29); 
						$PokemonBag.pbStoreItem(PBItems::TM13); $PokemonBag.pbStoreItem(PBItems::TM24); $PokemonBag.pbStoreItem(PBItems::TM26); 
						#Kernel.pbMessage(_INTL("To use Thunder Wave, you need to be able to beat Breloom Bot!"))
						when 17
						$PokemonBag.pbStoreItem(PBItems::TM14); $PokemonBag.pbStoreItem(PBItems::TM25); $PokemonBag.pbStoreItem(PBItems::TM38); 
						$PokemonBag.pbStoreItem(PBItems::TM80); 
						when 18
						$PokemonBag.pbStoreItem(PBItems::TM02); 
						end
					end
				when 1
				bercmd=0
					loop do
						bercmds=[
						_INTL("Early Game Berries"),
						_INTL("Rhodochrine/Peridot : Limited Berries (one)"),
						_INTL("Type Resist Berries"),
						_INTL("Route 1 Berries (Custap, Lum, Sitrus)"),
						_INTL("Resto : Pinch Beries"),
						_INTL("Resto : Super Heal Berries"),
						_INTL("Weird Berries")
						]
					bercmd=Kernel.pbShowCommands(nil,bercmds,-1,bercmd)
					break if bercmd<0
						case bercmd
						when 0
						$PokemonBag.pbStoreItem(PBItems::ORANBERRY,99); $PokemonBag.pbStoreItem(PBItems::PECHABERRY,99); $PokemonBag.pbStoreItem(PBItems::CHERIBERRY,99);
						$PokemonBag.pbStoreItem(PBItems::ASPEARBERRY,99); $PokemonBag.pbStoreItem(PBItems::RAWSTBERRY,99); $PokemonBag.pbStoreItem(PBItems::PERSIMBERRY,99);
						$PokemonBag.pbStoreItem(PBItems::CHESTOBERRY,99); 
						when 1
						$PokemonBag.pbStoreItem(PBItems::SITRUSBERRY,1); $PokemonBag.pbStoreItem(PBItems::LIECHIBERRY,1); $PokemonBag.pbStoreItem(PBItems::SALACBERRY,1);
						$PokemonBag.pbStoreItem(PBItems::PETAYABERRY,1); 
						when 2
						#Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						$PokemonBag.pbStoreItem(PBItems::BABIRIBERRY,99); $PokemonBag.pbStoreItem(PBItems::HABANBERRY,99); $PokemonBag.pbStoreItem(PBItems::RINDOBERRY,99);
						$PokemonBag.pbStoreItem(PBItems::CHARTIBERRY,99); $PokemonBag.pbStoreItem(PBItems::KASIBBERRY,99); $PokemonBag.pbStoreItem(PBItems::ROSELIBERRY,99);
						$PokemonBag.pbStoreItem(PBItems::CHILANBERRY,99); $PokemonBag.pbStoreItem(PBItems::KEBIABERRY,99); $PokemonBag.pbStoreItem(PBItems::SHUCABERRY,99);
						$PokemonBag.pbStoreItem(PBItems::CHOPLEBERRY,99); $PokemonBag.pbStoreItem(PBItems::OCCABERRY,99); $PokemonBag.pbStoreItem(PBItems::TANGABERRY,99);
						$PokemonBag.pbStoreItem(PBItems::COBABERRY,99); $PokemonBag.pbStoreItem(PBItems::PASSHOBERRY,99); $PokemonBag.pbStoreItem(PBItems::WACANBERRY,99);
						$PokemonBag.pbStoreItem(PBItems::COLBURBERRY,99); $PokemonBag.pbStoreItem(PBItems::PAYAPABERRY,99); $PokemonBag.pbStoreItem(PBItems::YACHEBERRY,99);
						when 3
						$PokemonBag.pbStoreItem(PBItems::CUSTAPBERRY,250); $PokemonBag.pbStoreItem(PBItems::LUMBERRY,250); $PokemonBag.pbStoreItem(PBItems::SITRUSBERRY,99);
						when 4
						$PokemonBag.pbStoreItem(PBItems::LIECHIBERRY,99); $PokemonBag.pbStoreItem(PBItems::PETAYABERRY,99); $PokemonBag.pbStoreItem(PBItems::SALACBERRY,99);
						$PokemonBag.pbStoreItem(PBItems::GANLONBERRY,99); $PokemonBag.pbStoreItem(PBItems::APICOTBERRY,99); $PokemonBag.pbStoreItem(PBItems::LANSATBERRY,99);
						when 5
						$PokemonBag.pbStoreItem(PBItems::IAPAPABERRY,99); $PokemonBag.pbStoreItem(PBItems::MAGOBERRY,99); $PokemonBag.pbStoreItem(PBItems::WIKIBERRY,99);
						$PokemonBag.pbStoreItem(PBItems::AGUAVBERRY,99); $PokemonBag.pbStoreItem(PBItems::FIGYBERRY,99); 
						when 6
						$PokemonBag.pbStoreItem(PBItems::KEEBERRY,99); $PokemonBag.pbStoreItem(PBItems::MARANGABERRY,99); $PokemonBag.pbStoreItem(PBItems::JABOCABERRY,99);
						$PokemonBag.pbStoreItem(PBItems::ROWAPBERRY,99); 
						end
					end
					
				when 2
				heldcmd=0
					loop do
						heldcmds=[
						_INTL("Choice Bundle"),
						_INTL("20% Bundle"),
						_INTL("Plates Bundle"),
						_INTL("Gem Bundle"),
						_INTL("Recovery & Defense Bundle"),
						_INTL("Mobility Bundle"),
						_INTL("Sash Bundle"),
						_INTL("Clown Bundle"),
						_INTL("Herbs Bundle"),
						_INTL("Terrain Seeds Bundle"),
						_INTL("Weather Items Bundle"),
						_INTL("Victini Quest Bundle"),
						]
					heldcmd=Kernel.pbShowCommands(nil,heldcmds,-1,heldcmd)
					break if heldcmd<0
						case heldcmd
						when 0
						$PokemonBag.pbStoreItem(PBItems::CHOICESPECS,10); $PokemonBag.pbStoreItem(PBItems::CHOICEBAND,10); $PokemonBag.pbStoreItem(PBItems::CHOICESCARF,2);
						when 1
						#Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						$PokemonBag.pbStoreItem(PBItems::BLACKBELT,10); $PokemonBag.pbStoreItem(PBItems::BLACKGLASSES,10); $PokemonBag.pbStoreItem(PBItems::CHARCOAL,10);
						$PokemonBag.pbStoreItem(PBItems::DRAGONFANG,10); $PokemonBag.pbStoreItem(PBItems::HARDSTONE,10); $PokemonBag.pbStoreItem(PBItems::MAGNET,10);
						$PokemonBag.pbStoreItem(PBItems::METALCOAT,10); $PokemonBag.pbStoreItem(PBItems::MIRACLESEED,10); $PokemonBag.pbStoreItem(PBItems::MYSTICWATER,10);
						$PokemonBag.pbStoreItem(PBItems::NEVERMELTICE,10); $PokemonBag.pbStoreItem(PBItems::SILKSCARF,10); $PokemonBag.pbStoreItem(PBItems::POISONBARB,10);
						$PokemonBag.pbStoreItem(PBItems::SHARPBEAK,10); $PokemonBag.pbStoreItem(PBItems::SILVERPOWDER,10); $PokemonBag.pbStoreItem(PBItems::SOFTSAND,10);
						$PokemonBag.pbStoreItem(PBItems::SPELLTAG,10); $PokemonBag.pbStoreItem(PBItems::TWISTEDSPOON,10); $PokemonBag.pbStoreItem(PBItems::PIXIEPLATE,10);
						when 2
						$PokemonBag.pbStoreItem(PBItems::DRACOPLATE,10); $PokemonBag.pbStoreItem(PBItems::DREADPLATE,10); $PokemonBag.pbStoreItem(PBItems::EARTHPLATE,10);
						$PokemonBag.pbStoreItem(PBItems::FISTPLATE,10); $PokemonBag.pbStoreItem(PBItems::FLAMEPLATE,10); $PokemonBag.pbStoreItem(PBItems::ICICLEPLATE,10);
						$PokemonBag.pbStoreItem(PBItems::INSECTPLATE,10); $PokemonBag.pbStoreItem(PBItems::IRONPLATE,10); $PokemonBag.pbStoreItem(PBItems::MEADOWPLATE,10);
						$PokemonBag.pbStoreItem(PBItems::MINDPLATE,10); $PokemonBag.pbStoreItem(PBItems::SKYPLATE,10); $PokemonBag.pbStoreItem(PBItems::SPLASHPLATE,10);
						$PokemonBag.pbStoreItem(PBItems::SPOOKYPLATE,10); $PokemonBag.pbStoreItem(PBItems::STONEPLATE,10); $PokemonBag.pbStoreItem(PBItems::TOXICPLATE,10);
						$PokemonBag.pbStoreItem(PBItems::ZAPPLATE,10);  $PokemonBag.pbStoreItem(PBItems::PIXIEPLATE,10);
						when 3
						#Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						$PokemonBag.pbStoreItem(PBItems::NORMALGEM,99); $PokemonBag.pbStoreItem(PBItems::FIREGEM,99); $PokemonBag.pbStoreItem(PBItems::WATERGEM,99);
						$PokemonBag.pbStoreItem(PBItems::GRASSGEM,99); $PokemonBag.pbStoreItem(PBItems::ELECTRICGEM,99); $PokemonBag.pbStoreItem(PBItems::FLYINGGEM,199);
						$PokemonBag.pbStoreItem(PBItems::GROUNDGEM,99); $PokemonBag.pbStoreItem(PBItems::ROCKGEM,99); $PokemonBag.pbStoreItem(PBItems::STEELGEM,99);
						$PokemonBag.pbStoreItem(PBItems::POISONGEM,99); $PokemonBag.pbStoreItem(PBItems::FAIRYGEM,99); $PokemonBag.pbStoreItem(PBItems::DRAGONGEM,99);
						$PokemonBag.pbStoreItem(PBItems::PSYCHICGEM,99); $PokemonBag.pbStoreItem(PBItems::DARKGEM,99); $PokemonBag.pbStoreItem(PBItems::FIGHTINGGEM,99);
						$PokemonBag.pbStoreItem(PBItems::BUGGEM,99); $PokemonBag.pbStoreItem(PBItems::ICEGEM,99); $PokemonBag.pbStoreItem(PBItems::GHOSTGEM,99);
						when 4
						$PokemonBag.pbStoreItem(PBItems::LEFTOVERS,10); $PokemonBag.pbStoreItem(PBItems::BLACKSLUDGE,10); $PokemonBag.pbStoreItem(PBItems::EVIOLITE,10);
						when 5
						$PokemonBag.pbStoreItem(PBItems::EJECTBUTTON,99); $PokemonBag.pbStoreItem(PBItems::REDCARD,99);
						
						when 6
						$PokemonBag.pbStoreItem(PBItems::FOCUSSASH,150);
						when 7
						$PokemonBag.pbStoreItem(PBItems::AIRBALLOON,150);
						when 8
						$PokemonBag.pbStoreItem(PBItems::WHITEHERB,99); $PokemonBag.pbStoreItem(PBItems::POWERHERB,99); $PokemonBag.pbStoreItem(PBItems::MENTALHERB,99); 
						when 9
						$PokemonBag.pbStoreItem(PBItems::TELLURICSEED,99);  $PokemonBag.pbStoreItem(PBItems::ELEMENTALSEED,99); $PokemonBag.pbStoreItem(PBItems::SYNTHETICSEED,99); 
						$PokemonBag.pbStoreItem(PBItems::MAGICALSEED,99);  
						when 10
						$PokemonBag.pbStoreItem(PBItems::SMOOTHROCK,29);  $PokemonBag.pbStoreItem(PBItems::DAMPROCK,29); $PokemonBag.pbStoreItem(PBItems::HEATROCK,29); 
						$PokemonBag.pbStoreItem(PBItems::ICYROCK,29);   $PokemonBag.pbStoreItem(PBItems::AMPLIFIELDROCK,29); 
						
						when 11
						$PokemonBag.pbStoreItem(PBItems::PECHABERRY,1);  $PokemonBag.pbStoreItem(PBItems::BERRYJUICE,1); $PokemonBag.pbStoreItem(PBItems::BALMMUSHROOM,1); 
						$PokemonBag.pbStoreItem(PBItems::TARTAPPLE,1);  $PokemonBag.pbStoreItem(PBItems::SWEETAPPLE,1); $PokemonBag.pbStoreItem(PBItems::STICK,1); 
						$game_switches[463] = true
						$game_switches[464] = false
						Kernel.pbMessage(_INTL("You have rage powder now."))
						end
					end
				
				when 3
				megacmd=0
					loop do
						megacmds=[
						_INTL("Main Game Bundlite"),
						_INTL("Legends Bundlite"),
						]
					megacmd=Kernel.pbShowCommands(nil,megacmds,-1,megacmd)
					break if megacmd<0
						case megacmd
						when 0
						#Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						Kernel.pbMessage(_INTL("Reminder : Meganium and Yanmega do not need Mega Stones to evolve. :blobcatgooglythumbsup:"))
						$PokemonBag.pbStoreItem(PBItems::GENGARITE,1);  $PokemonBag.pbStoreItem(PBItems::GARDEVOIRITE,1); $PokemonBag.pbStoreItem(PBItems::CHARIZARDITEX,1); 
						$PokemonBag.pbStoreItem(PBItems::CHARIZARDITEY,1);  $PokemonBag.pbStoreItem(PBItems::AMPHAROSITE,1); $PokemonBag.pbStoreItem(PBItems::VENUSAURITE,1);
						$PokemonBag.pbStoreItem(PBItems::BLASTOISINITE,1);  $PokemonBag.pbStoreItem(PBItems::BLAZIKENITE,1); $PokemonBag.pbStoreItem(PBItems::MEDICHAMITE,1);
						$PokemonBag.pbStoreItem(PBItems::HOUNDOOMINITE,1);  $PokemonBag.pbStoreItem(PBItems::AGGRONITE,1); $PokemonBag.pbStoreItem(PBItems::BANETTITE,1);
						$PokemonBag.pbStoreItem(PBItems::TYRANITARITE,1);  $PokemonBag.pbStoreItem(PBItems::SCIZORITE,1); $PokemonBag.pbStoreItem(PBItems::PINSIRITE,1);
						$PokemonBag.pbStoreItem(PBItems::AERODACTYLITE,1);  $PokemonBag.pbStoreItem(PBItems::LUCARIONITE,1); $PokemonBag.pbStoreItem(PBItems::ABOMASITE,1);
						$PokemonBag.pbStoreItem(PBItems::KANGASKHANITE,1);  $PokemonBag.pbStoreItem(PBItems::GYARADOSITE,1); $PokemonBag.pbStoreItem(PBItems::ABSOLITE,1);
						$PokemonBag.pbStoreItem(PBItems::HERACRONITE,1);  $PokemonBag.pbStoreItem(PBItems::MAWILITE,1); $PokemonBag.pbStoreItem(PBItems::MANECTITE,1);
						$PokemonBag.pbStoreItem(PBItems::GARCHOMPITE,1);  $PokemonBag.pbStoreItem(PBItems::SWAMPERTITE,1); $PokemonBag.pbStoreItem(PBItems::SCEPTILITE,1);
						$PokemonBag.pbStoreItem(PBItems::SABLENITE,1);  $PokemonBag.pbStoreItem(PBItems::ALTARIANITE,1); $PokemonBag.pbStoreItem(PBItems::GALLADITE,1);
						$PokemonBag.pbStoreItem(PBItems::AUDINITE,1);  $PokemonBag.pbStoreItem(PBItems::METAGROSSITE,1); $PokemonBag.pbStoreItem(PBItems::SHARPEDONITE,1);
						$PokemonBag.pbStoreItem(PBItems::STEELIXITE,1);  $PokemonBag.pbStoreItem(PBItems::SLOWBRONITE,1); $PokemonBag.pbStoreItem(PBItems::PIDGEOTITE,1);
						$PokemonBag.pbStoreItem(PBItems::GLALITITE,1);  $PokemonBag.pbStoreItem(PBItems::CAMERUPTITE,1); $PokemonBag.pbStoreItem(PBItems::LOPUNNITE,1);
						$PokemonBag.pbStoreItem(PBItems::SALAMENCITE,1);  $PokemonBag.pbStoreItem(PBItems::BEEDRILLITE,1); 
						
						when 1
						$PokemonBag.pbStoreItem(PBItems::MEWTWONITEX,1);  $PokemonBag.pbStoreItem(PBItems::MEWTWONITEY,1); $PokemonBag.pbStoreItem(PBItems::DIANCITE,1);
						$PokemonBag.pbStoreItem(PBItems::LATIASITE,1);  $PokemonBag.pbStoreItem(PBItems::LATIOSITE,1); 
						end
					end
				when 4
				zcmd=0
					loop do
						zcmds=[
						_INTL("Type Crystals"),
						_INTL("Unique Crystals"),
						_INTL("Uber Crystals"),
						_INTL("just gimme eevium and kommonium lol"),
						]
					zcmd=Kernel.pbShowCommands(nil,zcmds,-1,zcmd)
					break if zcmd<0
						case zcmd
						when 0
						#Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						$PokemonBag.pbStoreItem(PBItems::NORMALIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::FIRIUMZ,1); $PokemonBag.pbStoreItem(PBItems::WATERIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::GRASSIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::ELECTRIUMZ,1); $PokemonBag.pbStoreItem(PBItems::GROUNDIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::ROCKIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::STEELIUMZ,1); $PokemonBag.pbStoreItem(PBItems::FLYINIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::POISONIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::DRAGONIUMZ,1); $PokemonBag.pbStoreItem(PBItems::FAIRIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::FIGHTINIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::DARKINIUMZ,1); $PokemonBag.pbStoreItem(PBItems::PSYCHIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::GHOSTIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::ICIUMZ,1); $PokemonBag.pbStoreItem(PBItems::BUGINIUMZ,1); 
						when 1
						$PokemonBag.pbStoreItem(PBItems::EEVIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::KOMMONIUMZ,1); $PokemonBag.pbStoreItem(PBItems::PIKANIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::ALORAICHIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::SNORLIUMZ,1); $PokemonBag.pbStoreItem(PBItems::DECIDIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::INCINIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::PRIMARIUMZ,1); $PokemonBag.pbStoreItem(PBItems::LYCANIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::MIMIKIUMZ,1); 
						when 2
						$PokemonBag.pbStoreItem(PBItems::MARSHADIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::TAPUNIUMZ,1); $PokemonBag.pbStoreItem(PBItems::SOLGANIUMZ,1); 
						$PokemonBag.pbStoreItem(PBItems::ULTRANECROZIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::LUNALIUMZ,1); $PokemonBag.pbStoreItem(PBItems::MEWNIUMZ,1); 
						when 3
						Kernel.pbMessage(_INTL("Nerd."))
						$PokemonBag.pbStoreItem(PBItems::EEVIUMZ,1);  $PokemonBag.pbStoreItem(PBItems::KOMMONIUMZ,1); 
						end
					end
				when 5
				bundlecmd=-1
				end
		end


end

def torDebugAdvancedPC
advancedpccmd=0
loop do
	advancedpccmds=[
		_INTL("Save Team in Slot 1"),
		_INTL("Load Team in Slot 1"),
		_INTL("Save Team in Slot 2"),
		_INTL("Load Team in Slot 2"),
		_INTL("Save Team in Slot 3"),
		_INTL("Load Team in Slot 3"),
		_INTL("Save Team in Slot 4"),
		_INTL("Load Team in Slot 4"),
		_INTL("Save Team in Slot 5"),
		_INTL("Load Team in Slot 5")
		]
			advancedpccmd=Kernel.pbShowCommands(nil,advancedpccmds,-1,advancedpccmd)

		break if advancedpccmd<0
			case advancedpccmd
			when 0 #Save 1
			torsaveteamin47(1)
			break
			when 1 #Load 1
			torloadteamin47(1)
			break
			when 2 #Save 2
			torsaveteamin47(2)
			when 3 #Load 2
			torloadteamin47(2)
			break
			when 4 #Save 3
			torsaveteamin47(3)
			when 5 #Load 3
			torloadteamin47(3)
			break
			when 6 #Save 4
			torsaveteamin47(4)
			when 7 #Load 4
			torloadteamin47(4)
			break
			when 8 #Save 5
			torsaveteamin47(5)
			when 9 #Load 5
			torloadteamin47(5)
			break
			end
	end
end

def torDebugMadness
		loop do
		madcmds=[
		_INTL("Set Party to Cap (Half)"),
		_INTL("smh"),
		]
		madcmd=0
		madcmd=Kernel.pbShowCommands(nil,madcmds,-1,madcmd)
		break if madcmd<0
		case madcmd
			when 0
			  leadersDefeated = $Trainer.numbadges
			  lcap=LEVELCAPS[leadersDefeated] + $game_variables[595]
			  if lcap>100
			  lcap=lcap-50
			  end
				  for i in $Trainer.party
					i.level=(lcap/2).floor
					i.calcStats
				end
				i.calcStats
				Kernel.pbMessage(_INTL("Your Pokémon were set to half level cap. Nerd."))
			when 1
				Kernel.pbMessage(_INTL("Ok."))
			end
		end
end

def torDebuge19shortcut
	scenariocmd=0
	loop do
	scenariocmds=[
	_INTL("Glass Gauntlet 3"),
	_INTL("Glass Gauntlet 2"),
	_INTL("Lin 3 (Anna)"),
	_INTL("Lin 2 (Anna)"),
	_INTL("Lin 2 (Lin)"),
	_INTL("Lin 1 (Conk)"),
	_INTL("Lin 1 (Toge)"),
	_INTL("Elite 4 Anna"),
	_INTL("Elite 4 Elias"),
	_INTL("Elite 4 Tag Team"),
	_INTL("Elite 4 Heather"),
	_INTL("Mega Ring fights"),
	_INTL("Fiore 3 (Julia)"),
	_INTL("Fiore 3 (Flobot)"),
	_INTL("Fiore 2"),
	]
	scenariocmd=Kernel.pbShowCommands(nil,scenariocmds,-1,scenariocmd)
	break if scenariocmd<0
		case scenariocmd
		when 0
		$game_variables[161] = 17
		pbDoubleTrainerBattle(PBTrainers::QMARK,"?????",1,_I("???"),PBTrainers::QMARK,"?????",2,_I("???"))
		$game_variables[161] = 0
		when 1
		$game_variables[161] = 17
		pbTrainerBattle(PBTrainers::QMARK,"?????",_I("???"),false,0)
		$game_variables[161] = 0
		when 2
		$game_switches[1303] = true
		$game_variables[161] = 35
		pbTrainerBattle(PBTrainers::CHILDLIN,"Lin",_I("huh??????"),false,0,true)
		$game_variables[161] = 0
		$game_switches[1303] = false
		when 3
		$game_variables[161] = 35
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("I've waited for so long."),false,3)
		$game_variables[161] = 0
		when 4
		$game_switches[1000] = true
		$game_switches[1303] = true
		$game_variables[161] = 35
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("I've waited for so long."),false,2)
		$game_variables[161] = 0
		$game_switches[1000] = false
		$game_switches[1303] = false
		when 5
		$game_switches[1000] = true
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("Before you sleep, creature, you have one more task."),false,0)
		$game_switches[1000] = false
		when 6
		$game_switches[1000] = true
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("Before you sleep, creature, you have one more task."),false,1)
		$game_switches[1000] = false
		when 7
		$game_switches[1000] = true
		$game_variables[161] = 34
		pbTrainerBattle(PBTrainers::ANNA,"Anna",_I("If stars never fell, how would anyone make their wishes?"),false,0)
		$game_variables[161] = 0
		$game_switches[1000] = false
		when 8
		Kernel.pbMessage(_INTL("Godspeed!"))
		$game_variables[161] = 29
		pbTrainerBattle(PBTrainers::ELIAS,"Elias",_I("So be it."),false,0)
		$game_variables[161] = 0
		when 9
		$game_variables[161] = 33
		pbTrainerBattle(PBTrainers::BENNETTLAURA,"Bennett & Laura",_I("BENNETT: Impressive. I'll make note to study this later."),true,0)
		$game_variables[161] = 0
		when 10
		$game_variables[161] = 27
		pbTrainerBattle(PBTrainers::HEATHER,"Heather",_I("No! No! Nonononononono!!!"),false,0)
		$game_variables[161] = 0
		when 11
		pbDoubleTrainerBattle(PBTrainers::CUEBALL,"Colin",0,_I("I don't think this was in the plan."),PBTrainers::CUEBALL,"Matthew",0,_I("Uhh... Boss?"))
		pbTrainerBattle(PBTrainers::MASTERMIND,"Eustace",_I("Wha-- Adults ruin everything!"),false)
		when 12
		pbRegisterPartner(PBTrainers::JULIA,"Julia",1)
		pbDoubleTrainerBattle(PBTrainers::NWOrderly,"John",0,_I("I did my best, sir."),PBTrainers::Solaris,"Solaris",1,_I("Your purpose is asinine, but I must respect your ability."))
		Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
		a=0; b="lol"; c=a+b;
		when 13
		pbRegisterPartner(PBTrainers::FLORINIA,"Florinia",1)
		pbDoubleTrainerBattle(PBTrainers::NWOrderly,"John",0,_I("I did my best, sir."),PBTrainers::Solaris,"Solaris",1,_I("Your purpose is asinine, but I must respect your ability."))
		Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
		a=0; b="lol"; c=a+b;
		when 14
		pbRegisterPartner(PBTrainers::FLORINIA,"Florinia",1)
		pbDoubleTrainerBattle(PBTrainers::BLAKE,"Blake",1,_I("Tch, fuck this."),PBTrainers::Hotshot,"Fern",6,_I("You're gonna regret crossing me-- both of you will!"))
		Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
		a=0; b="lol"; c=a+b;
		end
	end

end

def torDebuge20shortcut
		scenariocmd=0
		loop do
		scenariocmds=[
		_INTL("Tier 8 : Lin Boss - Part 2"),
		_INTL("Tier 8 : Lin Boss - Part 3"),
		_INTL("Tier 7 : Titania & Groudon"),
		_INTL("Tier 7 : Amaria & Kyogre"),
		_INTL("Tier 8 : Anna Boss - Part 2"),
		_INTL("Tier 8 : Anna Boss - Part 3"),
		_INTL("Tao 1 - with Zero"),
		_INTL("Tao 2 - with Zero"),
		_INTL("Tao 1 - with Pirate Taka"),
		_INTL("Tao 2 - with Pirate Taka"),
		_INTL("Tao 1 - with Reborn Taka"),
		_INTL("Tao 2 - with Reborn Taka"),
		]
		scenariocmd=Kernel.pbShowCommands(nil,scenariocmds,-1,scenariocmd)
		break if scenariocmd<0
			case scenariocmd
			when 0 # Lin 2
			$game_variables[192] = 1
			$game_variables[161] = 35
			pbTrainerBattle(PBTrainers::CHILDLIN,"Lin",_I("well i hope YOU'RE having a good time at least."),true,2,true)
			$game_variables[192] = 0
			$game_variables[161] = 0
			when 1
			$game_switches[1000] = true
			$game_variables[161] = 35
			$game_switches[1303] = true
			pbTrainerBattle(PBTrainers::ARCEUS,"Arceus",_I("Caraa~"),false,0,true)
			$game_switches[1303] = false
			$game_switches[1000] = false
			$game_variables[161] = 0
			when 2
			$game_variables[161] = 2
			pbDoubleTrainerBattle(PBTrainers::UMBTITANIA,"Titania",2,_I("XXXXXXXXX!!!"),PBTrainers::GROUDON,"Groudon",0,_I("Graaagh!!!"),true)
			$game_variables[161] = 0
			when 3
			$game_variables[161] = 21
			pbDoubleTrainerBattle(PBTrainers::UMBAMARIA,"Amaria",2,_I("XXXXXXXXX!!!"),PBTrainers::KYOGRE,"Kyogre",0,_I("Gyoorrrgh!!!"))
			$game_variables[161] = 0
			when 4 # Anna
			$game_switches[1942] = true
			$game_variables[192] = 0
			$game_variables[161] = 24
			pbTrainerBattle(PBTrainers::ANNA2,"Anna",_I("WHY?!? i just... wanted..."),false,0)
			$game_variables[161] = 0
			$game_switches[1942] = false
			when 5 #Arceus Anna
			$game_switches[1000] = true
			$game_switches[1303] = true
			$game_variables[161] = 24
			pbTrainerBattle(PBTrainers::ARCEUS,"Arceus",_I("Caraa~"),false,1)
			$game_variables[161] = 0
			$game_switches[1000] = false
			$game_switches[1303] = false
			when 6 #Tao 1 Zero
			pbRegisterPartner(PBTrainers::ZEL3,"Zero",0)
			$game_variables[161] = 13
			pbDoubleTrainerBattle(PBTrainers::ZEKROM,"Zekrom",0,_I("Zaaaaaaaaaahk!"),PBTrainers::RESHIRAM,"Reshiram",0,_I("Yrrrraaaah!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 7
			pbRegisterPartner(PBTrainers::ZEL3,"Zero",0)
			$game_variables[161] = 35
			pbDoubleTrainerBattle(PBTrainers::KYUREM1,"Kyurem",0,_I("Kyuuu!!!"),PBTrainers::KYUREM2,"Fusion Simulations",0,_I("Raaaaaaam!!!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 8
			pbRegisterPartner(PBTrainers::ZTAKA2,"Taka",0)
			$game_variables[161] = 13
			pbDoubleTrainerBattle(PBTrainers::ZEKROM,"Zekrom",0,_I("Zaaaaaaaaaahk!"),PBTrainers::RESHIRAM,"Reshiram",0,_I("Yrrrraaaah!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 9
			pbRegisterPartner(PBTrainers::ZTAKA2,"Taka",0)
			$game_variables[161] = 35
			pbDoubleTrainerBattle(PBTrainers::KYUREM1,"Kyurem",0,_I("Kyuuu!!!"),PBTrainers::KYUREM2,"Fusion Simulations",0,_I("Raaaaaaam!!!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 10
			pbRegisterPartner(PBTrainers::Taka2,"Taka",1)
			$game_variables[161] = 13
			pbDoubleTrainerBattle(PBTrainers::ZEKROM,"Zekrom",0,_I("Zaaaaaaaaaahk!"),PBTrainers::RESHIRAM,"Reshiram",0,_I("Yrrrraaaah!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 11
			pbRegisterPartner(PBTrainers::Taka2,"Taka",1)
			$game_variables[161] = 35
			pbDoubleTrainerBattle(PBTrainers::KYUREM1,"Kyurem",0,_I("Kyuuu!!!"),PBTrainers::KYUREM2,"Fusion Simulations",0,_I("Raaaaaaam!!!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			end
		end
end

def torDebugAddMoPreset
	monzcmd=0
		loop do
		monzcmds=[
		_INTL("Smeargle with 4 Terrain Moves"),
		_INTL("Jigglypuff (Mega Quest)"),
		_INTL("Loudred (Mega Quest)"),
		_INTL("Makuhita (Mega Quest)"),
		_INTL("Roggenrola (Mega Quest)"),
		_INTL("Vanillite (Mega Quest)"),
		]
		monzcmd=Kernel.pbShowCommands(nil,monzcmds,-1,monzcmd)
		break if monzcmd<0
			case monzcmd
			when 0
			poke=PokeBattle_Pokemon.new(:SMEARGLE,100);poke.pbLearnMove(:MISTYTERRAIN);poke.pbLearnMove(:PSYCHICTERRAIN);
			poke.pbLearnMove(:GRASSYTERRAIN);poke.pbLearnMove(:ELECTRICTERRAIN);pbAddPokemon(poke)
			when 1
			poke=PokeBattle_Pokemon.new(:JIGGLYPUFF,30);poke.ot="Santiago";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 2
			poke=PokeBattle_Pokemon.new(:LOUDRED,35);poke.ot="Lillin";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 3
			poke=PokeBattle_Pokemon.new(:MAKUHITA,40);poke.ot="Felicia";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 4
			poke=PokeBattle_Pokemon.new(:ROGGENROLA,24);poke.ot="Mr.McKrezzy";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 5
			poke=PokeBattle_Pokemon.new(:VANILLITE,35);poke.ot="Eustace";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			end
		end
end

def torDebugOrderBoxes
			params=ChooseNumberParams.new
			params.setRange(2,30)
			params.setDefaultValue(10)
			maxbox=Kernel.pbMessageChooseNumber(
			_INTL("This orders Pokemon by dex numbers between boxes 2 and X. Decide X in [3;30]"),params)
			torBoxSorter(2,maxbox)
end

def torDebugRandomID
      $Trainer.id=rand(256)
      $Trainer.id|=rand(256)<<8
      $Trainer.id|=rand(256)<<16
      $Trainer.id|=rand(256)<<24
      Kernel.pbMessage(_INTL("The player's ID was changed to {1} (2).",$Trainer.publicID,$Trainer.id))
end

def torDebugSetMoney
      params=ChooseNumberParams.new
      params.setMaxDigits(6)
      params.setDefaultValue($Trainer.money)
      $Trainer.money=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's money."),params)
      Kernel.pbMessage(_INTL("You now have ${1}.",$Trainer.money))

end

def torDebugSetCoins
      params=ChooseNumberParams.new
      params.setRange(0,MAXCOINS)
      params.setDefaultValue($PokemonGlobal.coins)
      $PokemonGlobal.coins=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's Coin amount."),params)
      Kernel.pbMessage(_INTL("You now have {1} Coins.",$PokemonGlobal.coins))
end

def torDebugStealTrainer
		trainerchoice=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
		if !trainerchoice
		else
		trainerdata=trainerchoice[1]
		boxtrack=0
			for poke in trainerdata[3]
			opponent=PokeBattle_Trainer.new(trainerdata[1],trainerdata[0])
			species=poke[TPSPECIES]
			level=poke[TPLEVEL]
			pokegift=PokeBattle_Pokemon.new(species,level)
			pokemon=PokeBattle_Pokemon.new(species,level,opponent)
			pokemon=PokeBattle_Pokemon.new(species,level)
			pokemon.form=poke[TPFORM]
			pokemon.resetMoves
			pokemon.setItem(poke[TPITEM])
				if poke[TPMOVE1]>0 || poke[TPMOVE2]>0 || poke[TPMOVE3]>0 || poke[TPMOVE4]>0
				k=0
					for move in [TPMOVE1,TPMOVE2,TPMOVE3,TPMOVE4]
					pokemon.moves[k]=PBMove.new(poke[move])
					k+=1
					end
				end
			pokemon.setAbility(poke[TPABILITY])
			pokemon.setGender(poke[TPGENDER])
				if poke[TPSHINY]   # if this is a shiny Pokémon
				pokemon.makeShiny
				else
				pokemon.makeNotShiny
				end
			pokemon.setNature(poke[TPNATURE])
			iv=poke[TPIV]
				if iv==32
					for i in 0...6
					pokemon.iv[i]=31
					end
				pokemon.iv[3]=0
				else
					for i in 0...6
					pokemon.iv[i]=iv&0x1F
					end
				end
			evsum = poke[TPHPEV].to_i+poke[TPATKEV].to_i+poke[TPDEFEV].to_i+poke[TPSPEEV].to_i+poke[TPSPAEV].to_i+poke[TPSPDEV].to_i
				if evsum>0 
				pokemon.ev=[poke[TPHPEV].to_i,
				poke[TPATKEV].to_i,
				poke[TPDEFEV].to_i,
				poke[TPSPEEV].to_i,
				poke[TPSPAEV].to_i,
				poke[TPSPDEV].to_i]
				elsif evsum == 0
					for i in 0...6
					pokemon.ev[i]=[85,level*3/2].min
					end
				end
			pokemon.calcStats
			$PokemonStorage[47,boxtrack]=pokemon
			boxtrack=boxtrack+1
			end
			if boxtrack<5
			imax=7-boxtrack
				for i in 1...imax
				$PokemonStorage.pbDelete(47,boxtrack)
				boxtrack=boxtrack+1
				end
			end
		end
end

def torDebug1v2
      battle1=pbListScreen(_INTL("DOUBLE TRAINER 1"),TrainerBattleLister.new(0,false))
      if battle1
        battle2=pbListScreen(_INTL("DOUBLE TRAINER 2"),TrainerBattleLister.new(0,false))
        if battle2
          trainerdata1=battle1[1]
          trainerdata2=battle2[1]
          pbDoubleTrainerBattle(trainerdata1[0],trainerdata1[1],trainerdata1[4],"...",
                                trainerdata2[0],trainerdata2[1],trainerdata2[4],"...",
                                true)
        end
      end
end

def torDebug2v2
      battle=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
      if battle
        trainerdata=battle[1]
        pbTrainerBattle(trainerdata[0],trainerdata[1],"...",true,trainerdata[4],true)
      end
end

def torDebug1v1
      battle=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
      if battle
        trainerdata=battle[1]
        pbTrainerBattle(trainerdata[0],trainerdata[1],"...",false,trainerdata[4],true)
      end
end

def torDebugDaycare
      daycarecmd=0
      loop do
        daycarecmds=[
           _INTL("Summary"),
           _INTL("Deposit Pokémon"),
           _INTL("Withdraw Pokémon"),
           _INTL("Generate egg"),
           _INTL("Collect egg"),
           _INTL("Dispose egg")
        ]
        daycarecmd=Kernel.pbShowCommands(nil,daycarecmds,-1,daycarecmd)
        break if daycarecmd<0
        case daycarecmd
          when 0 # Summary
            if $PokemonGlobal.daycare
              num=pbDayCareDeposited
              Kernel.pbMessage(_INTL("{1} Pokémon are in the Day Care.",num))
              if num>0
                txt=""
                for i in 0...num
                  next if !$PokemonGlobal.daycare[i][0]
                  pkmn=$PokemonGlobal.daycare[i][0]
                  initlevel=$PokemonGlobal.daycare[i][1]
                  gender=[_INTL("♂"),_INTL("♀"),_INTL("genderless")][pkmn.gender]
                  txt+=_INTL("{1}) {2} ({3}), Lv.{4} (deposited at Lv.{5})",
                     i,pkmn.name,gender,pkmn.level,initlevel)
                  txt+="\n" if i<num-1
                end
                Kernel.pbMessage(txt)
              end
              if $PokemonGlobal.daycareEgg==1
                Kernel.pbMessage(_INTL("An egg is waiting to be picked up."))
              elsif pbDayCareDeposited==2
                if pbDayCareGetCompat==0
                  Kernel.pbMessage(_INTL("The deposited Pokémon can't breed."))
                else
                  Kernel.pbMessage(_INTL("The deposited Pokémon can breed."))
                end
              end
            end
          when 1 # Deposit Pokémon
            if pbEggGenerated?
              Kernel.pbMessage(_INTL("Egg is available, can't deposit Pokémon."))
            elsif pbDayCareDeposited==2
              Kernel.pbMessage(_INTL("Two Pokémon are deposited already."))
            elsif $Trainer.party.length==0
              Kernel.pbMessage(_INTL("Party is empty, can't desposit Pokémon."))
            else
              pbChooseNonEggPokemon(1,3)
              if pbGet(1)>=0
                pbDayCareDeposit(pbGet(1))
                Kernel.pbMessage(_INTL("Deposited {1}.",pbGet(3)))
              end
            end
          when 2 # Withdraw Pokémon
            if pbEggGenerated?
              Kernel.pbMessage(_INTL("Egg is available, can't withdraw Pokémon."))
            elsif pbDayCareDeposited==0
              Kernel.pbMessage(_INTL("No Pokémon are in the Day Care."))
            elsif $Trainer.party.length>=6
              Kernel.pbMessage(_INTL("Party is full, can't withdraw Pokémon."))
            else
              pbDayCareChoose(_INTL("Which one do you want back?"),1)
              if pbGet(1)>=0
                pbDayCareGetDeposited(pbGet(1),3,4)
                pbDayCareWithdraw(pbGet(1))
                Kernel.pbMessage(_INTL("Withdrew {1}.",pbGet(3)))
              end
            end
          when 3 # Generate egg
            if $PokemonGlobal.daycareEgg==1
              Kernel.pbMessage(_INTL("An egg is already waiting."))
            elsif pbDayCareDeposited!=2
              Kernel.pbMessage(_INTL("There aren't 2 Pokémon in the Day Care."))
            elsif pbDayCareGetCompat==0
              Kernel.pbMessage(_INTL("The Pokémon in the Day Care can't breed."))
            else
              $PokemonGlobal.daycareEgg=1
              Kernel.pbMessage(_INTL("An egg is now waiting in the Day Care."))
            end
          when 4 # Collect egg
            if $PokemonGlobal.daycareEgg!=1
              Kernel.pbMessage(_INTL("There is no egg available."))
            elsif $Trainer.party.length>=6
              Kernel.pbMessage(_INTL("Party is full, can't collect the egg."))
            else
              pbDayCareGenerateEgg
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Collected the {1} egg.",
                 PBSpecies.getName($Trainer.party[$Trainer.party.length-1].species)))
            end
          when 5 # Dispose egg
            if $PokemonGlobal.daycareEgg!=1
              Kernel.pbMessage(_INTL("There is no egg available."))
            else
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Disposed of the egg."))
            end
        end
      end
end

def torDebugQuickhatch
      for pokemon in $Trainer.party
        pokemon.eggsteps=1 if pokemon.isEgg?
      end
      Kernel.pbMessage(_INTL("All eggs on your party now require one step to hatch."))
end

def torDebugWildSingles
      species=pbChooseSpeciesOrdered(1)
      if species!=0
        params=ChooseNumberParams.new
        params.setRange(1,PBExperience::MAXLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level=Kernel.pbMessageChooseNumber(
           _INTL("Set the Pokémon's level."),params)
        if level>0
          pbWildBattle(species,level)
        end
      end
end

def torDebugWildDoubles
      Kernel.pbMessage(_INTL("Choose the first Pokémon."))
      species1=pbChooseSpeciesOrdered(1)
      if species1!=0
        params=ChooseNumberParams.new
        params.setRange(1,PBExperience::MAXLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level1=Kernel.pbMessageChooseNumber(
           _INTL("Set the first Pokémon's level."),params)
        if level1>0
          Kernel.pbMessage(_INTL("Choose the second Pokémon."))
          species2=pbChooseSpeciesOrdered(1)
          if species2!=0
            params=ChooseNumberParams.new
            params.setRange(1,PBExperience::MAXLEVEL)
            params.setInitialValue(5)
            params.setCancelValue(0)
            level2=Kernel.pbMessageChooseNumber(
               _INTL("Set the second Pokémon's level."),params)
            if level2>0
              pbDoubleWildBattle(species1,level1,species2,level2)
            end
          end
        end
      end
end



def torsaveteamin47(slot)
	pcslot=0+6*(slot-1)
	inipcslot=pcslot
	for poke in $Trainer.party
			species=poke.species
			level=poke.level
			pokegift=PokeBattle_Pokemon.new(species,level)
			pokemon=PokeBattle_Pokemon.new(species,level)
			pokemon.form=poke.form
			pokemon.resetMoves
			pokemon.setItem(poke.item)
			pokemon.pbDeleteAllMoves
			
			for i in 0...4
				if (poke.moves[i].id>0)
					pokemon.pbLearnMove(poke.moves[i].id)
					pokemon.moves[i].ppup=poke.moves[i].ppup
					pokemon.moves[i].pp=poke.moves[i].pp
				end
			end
			kreal=0
			for k in 0..2
			pokemon.setAbility(k)
				if pokemon.ability==poke.ability
				kreal=k
				end
			end
			pokemon.setAbility(kreal)
			pokemon.setGender(poke.gender)
			pokemon.name=poke.name
			pokemon.status=poke.status
			pokemon.statusCount=poke.statusCount
			pokemon.hptype=poke.hptype
			pokemon.happiness=poke.happiness
			pokemon.obtainMode=poke.obtainMode
			pokemon.obtainMap=poke.obtainMap
			pokemon.obtainText=poke.obtainText
			pokemon.obtainLevel=poke.obtainLevel
			pokemon.timeReceived=(poke.timeReceived)
			
				if poke.shinyflag   # if this is a shiny Pokémon
				pokemon.makeShiny
				else
				pokemon.makeNotShiny
				end
			pokemon.setNature(poke.natureflag)
				for i in 0...6
				pokemon.iv[i]=poke.iv[i]
				end
				for i in 0...6
				pokemon.ev[i]=poke.ev[i]
				end
			pokemon.calcStats
			pokemon.hp=poke.hp
			pokemon.calcStats
			$PokemonStorage[46,pcslot]=pokemon
			pcslot=pcslot+1
			end
			if pcslot<5+inipcslot
			maxpcslot=inipcslot+6
			imax=7-pcslot
				for i in pcslot...maxpcslot
				$PokemonStorage.pbDelete(46,i)
				end
			
	end
end

def torloadteamin47(slot)
	pcslot=0+6*(slot-1)
	inipcslot=pcslot
	for j in 0...6
	$Trainer.party[j]=nil
	end
	$Trainer.party.compact!
	
	for l in 1...7
	poke=$PokemonStorage[46,pcslot]
		if poke!=nil
			species=poke.species
			level=poke.level
			pokegift=PokeBattle_Pokemon.new(species,level)
			pokemon=PokeBattle_Pokemon.new(species,level)
			pokemon.form=poke.form
			pokemon.resetMoves
			pokemon.setItem(poke.item)
			pokemon.pbDeleteAllMoves
			
			for i in 0...4
				if (poke.moves[i].id>0)
					pokemon.pbLearnMove(poke.moves[i].id)
					pokemon.moves[i].ppup=poke.moves[i].ppup
					pokemon.moves[i].pp=poke.moves[i].pp
				end
			end
			kreal=0
			for k in 0..2
			pokemon.setAbility(k)
				if pokemon.ability==poke.ability
				kreal=k
				end
			end
			pokemon.setAbility(kreal)
			pokemon.setGender(poke.gender)
			pokemon.name=poke.name
			pokemon.status=poke.status
			pokemon.statusCount=poke.statusCount
			pokemon.hptype=poke.hptype
			pokemon.happiness=poke.happiness
			pokemon.obtainMode=poke.obtainMode
			pokemon.obtainMap=poke.obtainMap
			pokemon.obtainText=poke.obtainText
			pokemon.obtainLevel=poke.obtainLevel
			pokemon.timeReceived=(poke.timeReceived)
			
				if poke.shinyflag   # if this is a shiny Pokémon
				pokemon.makeShiny
				else
				pokemon.makeNotShiny
				end
			pokemon.setNature(poke.natureflag)
				for i in 0...6
				pokemon.iv[i]=poke.iv[i]
				end
				for i in 0...6
				pokemon.ev[i]=poke.ev[i]
				end
			pokemon.calcStats
			pokemon.hp=poke.hp
			pokemon.calcStats
			pbStorePokemon(pokemon)
			pcslot=pcslot+1
			end
		end
end

def torselfteamtotext
# Exports your team in a file in the game folder.
    f = File.open("Team Data - My Own Team.txt","w")
    for poke in $Trainer.party
		#If the form isn't the base form, gives a warning. Also mentions the typings to easily notice stuff like Kyurems and Necrozmas.
        if poke.form!=0
			f.write("WATCH OUT, THIS POKEMON IS NOT IN ITS BASE FORM. ITS TYPING IS #{PBTypes.getName(poke.type1)} #{PBTypes.getName(poke.type2)}\n")
		end
		f.write(PBSpecies.getName(poke.species))
        if poke.item!=0
			f.write(" @ ")
			f.write(PBItems.getName(poke.item))
        end
		f.write("\n")
		f.write("Level: ")
		f.write(poke.poklevel)
		f.write("\n")
        f.write(PBNatures.getName(poke.nature))
		f.write(" Nature\n")
		f.write("Ability: ")
        f.write(PBAbilities.getName(poke.ability))
        f.write("\n")
        f.write("EVs: #{poke.ev[0]} HP / #{poke.ev[1]} Atk / #{poke.ev[2]} Def / #{poke.ev[4]} SpA / #{poke.ev[5]} SpD / #{poke.ev[3]} Spe\n")
        f.write("IVs: #{poke.iv[0]} HP / #{poke.iv[1]} Atk / #{poke.iv[2]} Def / #{poke.iv[4]} SpA / #{poke.iv[5]} SpD / #{poke.iv[3]} Spe\n")
        for move in poke.moves
			if move.id>0
			f.write("- ")
			f.write(PBMoves.getName(move.id))
			f.write("\n")
			end
        end
        f.write("\n")
		f.write("-----------------")
        f.write("\n\n")
    end
    f.close
	
end

def torallopponentsteamtotext
# Exports the entirety of the trainers in a trainer file
# Opens the file
f = File.open("Team Data - Opponents.txt","w")
# Loops around for every single trainer in the game (1135).
	for i in 0..1137
	# Grab the trainer from the list and its data
	trainerchoice=torFakeListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false),i)
	trainerdata=trainerchoice[1]
	# Write down basic information about the trainer, such as the name and number of the trainer.
	f.write("Trainer Info : #{PBTrainers.getName(trainerdata[0])} -  #{trainerdata[1]} - Team #{trainerdata[4]}\n\n")
		for poke in trainerdata[3]
		# Create the actual pokemon to be exported
		opponent=PokeBattle_Trainer.new(trainerdata[1],trainerdata[0])
		species=poke[TPSPECIES]
		level=poke[TPLEVEL]
		pokegift=PokeBattle_Pokemon.new(species,level)
		pokemon=PokeBattle_Pokemon.new(species,level,opponent)
		pokemon=PokeBattle_Pokemon.new(species,level)
		pokemon.form=poke[TPFORM]
		pokemon.resetMoves
		pokemon.setItem(poke[TPITEM])
			if poke[TPMOVE1]>0 || poke[TPMOVE2]>0 || poke[TPMOVE3]>0 || poke[TPMOVE4]>0
			k=0
				for move in [TPMOVE1,TPMOVE2,TPMOVE3,TPMOVE4]
				pokemon.moves[k]=PBMove.new(poke[move])
				k+=1
				end
			end
		pokemon.setAbility(poke[TPABILITY])
		pokemon.setGender(poke[TPGENDER])
			if poke[TPSHINY]   # if this is a shiny Pokémon
			pokemon.makeShiny
			else
			pokemon.makeNotShiny
			end
		pokemon.setNature(poke[TPNATURE])
		iv=poke[TPIV]
			if iv==32
				for i in 0...6
				pokemon.iv[i]=31
				end
			pokemon.iv[3]=0
			else
				for i in 0...6
				pokemon.iv[i]=iv&0x1F
				end
			end
		evsum = poke[TPHPEV].to_i+poke[TPATKEV].to_i+poke[TPDEFEV].to_i+poke[TPSPEEV].to_i+poke[TPSPAEV].to_i+poke[TPSPDEV].to_i
			if evsum>0 
			pokemon.ev=[poke[TPHPEV].to_i,
			poke[TPATKEV].to_i,
			poke[TPDEFEV].to_i,
			poke[TPSPEEV].to_i,
			poke[TPSPAEV].to_i,
			poke[TPSPDEV].to_i]
			elsif evsum == 0
				for i in 0...6
				pokemon.ev[i]=[85,level*3/2].min
				end
			end
		pokemon.calcStats
		#Now the pokemon is created. We export it with the same method as the other one.
		#If the form isn't the base form, gives a warning. Also mentions the typings to easily notice stuff like Kyurems and Necrozmas.
			if pokemon.form!=0
			f.write("WATCH OUT, THIS POKEMON IS NOT IN ITS BASE FORM. ITS TYPING IS #{PBTypes.getName(pokemon.type1)} #{PBTypes.getName(pokemon.type2)}\n")
			end
		f.write(PBSpecies.getName(pokemon.species))
			if pokemon.item!=0
				f.write(" @ ")
				f.write(PBItems.getName(pokemon.item))
			end
		f.write("\n")
		f.write("Level: ")
		f.write(pokemon.poklevel)
		f.write("\n")
		f.write(PBNatures.getName(pokemon.nature))
		f.write(" Nature\n")
		f.write("Ability: ")
		f.write(PBAbilities.getName(pokemon.ability))
		f.write("\n")
		f.write("EVs: #{pokemon.ev[0]} HP / #{pokemon.ev[1]} Atk / #{pokemon.ev[2]} Def / #{pokemon.ev[4]} SpA / #{pokemon.ev[5]} SpD / #{pokemon.ev[3]} Spe\n")
		f.write("IVs: #{pokemon.iv[0]} HP / #{pokemon.iv[1]} Atk / #{pokemon.iv[2]} Def / #{pokemon.iv[4]} SpA / #{pokemon.iv[5]} SpD / #{pokemon.iv[3]} Spe\n")
			for move in pokemon.moves
				if move.id>0
				f.write("- ")
				f.write(PBMoves.getName(move.id))
				f.write("\n")
				end
			end
		f.write("\n")
		f.write("-----------------")
		f.write("\n\n")
		end
	end
f.close
end

def torBoxSorter(boxbeginning,boxend)
	if boxbeginning>boxend
	else
	box11=torBoxToInt(boxbeginning,1)
	box1n=torBoxToInt(boxbeginning,30)
	boxnn=torBoxToInt(boxend,30)
		for i in box11..box1n
		ibox=torIntToBox(i)[0]
		islot=torIntToBox(i)[1]
		wbox=ibox
		wslot=islot
			if $PokemonStorage[ibox-1,islot-1]
			idinitial=$PokemonStorage[ibox-1,islot-1].species
			idminimum=idinitial
			else
			idinitial=999
			idminimum=999
			end
			for j in i..boxnn
			jbox=torIntToBox(j)[0]
			jslot=torIntToBox(j)[1]
				if $PokemonStorage[jbox-1,jslot-1]
				idcurrent=$PokemonStorage[jbox-1,jslot-1].species
				else
				idcurrent=999
				end
				if idcurrent<idminimum
				idminimum=idcurrent
				wbox=jbox
				wslot=jslot
				end
			end
		poke1=$PokemonStorage[ibox-1,islot-1]
		poke2=$PokemonStorage[wbox-1,wslot-1]
		nom1=""
		nom2=""
			if poke1
			nom1=poke1.name
			end
			if poke2
			nom2=poke2.name
			end
			$PokemonStorage[ibox-1,islot-1]=poke2
			$PokemonStorage[wbox-1,wslot-1]=poke1
		end
	torBoxSorter(boxbeginning+1,boxend)
	end

end

def torBoxToInt(box,spot)
return 30*box+spot
end

def torIntToBox(int)
#box 1 is 1 to 30, but slot 1 is 0 (0,0) so watch out, me
retour=[]
retour[0]=int.div(30)
retour[1]=int-30*retour[0]
	if retour[1]==0
	retour[0]=retour[0]-1
	retour[1]=30
	end
return retour 

end

def torFakeListScreen(title,lister,i)
# Code that "simulates" the opening of a debugging trainer list, and instead pre-picks the value according to i.
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  list=pbListWindow([],256)
  list.viewport=viewport
  list.z=2
  title=Window_UnformattedTextPokemon.new(title)
  title.x=256
  title.y=0
  title.width=Graphics.width-256
  title.height=64
  title.viewport=viewport
  title.z=2
  lister.setViewport(viewport)
  selectedmap=-1
  commands=lister.commands
  selindex=lister.startIndex
  if commands.length==0
    value=lister.value(-1)
    lister.dispose
    return value
  end
  list.commands=commands
  list.index=selindex
  value=lister.value(i)
  lister.dispose
  title.dispose
  list.dispose
  Input.update
  return value
end

##MODDED
def pbAddPokemon(pokemon,level=nil,seeform=true,ivedit=false)
  return if !pokemon || !$Trainer 
  if pbBoxesFull?
    Kernel.pbMessage(_INTL("There's no more room for Pokémon!\1"))
    Kernel.pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
    return false
  end
  if pokemon.is_a?(String) || pokemon.is_a?(Symbol)
    pokemon=getID(PBSpecies,pokemon)
  end
  if pokemon.is_a?(Integer) && level.is_a?(Integer)
    pokemon=PokeBattle_Pokemon.new(pokemon,level,$Trainer)
  end
  speciesname=PBSpecies.getName(pokemon.species)
  pokemon.timeReceived=Time.new
  if pokemon.ot == ""
    pokemon.ot = $Trainer.name 
    pokemon.trainerID = $Trainer.id
  end  
  
  if hasConst?(PBItems,:SHINYCHARM) && $PokemonBag.pbQuantity(PBItems::SHINYCHARM)>0
    for i in 0...2   # 3 times as likely (should be 0...2)
      break if pokemon.isShiny?
      pokemon.personalID=rand(65536)|(rand(65536)<<16)
    end
  end 
  if ivedit
	  for i in 0..5
	  pokemon.iv[i]=31
	  end
	  pokemon.setNature(0)
  end
  Kernel.pbMessage(_INTL("{1} obtained {2}!\\se[itemlevel]\1",$Trainer.name,speciesname))
  pbNicknameAndStore(pokemon)
  pbSeenForm(pokemon) if seeform
  return true
end


def pbSetItemQuantitytoValue(itemid,targetvalue)
	if $PokemonBag.pbQuantity(itemid)<targetvalue
	$PokemonBag.pbStoreItem(itemid,targetvalue-$PokemonBag.pbQuantity(itemid))
	elsif $PokemonBag.pbQuantity(itemid)>targetvalue
	$PokemonBag.pbDeleteItem(itemid,$PokemonBag.pbQuantity(itemid)-targetvalue)
	end
end

def torDebugAddLegalItems
#Ciel
if $game_switches[581]
Kernel.pbMessage(_INTL("This might take a few seconds, please hold."))
end
#Basic
pbSetItemQuantitytoValue(PBItems::COMMONCANDY,500)
pbSetItemQuantitytoValue(PBItems::EXPCANDYS,500)
pbSetItemQuantitytoValue(PBItems::MAXREPEL,500)
#Julia
if $game_switches[62]
$PokemonBag.pbStoreItem(PBItems::TM57,1) ; $PokemonBag.pbStoreItem(PBItems::TM60,1) ; 
 $PokemonBag.pbStoreItem(PBItems::TM54,1) ;
end
#Tangrowth 1
if $game_switches[63]
$PokemonBag.pbStoreItem(PBItems::TM42,1) ; $PokemonBag.pbStoreItem(PBItems::TM45,1) ; $PokemonBag.pbStoreItem(PBItems::TM90,1) ; 
 $PokemonBag.pbStoreItem(PBItems::TM63,1) ; 
pbSetItemQuantitytoValue(PBItems::ORANBERRY,500)
pbSetItemQuantitytoValue(PBItems::PECHABERRY,500)
pbSetItemQuantitytoValue(PBItems::ASPEARBERRY,500)
pbSetItemQuantitytoValue(PBItems::CHERIBERRY,500)
pbSetItemQuantitytoValue(PBItems::CHESTOBERRY,500)
pbSetItemQuantitytoValue(PBItems::RAWSTBERRY,500)
pbSetItemQuantitytoValue(PBItems::PERSIMBERRY,500)


end
#Florinia
if $game_switches[64]
$PokemonBag.pbStoreItem(PBItems::TM96,1) ; $PokemonBag.pbStoreItem(PBItems::TM100,1) ; $PokemonBag.pbStoreItem(PBItems::TM20,1) ; 
$PokemonBag.pbStoreItem(PBItems::TM88,1) ; $PokemonBag.pbStoreItem(PBItems::TM77,1) ; 

pbSetItemQuantitytoValue(PBItems::HEATROCK,500) ; pbSetItemQuantitytoValue(PBItems::SMOOTHROCK,500) ; pbSetItemQuantitytoValue(PBItems::ICYROCK,500) ; 
pbSetItemQuantitytoValue(PBItems::DAMPROCK,500) ; pbSetItemQuantitytoValue(PBItems::GRIPCLAW,500) ; pbSetItemQuantitytoValue(PBItems::LIGHTCLAY,500) ; 
pbSetItemQuantitytoValue(PBItems::EVERSTONE,500) ; pbSetItemQuantitytoValue(PBItems::STICKYBARB,500) ; pbSetItemQuantitytoValue(PBItems::LAGGINGTAIL,500) ; 
pbSetItemQuantitytoValue(PBItems::IRONBALL,500) ; pbSetItemQuantitytoValue(PBItems::BINDINGBAND,500) ; pbSetItemQuantitytoValue(PBItems::FLOATSTONE,500) ; 
pbSetItemQuantitytoValue(PBItems::RINGTARGET,500) ; pbSetItemQuantitytoValue(PBItems::REDCARD,500) ; pbSetItemQuantitytoValue(PBItems::EJECTBUTTON,500) ; 
pbSetItemQuantitytoValue(PBItems::METRONOME,500) ; pbSetItemQuantitytoValue(PBItems::BLACKSLUDGE,500) ; 
pbSetItemQuantitytoValue(PBItems::PROTECTIVEPADS,1) ; pbSetItemQuantitytoValue(PBItems::BIGROOT,1) ; 
end
#Corey
if $game_switches[107]
	$PokemonBag.pbStoreItem(PBItems::TM17); $PokemonBag.pbStoreItem(PBItems::TM46); $PokemonBag.pbStoreItem(PBItems::TM56); 
	$PokemonBag.pbStoreItem(PBItems::TM07); $PokemonBag.pbStoreItem(PBItems::TM21); $PokemonBag.pbStoreItem(PBItems::TM41); 
	$PokemonBag.pbStoreItem(PBItems::TM69); 
	pbSetItemQuantitytoValue(PBItems::SMOKEBALL,500) ; pbSetItemQuantitytoValue(PBItems::DESTINYKNOT,500) ; pbSetItemQuantitytoValue(PBItems::AIRBALLOON,500) ; 
	pbSetItemQuantitytoValue(PBItems::WHITEHERB,500) ; pbSetItemQuantitytoValue(PBItems::MENTALHERB,500) ; pbSetItemQuantitytoValue(PBItems::POWERHERB,500) ; 
	pbSetItemQuantitytoValue(PBItems::ABSORBBULB,500) ; pbSetItemQuantitytoValue(PBItems::SNOWBALL,500) ; 
	

end
#Shelly
if $game_switches[134]
	$PokemonBag.pbStoreItem(PBItems::TM76); $PokemonBag.pbStoreItem(PBItems::TM05); $PokemonBag.pbStoreItem(PBItems::TM48); 
	pbSetItemQuantitytoValue(PBItems::DRACOPLATE,500); pbSetItemQuantitytoValue(PBItems::DREADPLATE,500); pbSetItemQuantitytoValue(PBItems::EARTHPLATE,500);
	pbSetItemQuantitytoValue(PBItems::FISTPLATE,500); pbSetItemQuantitytoValue(PBItems::FLAMEPLATE,500); pbSetItemQuantitytoValue(PBItems::ICICLEPLATE,500);
	pbSetItemQuantitytoValue(PBItems::INSECTPLATE,500); pbSetItemQuantitytoValue(PBItems::IRONPLATE,500); pbSetItemQuantitytoValue(PBItems::MEADOWPLATE,500);
	pbSetItemQuantitytoValue(PBItems::MINDPLATE,500); pbSetItemQuantitytoValue(PBItems::SKYPLATE,500); pbSetItemQuantitytoValue(PBItems::SPLASHPLATE,500);
	pbSetItemQuantitytoValue(PBItems::SPOOKYPLATE,500); pbSetItemQuantitytoValue(PBItems::STONEPLATE,500); pbSetItemQuantitytoValue(PBItems::TOXICPLATE,500);
	pbSetItemQuantitytoValue(PBItems::ZAPPLATE,500);  pbSetItemQuantitytoValue(PBItems::PIXIEPLATE,500); pbSetItemQuantitytoValue(PBItems::SILKSCARF,500) ; 
	
	pbSetItemQuantitytoValue(PBItems::HELIXFOSSIL,500);  pbSetItemQuantitytoValue(PBItems::AMPLIFIELDROCK,500); pbSetItemQuantitytoValue(PBItems::LIGHTBALL,1) ; 
	
	
	pbSetItemQuantitytoValue(PBItems::GREENSHARD,500) ; pbSetItemQuantitytoValue(PBItems::REDSHARD,500) ; 
	pbSetItemQuantitytoValue(PBItems::YELLOWSHARD,500) ; pbSetItemQuantitytoValue(PBItems::BLUESHARD,500) ; 
end
#Shade
if $game_switches[139]
	$PokemonBag.pbStoreItem(PBItems::TM65); $PokemonBag.pbStoreItem(PBItems::TM49); 
end
#Muk
if $game_variables[107]>15
	pbSetItemQuantitytoValue(PBItems::FLAMEORB,1) ; pbSetItemQuantitytoValue(PBItems::ZOOMLENS,1) ; 
	
	pbSetItemQuantitytoValue(PBItems::BABIRIBERRY,500); pbSetItemQuantitytoValue(PBItems::HABANBERRY,500); pbSetItemQuantitytoValue(PBItems::RINDOBERRY,500);
	pbSetItemQuantitytoValue(PBItems::CHARTIBERRY,500); pbSetItemQuantitytoValue(PBItems::KASIBBERRY,500); pbSetItemQuantitytoValue(PBItems::ROSELIBERRY,500);
	pbSetItemQuantitytoValue(PBItems::CHILANBERRY,500); pbSetItemQuantitytoValue(PBItems::KEBIABERRY,500); pbSetItemQuantitytoValue(PBItems::SHUCABERRY,500);
	pbSetItemQuantitytoValue(PBItems::CHOPLEBERRY,500); pbSetItemQuantitytoValue(PBItems::OCCABERRY,500); pbSetItemQuantitytoValue(PBItems::TANGABERRY,500);
	pbSetItemQuantitytoValue(PBItems::COBABERRY,500); pbSetItemQuantitytoValue(PBItems::PASSHOBERRY,500); pbSetItemQuantitytoValue(PBItems::WACANBERRY,500);
	pbSetItemQuantitytoValue(PBItems::COLBURBERRY,500); pbSetItemQuantitytoValue(PBItems::PAYAPABERRY,500); pbSetItemQuantitytoValue(PBItems::YACHEBERRY,500);
end
#Kiki
if $game_variables[107]>26
	pbSetItemQuantitytoValue(PBItems::BERRYJUICE,500); 
	$PokemonBag.pbStoreItem(PBItems::TM83); 
end
#Solarchomp
if $game_variables[118]>9
	$PokemonBag.pbStoreItem(PBItems::TM66); $PokemonBag.pbStoreItem(PBItems::TM09);
end
#Aya
if $game_switches[179]
	$PokemonBag.pbStoreItem(PBItems::TM34); $PokemonBag.pbStoreItem(PBItems::TM12); $PokemonBag.pbStoreItem(PBItems::TM37); 
	$PokemonBag.pbStoreItem(PBItems::TM942); $PokemonBag.pbStoreItem(PBItems::TM44); 
end
#Yureyu
if $game_variables[123]>6
	$PokemonBag.pbStoreItem(PBItems::TM32); 
	$PokemonBag.pbStoreItem(PBItems::TM85); 
	
	pbSetItemQuantitytoValue(PBItems::NORMALGEM,500); pbSetItemQuantitytoValue(PBItems::FIREGEM,500); pbSetItemQuantitytoValue(PBItems::WATERGEM,500);
	pbSetItemQuantitytoValue(PBItems::GRASSGEM,500); pbSetItemQuantitytoValue(PBItems::ELECTRICGEM,500); pbSetItemQuantitytoValue(PBItems::FLYINGGEM,500);
	pbSetItemQuantitytoValue(PBItems::GROUNDGEM,500); pbSetItemQuantitytoValue(PBItems::ROCKGEM,500); pbSetItemQuantitytoValue(PBItems::STEELGEM,500);
	pbSetItemQuantitytoValue(PBItems::POISONGEM,500); pbSetItemQuantitytoValue(PBItems::FAIRYGEM,500); pbSetItemQuantitytoValue(PBItems::DRAGONGEM,500);
	pbSetItemQuantitytoValue(PBItems::PSYCHICGEM,500); pbSetItemQuantitytoValue(PBItems::DARKGEM,500); pbSetItemQuantitytoValue(PBItems::FIGHTINGGEM,500);
	pbSetItemQuantitytoValue(PBItems::BUGGEM,500); pbSetItemQuantitytoValue(PBItems::ICEGEM,500); pbSetItemQuantitytoValue(PBItems::GHOSTGEM,500);
end
#Serra
if $game_switches[207]

end
#Noel
if $game_switches[256]
$PokemonBag.pbStoreItem(PBItems::TM10); 
end
#Route 1 Fern
if $game_variables[123]>3
	pbSetItemQuantitytoValue(PBItems::BIGROOT,500); pbSetItemQuantitytoValue(PBItems::FOCUSBAND,500); pbSetItemQuantitytoValue(PBItems::ZOOMLENS,500);
	pbSetItemQuantitytoValue(PBItems::SCOPELENS,500); pbSetItemQuantitytoValue(PBItems::BRIGHTPOWDER,500); pbSetItemQuantitytoValue(PBItems::QUICKCLAW,500);
	pbSetItemQuantitytoValue(PBItems::TOXICORB,1);
	pbSetItemQuantitytoValue(PBItems::CUSTAPBERRY,500); pbSetItemQuantitytoValue(PBItems::LUMBERRY,500); pbSetItemQuantitytoValue(PBItems::SITRUSBERRY,500);
	pbSetItemQuantitytoValue(PBItems::WIDELENS,1); 
	$PokemonBag.pbStoreItem(PBItems::TM40); $PokemonBag.pbStoreItem(PBItems::TM51); 
	$PokemonBag.pbStoreItem(PBItems::TM86); $PokemonBag.pbStoreItem(PBItems::TM23);
	
end
#Radomus
if $game_switches[283]
end
#7th access
if $game_variables[123]>3
	$PokemonBag.pbStoreItem(PBItems::TM11); $PokemonBag.pbStoreItem(PBItems::TM18); $PokemonBag.pbStoreItem(PBItems::TM64); 
	pbSetItemQuantitytoValue(PBItems::FLOATSTONE,500); pbSetItemQuantitytoValue(PBItems::ADRENALINEORB,500); pbSetItemQuantitytoValue(PBItems::EJECTBUTTON,500); 
end
#Luna
if $game_switches[422]
	pbSetItemQuantitytoValue(PBItems::EVIOLITE,500); pbSetItemQuantitytoValue(PBItems::SHELLBELL,2); 
	$PokemonBag.pbStoreItem(PBItems::TM87);$PokemonBag.pbStoreItem(PBItems::TM58);
end
#Samson
if $game_switches[460]
$PokemonBag.pbStoreItem(PBItems::TM39); $PokemonBag.pbStoreItem(PBItems::TM43); 
end
#Charlotte
if $game_switches[499]
$PokemonBag.pbStoreItem(PBItems::TM79); $PokemonBag.pbStoreItem(PBItems::TM95); $PokemonBag.pbStoreItem(PBItems::TM82); 
end
#Blake
if $game_variables[193]>29
end
#Terra
if $game_switches[520]
	$PokemonBag.pbStoreItem(PBItems::TM01); $PokemonBag.pbStoreItem(PBItems::TM03); 
	$PokemonBag.pbStoreItem(PBItems::TM47); $PokemonBag.pbStoreItem(PBItems::TM74); $PokemonBag.pbStoreItem(PBItems::TM93); 
	$PokemonBag.pbStoreItem(PBItems::TM67); 
end
#WTC
if $game_variables[276]>25
end
#Ciel
if $game_switches[581]

	$PokemonBag.pbStoreItem(PBItems::TM62); $PokemonBag.pbStoreItem(PBItems::TM06); $PokemonBag.pbStoreItem(PBItems::TM22); 
	$PokemonBag.pbStoreItem(PBItems::TM27); $PokemonBag.pbStoreItem(PBItems::TM30); 
	$PokemonBag.pbStoreItem(PBItems::TM50); $PokemonBag.pbStoreItem(PBItems::TM61); $PokemonBag.pbStoreItem(PBItems::TM68); 
	 $PokemonBag.pbStoreItem(PBItems::TM89); $PokemonBag.pbStoreItem(PBItems::TM59); 
	$PokemonBag.pbStoreItem(PBItems::TM16); $PokemonBag.pbStoreItem(PBItems::TM98); 
	
	pbSetItemQuantitytoValue(PBItems::PPUP,500); pbSetItemQuantitytoValue(PBItems::PPALL,500); 
	pbSetItemQuantitytoValue(PBItems::TELLURICSEED,500) ; pbSetItemQuantitytoValue(PBItems::MAGICALSEED,500) ; 
	pbSetItemQuantitytoValue(PBItems::SYNTHETICSEED,500) ; pbSetItemQuantitytoValue(PBItems::ELEMENTALSEED,500) ; 

	pbSetItemQuantitytoValue(PBItems::LIECHIBERRY,500); pbSetItemQuantitytoValue(PBItems::PETAYABERRY,500); pbSetItemQuantitytoValue(PBItems::SALACBERRY,500);
	pbSetItemQuantitytoValue(PBItems::GANLONBERRY,500); pbSetItemQuantitytoValue(PBItems::APICOTBERRY,500); pbSetItemQuantitytoValue(PBItems::LANSATBERRY,500);
	pbSetItemQuantitytoValue(PBItems::IAPAPABERRY,500); pbSetItemQuantitytoValue(PBItems::MAGOBERRY,500); pbSetItemQuantitytoValue(PBItems::WIKIBERRY,500);
	pbSetItemQuantitytoValue(PBItems::AGUAVBERRY,500); pbSetItemQuantitytoValue(PBItems::FIGYBERRY,500); 
	pbSetItemQuantitytoValue(PBItems::KEEBERRY,500); pbSetItemQuantitytoValue(PBItems::MARANGABERRY,500); pbSetItemQuantitytoValue(PBItems::JABOCABERRY,500);
	pbSetItemQuantitytoValue(PBItems::ROWAPBERRY,500); 
	
	
	pbSetItemQuantitytoValue(PBItems::KINGSROCK,500); 
	pbSetItemQuantitytoValue(PBItems::LEFTOVERS,2); 

end
#Devon
if $game_variables[339]>38
$PokemonBag.pbStoreItem(PBItems::TM81); $PokemonBag.pbStoreItem(PBItems::TM33); 
	pbSetItemQuantitytoValue(PBItems::WISEGLASSES,1); 
end
#Adrienn
if $game_switches[651]
	$PokemonBag.pbStoreItem(PBItems::TM72); 
	$PokemonBag.pbStoreItem(PBItems::TM71); $PokemonBag.pbStoreItem(PBItems::TM36); $PokemonBag.pbStoreItem(PBItems::TM04); 
	$PokemonBag.pbStoreItem(PBItems::TM08); $PokemonBag.pbStoreItem(PBItems::TM75); $PokemonBag.pbStoreItem(PBItems::TM19); 
end
#Titania
if $game_switches[656]
end
#Amaria
if $game_switches[657]
	pbSetItemQuantitytoValue(PBItems::LIFEORB,2); pbSetItemQuantitytoValue(PBItems::CHOICEBAND,1); pbSetItemQuantitytoValue(PBItems::CHOICESPECS,1);
	pbSetItemQuantitytoValue(PBItems::ROCKYHELMET,1); pbSetItemQuantitytoValue(PBItems::ASSAULTVEST,1);  
	$PokemonBag.pbStoreItem(PBItems::TM84); $PokemonBag.pbStoreItem(PBItems::TM28); $PokemonBag.pbStoreItem(PBItems::TM52); 
	$PokemonBag.pbStoreItem(PBItems::TM53); $PokemonBag.pbStoreItem(PBItems::TM73); $PokemonBag.pbStoreItem(PBItems::TM29); 
end
#Glass (before gauntlet)
if $game_variables[391]>22
	 $PokemonBag.pbStoreItem(PBItems::TM24);
end
#Agate Solaris
if $game_variables[391]>53

	pbSetItemQuantitytoValue(PBItems::KINGSROCK,500); pbSetItemQuantitytoValue(PBItems::SAFETYGOGGLES,500); pbSetItemQuantitytoValue(PBItems::WIDELENS,500);
	pbSetItemQuantitytoValue(PBItems::WISEGLASSES,500); pbSetItemQuantitytoValue(PBItems::MUSCLEBAND,500); pbSetItemQuantitytoValue(PBItems::FLAMEORB,500);
	pbSetItemQuantitytoValue(PBItems::TOXICORB,500); 
	pbSetItemQuantitytoValue(PBItems::EXPERTBELT,500); 
	pbSetItemQuantitytoValue(PBItems::SHEDSHELL,500); 
	
	
	$PokemonBag.pbStoreItem(PBItems::TM13); $PokemonBag.pbStoreItem(PBItems::TM26); 
end
#Hardy
if $game_switches[658]
end
#Zero
if $game_switches[1052]
	pbSetItemQuantitytoValue(PBItems::LIFEORB,500); pbSetItemQuantitytoValue(PBItems::FOCUSSASH,500); pbSetItemQuantitytoValue(PBItems::LEPPABERRY,500); 
	pbSetItemQuantitytoValue(PBItems::WEAKNESSPOLICY,500); 
	$PokemonBag.pbStoreItem(PBItems::TM14); $PokemonBag.pbStoreItem(PBItems::TM25); $PokemonBag.pbStoreItem(PBItems::TM38); 
end
#Saphira / Fontless
if $game_variables[475]>108
end
#VR
if $game_variables[475]>144
	pbSetItemQuantitytoValue(PBItems::CHOICEBAND,2); pbSetItemQuantitytoValue(PBItems::CHOICESPECS,2);
	pbSetItemQuantitytoValue(PBItems::CHOICESCARF,2); pbSetItemQuantitytoValue(PBItems::ASSAULTVEST,2);  
end
#Pokeleague
if $game_switches[1305]
	$PokemonBag.pbStoreItem(PBItems::TM15); 
	pbSetItemQuantitytoValue(PBItems::CHOICEBAND,500); pbSetItemQuantitytoValue(PBItems::CHOICESPECS,500);
	pbSetItemQuantitytoValue(PBItems::CHOICESCARF,500);
end
end