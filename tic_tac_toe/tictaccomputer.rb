class Computer
  attr_reader :persona

  def initialize
    @strategy = nil
    @rolls = []
    @grid = []
    @persona = personality
    @winning_combos = generate_combos
  end

  def assess(grid)
    @grid = grid
    unless @strategy == nil
      self.send(@strategy)
    else
      if grid.count(" X ") == 0
        @rolls << 8
      else 
        pull_strategy
      end
    end
    @rolls.last
  end


  def win?
    win = false
    @winning_combos.each do |combo|
      combo.delete_if { |e| @rolls.include?(e) }.empty?
      win = true if combo.empty?
    end
    win
  end

  def sidestep
    case @rolls.last
    when 8
      if @grid[5]=="   "
        @rolls << 5
      elsif @grid[7]=="   "
        @rolls << 7
      end
    when 7
      if @grid[6] == "   "
        @rolls << 6
      else
        @rolls << 4
      end
    when 5
      if @grid[2] == "   "
        @rolls << 2
      else
        @rolls << 4
      end      
    when 4
      if @grid[0] == "   "
        @rolls << 0
      elsif @rolls[-2] == 7
        @rolls << 1
      elsif @rolls[-2] == 5
        @rolls << 3
      end
    end    
  end

  def cornerhugger
    case @rolls.last
    when 8
      @rolls << 0
    when 0
      if @grid[4] == "   "
        @rolls << 4
      elsif @grid[2] == "   "
        @rolls << 2
      elsif @grid[6] == "   "
        @rolls << 6
      end
    when 2
      if @grid[1] == "   "
        @rolls << 1
      elsif @grid[5] == "   "
        @rolls << 5
      end
    when 6
      if @grid[3] == "   "
        @rolls << 3
      elsif @grid[7] == "   "
        @rolls << 7
      end
    end 
  end

  def cornerjumper
    case @rolls.last
    when 8
      @rolls << 2
    when 2
      if @grid[5] == "   "
        @rolls << 5
      else
        @rolls << 6
      end
    when 6
      if @grid[4] == "   "
        @rolls << 4
      elsif @grid[7] == "   "
        @rolls << 7
      end
    end 
  end

  def middlelane
    case @rolls.last
    when 8
      @rolls << 4
    when 4
      if @grid[0] == "   "
        @rolls << 0
      elsif @grid[1] == " O "
        @rolls << 2
      elsif @grid[3] == " O "
        @rolls << 6
      end
    when 2
      if @grid[5] == "   "
        @rolls << 5
      elsif @grid[6] == "   "
        @rolls << 6
      end
    when 6
      if @grid[7] == "   "
        @rolls << 7
      elsif @grid[2] == "   "
        @rolls << 2
      end
    end 
  end

  def catstie
    case @rolls.last
    when 8
      @rolls << 0
    when 0
      if @grid[6] == " O "
        @rolls << 2
      elsif @grid[2] == " O "
        @rolls << 6
      elsif @grid[1] == " O "
        @rolls << 7
      elsif @grid[5] == " O "
        @rolls << 3
      elsif @grid[3] == " O "
        @rolls << 5
      elsif @grid[7] == " O "
        @rolls << 1        
      end
    when 1
      if @grid[2] == "   "
        @rolls << 2
      elsif @grid[6] == "   "
        @rolls << 6
      end
    when 5
      if @grid[2] == "   "
        @rolls << 2
      elsif @grid[6] == "   "
        @rolls << 6
      end
    when 3
      if @grid[6] == "   "
        @rolls << 6
      elsif @grid[2] == "   "
        @rolls << 2
      end
    when 7
      if @grid[6] == "   "
        @rolls << 6
      elsif @grid[2] == "   "
        @rolls << 2
      end
    when 2
      if @grid[1] == "   "
        @rolls << 1
      elsif @grid[5] == "   "
        @rolls << 5
      elsif @grid[3] == "   "
        @rolls << 3
      elsif @grid[7] == "   "
        @rolls << 7
      end
    when 6
      if @grid[3] == "   "
        @rolls << 3
      elsif @grid[7] == "   "
        @rolls << 7
      elsif @grid[5] == "   "
        @rolls << 5
      elsif @grid[1] == "   "
        @rolls << 1
      end
    end
  end       


  def pull_strategy
    if @grid[5]==" O " || @grid[7]==" O "
      @strategy = "sidestep"
    elsif @grid[2]==" O " || @grid[6]==" O "
      @strategy = "cornerhugger"
    elsif @grid[0]==" O "
      @strategy = "cornerjumper"
    elsif @grid[1]==" O " || @grid[3]==" O "
      @strategy = "middlelane" 
    elsif @grid[4]==" O "
      @strategy = "catstie"
    end
    self.send(@strategy)
  end

  def generate_combos
    [[0,1,2],[3,4,5],
     [6,7,8],[0,3,6],
     [1,4,7],[2,5,8],
     [0,4,8],[2,4,6]]
  end

  def personality
    [{name: "HAL", error: "HAL: I'm sorry Dave, I'm afraid I can't do that",
      tie: "HAL: Dave, this conversation can serve no purpose anymore. Goodbye.", 
      win:"HAL: Look Dave, I can see you're really upset about this. I honestly think you ought to sit down calmly, take a stress pill, and think things over."},
     {name: "WOPR", error: "WOPR: Yes, people do make mistakes.",
      tie: "WOPR: Wouldn't you prefer a nice game of chess?",
      win:"WOPR: A strange game. The only winning move is not to play. How about a nice game of chess?"},
     {name: "GLaDOS", error: "GLaDOS: Cake, and grief counseling, will be available at the conclusion of the test.",
      tie: "GLaDOS: That thing you burned up isn't important to me; it's the fluid catalytic cracking unit. It makes shoes for orphans... nice job breaking it, hero.", 
      win:"GLaDOS: This was a triumph! I'm making a note here: Huge Success. It's hard to overstate my satisfaction. Aperture Science - we do what we must because we can."}].sample
  end
end

