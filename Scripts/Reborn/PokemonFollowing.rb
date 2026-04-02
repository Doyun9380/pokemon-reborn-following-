################################################################################
# Pokemon Following Feature
################################################################################

class PokemonTemp
  attr_accessor :followingStarted
end

module PokemonFollowing
  FOLLOWING_ENABLED = true
  SPRITE_PATH = "Graphics/Characters/"

  def self.getFollowSprite(pokemon)
    return nil if !pokemon
    species = pokemon.species
    filename = sprintf("Follow%03d", species)
    echoln "Following: 스프라이트 찾는중 - #{filename}"
    if pbResolveBitmap(SPRITE_PATH + filename)
      echoln "Following: 스프라이트 찾음! - #{filename}"
      return filename
    end
    echoln "Following: 스프라이트 없음 - #{filename}"
    return nil
  end

  def self.startFollowing
    echoln "Following: startFollowing 호출됨"
    return if !FOLLOWING_ENABLED
    return if !$Trainer || $Trainer.party.length == 0
    stopFollowing
    pokemon = $Trainer.party[0]
    echoln "Following: 포켓몬 = #{pokemon ? pokemon.name : 'nil'}"
    return if !pokemon || pokemon.isEgg?
    sprite = getFollowSprite(pokemon)
    echoln "Following: 스프라이트 결과 = #{sprite}"
    return if !sprite
    pbCreateFollowingPokemon(sprite)
    echoln "Following: 생성 완료!"
  end

  def self.stopFollowing
    pbRemoveDependency2("FollowingPokemon")
  end

  def self.refresh
    return if !FOLLOWING_ENABLED
    startFollowing
  end
end

def pbCreateFollowingPokemon(spriteName)
  echoln "Following: pbCreateFollowingPokemon 호출됨 - #{spriteName}"
  return if !$game_map || !$game_player
  return if !$MapFactory

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

  rpgEvent = RPG::Event.new(x, y)
  rpgEvent.id = -9999
  rpgEvent.name = "FollowingPokemon"
  rpgEvent.pages[0].graphic.character_name = spriteName
  rpgEvent.pages[0].move_type = 0
  rpgEvent.pages[0].through = false

  newEvent = Game_Event.new($game_map.map_id, rpgEvent, $game_map)
  newEvent.character_name = spriteName
  newEvent.moveto(x, y)
  newEvent.through = false

  $game_map.events[-9999] = newEvent

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
  echoln "Following: 이벤트 등록 완료!"
end

Events.onMapSceneChange += proc { |sender, e|
  mapChanged = e[1]
  echoln "Following: onMapSceneChange - mapChanged=#{mapChanged}"
  if mapChanged
    PokemonFollowing.refresh
  end
}

Events.onEndBattle += proc { |sender, e|
  PokemonFollowing.refresh
}

Events.onMapUpdate += proc { |sender, e|
  if !$PokemonTemp.followingStarted
    echoln "Following: 첫 실행 시도"
    PokemonFollowing.startFollowing
    $PokemonTemp.followingStarted = true
  end
}
  
