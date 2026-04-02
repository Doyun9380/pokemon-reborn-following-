def getNGPData
    $idk[:starterQ] = ($game_variables[:Starter_Quest]>=21) if $idk[:starterQ] != true
    $idk[:magicS] = $game_switches[:Magic_Square_Done] if $idk[:magicS] != true
    $idk[:dexQ] = $game_switches[:Dex_Quest_Done] if $idk[:dexQ] != true
    #$idk[:spiritQ] = ($game_variables[:Spirit_Rewards]>=25) if $idk[:spiritQ] != true
    $idk[:treePuzzle] = ($game_variables[:Xernyvel]>=19) if $idk[:treePuzzle] != true
    $idk[:vrGem3] = $game_switches[:VR_Gem3] if $idk[:vrGem3] != true
    $idk[:vrGem4] = $game_switches[:VR_Gem4] if $idk[:vrGem4] != true
    $idk[:vrGem5] = $game_switches[:VR_Gem5] if $idk[:vrGem5] != true
    $idk[:southAv] = $game_switches[:HearPinsir_Puzzle] if $idk[:southAv] != true
    $idk[:chessPuzzle] = ($game_variables[:E10_Story]>=40) if $idk[:chessPuzzle] != true
   ## ng++ updates below, canon above, no the spirit one wasn't me
    $idk[:mirage] = ($game_variables[377]>=6) if $idk[:mirage] != true
    $idk[:mirage2] = ($game_variables[646]>=3) if $idk[:mirage2] != true
    $idk[:saphiraGym] = $game_switches[1098] if $idk[:saphiraGym] != true
    $idk[:vrAme] = ($game_variables[520]>=9) if $idk[:vrAme] != true
    $idk[:tinaDoor] = (($game_variables[651]>=11) && (!$game_switches[1867])) if $idk[:tinaDoor] != true
    $idk[:test] = true
    $idk[:sub7stealth] = $game_switches[528] if $idk[:sub7stealth] != true
    $idk[:sugiline] = ($game_switches[887] && $game_switches[886]) if $idk[:sugiline] != true
    $idk[:vrEmer] = ($game_variables[521]>=8) if $idk[:vrEmer] != true
    $idk[:necro] = ($game_variables[725]>=9) if $idk[:necro] != true
    $idk[:devon] = ($game_variables[339]>=39) if $idk[:devon] != true
    $idk[:blacksteam] = ($game_variables[107]>=13) if $idk[:blacksteam] != true
    #$idk[:route2] = ($game_switches[465] && $game_switches[467] && $game_switches[468] && $game_switches[469] && $game_switches[470] && $game_switches[471] && $game_switches[472]) if $idk[:route2] != true
    $idk[:route2] = ($game_variables[173] >=8) if $idk[:route2] != true
    $idk[:vrSaph] = ($game_variables[523]>=1) if $idk[:vrSaph] != true
    $idk[:mineboom] = ($game_variables[475] >= 118) if $idk[:mineboom] != true
    $idk[:grassZ] = $game_switches[983] if $idk[:grassZ] != true
    saveClientData
end 