
class PokemonEggHatchScene
    alias hmdMain pbMain
    def pbMain
        hmdMain
        ######    HMD START   ######
        if Kernel.pbConfirmMessage(_INTL("Would you like to place the newly hatched {1} in a different Poké Ball?", PBSpecies.getName(@pokemon.species)))
          listOfBalls = []
          ballDat = []
          for balls in 0...$PokemonBag.pockets[3].length
            listOfBalls.push(PBItems.getName($PokemonBag.pockets[3][balls][0]))
            ballDat.push($PokemonBag.pockets[3][balls][0])
          end

          breakBallLoop = false
          if listOfBalls.length == 0
            breakBallLoop = true
            Kernel.pbMessage(_INTL("You don't have any extra Poké Balls to use!"))
          end
          listOfBalls.push("Nevermind")
            
          while breakBallLoop == false
            ballChoice = Kernel.pbMessage(_INTL("Which Poké Ball would you like to use?"), listOfBalls)
            if ballChoice == listOfBalls.length - 1
                break
            end
            if Kernel.pbConfirmMessage(_INTL("Are you sure you wish to use a {1}?", listOfBalls[ballChoice]))
              breakBallLoop = true
              case ballDat[ballChoice]
                when PBItems::FRIENDBALL
                  @pokemon.happiness = 220
                when PBItems::GLITTERBALL
                  @pokemon.makeShiny
              end
              
              @pokemon.ballused = pbGetBallType(ballDat[ballChoice])
              $PokemonBag.pbDeleteItem(ballDat[ballChoice])
            end
          end
        end
        ######    HMD END     ######

    end
end