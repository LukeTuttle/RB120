module Mirageable
  def mirage
    puts "mirage to be implemented"
  end
end

class SorcerySchool
  @@available_spells = ['fireball', 'earthquake', 'wall of water', 'lightning bolt']


  def self.assign_spell
    temp_spell = @@available_spells.sample

    if temp_spell.nil?
      'TBD'
    else
      @@available_spells.delete(temp_spell)
      temp_spell
    end
  end
end

class SorceryStudent
  def initialize(artifact, robe_color, energy_range = (100..200))
    @magical_energy = calc_magical_energy(energy_range)
    @artifact = artifact
    @robe_color = robe_color
    @unique_spell = SorcerySchool.assign_spell
  end

  def to_s
    message = <<TEXT
    ============================
    School of Sorcery: #{self.class}
    Magical Energy: #{magical_energy}
    Unique Spell: #{unique_spell}
    Artifact: #{artifact}
    Robe Color: #{robe_color}
    ============================
TEXT
    message
  end

  private

  attr_reader :magical_energy, :artifact, :robe_color
  attr_accessor :unique_spell

  def calc_magical_energy(range)
    rand(range)
  end

end

class Illusionist < SorceryStudent
  include Mirageable

  def initialize(*)
    super('crystal ball', 'purple') if self.class == Illusionist
    super(*) if self.class == Enchanter
  end
end

class Enchanter < Illusionist
  include Mirageable

  def initialize
    super('crystal ball', 'gold', (150..250))
  end
end

class Necromancer < SorceryStudent
  def initialize
    super('wooden staff', 'black', (75..175))
  end

  def time_stop
    # code ommitted
  end

  def create_zombie
    # code ommitted
  end
end

class Conjurer < SorceryStudent
  include Mirageable

  def initialize
    super('silver wand', 'green')
  end

  def time_stop
    # code ommitted
  end
end


ill = Illusionist.new
ench = Enchanter.new
necro = Necromancer.new
conj = Conjurer.new


[ill, ench, necro, conj].each {|x| puts x}

[ill, ench, conj].each(&:mirage)