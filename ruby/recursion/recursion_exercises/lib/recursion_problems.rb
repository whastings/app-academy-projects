#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  array.first + sum_recur(array.drop(1))
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return true if array.first == target
  return false if array.length == 1
  includes?(array.drop(1), target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  occurrences = 0
  occurrences += 1 if array.first == target
  return occurrences if array.length == 1
  occurrences + num_occur(array.drop(1), target)
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  adds = array[0] + array[1] == 12
  return adds if adds || array.length == 2
  add_to_twelve?(array.drop(1))
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return [] if array.empty?
  return true if array.length == 1
  sorted = array[0] <= array[1]
  return sorted if !sorted || array.length == 2
  sorted?(array.drop(1))
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number)
  return number if number / 10 == 0
  last_digit = number % 10
  number /= 10
  number_length, number_dec = 0, number
  while number_dec > 0
    number_length += 1
    number_dec /= 10
  end
  number_length.times { last_digit *= 10 }
  last_digit + reverse(number)
end

