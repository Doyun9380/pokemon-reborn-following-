class PokemonOptions
  #####MODDED
  attr_accessor :amb_showDebugMenu
  
  def amb_showDebugMenu
	  @amb_showDebugMenu = 0 if !@amb_showDebugMenu
	  return @amb_showDebugMenu
  end
  #####/MODDED
end

#####MODDED
#Make sure it exists
$amb_addOpt_Options={} if !defined?($amb_addOpt_Options)

#Record the new option
$amb_addOpt_Options["Show Debug Menu"] = EnumOption.new(_INTL("Show Debug Menu"),[_INTL("Off"),_INTL("Pause"),_INTL("Pkmn"),_INTL("Both")],
                                                 proc { $idk[:settings].amb_showDebugMenu },
                                                 proc {|value|  $idk[:settings].amb_showDebugMenu=value },
                                                 "Grants access to the debug menu in the pause menu, pokémon menu, or both."
                                               )
#####/MODDED

class PokemonMenu
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
    #####MODDED
    commands[cmdDebug=commands.length]=_INTL("Debug") if $DEBUG || (defined?($idk[:settings].amb_showDebugMenu) && $idk[:settings].amb_showDebugMenu % 2 == 1)
    #####/MODDED
    commands[cmdEndGame=commands.length]=_INTL("Quit Game")
    $game_screen.getTimeCurrent(true)
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

class PokemonStorageScreen
  def pbStartScreen(command)
    @heldpkmn=nil
    if command==2
### WITHDRAW ###################################################################
      @scene.pbStartBox(self,command)
      loop do
        selected=@scene.pbSelectBox(@storage.party)
        if selected && selected[0]==-3 # Close box
          if pbConfirm(_INTL("Exit from the Box?"))
            break
          else
            next
          end
        end
        if selected && selected[0]==-2 # Party Pokémon
          pbDisplay(_INTL("Which one will you take?"))
          next
        end
        if selected && selected[0]==-4 # Box name
          pbBoxCommands
          next
        end
        if selected==nil
          if pbConfirm(_INTL("Continue Box operations?"))
            next
          else
            break
          end
        else
          pokemon=@storage[selected[0],selected[1]]
          next if !pokemon
          command=pbShowCommands(
            _INTL("{1} is selected.",pokemon.name),[_INTL("Withdraw"),
            _INTL("Summary"),_INTL("Mark"),_INTL("Release"),_INTL("Cancel")])
          case command
          when 0 then pbWithdraw(selected,nil)
          when 1 then pbSummary(selected,nil)
          when 2 then pbMark(selected,nil)
          when 3 then pbRelease(selected,nil)
          end
        end
      end
      @scene.pbCloseBox
    elsif command==1
### DEPOSIT ####################################################################
      @scene.pbStartBox(self,command)
      loop do
        selected=@scene.pbSelectParty(@storage.party)
        if selected==-3 # Close box
          if pbConfirm(_INTL("Exit from the Box?"))
            break
          else
            next
          end
        end
        if selected<0
          if pbConfirm(_INTL("Continue Box operations?"))
            next
          else
            break
          end
        else
          pokemon=@storage[-1,selected]
          next if !pokemon
          command=pbShowCommands(
             _INTL("{1} is selected.",pokemon.name),[_INTL("Store"),
             _INTL("Summary"),_INTL("Mark"),_INTL("Release"),_INTL("Cancel")])
          case command
            when 0 # Store
              pbStore([-1,selected],nil)
            when 1 # Summary
              pbSummary([-1,selected],nil)
            when 2 # Mark
              pbMark([-1,selected],nil)
            when 3 # Release
              pbRelease([-1,selected],nil)
          end
        end
      end
      @scene.pbCloseBox
    elsif command==0
### MOVE #######################################################################
      @scene.pbStartBox(self,command)
      loop do
        selected=@scene.pbSelectBox(@storage.party)
        if selected && selected[0]==-3 # Close box
          if pbHeldPokemon
            pbDisplay(_INTL("You're holding a Pokémon!"))
            next
          end
          if pbConfirm(_INTL("Exit from the Box?"))
            break
          else
            next
          end
        end
        if selected==nil
          if pbHeldPokemon
            pbDisplay(_INTL("You're holding a Pokémon!"))
            next
          end
          if pbConfirm(_INTL("Continue Box operations?"))
            next
          else
            break
          end
        elsif selected[0]==-4 # Box name
          pbBoxCommands
        elsif selected[0]==-2 && selected[1]==-1
          next
        elsif Input.press?(Input::CTRL) && !@heldpkmn
          pokemon=@storage[selected[0],selected[1]]
          heldpoke=pbHeldPokemon
          next if !pokemon && !heldpoke
          pbHold(selected,true)
        else
          pokemon=@storage[selected[0],selected[1]]
          heldpoke=pbHeldPokemon
          next if !pokemon && !heldpoke
          if @scene.quickswap
            if @heldpkmn
              (pokemon) ? pbSwap(selected) : pbPlace(selected)
            else
              pbHold(selected)
            end
          else
            #####MODDED
            commands=[
              _INTL("Move"),
              _INTL("Summary"),
              _INTL("Multi-Move"),
              _INTL("Withdraw"),
              _INTL("Item"),
              _INTL("Mark"),
              _INTL("Release")
            ]
            commands.push(_INTL("Debug")) if $DEBUG || (defined?($idk[:settings].amb_showDebugMenu) && $idk[:settings].amb_showDebugMenu > 1)
            commands.push(_INTL("Cancel"))
            #####/MODDED
            
            if heldpoke
              helptext=_INTL("{1} is selected.",heldpoke.name)
              commands[0]=pokemon ? _INTL("Shift") : _INTL("Place")
            elsif pokemon
              helptext=_INTL("{1} is selected.",pokemon.name)
              commands[0]=_INTL("Move")
            else
              next
            end
            if selected[0]==-1
              commands[3]=_INTL("Store")
            else
              commands[3]=_INTL("Withdraw")
            end
            command=pbShowCommands(helptext,commands)
            case command
            when 0 # Move/Shift/Place
              if @heldpkmn && pokemon
                pbSwap(selected)
              elsif @heldpkmn
                pbPlace(selected)
              else
                pbHold(selected)
              end
            when 1 # Summary
              pbSummary(selected,@heldpkmn)
            when 2 # Multi-Move
              if selected[0] >=0 && !@heldpkmn
                pbHold(selected,true)
              elsif @heldpkmn
                Kernel.pbMessage("Can't Multi-Move while holding a Pokémon.")
              else
                Kernel.pbMessage("Can't Multi-Move a Pokémon from your party.")
              end
            when 3 # Withdraw
              if selected[0]==-1
                pbStore(selected,@heldpkmn)
              else
                pbWithdraw(selected,@heldpkmn)
              end
            when 4 # Item
              pbItem(selected,@heldpkmn)
            when 5 # Mark
              pbMark(selected,@heldpkmn)
            when 6 # Release
              pbRelease(selected,@heldpkmn)
            when 7
              #####MODDED
              if $DEBUG || (defined?($idk[:settings].amb_showDebugMenu) && $idk[:settings].amb_showDebugMenu > 1)
                pkmn=@heldpkmn ? @heldpkmn : pokemon
                debugMenu(selected,pkmn,heldpoke)
              end
            when 8
              #####/MODDED
            end
          end
        end
      end
      @scene.pbCloseBox
    elsif command==3
      @scene.pbStartBox(self,command)
      @scene.pbCloseBox
    end
  end
end

def pbDebugMenu
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  sprites={}
  commands=CommandList.new
  commands.add("switches",_INTL("Switches"))
  commands.add("variables",_INTL("Variables"))
  commands.add("refreshmap",_INTL("Refresh Map"))
  commands.add("warp",_INTL("Warp to Map (press A for map id)"))
  commands.add("healparty",_INTL("Heal Party"))
  commands.add("additem",_INTL("Add Item"))
  commands.add("clearbag",_INTL("Empty Bag"))
  commands.add("addpokemon",_INTL("Add Pokémon"))
  commands.add("teamyeet",_INTL("Export team to text"))
  commands.add("setplayer",_INTL("Set Player Character"))
  commands.add("renameplayer",_INTL("Rename Player"))
  commands.add("usepc",_INTL("Use PC"))
  commands.add("randomid",_INTL("Randomise Player's ID"))
  commands.add("changeoutfit",_INTL("Change Player Outfit"))
  commands.add("setmoney",_INTL("Set Money"))
  commands.add("setcoins",_INTL("Set Coins"))
  commands.add("setbadges",_INTL("Set Badges"))
  commands.add("toggleshoes",_INTL("Toggle Running Shoes Ownership"))
  commands.add("togglepokegear",_INTL("Toggle Pokégear Ownership"))
  commands.add("togglepokedex",_INTL("Toggle Pokédex Ownership"))
  commands.add("dexlists",_INTL("Dex List Accessibility"))
  commands.add("daycare",_INTL("Day Care Options..."))
  commands.add("quickhatch",_INTL("Quick Hatch"))
  commands.add("roamerstatus",_INTL("Roaming Pokémon Status"))
  commands.add("roam",_INTL("Advance Roaming"))
  commands.add("terraintags",_INTL("Set Terrain Tags"))
  commands.add("testwildbattle",_INTL("Test Wild Battle"))
  commands.add("testdoublewildbattle",_INTL("Test Double Wild Battle"))
  commands.add("testtrainerbattle",_INTL("Test Trainer Battle"))
  commands.add("testdoubletrainerbattle",_INTL("Test Double Trainer Battle"))
  commands.add("relicstone",_INTL("Relic Stone"))
  commands.add("purifychamber",_INTL("Purify Chamber"))
  commands.add("extracttext",_INTL("Extract Text"))
  commands.add("compiletext",_INTL("Compile Text"))
  commands.add("compiletrainers", _INTL("Compile Trainers"))
  commands.add("compiledata",_INTL("Compile All Data"))
  commands.add("mapconnections",_INTL("Map Connections"))
  commands.add("animeditor",_INTL("Animation Editor"))
  commands.add("togglelogging",_INTL("Toggle Battle Logging"))
  commands.add("debugbattle",_INTL("Battle The Debug Trainer"))
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
      $game_map.need_refresh = true
      Kernel.pbMessage(_INTL("The map will refresh."))
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
      for i in $Trainer.party
        i.heal
      end
      Kernel.pbMessage(_INTL("Your Pokémon were healed."))
    elsif cmd=="additem"
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
    elsif cmd=="clearbag"
      $PokemonBag.clear
      Kernel.pbMessage(_INTL("The Bag was cleared."))
    elsif cmd=="addpokemon"
      species=pbChooseSpeciesOrdered(1)
      if species!=0
        params=ChooseNumberParams.new
        params.setRange(1,PBExperience::MAXLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level=Kernel.pbMessageChooseNumber(
           _INTL("Set the Pokémon's level."),params)
        if level>0
          pbAddPokemon(species,level)
        end
      end
    elsif cmd=="usepc"
      pbPokeCenterPC
    elsif cmd=="teamyeet"
      teamtotext
    elsif cmd=="setplayer"
      limit=0
      for i in 0...8
        meta=pbGetMetadata(0,MetadataPlayerA+i)
        if !meta
          limit=i
          break
        end
      end
      if limit<=1
        Kernel.pbMessage(_INTL("There is only one player defined."))
      else
        params=ChooseNumberParams.new
        params.setRange(0,23)
        params.setDefaultValue($PokemonGlobal.playerID)
        newid=Kernel.pbMessageChooseNumber(
           _INTL("Choose the new player character."),params)
        if newid!=$PokemonGlobal.playerID
          pbChangePlayer(newid)
          Kernel.pbMessage(_INTL("The player character was changed."))
        end
      end
    elsif cmd=="renameplayer"
      trname=pbEnterPlayerName("Your name?",0,12,$Trainer.name)
      if trname==""
        trainertype=pbGetPlayerTrainerType
        gender=pbGetTrainerTypeGender(trainertype) 
        trname=pbSuggestTrainerName(gender)
      end
      $Trainer.name=trname
      Kernel.pbMessage(_INTL("The player's name was changed to {1}.",$Trainer.name))
    elsif cmd=="randomid"
      $Trainer.id=rand(256)
      $Trainer.id|=rand(256)<<8
      $Trainer.id|=rand(256)<<16
      $Trainer.id|=rand(256)<<24
      Kernel.pbMessage(_INTL("The player's ID was changed to {1} (2).",$Trainer.publicID,$Trainer.id))
    elsif cmd=="changeoutfit"
      oldoutfit=$Trainer.outfit
      params=ChooseNumberParams.new
      params.setRange(0,99)
      params.setDefaultValue(oldoutfit)
      $Trainer.outfit=Kernel.pbMessageChooseNumber(_INTL("Set the player's outfit."),params)
      Kernel.pbMessage(_INTL("Player's outfit was changed.")) if $Trainer.outfit!=oldoutfit
    elsif cmd=="setmoney"
      params=ChooseNumberParams.new
      params.setMaxDigits(6)
      params.setDefaultValue($Trainer.money)
      $Trainer.money=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's money."),params)
      Kernel.pbMessage(_INTL("You now have ${1}.",$Trainer.money))
    elsif cmd=="setcoins"
      params=ChooseNumberParams.new
      params.setRange(0,MAXCOINS)
      params.setDefaultValue($PokemonGlobal.coins)
      $PokemonGlobal.coins=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's Coin amount."),params)
      Kernel.pbMessage(_INTL("You now have {1} Coins.",$PokemonGlobal.coins))
    elsif cmd=="setbadges"
      badgecmd=0
      loop do
        badgecmds=[]
        for i in 0...32
          badgecmds.push(_INTL("{1} Badge {2}",$Trainer.badges[i] ? "[Y]" : "[  ]",i+1))
        end
        badgecmd=Kernel.pbShowCommands(nil,badgecmds,-1,badgecmd)
        break if badgecmd<0
        $Trainer.badges[badgecmd]=!$Trainer.badges[badgecmd]
      end
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
      dexescmd=0
      loop do
        dexescmds=[]
        d=pbDexNames
        for i in 0...d.length
          name=d[i]
          name=name[0] if name.is_a?(Array)
          dexindex=i
          unlocked=$PokemonGlobal.pokedexUnlocked[dexindex]
          dexescmds.push(_INTL("{1} {2}",unlocked ? "[Y]" : "[  ]",name))
        end
        dexescmd=Kernel.pbShowCommands(nil,dexescmds,-1,dexescmd)
        break if dexescmd<0
        dexindex=dexescmd
        if $PokemonGlobal.pokedexUnlocked[dexindex]
          pbLockDex(dexindex)
        else
          pbUnlockDex(dexindex)
        end
      end
    elsif cmd=="daycare"
      daycarecmd=0
      loop do
        daycarecmds=[
           _INTL("Summary"),
           _INTL("Deposit Pokémon"),
           _INTL("Withdraw Pokémon"),
           _INTL("Generate egg"),
           _INTL("Collect egg"),
           #####MODDED
           _INTL("Dispose egg"),
           _INTL("Generate & collect egg")
           #####/MODDED
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
            #####MODDED
            #elsif $Trainer.party.length>=6
              #Kernel.pbMessage(_INTL("Party is full, can't collect the egg."))
            #####/MODDED
            else
              pbDayCareGenerateEgg
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              #####MODDED
              #Kernel.pbMessage(_INTL("Collected the {1} egg.",
                 #PBSpecies.getName($Trainer.party[$Trainer.party.length-1].species)))
              Kernel.pbMessage(_INTL("Collected the egg."))
              #####/MODDED
            end
          when 5 # Dispose egg
            if $PokemonGlobal.daycareEgg!=1
              Kernel.pbMessage(_INTL("There is no egg available."))
            else
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Disposed of the egg."))
            end
          #####MODDED
          when 6
            if pbDayCareDeposited!=2
              Kernel.pbMessage(_INTL("There aren't 2 Pokémon in the Day Care."))
            elsif pbDayCareGetCompat==0
              Kernel.pbMessage(_INTL("The Pokémon in the Day Care can't breed."))
            else
              pbDayCareGenerateEgg
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Collected the egg."))
            end
          #####/MODDED
        end
      end
    elsif cmd=="quickhatch"
      for pokemon in $Trainer.party
        pokemon.eggsteps=1 if pokemon.isEgg?
      end
      Kernel.pbMessage(_INTL("All eggs on your party now require one step to hatch."))
    elsif cmd=="roamerstatus"
      if RoamingSpecies.length==0
        Kernel.pbMessage(_INTL("No roaming Pokémon defined."))
      else
        text="\\l[8]"
        for i in 0...RoamingSpecies.length
          poke=RoamingSpecies[i]
          if $game_switches[poke[:switch]]
            status=$PokemonGlobal.roamPokemon[i]
            if status==true
              if $PokemonGlobal.roamPokemonCaught[i]
                text+=_INTL("{1} (Lv.{2}) caught.",
                   PBSpecies.getName(getID(PBSpecies,poke[:species])),poke[:level])
              else
                text+=_INTL("{1} (Lv.{2}) defeated.",
                   PBSpecies.getName(getID(PBSpecies,poke[:species])),poke[:level])
              end
            else
              curmap=$PokemonGlobal.roamPosition[i]
              if curmap
                $cache.mapinfos
                text+=_INTL("{1} (Lv.{2}) roaming on map {3} ({4}){5}",
                   PBSpecies.getName(getID(PBSpecies,poke[:species])),poke[:level],curmap,
                   $cache.mapinfos[curmap].name,(curmap==$game_map.map_id) ? _INTL("(this map)") : "")
              else
                text+=_INTL("{1} (Lv.{2}) roaming (map not set).",
                   PBSpecies.getName(getID(PBSpecies,poke[:species])),poke[:level])
              end
            end
          else
            text+=_INTL("{1} (Lv.{2}) not roaming (switch {3} is off).",
               PBSpecies.getName(getID(PBSpecies,poke[:species])),poke[:level],poke[:switch])
          end
          text+="\n" if i<RoamingSpecies.length-1
        end
        Kernel.pbMessage(text)
      end
    elsif cmd=="roam"
      if RoamingSpecies.length==0
        Kernel.pbMessage(_INTL("No roaming Pokémon defined."))
      else
        pbRoamPokemon(true)
        #$PokemonGlobal.roamedAlready=false
        Kernel.pbMessage(_INTL("Pokémon have roamed."))
      end
    elsif cmd=="terraintags"
      pbFadeOutIn(99999) { pbTilesetScreen }
    elsif cmd=="testwildbattle"
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
    elsif cmd=="testdoublewildbattle"
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
    elsif cmd=="testtrainerbattle"
      battle=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
      if battle
        trainerdata=battle[1]
        pbTrainerBattle(trainerdata[0],trainerdata[1],"...",false,trainerdata[4],true)
      end
    elsif cmd=="testdoubletrainerbattle"
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
    elsif cmd=="relicstone"
      pbRelicStone()
    elsif cmd=="purifychamber"
      pbPurifyChamber()
    elsif cmd=="extracttext"
      pbExtractText
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
      msgwindow=Kernel.pbCreateMessageWindow;pbCompileAllData(true) {|msg| Kernel.pbMessageDisplay(msgwindow,msg,false) }
      Kernel.pbMessageDisplay(msgwindow,_INTL("All game data was compiled."))
      Kernel.pbDisposeMessageWindow(msgwindow)
    elsif cmd=="mapconnections"
      pbFadeOutIn(99999) { pbEditorScreen }
    elsif cmd=="animeditor"
      pbFadeOutIn(99999) { pbAnimationEditor }
    elsif cmd=="togglelogging"
      $INTERNAL=!$INTERNAL
      Kernel.pbMessage(_INTL("Debug logs for battles will be made in the Data folder.")) if $INTERNAL
      Kernel.pbMessage(_INTL("Debug logs for battles will not be made.")) if !$INTERNAL
    elsif cmd=="debugbattle"
      begin
        pbDebugTestBattle
      rescue
        pbPrintException($!)
      end
    end
  end
  pbFadeOutAndHide(sprites)
  pbDisposeSpriteHash(sprites)
  viewport.dispose
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

amb_checkDependencies("AMB - AddOpt_DebugMenu", ["AMB - AddOpt.rb"])
#####/MODDED