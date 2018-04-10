require("pg")

class Bounty

  attr_reader :id
  attr_accessor :name, :species, :bounty_value, :danger_level

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @species = options["species"]
    @bounty_value = options["bounty_value"].to_i
    @danger_level = options["danger_level"]
  end

  def save()
    db = PG.connect({ dbname: "space_cowboys", host: "localhost"})
    sql = "INSERT INTO bounty (name, species, bounty_value, danger_level) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@name, @species, @bounty_value, @danger_level]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]["id"].to_i
  end

  def Bounty.all()
    db = PG.connect({ dbname: "space_cowboys", host: "localhost" })
    sql = "SELECT * FROM space_cowboys"
    db.prepare("all", sql)
    bountys = db.exec_prepared("all")
    db.close()
    return bountys.map { |bounty| Bounty.new(order) }
  end




end
