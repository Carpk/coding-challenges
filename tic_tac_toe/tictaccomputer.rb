class Computer

  def initialize
    @strategy = nil
    @rolls = []
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
      if @rolls[4] == "   "
        @rolls << 4
      elsif @rolls[2] == "   "
        @rolls << 2
      elsif @rolls[6] == "   "
        @rolls << 6
      end
    when 2
      if @rolls[1] == "   "
        @rolls << 1
      elsif @rolls[5] == "   "
        @rolls << 5
      end
    when 6
      if @rolls[3] == "   "
        @rolls << 3
      elsif @rolls[7] == "   "
        @rolls << 7
      end
    end 
  end

  def cornerjumper
    case @rolls.last
    when 8
      @rolls << 2
    when 2
      if @rolls[5] == "   "
        @rolls << 5
      else
        @rolls << 6
    when 6
      if @roll[4] == "   "
        @rolls << 4
      elsif @rolls[7] == "   "
        @rolls << 7
      end
    end 
  end

  def middlelane
    case @rolls.last
    when 8
      @rolls << 4
    when 4
      if @rolls[0] == "   "
        @rolls << 0
      elsif @rolls[1] == " O "
        @rolls << 2
      elsif @rolls[3] == " O "
        @rolls << 6
      end
    when 2

    when 6

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
end

