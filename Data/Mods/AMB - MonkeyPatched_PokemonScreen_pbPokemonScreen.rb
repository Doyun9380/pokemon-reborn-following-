##### This file is needed by AddOpt_DebugMenu and Misc_RelearnRework.

class PokemonScreen
  def pbPokemonScreen
    @scene.pbStartScene(@party,
       @party.length>1 ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."),nil)
    loop do
      @scene.pbSetHelpText(
         @party.length>1 ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."))
      pkmnid=@scene.pbChoosePokemon(false,true)
      if pkmnid.is_a?(Array) && pkmnid[0]==1  # Switch
        @scene.pbSetHelpText(_INTL("Move to where?"))
        oldpkmnid = pkmnid[1]
        pkmnid = @scene.pbChoosePokemon(true,true,1)
        if pkmnid>=0 && pkmnid!=oldpkmnid
          pbSwitch(oldpkmnid,pkmnid)
        end
        next
      end
      if pkmnid<0
        break
      end
      pkmn=@party[pkmnid]
      commands=[]
      cmdSummary=-1
      cmdSwitch=-1
      cmdItem=-1
      cmdDebug=-1
      cmdMail=-1
      cmdRename=-1
      #####MODDED
      cmdRetrain=-1
      #####/MODDED
      # Build the commands
      commands[cmdSummary=commands.length]=_INTL("Summary")
      #####MODDED
      if defined?(pkmn.amb_learntEggMoves) && pbHasRelearnableMove?(pkmn,true,true)
        commands[cmdRetrain=commands.length]=_INTL("Retrain")
      end
      #####/MODDED
      if $game_switches[:EasyHMs_Password] && !pkmn.isEgg?
        acmdTMX=-1
        commands[acmdTMX=commands.length]=_INTL("Use TMX")
      end
      cmdMoves=[-1,-1,-1,-1]
      for i in 0...pkmn.moves.length
        move=pkmn.moves[i]
        # Check for hidden moves and add any that were found
        if !pkmn.isEgg? && (
           (move.id == PBMoves::MILKDRINK) ||
           (move.id == PBMoves::SOFTBOILED) ||
           HiddenMoveHandlers.hasHandler(move.id)
           )
          commands[cmdMoves[i]=commands.length]=PBMoves.getName(move.id)
        end
      end
      commands[cmdSwitch=commands.length]=_INTL("Switch") if @party.length>1
      if !pkmn.isEgg?
        if pkmn.mail
          commands[cmdMail=commands.length]=_INTL("Mail")
        else
          commands[cmdItem=commands.length]=_INTL("Item")
        end
        commands[cmdRename = commands.length] = _INTL("Rename")
      end
      #####MODDED
      if $DEBUG || (defined?($idk[:settings].amb_showDebugMenu) && $idk[:settings].amb_showDebugMenu > 1)
        # Commands for debug mode only
        commands[cmdDebug=commands.length]=_INTL("Debug")
      end
      #####/MODDED
      commands[commands.length]=_INTL("Cancel")
      command=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),commands)
      havecommand=false
      for i in 0...4
        if cmdMoves[i]>=0 && command==cmdMoves[i]
          havecommand=true
          if isConst?(pkmn.moves[i].id,PBMoves,:SOFTBOILED) ||
             isConst?(pkmn.moves[i].id,PBMoves,:MILKDRINK)
            if pkmn.hp<=(pkmn.totalhp/5.0).floor
              pbDisplay(_INTL("Not enough HP..."))
              break
            end
            @scene.pbSetHelpText(_INTL("Use on which Pokémon?"))
            oldpkmnid=pkmnid
            loop do
              @scene.pbPreSelect(oldpkmnid)
              pkmnid=@scene.pbChoosePokemon(true)
              break if pkmnid<0
              newpkmn=@party[pkmnid]
              if newpkmn.isEgg? || newpkmn.hp==0 || newpkmn.hp==newpkmn.totalhp || pkmnid==oldpkmnid
                pbDisplay(_INTL("This item can't be used on that Pokémon."))
              else
                pkmn.hp-=(pkmn.totalhp/5.0).floor
                hpgain=pbItemRestoreHP(newpkmn,(pkmn.totalhp/5.0).floor)
                @scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.",newpkmn.name,hpgain))
                pbRefresh
              end
            end
            break
          elsif Kernel.pbCanUseHiddenMove?(pkmn,pkmn.moves[i].id)
            @scene.pbEndScene
            if isConst?(pkmn.moves[i].id,PBMoves,:FLY)
              scene=PokemonRegionMapScene.new(-1,false)
              screen=PokemonRegionMap.new(scene)
              ret=screen.pbStartFlyScreen
              if ret
                $PokemonTemp.flydata=ret
                $game_system.bgs_stop
                $game_screen.weather(0,0,0)
                return [pkmn,pkmn.moves[i].id]
              end
              @scene.pbStartScene(@party,
                 @party.length>1 ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."))
              break
            end
            return [pkmn,pkmn.moves[i].id]
          else
            break
          end
        end
      end
      if $game_switches[:EasyHMs_Password] && !pkmn.isEgg?
        if acmdTMX>=0 && command==acmdTMX
          aRetArr = passwordUseTMX(pkmn)
          if aRetArr.length > 0
            havecommand=true
            return aRetArr
          end
        end
      end
      next if havecommand
      if cmdSummary>=0 && command==cmdSummary
        @scene.pbSummary(pkmnid)
      elsif cmdSwitch>=0 && command==cmdSwitch
        @scene.pbSetHelpText(_INTL("Move to where?"))
        oldpkmnid=pkmnid
        pkmnid=@scene.pbChoosePokemon(true)
        if pkmnid>=0 && pkmnid!=oldpkmnid
          pbSwitch(oldpkmnid,pkmnid)
        end
      elsif cmdDebug>=0 && command==cmdDebug
        pbPokemonDebug(pkmn,pkmnid)
      elsif cmdMail>=0 && command==cmdMail
        command=@scene.pbShowCommands(_INTL("Do what with the mail?"),[_INTL("Read"),_INTL("Take"),_INTL("Cancel")])
        case command
          when 0 # Read
            pbFadeOutIn(99999){
               pbDisplayMail(pkmn.mail,pkmn)
            }
          when 1 # Take
            pbTakeMail(pkmn)
            pbRefreshSingle(pkmnid)
        end
      elsif cmdItem>=0 && command==cmdItem
        command=@scene.pbShowCommands(_INTL("Do what with an item?"),[_INTL("Use"),_INTL("Give"),_INTL("Take"),_INTL("Cancel")])
        case command
          when 0 # Use
          item=@scene.pbChooseItem($PokemonBag,from_bag: true)
          if item>0
            pbUseItemOnPokemon(item,pkmn,self)
            pbRefreshSingle(pkmnid)
          end            
          when 1 # Give
            item=@scene.pbChooseItem($PokemonBag,from_bag: true)
            if item>0
              if pbIsZCrystal2?(item)
                pbUseItemOnPokemon(item,pkmn,self)
              else
                pbGiveMail(item,pkmn,pkmnid)
              end
              pbRefreshSingle(pkmnid)
            end
          when 2 # Take
            pbTakeMail(pkmn)
            pbRefreshSingle(pkmnid)
        end
      elsif cmdRename>=0 && command==cmdRename
        species=PBSpecies.getName(pkmn.species)
        $game_variables[5]=Kernel.pbMessageFreeText("#{species}'s nickname?",_INTL(""),false,12)
        if pbGet(5)==""
          pkmn.name=PBSpecies.getName(pkmn.species)
          pbSet(5,pkmn.name)
        end
        pkmn.name=pbGet(5)
        pbDisplay(_INTL("{1} was renamed to {2}.",species,pkmn.name))
      #####MODDED
      elsif cmdRetrain >= 0 && command == cmdRetrain
        if pbHasRelearnableMove?(pkmn, true, false)
          if $PokemonBag.pbQuantity(PBItems::HEARTSCALE) > 0 && pbConfirm(_INTL("Do you want to use a Heart Scale to retrain #{pkmn.name}?"))
            pbRelearnMoveScreen(pkmn, true, true)
          else
            pbRelearnMoveScreen(pkmn, true, false)
          end
        else
          if $PokemonBag.pbQuantity(PBItems::HEARTSCALE) > 0
            pbRelearnMoveScreen(pkmn, true, true) if pbConfirm(_INTL("You need to use a Heart Scale to retrain #{pkmn.name}. Proceed?"))
          else
            pbDisplay(_INTL("You need a Heart Scale to retrain #{pkmn.name}."))
          end
        end
      #####/MODDED
      end
    end
    @scene.pbEndScene
    return nil
  end
end