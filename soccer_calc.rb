class Command
  include Comparable

  attr_accessor :name, :rank

  def initialize(name, rank = 0)
    @name = name
    @rank = rank
  end

  def add_rank (n)
    @rank+=n
  end

  def <=> (other)
    self.rank==other.rank ? (self.name<=>other.name) : (self.rank <=> other.rank)
  end

  def to_s
    "#{@name}, #{@rank} #{@rank==1 ? "pt" : "pts"}"
  end
end

class SoccerCalc

  file = File.open(ARGV[0], "r")
  raw_string = file.read
  plate_string = raw_string.delete("\n")
  commands_names = plate_string.split(/\s\d+,? ?/)
  commands = {}
  commands_names.each {|n| commands[n] = Command.new(n)}
  games = raw_string.split("\n")

  games.each do |game|
    counts = game.scan(/\d+/)
    names = game.split(/\s\d+,? ?/)

    if counts[0] > counts[1]
      commands[names[0]].add_rank(3)
    elsif counts[0] < counts[1]
      commands[names[1]].add_rank(3)
    else
      commands[names[0]].add_rank(1)
      commands[names[1]].add_rank(1)
    end
  end

  sorted_command = commands.values.sort
  puts sorted_command

end