class Team
  # include Comparable

  attr_accessor :name, :rank

  def initialize(name, rank = 0)
    @name = name
    @rank = rank
  end

  def add_rank (n)
    @rank += n
  end

  def <=> (other)
    self.rank == other.rank ? (self.name <=> other.name) : (self.rank <=> other.rank)
  end

  def to_s
    "#{@name}, #{@rank} #{@rank==1 ? "pt" : "pts"}"
  end
end

class SoccerCalc

  # file = File.open(ARGV[0], "r")
  file = File.open("./input_data.txt", "r")
  raw_string = file.read
  plate_string = raw_string.delete("\n")
  teams_names = plate_string.split(/\s\d+,? ?/)

  teams = {}
  teams_names.each {|n| teams[n] = Team.new(n)}
  games = raw_string.split("\n")

  games.each do |game|
    counts = game.scan(/\d+/)
    names = game.split(/\s\d+,? ?/)

    if counts[0] > counts[1]
      teams[names[0]].add_rank(3)
    elsif counts[0] < counts[1]
      teams[names[1]].add_rank(3)
    else
      teams[names[0]].add_rank(1)
      teams[names[1]].add_rank(1)
    end
  end

  sorted_teams = teams.values.sort
  puts sorted_teams

end