class Hanoi

  attr_reader :disks

  def initialize
    @disks = Array.new(3) { [] }
    @disks[0] = (1..4).to_a.reverse
  end

  def move(start_pos, end_pos)
    return false if @disks[start_pos].last.nil?
    if @disks[end_pos].last.nil? || @disks[start_pos].last < @disks[end_pos].last
      move_piece = @disks[start_pos].pop
      @disks[end_pos] << move_piece
      return true
    else
      return false
    end
  end

  def won?
    @disks.last == [4,3,2,1]
  end

  # def render
#     @disks.flatten.map do |disk|
#       if disk.nil?
#         " "
#       else
#         "-" * disk
#       end
#     end
#
#     @disks.map do |row|
#       @disks.
#
#   end

end