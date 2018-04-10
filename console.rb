require ("pry-byebug")
require_relative("./models/bounty.rb")

Bounty.delete_all()

bounty1 = Bounty.new({
  "name" => "Alien1",
  "species" => "Alien",
  "bounty_value" => 1000,
  "danger_level" => "medium"
  })

  bounty1.save()

  bounty2 = Bounty.new({
    "name" => "Human1",
    "species" => "Human",
    "bounty_value" => 1500,
    "danger_level" => "high"
    })

    bounty2.save()

    bounty3 = Bounty.new({
      "name" => "Alien2",
      "species" => "Alien",
      "bounty_value" => 750,
      "danger_level" => "low"
      })

      bounty3.save()

      bounty4 = Bounty.new({
        "name" => "Human2",
        "species" => "Human",
        "bounty_value" => 500,
        "danger_level" => "low"
        })


        binding.pry
        nil
