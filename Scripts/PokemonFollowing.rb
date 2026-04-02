################################################################################
# Pokemon Following Feature
# 대표 포켓몬이 플레이어 뒤를 따라다니는 기능
################################################################################

module PokemonFollowing
  FOLLOWING_ENABLED = true
  SPRITE_PATH = "Graphics/Characters/"

  def self.getFollowSprite(pokemon)
    return nil if !pokemon
    species = pokemon.species
    filename = sprintf("Follow%03d", species)
    if pbResolveBitmap(SPRITE_PATH + filename)
      return filename
    end
    filename2 = "Follow" + PBSpecies.getName(species).gsub(" ","")
    if pbResolveBitmap(SPRITE_PATH + filename2)
      return filename2
    end
    return nil
  end

  def self.startFollowing
    return if !FOLLOWING_ENABLED
    return if !$Trainer || $Trainer.party.length == 0
    stopFollowing
    pokemon = $Trainer.party[0]
    return if !pokemon || pokemon.isEgg?
    sprite = getFollowSprite(pokemon)
    return if !sprite
    pbCreateFollowingPokemon(sprite)
  end

  def self.stopFollowing
    pbRemoveDependency2("FollowingPokemon")
  end

  def self.refresh
    return if !FOLLOWING_ENABLED
    startFollowing
  end
end

################################################################################
# 코드로 직접 이벤트 생성
################################################################################
def pbCreateFollowingPokemon(spriteName)
  return if !$game_map || !$game_player
  return if !$MapFactory

  # 플레이어 뒤 위치
  x = $game_player.x
  y = $game_player.y
  case $game_player.direction
  when 2 then y -= 1
  when 4 then x += 1
  when 6 then x -= 1
  when 8 then y += 1
  end
  x = [[$game_player.x, x].max, 0].max
  y = [[$game_player.y, y].max, 0].max

  # RPG::Event 직접 생성
  rpgEvent = RPG::Event.new(x, y)
  rpgEvent.id = -9999  # 충돌 없는 고유 ID
  rpgEvent.name = "FollowingPokemon"
  rpgEvent.pages[0].graphic.character_name = spriteName
  rpgEvent.pages[0].move_type = 0
  rpgEvent.pages[0].through = false

  # Game_Event 생성
  newEvent = Game_Event.new($game_map.map_id, rpgEvent, $game_map)
  newEvent.character_name = spriteName
  newEvent.moveto(x, y)
  newEvent.through = false

  # $game_map에 등록
  $game_map.events[-9999] = newEvent

  # DependentEvents에 등록
  eventData = [
    $game_map.map_id, -9999, $game_map.map_id,
    x, y, $game_player.direction,
    spriteName, 0, "FollowingPokemon", nil
  ]
  newRealEvent = $PokemonTemp.dependentEvents.createEvent(eventData)
  $PokemonGlobal.dependentEvents.push(eventData)
  $PokemonTemp.dependentEvents.instance_variable_get(:@realEvents).push(newRealEvent)
  $PokemonTemp.dependentEvents.instance_variable_set(:@lastUpdate,
    $PokemonTemp.dependentEvents.lastUpdate + 1)
end

################################################################################
# 시스템 연동
################################################################################
Events.onMapSceneChange += proc { |sender, e|
  mapChanged = e[1]
  if mapChanged
    PokemonFollowing.refresh
  end
}

Events.onEndBattle += proc { |sender, e|
  PokemonFollowing.refresh
}
