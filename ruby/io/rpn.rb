# Pair programming partner: Samantha Eng

class RPN

  def initialize
    @operands = []
  end

  def calculate(operator)
    operand2, operand1 = @operands.pop, @operands.pop
    result = operand1.send(operator, operand2.to_f)
    @operands << result
    result
  end

  def add_operand(operand)
    @operands << operand
  end

  def peek
    @operands.last
  end

  def parse_character(character)
    if character =~ /\d+/
      add_operand(character.to_f)
      nil
    else
      calculate(character)
    end
  end

end

class FileRPN < RPN
  def initialize
    @file_name = ARGV[0]
    super
  end

  def read_input
    File.read(@file_name).split.each do |character|
      parse_character(character)
    end
    peek
  end
end

class TerminalRPN < RPN

  def read_input
    puts <<-END
      Welcome to Reverse Polish Notation Calculator.
      Please enter one number or operator at a time.
      Type "q" when you're done.
    END
    input = gets.chomp
    until %w{q quit}.include?(input)
      puts peek if parse_character(input)
      input = gets.chomp
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  if ARGV[0]
    puts FileRPN.new.read_input
  else
    puts TerminalRPN.new.read_input
  end
end
