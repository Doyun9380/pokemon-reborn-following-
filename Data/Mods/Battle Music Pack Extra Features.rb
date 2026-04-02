#Map IDs: 362=Fiore Mansion, 455=Cerulean Cave, 628=Devon Corp?, 821=Charous Hall, 828=Nightclub Arena, 854=Not Truly For Chidren


def bmp_allowOverride?(trainer)
  return false if [828,362,854].include?($game_map.map_id)
  if !trainer.is_a?(Array)
    return false if [PBTrainers::DOCTOR,PBTrainers::FLORA].include?(trainer.trainertype) || ($game_map.map_id == 821 && trainer.trainertype != PBTrainers::LIN)
  end
  return true
end


def pbGetWildBattleBGM(species)
  if $PokemonGlobal.nextBattleBGM
    return $PokemonGlobal.nextBattleBGM.clone
  end
  ret=nil
  if PBStuff::LEGENDARYLIST.include?(species)
    ret=pbStringToAudioFile("Battle- Legendary") if !ret
  ####MODDED
  elsif [PBSpecies::NIHILEGO, PBSpecies::BUZZWOLE, PBSpecies::PHEROMOSA, PBSpecies::XURKITREE, PBSpecies::CELESTEELA, PBSpecies::KARTANA, PBSpecies::GUZZLORD, PBSpecies::POIPOLE, PBSpecies::NAGANADEL, PBSpecies::STAKATAKA, PBSpecies::BLACEPHALON].include?(species)
    ret=pbStringToAudioFile("Battle- Legendary") if !ret
  ####/MODDED
  end
  if !ret && $game_map
    # Check map-specific metadata
    music=pbGetMetadata($game_map.map_id,MetadataMapWildBattleBGM)
    if music && music!=""
      ret=pbStringToAudioFile(music)
    end
  end
  if !ret
    # Check global metadata
    music=pbGetMetadata(0,MetadataWildBattleBGM)
    if music && music!=""
      ret=pbStringToAudioFile(music)
    end
  end
  ret=pbStringToAudioFile("Battle- Wild") if !ret
  return ret
end


def pbGetTrainerBattleBGM(trainer) # can be a PokeBattle_Trainer or an array of PokeBattle_Trainer
  ####MODDED
  if $PokemonGlobal.nextBattleBGM && bmp_allowOverride?(trainer)
  ####/MODDED
    return $PokemonGlobal.nextBattleBGM.clone
  end
  music=nil
  if !trainer.is_a?(Array)
    trainerarray=[trainer]
  else
    trainerarray=trainer
  end
  for i in 0...trainerarray.length
    trainertype=trainerarray[i].trainertype
    ####MODDED
    if $game_map.map_id == 455 && trainertype == PBTrainers::GLITCH2
      music = "RBY Battle- Champion"
    elsif $game_map.map_id == 362 && trainertype == PBTrainers::Hotshot
      music = "Battle- Meteor Admin"
    elsif $game_map.map_id == 628 && trainertype == PBTrainers::Victoria2
      music = "Battle- Inner Peace"
    elsif ($game_map.map_id == 854 && trainertype == PBTrainers::ANTICS) || ([821,828].include?($game_map.map_id) && trainertype == PBTrainers::CHILDLIN)
      music = "Battle- Postgame"
    elsif $game_map.map_id == 828 && trainertype == PBTrainers::SHADE
      music = "Battle- Gym"
    ####/MODDED
    elsif $cache.trainertypes[trainertype]
      music=$cache.trainertypes[trainertype][4]
    end
  end
  ret=nil
  if music && music!=""
    ret=pbStringToAudioFile(music)
  end
  if !ret && $game_map
    # Check map-specific metadata
    music=pbGetMetadata($game_map.map_id,MetadataMapTrainerBattleBGM)
    if music && music!=""
      ret=pbStringToAudioFile(music)
    end
  end
  if !ret
    # Check global metadata
    music=pbGetMetadata(0,MetadataTrainerBattleBGM)
    if music && music!=""
      ret=pbStringToAudioFile(music)
    end
  end
  return ret
end