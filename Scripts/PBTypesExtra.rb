class PBTypes
  @@TypeData=nil # internal

  def PBTypes.loadTypeData # internal
    if !@@TypeData
      @@TypeData=load_data("Data/types.dat")
      @@TypeData[0].freeze
      @@TypeData[1].freeze
      @@TypeData[2].freeze
      @@TypeData.freeze
    end
    return @@TypeData
  end

  def PBTypes.isPseudoType?(type)
    return PBTypes.loadTypeData()[0].include?(type)
  end

  def PBTypes.isSpecialType?(type)
    return PBTypes.loadTypeData()[1].include?(type)
  end

  def PBTypes.getEffectiveness(attackType,opponentType)
    return PBTypes.loadTypeData()[2][opponentType][attackType]
  end

  def PBTypes.getCombinedEffectiveness(attackType,opponentType1,opponentType2=nil)
    if opponentType2==nil
      return PBTypes.getEffectiveness(attackType,opponentType1)*2
    else
      mod1=PBTypes.getEffectiveness(attackType,opponentType1)
      mod2=(opponentType1==opponentType2) ? 2 : PBTypes.getEffectiveness(attackType,opponentType2)
      return (mod1*mod2)
    end
  end

  def PBTypes.getTypesThatResist(type)
    resists = []
    PBTypes.loadTypeData() if !@@TypeData
    for i in 0..20
      resists.push(i) if @@TypeData[2][i][type] == 1 || @@TypeData[2][i][type] == 0
    end
    return resists
  end

  def PBTypes.isSuperEffective?(attackType,opponentType1,opponentType2=nil)
    e=PBTypes.getCombinedEffectiveness(attackType,opponentType1,opponentType2)
    return e>4
  end
end

FUSIONTYPES = hashArrayToConstant(PBTypes,{
  PBTypes::NORMAL   => [:NPG],
  PBTypes::GHOST    => [:SWG, :PG],
  PBTypes::BUG      => [:BS],
  PBTypes::POISON   => [:PF,:NPG,:SFP],
  PBTypes::FIGHTING => [:FG,:GFS,:PFD,:FD],
  PBTypes::FLYING   => [:WGF,:PF],
  PBTypes::GROUND   => [:WGF,:FG,:GFS,:NPG],
  PBTypes::STEEL    => [:SWG,:GS,:BS,:GFS,:SRG,:SFP],
  PBTypes::GRASS    => [:GFW,:GS,:SRG],
  PBTypes::FIRE     => [:IFE,:EFW,:GFW],
  PBTypes::WATER    => [:EFW,:WGF,:SWG,:GFW],
  PBTypes::ELECTRIC => [:IFE,:EFW],
  PBTypes::ICE      => [:IFE],
  PBTypes::PSYCHIC  => [:PFD, :PG],
  PBTypes::DARK     => [:PFD],
  PBTypes::ROCK		=> [:SRG],
  PBTypes::FAIRY	=> [:SFP],
  PBTypes::DRAGON	=> [:FD]
})