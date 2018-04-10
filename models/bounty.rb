class Bounty

  attr_accessor :name, :species, :bounty_value, :danger_level

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @species = options["species"]
    @bounty_value = options["bounty_value"].to_i
    @danger_level = options["danger_level"]
end



end
