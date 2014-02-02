# Pair programming partner: Samantha Eng

def super_print(str, options={})
  default = {
    times: 1,
    upcase: false,
    reverse: false
  }

  options = default.merge(options)

  str = str * options[:times]
  str.upcase! if options[:upcase]
  str.reverse! if options[:reverse]

  puts str
end
