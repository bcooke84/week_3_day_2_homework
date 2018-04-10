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
    db = PG.connect({ dbname: "space_cowboys", host: "localhost" })
    sql = "INSERT INTO bounty (name, species, bounty_value, danger_level) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@name, @species, @bounty_value, @danger_level]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]["id"].to_i
  end

  def update()
    db = PG.connect({ dbname: "space_cowboys", host: "localhost" })
    sql = "UPDATE bounty SET (name, species, bounty_value, danger_level) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @species, @bounty_value, @danger_level, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect ({ dbname: "space_cowboys", host: "localhost" })
    sql = "DELETE FROM bounty WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Bounty.all()
    db = PG.connect({ dbname: "space_cowboys", host: "localhost" })
    sql = "SELECT * FROM bounty"
    db.prepare("all", sql)
    bounties = db.exec_prepared("all")
    db.close()
    return bounties.map { |bounty| Bounty.new(bounty) }
  end

  def Bounty.delete_all()
    db = PG.connect ({ dbname: "space_cowboys", host: "localhost" })
    sql = "DELETE FROM bounty"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  # Implement a find_by_name method that returns one instance of your class when a name is passed in, or nil if no instance is found. Note: this will probably be another class method self.find_by_name(name) (do you have to use a map method if it's a single result?)

  def Bounty.find_by_name(name)
    db = PG.connect ({ dbname: "space_cowboys", host: "localhost" })
    sql = "SELECT * FROM bounty WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    bounty_instance = db.exec_prepared("find_by_name", values)
    bounty_instance.count == 0 ? nil : Bounty.new(bounty_instance.first())
  end

  # Implement a second self.find method that returns one instance of your class when an id is passed in.

  def Bounty.find_by_id(id)
    db = PG.connect ({ dbname: "space_cowboys", host: "localhost" })
    sql = "SELECT * FROM bounty WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    bounty_instance = db.exec_prepared("find_by_id", values)
    bounty_instance.count == 0 ? nil : Bounty.new(bounty_instance.first())
  end

end
