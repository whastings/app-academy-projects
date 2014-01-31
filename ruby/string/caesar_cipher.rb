# Pair programming partner: Rob Andrews

def caesar(str, num)
  hsh = {}
  new_str=''
  ("a".."z").to_a.each {|x| hsh[x.ord]=x}
  str.split('').each do |char|
    new_index = char.ord + num
    if new_index > 122
      new_index -= 26
    end
    new_str << hsh[new_index]
  end
  new_str
end
