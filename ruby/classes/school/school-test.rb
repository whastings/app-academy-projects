# Pair programming partner: Samantha Eng

require "./school"

courses = [
  Course.new(1, "English", 4, [:mon], 2),
  Course.new(2, "Math", 3, [:tues, :thurs], 3),
  Course.new(3, "Math", 2, [:mon, :wed], 2)
]

students = [
  Student.new("Sam", "Eng"),
  Student.new("Bob", "Barker"),
  Student.new("Harry", "Potter")
]

# Student#name:
puts students[1].name

# Student#courses:
students[0].enroll(courses[1])
courses[2].add_student(students[0])
p students[0].courses

# Student#course_load
p students[0].course_load

# Course#students
p courses[1].students.to_s
p courses[2].students.to_s

# Course#conflicts_with
p courses[0].conflicts_with?(courses[2])

# Student#has_conflict?
begin
  students[0].enroll(courses[0])
rescue ArgumentError => e
  puts e.message
end
