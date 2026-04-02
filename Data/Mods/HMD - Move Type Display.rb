#Slightly modified for Reatomized

####ADDED
def pbJudgmentType(pokemon)
  type = PBTypes::NORMAL
  type = pokemon.form % 21 if pokemon.species == PBSpecies::ARCEUS
  if pokemon.form<21
    case pokemon.item
      when PBItems::FISTPLATE then type = PBTypes::FIGHTING
      when PBItems::SKYPLATE then type = PBTypes::FLYING
      when PBItems::TOXICPLATE then type = PBTypes::POISON
      when PBItems::EARTHPLATE then type = PBTypes::GROUND
      when PBItems::STONEPLATE then type = PBTypes::ROCK
      when PBItems::INSECTPLATE then type = PBTypes::BUG
      when PBItems::SPOOKYPLATE then type = PBTypes::GHOST
      when PBItems::IRONPLATE then type = PBTypes::STEEL
      when PBItems::FLAMEPLATE then type = PBTypes::FIRE
      when PBItems::SPLASHPLATE then type = PBTypes::WATER
      when PBItems::MEADOWPLATE then type = PBTypes::GRASS
      when PBItems::ZAPPLATE then type = PBTypes::ELECTRIC
      when PBItems::MINDPLATE then type = PBTypes::PSYCHIC
      when PBItems::ICICLEPLATE then type = PBTypes::ICE
      when PBItems::DRACOPLATE then type = PBTypes::DRAGON
      when PBItems::DREADPLATE then type = PBTypes::DARK
      when PBItems::PIXIEPLATE then type = PBTypes::FAIRY
      when PBItems::ATOMICPLATE then type = PBTypes::NUCLEAR
      when PBItems::COSMICPLATE then type = PBTypes::COSMIC
    end
  end
  return type
end

def pbMultiAttackType(pokemon)
  type = PBTypes::NORMAL
  type = pokemon.form % 21 if pokemon.species == PBSpecies::SILVALLY
  if pokemon.form<21
    case pokemon.item
      when PBItems::FIGHTINGMEMORY then type = PBTypes::FIGHTING
      when PBItems::FLYINGMEMORY then type = PBTypes::FLYING
      when PBItems::POISONMEMORY then type = PBTypes::POISON
      when PBItems::GROUNDMEMORY then type = PBTypes::GROUND
      when PBItems::ROCKMEMORY then type = PBTypes::ROCK
      when PBItems::BUGMEMORY then type = PBTypes::BUG
      when PBItems::GHOSTMEMORY then type = PBTypes::GHOST
      when PBItems::STEELMEMORY then type = PBTypes::STEEL
      when PBItems::FIREMEMORY then type = PBTypes::FIRE
      when PBItems::WATERMEMORY then type = PBTypes::WATER
      when PBItems::GRASSMEMORY then type = PBTypes::GRASS
      when PBItems::ELECTRICMEMORY then type = PBTypes::ELECTRIC
      when PBItems::PSYCHICMEMORY then type = PBTypes::PSYCHIC
      when PBItems::ICEMEMORY then type = PBTypes::ICE
      when PBItems::DRAGONMEMORY then type = PBTypes::DRAGON
      when PBItems::DARKMEMORY then type = PBTypes::DARK
      when PBItems::FAIRYMEMORY then type = PBTypes::FAIRY
      when PBItems::ATOMICMEMORY then type = PBTypes::NUCLEAR
      when PBItems::COSMICMEMORY then type = PBTypes::COSMIC
      when PBItems::QMARKSMEMORY then type = PBTypes::QMARKS
    end
  end
  return type
end
####/ADDED

def pbTechnoBlast(pokemon)
    case pokemon.item
        when PBItems::SHOCKDRIVE   then return PBTypes::ELECTRIC
        when PBItems::BURNDRIVE    then return PBTypes::FIRE
        when PBItems::CHILLDRIVE   then return PBTypes::ICE
        when PBItems::DOUSEDRIVE   then return PBTypes::WATER
    else return PBTypes::NORMAL
    end
end

def moveTypeChangeAbils
    return {
        PBAbilities::GALVANIZE => PBTypes::ELECTRIC,
        PBAbilities::REFRIGERATE => PBTypes::ICE,
        PBAbilities::AERILATE => PBTypes::FLYING,
        PBAbilities::PIXILATE => PBTypes::FAIRY,
        ####ADDED
        PBAbilities::DUSKILATE => PBTypes::DARK,
        PBAbilities::ATOMIZATE => PBTypes::NUCLEAR
        ####/ADDED
    }
end

def moveTypeDisplay(moveid,pokemon)
    movedata = PBMoveData.new(moveid)
    move = PBMove.new(moveid)
    type = move.type
    type = pbHiddenPower(pokemon) if moveid == PBMoves::HIDDENPOWER
    ####CHANGED
    type = pbJudgmentType(pokemon) if moveid == PBMoves::JUDGMENT
    type = pbMultiAttackType(pokemon) if moveid == PBMoves::MULTIATTACK
    type = pbTechnoBlast(pokemon) if moveid == PBMoves::TECHNOBLAST
    ####/CHANGED
    ####ADDED
    type = (!PBStuff::NATURALGIFTTYPE[pokemon.item].nil? ? PBStuff::NATURALGIFTTYPE[pokemon.item] : PBTypes::NORMAL) if moveid == PBMoves::NATURALGIFT
    type = pokemon.type1 if moveid == PBMoves::REVELATIONDANCE
    type = PBTypes::DARK if moveid == PBMoves::AURAWHEELPLUS && pokemon.species == PBSpecies::MORPEKO && pokemon.form == 1
    if moveid == PBMoves::RAGINGBULL && pokemon.species == PBSpecies::TAUROS
      type = PBTypes::FIGHTING if pokemon.form == 1
      type = PBTypes::FIRE if pokemon.form == 2
      type = PBTypes::WATER if pokemon.form == 3
    end
    if moveid == PBMoves::IVYCUDGEL && pokemon.species == PBSpecies::OGERPON
      type = PBTypes::WATER if pokemon.form == 2 || pokemon.form == 6
      type = PBTypes::FIRE if pokemon.form == 3 || pokemon.form == 7
      type = PBTypes::ROCK if pokemon.form == 4 || pokemon.form == 8
    end
    ####/ADDED

    if type == PBTypes::NORMAL
        if moveTypeChangeAbils.keys.include?(pokemon.ability)
            type = moveTypeChangeAbils[pokemon.ability]
        end
    end

    if pokemon.ability == PBAbilities::LIQUIDVOICE
        if movedata.isSoundBased?
            type = PBTypes::WATER
        end
    end

    if pokemon.ability == PBAbilities::NORMALIZE
        type = PBTypes::NORMAL
    end

    return type
end

class PokemonSummaryScene
    def drawSelectedMove(pokemon,moveToLearn,moveid)
        overlay=@sprites["overlay"].bitmap
        @sprites["pokemon"].visible=false if @sprites["pokemon"]
        @sprites["pokeicon"].bitmap = pbPokemonIconBitmap(pokemon,pokemon.isEgg?)
        @sprites["pokeicon"].src_rect=Rect.new(0,0,64,64)
        @sprites["pokeicon"].visible=true
        movedata=PBMoveData.new(moveid)
        basedamage=movedata.basedamage
        type=movedata.type
        
        if moveToLearn > 0
            type = moveTypeDisplay(moveToLearn, pokemon)
        else
            type = moveTypeDisplay(moveid, pokemon)
        end
        
        category=movedata.category
        accuracy=movedata.accuracy
        drawMoveSelection(pokemon,moveToLearn)
        pbSetSystemFont(overlay)
        move=moveid
        textpos=[
           [basedamage<=1 ? basedamage==1 ? "???" : "---" : sprintf("%d",basedamage),
              216,154,1,Color.new(64,64,64),Color.new(176,176,176)],
           [accuracy==0 ? "---" : sprintf("%d",accuracy),
              216,186,1,Color.new(64,64,64),Color.new(176,176,176)]
        ]
        pbDrawTextPositions(overlay,textpos)
        imagepos=[["Graphics/Pictures/category",166,124,0,category*28,64,28]]
        pbDrawImagePositions(overlay,imagepos)
        drawTextEx(overlay,4,218,238,5,
           pbGetMessage(MessageTypes::MoveDescriptions,moveid),
           Color.new(64,64,64),Color.new(176,176,176))
    end

    def drawMoveSelection(pokemon,moveToLearn)
        overlay=@sprites["overlay"].bitmap
        overlay.clear
        base=Color.new(248,248,248)
        shadow=Color.new(104,104,104)
        @sprites["background"].setBitmap("Graphics/Pictures/Summary/summary5details")
        if moveToLearn!=0
          @sprites["background"].setBitmap("Graphics/Pictures/Summary/summary5learning")
        end
        pbSetSystemFont(overlay)
        textpos=[
           [_INTL("MOVES"),26,16,0,base,shadow],
           [_INTL("CATEGORY"),20,122,0,base,shadow],
           [_INTL("POWER"),20,154,0,base,shadow],
           [_INTL("ACCURACY"),20,186,0,base,shadow]
        ]
        type1rect=Rect.new(0,pokemon.type1*28,64,28)
        type2rect=Rect.new(0,pokemon.type2*28,64,28)
        if pokemon.type1==pokemon.type2
          overlay.blt(130,78,@typebitmap.bitmap,type1rect)
        else
          overlay.blt(96,78,@typebitmap.bitmap,type1rect)
          overlay.blt(166,78,@typebitmap.bitmap,type2rect)
        end
        imagepos=[]
        yPos=98
        yPos-=76 if moveToLearn!=0
        for i in 0...5
          moveobject=nil
          if i==4
            moveobject=PBMove.new(moveToLearn) if moveToLearn!=0
            yPos+=20
          else
            moveobject=pokemon.moves[i]
          end
          if moveobject
            if moveobject.id!=0
                
                movetype = moveTypeDisplay(moveobject.id, pokemon)

              imagepos.push(["Graphics/Pictures/types",248,yPos+2,0,
                 movetype*28,64,28])
              textpos.push([PBMoves.getName(moveobject.id),316,yPos,0,
                 Color.new(64,64,64),Color.new(176,176,176)])
              if moveobject.totalpp>0
                textpos.push([_ISPRINTF("PP"),342,yPos+32,0,
                   Color.new(64,64,64),Color.new(176,176,176)])
                textpos.push([sprintf("%d/%d",moveobject.pp,moveobject.totalpp),
                   460,yPos+32,1,Color.new(64,64,64),Color.new(176,176,176)])
              end
            else
              textpos.push(["-",316,yPos,0,Color.new(64,64,64),Color.new(176,176,176)])
              textpos.push(["--",442,yPos+32,1,Color.new(64,64,64),Color.new(176,176,176)])
            end
          end
          yPos+=64
        end
        pbDrawTextPositions(overlay,textpos)
        pbDrawImagePositions(overlay,imagepos)
      end

      def drawPageFive(pokemon)
        overlay=@sprites["overlay"].bitmap
        overlay.clear
        @sprites["background"].setBitmap("Graphics/Pictures/Summary/summary5")
        @sprites["pokemon"].visible=true
        @sprites["pokeicon"].visible=false
        imagepos=[]
        if pbPokerus(pokemon)==1 || pokemon.hp==0 || @pokemon.status>0
          status=6 if pbPokerus(pokemon)==1
          status=@pokemon.status-1 if @pokemon.status>0
          status=5 if pokemon.hp==0
          imagepos.push(["Graphics/Pictures/statuses",124,100,0,16*status,44,16])
        end
        if pokemon.isShiny?
          imagepos.push([sprintf("Graphics/Pictures/shiny"),2,134,0,0,-1,-1])
        end
        if pbPokerus(pokemon)==2
          imagepos.push([sprintf("Graphics/Pictures/Summary/summaryPokerus"),176,100,0,0,-1,-1])
        end
        ballused=@pokemon.ballused ? @pokemon.ballused : 0
        ballimage=sprintf("Graphics/Pictures/Summary/summaryball%02d",@pokemon.ballused)
        imagepos.push([ballimage,14,60,0,0,-1,-1])
        pbDrawImagePositions(overlay,imagepos)
        base=Color.new(248,248,248)
        shadow=Color.new(104,104,104)
        pbSetSystemFont(overlay)
        itemname=pokemon.hasItem? ? PBItems.getName(pokemon.item) : _INTL("None")
        pokename=@pokemon.name
        textpos=[
           [_INTL("MOVES"),26,16,0,base,shadow],
           [pokename,46,62,0,base,shadow],
           [pokemon.level.to_s,46,92,0,Color.new(64,64,64),Color.new(176,176,176)],
           [_INTL("Item"),16,320,0,base,shadow],
           [itemname,16,352,0,Color.new(64,64,64),Color.new(176,176,176)],
        ]
        if pokemon.isMale?
          textpos.push([_INTL("♂"),178,62,0,Color.new(24,112,216),Color.new(136,168,208)])
        elsif pokemon.isFemale?
          textpos.push([_INTL("♀"),178,62,0,Color.new(248,56,32),Color.new(224,152,144)])
        end
        pbDrawTextPositions(overlay,textpos)
        imagepos=[]
        yPos=98
        for i in 0...pokemon.moves.length
          if pokemon.moves[i].id>0


            movetype = moveTypeDisplay(pokemon.moves[i].id, pokemon)

            imagepos.push(["Graphics/Pictures/types",248,yPos+2,0,
               movetype*28,64,28])
            textpos.push([PBMoves.getName(pokemon.moves[i].id),316,yPos,0,
               Color.new(64,64,64),Color.new(176,176,176)])
            if pokemon.moves[i].totalpp>0
              textpos.push([_ISPRINTF("PP"),342,yPos+32,0,
                 Color.new(64,64,64),Color.new(176,176,176)])
              textpos.push([sprintf("%d/%d",pokemon.moves[i].pp,pokemon.moves[i].totalpp),
                 460,yPos+32,1,Color.new(64,64,64),Color.new(176,176,176)])
            end
          else
            textpos.push(["-",316,yPos,0,Color.new(64,64,64),Color.new(176,176,176)])
            textpos.push(["--",442,yPos+32,1,Color.new(64,64,64),Color.new(176,176,176)])
          end
          yPos+=64
        end
        pbDrawTextPositions(overlay,textpos)
        pbDrawImagePositions(overlay,imagepos)
        drawMarkings(overlay,15,291,72,20,pokemon.markings)
      end
end



class FightMenuDisplay
    attr_reader :battler
    attr_reader :index
    attr_accessor :megaButton
    attr_accessor :ultraButton
    attr_accessor :zButton
    attr_accessor :buttons
  
    def initialize(battler,viewport=nil)
      @display=nil
      if PokeBattle_SceneConstants::USEFIGHTBOX
        @display=IconSprite.new(0,Graphics.height-96,viewport)
        @display.setBitmap("Graphics/Pictures/Battle/battleFight")
      end
      @window=Window_CommandPokemon.newWithSize([],0,Graphics.height-96,320,96,viewport)
      @window.columns=2
      @window.columnSpacing=4
      @window.ignore_input=true
      pbSetNarrowFont(@window.contents)
      @info=Window_AdvancedTextPokemon.newWithSize(
         "",320,Graphics.height-96,Graphics.width-320,96,viewport)
      pbSetNarrowFont(@info.contents)
      @ctag=shadowctag(PokeBattle_SceneConstants::MENUBASECOLOR,
                       PokeBattle_SceneConstants::MENUSHADOWCOLOR)
      @buttons=nil
      @battler=battler
      @index=0
      @megaButton=0 # 0=don't show, 1=show, 2=pressed
      @ultraButton=0 # 0=don't show, 1=show, 2=pressed
      @zButton=0    # 0=don't show, 1=show, 2=pressed
      if PokeBattle_SceneConstants::USEFIGHTBOX
        @window.opacity=0
        @window.x=Graphics.width
        @info.opacity=0
        @info.x=Graphics.width+Graphics.width-96
        @buttons=FightMenuButtons.new(self.index,nil,viewport)
      end
      refresh
    end
    def battler=(value)
        @battler=value
        @buttons.pokemon = value.pokemon
        refresh
    end
end

class FightMenuButtons < BitmapSprite
    attr_accessor :pokemon

    def refresh(index,moves,megaButton,zButton,ultraButton)
        return if !moves
        self.bitmap.clear
        moveboxes=_INTL("Graphics/Pictures/Battle/battleFightButtons")
        textpos=[]
        for i in 0...4
          next if i==index
          next if moves[i].id==0
          x=((i%2)==0) ? 4 : 192
          y=((i/2)==0) ? 6 : 48
          y+=UPPERGAP

          movetype = moveTypeDisplay(moves[i].id, @pokemon)
          
          self.bitmap.blt(x,y,@buttonbitmap.bitmap,Rect.new(0,movetype*46,192,46))
          textpos.push([_INTL("{1}",moves[i].name),x+96,y+12,2,
              PokeBattle_SceneConstants::MENUBASECOLOR,PokeBattle_SceneConstants::MENUSHADOWCOLOR])
        end
        ppcolors=[
          PokeBattle_SceneConstants::PPTEXTBASECOLOR,PokeBattle_SceneConstants::PPTEXTSHADOWCOLOR,
          PokeBattle_SceneConstants::PPTEXTBASECOLOR,PokeBattle_SceneConstants::PPTEXTSHADOWCOLOR,
          PokeBattle_SceneConstants::PPTEXTBASECOLORYELLOW,PokeBattle_SceneConstants::PPTEXTSHADOWCOLORYELLOW,
          PokeBattle_SceneConstants::PPTEXTBASECOLORORANGE,PokeBattle_SceneConstants::PPTEXTSHADOWCOLORORANGE,
          PokeBattle_SceneConstants::PPTEXTBASECOLORRED,PokeBattle_SceneConstants::PPTEXTSHADOWCOLORRED
          ]
        for i in 0...4
          next if i!=index
          next if moves[i].id==0
          x=((i%2)==0) ? 4 : 192
          y=((i/2)==0) ? 6 : 48
          y+=UPPERGAP

            movetype = moveTypeDisplay(moves[i].id, @pokemon)

          self.bitmap.blt(x,y,@buttonbitmap.bitmap,Rect.new(192,movetype*46,192,46))
          self.bitmap.blt(416,20+UPPERGAP,@typebitmap.bitmap,Rect.new(0,movetype*28,64,28))
          textpos.push([_INTL("{1}",moves[i].name),x+96,y+12,2,
              PokeBattle_SceneConstants::MENUBASECOLOR,PokeBattle_SceneConstants::MENUSHADOWCOLOR])
          if moves[i].totalpp>0
            ppfraction=(4.0*moves[i].pp/moves[i].totalpp).ceil
            textpos.push([_INTL("PP: {1}/{2}",moves[i].pp,moves[i].totalpp),
                448,50+UPPERGAP,2,ppcolors[(4-ppfraction)*2],ppcolors[(4-ppfraction)*2+1]])
          end
        end
        for i in 0...4
          next if moves[i].id==0
          x=((i%2)==0) ? 4 : 192
          y=((i/2)==0) ? 6 : 48
          y+=UPPERGAP
          case pbFieldNotesBattle(moves[i])
          when 1 then self.bitmap.blt(x+2,y+2,@goodmovebitmap.bitmap, Rect.new(0,0,@goodmovebitmap.bitmap.width,@goodmovebitmap.bitmap.height))
          when 2 then self.bitmap.blt(x+2,y+2,@badmovebitmap.bitmap, Rect.new(0,0,@badmovebitmap.bitmap.width,@badmovebitmap.bitmap.height))
          end
        end
        pbDrawTextPositions(self.bitmap,textpos)
        if megaButton>0
          self.bitmap.blt(146,0,@megaevobitmap.bitmap,Rect.new(0,(megaButton-1)*46,96,46))
        end
        if ultraButton>0
          self.bitmap.blt(146,0,@megaevobitmap.bitmap,Rect.new(0,(ultraButton-1)*46,96,46))
        end
        if zButton>0
          self.bitmap.blt(146,0,@zmovebitmap.bitmap,Rect.new(0,(zButton-1)*46,96,46))
        end
      end

end