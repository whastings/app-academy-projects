# Pair programming partner: Samantha Eng

def shuffle_file(file_name)
  contents = File.read(file_name).split("\n")
  contents.shuffle!
  File.open("#{file_name}-shuffled.txt", "w") do |file|
    file.puts(contents.join("\n"))
  end
end

def get_file_name
  puts "Please enter the file name."
  gets.chomp
end

if __FILE__ == $PROGRAM_NAME
  shuffle_file(get_file_name)
end
