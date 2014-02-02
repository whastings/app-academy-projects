# Pair programming partner: Alexander Bryan

def fib_iterative(number)
  return [] if number < 0
  return [1] if number == 1
  return [1, 1] if number == 2
  fibs = [1, 1]
  (3..number).each do |x|
    fibs << fibs[x - 3] + fibs[x - 2]
  end
  fibs
end

def fib_recursive(number)
  return [] if number < 0
  return [1] if number == 1
  return [1, 1] if number == 2
  fibs = fib_recursive(number - 1)
  fibs << fibs[-1] + fibs[-2]
end
