################################################################################
# Pokemon Following Feature
# 대표 포켓몬이 플레이어 뒤를 따라다니는 기능
################################################################################

module PokemonFollowing
  # 팔로잉 기능 켜기/끄기 설정
  FOLLOWING_ENABLED = true
  
  # 스프라이트 파일 경로
  SPRITE_PATH = "Graphics/Characters/"
  
  # 팔로잉 포켓몬 스프라이트 파일명 형식
  # 도감번호 기준: "Follow001" = 이상해씨
  def self.getFollowSprite(pokemon)
    return nil if !pokemon
    species = pokemon.species
    # 도감번호로 파일명 생성
    filename = sprintf("Follow%03d", species)
    # 파일이 있으면 반환, 없으면 nil
    if pbResolveBitmap(SPRITE_PATH + filename)
      return filename
    end
    # 이름으로도 시도
    filename2 = "Follow" + PBSpecies.getName(species).gsub(" ","")
    if pbResolveBitmap(SPRITE_PATH + filename2)
      return filename2
    end
    return nil
  end

  # 현재 팔로잉 포켓몬 등록
  def self.startFollowing
    return if !FOLLOWING_ENABLED
    return if !$Trainer || $Trainer.party.length == 0
    
    # 이미 팔로잉 중이면 중지 후 재시작
    stopFollowing
    
    # 파티 첫 번째 포켓몬 가져오기
    pokemon = $Trainer.party[0]
    return if !pokemon || pokemon.isEgg?
    
    # 스프라이트 파일 확인
    sprite = getFollowSprite(pokemon)
    return if !sprite # 스프라이트 없으면 팔로잉 안함
    
    # 팔로잉 이벤트 생성
    pbCreateFollowingEvent(sprite, pokemon)
  end

  # 팔로잉 중지
  def self.stopFollowing
    pbRemoveDependency2("FollowingPokemon")
  end

  # 팔로잉 포켓몬 새로고침 (파티 변경 시 호출)
  def self.refresh
    return if !FOLLOWING_ENABLED
    startFollowing
  end
end

################################################################################
# 팔로잉 이벤트 생성
################################################################################
def pbCreateFollowingEvent(spriteName, pokemon=nil)
  return if !$game_map || !$game_player
  
  # 플레이어 뒤 위치 계산
  x = $game_player.x
  y = $game_player.y
  case $game_player.direction
  when 2 then y -= 1  # 아래 보는 중 → 위에 생성
  when 4 then x += 1  # 왼쪽 보는 중 → 오른쪽에 생성
  when 6 then x -= 1  # 오른쪽 보는 중 → 왼쪽에 생성
  when 8 then y += 1  # 위 보는 중 → 아래에 생성
  end
  
  # 맵 범위 체크
  x = $game_player.x if x < 0 || x >= $game_map.width
  y = $game_player.y if y < 0 || y >= $game_map.height
  
  # 이벤트 찾기 (맵에서 빈 이벤트 슬롯 사용)
  eventID = pbGetFollowEventID
  return if !eventID
  
  event = $game_map.events[eventID]
  return if !event
  
  # 스프라이트 설정
  event.character_name = spriteName
  event.moveto(x, y)
  
  # DependentEvents에 등록
  pbAddDependency2(eventID, "FollowingPokemon", nil)
end

# 팔로잉용 이벤트 ID 찾기
# 맵에서 이름이 "FollowingPokemon"인 이벤트를 찾음
def pbGetFollowEventID
  return nil if !$game_map
  for key in $game_map.events.keys
    event = $game_map.events[key]
    if event.name == "FollowingPokemon"
      return key
    end
  end
  return nil
end

################################################################################
# 기존 시스템과 연동
################################################################################

# 맵 이동 시 팔로잉 새로고침
Events.onMapSceneChange += proc { |sender, e|
  mapChanged = e[1]
  if mapChanged
    PokemonFollowing.refresh
  end
}

# 배틀 종료 후 팔로잉 새로고침
Events.onEndBattle += proc { |sender, e|
  PokemonFollowing.refresh
}
