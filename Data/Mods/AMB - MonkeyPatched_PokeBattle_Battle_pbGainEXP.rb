##### This file is needed by AddOpt_ExpAllEV, AddOpt_ExpPastCap, AddOpt_ExpScale and Misc_CandyExcess.

class PokeBattle_Battle
  def pbGainEXP
    return if !@internalbattle || @disableExpGain
    #Find who died and get their base EXP & level
    for i in 0...4 # Not ordered by priority
      if !@doublebattle && pbIsDoubleBattler?(i)
        @battlers[i].participants=[]
        next
      end
      next unless (pbIsOpposing?(i) && @battlers[i].participants.length>0 && (@battlers[i].isFainted? || @decision == 4))
      battlerSpecies=@battlers[i].pokemon.species
      baseexp=@battlers[i].baseExp
      level=@battlers[i].level
      mon_order = [] #order that the mons should be given EXP in
      #find who fought
      partic=0
      for j in @battlers[i].participants
        next if !@party1[j] || !pbIsOwner?(0,j) || @party1[j].isEgg?
        next if @party1[j].hp<=0 && ($game_switches[:Exp_All_On] == false || $game_switches[:Exp_All_Upgrade] == false)
        partic+=1
        mon_order.push(j)
      end
      next if partic==0 && !($game_switches[:Exp_All_On] == false || $game_switches[:Exp_All_Upgrade] == false)

      #push the rest of the party on that array
      for j in 0...@party1.length
        next if !@party1[j] || !pbIsOwner?(0,j) || @party1[j].isEgg?
        next if @party1[j].hp<=0 && ($game_switches[:Exp_All_On] == false || $game_switches[:Exp_All_Upgrade] == false)
        mon_order.push(j) if !mon_order.include?(j)
      end

      #get the base participant EXP
      partic = 1 if partic==0
      partic_exp=(level*baseexp/partic).floor
      partic_exp=(partic_exp*3/2).floor if @opponent

      #distribute EXP to each mon in the party
      messageskip = false
      #####MODDED
      excessExp = 0
      #####/MODDED
      for j in mon_order
        thispoke=@party1[j]

        #pokemon information for messages
        hasEXPshare = (thispoke.item == PBItems::EXPSHARE || thispoke.itemInitial == PBItems::EXPSHARE)
        boostedEXP = ((thispoke.trainerID != self.pbPlayer.id && thispoke.trainerID != 0) || (thispoke.language!=0 && thispoke.language!=self.pbPlayer.language))
        mon_fought = @battlers[i].participants.include?(j)

        #did this mon fight?
        if mon_fought
          exp = partic_exp
        elsif hasEXPshare || $game_switches[:Exp_All_On] #didn't participate- has EXP Share or EXP All is on
          exp = (partic_exp/3).floor #reduced
          exp = (partic_exp/2).floor if $game_switches[:Exp_All_Upgrade] == true
        else #does not get EXP
          next
        end

        #Gain effort value points, using RS effort values
        #####MODDED
        pbGainEvs(thispoke,i) if mon_fought || hasEXPshare || (defined?($idk[:settings].amb_expAllEV) && $idk[:settings].amb_expAllEV == 1 && $game_switches[:Exp_All_On])
        #####/MODDED
        
        #reborn-added EXP booster: 8% per level over 100
        exp*=(1+((thispoke.poklevel-100)*0.08)) if thispoke.poklevel>100
        if USENEWEXPFORMULA   # Use new (Gen 5) Exp. formula
          leveladjust=((2*level+10.0)/(level+thispoke.level+10.0))**2.5
          exp=(exp*leveladjust/5).floor
        else                  # Use old (Gen 1-4) Exp. formula
          exp=(exp/7).floor
        end

        #Trade EXP; different language EXP
        if boostedEXP
          exp*= (thispoke.language!=0 && thispoke.language!=self.pbPlayer.language) ? 1.7 : 1.5
        end
        exp=(exp*3/2).floor if (thispoke.item == PBItems::LUCKYEGG) || (thispoke.itemInitial == PBItems::LUCKYEGG)
        #####MODDED
        minimumYield = 1
        if defined?($idk[:settings].amb_expFactor) && defined?($idk[:settings].amb_expDivisor)
          if $idk[:settings].amb_expFactor == 0
            minimumYield = 0
            exp = 0
          else
            exp = (exp * $idk[:settings].amb_expFactor) / ($idk[:settings].amb_expDivisor + 1)
          end
        end
        exp=[minimumYield, exp.floor].max
        #####/MODDED

        #We have the EXP that this mon can gain.
        growthrate=thispoke.growthrate
        if $game_switches[:Hard_Level_Cap] || $game_switches[:Exp_All_On] # Rejuv-style Level Cap
          badgenum = pbPlayer.numbadges
          #####MODDED
          if thispoke.level>=LEVELCAPS[badgenum] && exp != 0
            expPastCapModifier = defined?($idk[:settings].amb_expPastCap) ? $idk[:settings].amb_expPastCap : 0
            excessExp += exp - expPastCapModifier if $game_switches[:Exp_All_On]
            exp = expPastCapModifier
          #####/MODDED
          elsif thispoke.level<LEVELCAPS[badgenum]
            totalExpNeeded = PBExperience.pbGetStartExperience(LEVELCAPS[badgenum], growthrate)
            currExpNeeded = totalExpNeeded - thispoke.exp
            #####MODDED
            currExpNeeded += $idk[:settings].amb_expPastCap if defined?($idk[:settings].amb_expPastCap) && currExpNeeded < exp
            if exp > currExpNeeded
              excessExp += exp - currExpNeeded if $game_switches[:Exp_All_On]
              exp = currExpNeeded
            end
            #####/MODDED
          end
        end
        newexp=PBExperience.pbAddExperience(thispoke.exp,exp,growthrate)
        exp=newexp-thispoke.exp
        exp = 0 if $game_switches[:No_EXP_Gain]
        next if exp <= 0
        if mon_fought || (hasEXPshare && !$game_switches[:Exp_All_On])
          #EXP All text is handled at the end
          if boostedEXP || thispoke.item == PBItems::LUCKYEGG
            pbDisplay(_INTL("{1} gained a boosted {2} Exp. Points!",thispoke.name,exp))
          else
            pbDisplay(_INTL("{1} gained {2} Exp. Points!",thispoke.name,exp))
          end
        elsif $game_switches[:Exp_All_On]
          pbDisplay(_INTL("The rest of your team gained Exp. Points thanks to the Exp. All!")) if !messageskip
          messageskip = true
        end
        
        #actually add the EXP
        newlevel=PBExperience.pbGetLevelFromExperience(newexp,growthrate)
        oldlevel=thispoke.level
        if thispoke.respond_to?("isShadow?") && thispoke.isShadow?
          thispoke.exp+=exp
          next
        end

        # Find battler
        battler=pbFindPlayerBattler(j)
        battler = nil if battler && battler.pokemon != thispoke
        curlevel = oldlevel
        oldtotalhp=thispoke.totalhp
        oldattack=thispoke.attack
        olddefense=thispoke.defense
        oldspeed=thispoke.speed
        oldspatk=thispoke.spatk
        oldspdef=thispoke.spdef
        tempexp1=thispoke.exp
        loop do
          #EXP Bar animation
          startexp=PBExperience.pbGetStartExperience(curlevel,growthrate)
          endexp=PBExperience.pbGetStartExperience(curlevel+1,growthrate)
          tempexp2=(endexp<newexp) ? endexp : newexp
          thispoke.exp=tempexp2
          @scene.pbEXPBar(thispoke,battler,startexp,endexp,tempexp1,tempexp2)
          tempexp1=tempexp2
          curlevel+=1
          if curlevel>newlevel
            thispoke.calcStats
            battler.pbUpdate(false) if battler
            @scene.pbRefresh
            break
          end
          thispoke.poklevel = curlevel
          if battler && battler.pokemon && @internalbattle
            battler.pokemon.changeHappiness("level up")
          elsif ((thispoke.item == PBItems::EXPSHARE) || $game_switches[:Exp_All_On])
            thispoke.changeHappiness("level up")
          end
        end
        next if newlevel<=oldlevel
        #leveled up!
        thispoke.calcStats
        battler.pbUpdate(false) if battler
        @scene.pbRefresh
        pbDisplayPaused(_INTL("{1} grew to Level {2}!",thispoke.name,newlevel))
        @scene.pbLevelUp(thispoke,battler,oldtotalhp,oldattack,olddefense,oldspeed,oldspatk,oldspdef)

        # Finding all moves learned at this level
        movelist=thispoke.getMoveList
        for lvl in oldlevel+1..newlevel
          for k in movelist
            if k[0]==lvl   # Learned a new move
              pbLearnMove(j,k[1])
            end
          end
        end

        #evolve if able to
        newspecies=pbCheckEvolution(thispoke)
        next if newspecies<=0
        pbFadeOutInWithMusic(99999){
          evo=PokemonEvolutionScene.new
          evo.pbStartScreen(thispoke,newspecies)
          evo.pbEvolution
          evo.pbEndScreen
          $game_map.autoplayAsCue
          if battler
            @scene.pbChangePokemon(@battlers[battler.index],@battlers[battler.index].pokemon)
            battler.pbUpdate(true)
            @scene.sprites["battlebox#{battler.index}"].refresh
            battler.name=thispoke.name
            for ii in 0...4
              battler.moves[ii]=PokeBattle_Move.pbFromPBMove(self,thispoke.moves[ii],battler)
            end
          end
        }
      end
      #####MODDED
      if defined?($amb_miscMods_Variables) && $amb_miscMods_Variables["CandyExcess"] && $game_switches[:Exp_All_On] && excessExp >= 100
        excessExp = (excessExp/2).floor unless $game_switches[:Exp_All_Upgrade]
        candyData = {PBItems::EXPCANDYXL => 30000, PBItems::EXPCANDYL => 10000, PBItems::EXPCANDYM => 3000, PBItems::EXPCANDYS => 800, PBItems::EXPCANDYXS => 100}
        candyData.each do |name,value|
          unless excessExp < value
            candyAmount = (excessExp / value).floor
            excessExp -= candyAmount * value
            $PokemonBag.pbStoreItem(name, candyAmount)
          end
        end
        pbDisplay(_INTL("Excess Exp. Points were turned into candy by Exp. All."))
      end
      #####/MODDED
      # Now clear the participants array
      @battlers[i].participants=[]
    end
  end
end