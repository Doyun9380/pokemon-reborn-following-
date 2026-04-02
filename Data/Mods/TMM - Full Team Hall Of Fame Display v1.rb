class HallOfFameScene
#MODDED
  def pbUpdatePC
    # Change the team
    if @battlerIndex>=@hallEntry.size
      @hallIndex-=1
      return false if @hallIndex==-1
      @hallEntry=$PokemonGlobal.hallOfFame[@hallIndex]
      @battlerIndex=0
      createBattlers(false)
    elsif @battlerIndex<0
      @hallIndex+=1
      return false if @hallIndex>=$PokemonGlobal.hallOfFame.size
      @hallEntry=$PokemonGlobal.hallOfFame[@hallIndex]
      @battlerIndex=@hallEntry.size-1
      createBattlers(false)
    end
    # Change the pokemon
    pbPlayCry(@hallEntry[@battlerIndex])
    #setPokemonSpritesOpacity(@battlerIndex,OPACITY)
    hallNumber=$PokemonGlobal.hallOfFameLastNumber + @hallIndex -
               $PokemonGlobal.hallOfFame.size + 1
    writePokemonData(@hallEntry[@battlerIndex],hallNumber)
    return true
  end
  
end