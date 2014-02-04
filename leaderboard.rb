class Leaderboard
  def initialize(time)
    contents = File.read("leaderboard.txt")
    @top_scores = contents.empty? ? {} : YAML.load(contents)
    @new_time = time
  end

  def check_time
    qualifies = false
    if @top_scores.keys.length <= 10
      qualifies = true
    else
      last_key = @top_scores.keys.last
      if @top_scores[last_key] > @new_time
        @top_scores.delete(last_key)
        qualifies = true
      end
    end
    if qualifies
      puts "Your name?"
      @top_scores[gets.chomp] = @new_time
    end
    @top_scores = @top_scores.sort_by { |person, time| time }
  end

  def save
    File.open("leaderboard.txt", "w") { |f| f.puts @top_scores.to_yaml }
  end

  def display
    puts "Top Scores:"
    @top_scores.each { |name, time| puts "#{name} - #{time}"}
  end

end
