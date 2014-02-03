# Pair programming partner: Alexander Bryan

def range(start_value,end_value)
  return [] if (start_value - end_value).abs == 1
  [start_value + 1].concat(range(start_value + 1,end_value))
end
