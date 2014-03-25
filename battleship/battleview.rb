class BattleView

  def launch_prompt
    puts "launch codes please:"
  end

  def repeated_bomb
    puts "You have already bombed that location, go merica!"
  end

  def vessel_hit(vessel)
    puts "You have hit my #{vessel}!"
  end

  def vessel_sink(vessel)
    puts "You sank my #{vessel}"
  end

  def open_water
    puts "no target"
  end
end
