# Pair programming partner: Samantha Eng

class Student
  def initialize(first_name, last_name)
    @first_name, @last_name = first_name, last_name
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def courses
    @courses ||= []
    @courses
  end

  def enroll(course)
    return if courses.include?(course)
    if has_conflict?(course)
      raise ArgumentError, "Course time conflicts with existing course"
    end
    courses << course
    course.students << self
  end

  def course_load
    departments = {}
    courses.each do |course|
      departments[course.department] ||= 0
      departments[course.department] += course.credits
    end
    departments
  end

  def has_conflict?(other_course)
    courses.select { |course| course.conflicts_with?(other_course) }.any?
  end

  def to_s
    name
  end
end

class Course
  attr_reader :department, :credits, :days_of_week, :time_block

  def initialize(name, department, credits, days_of_week, time_block)
    @name, @department, @credits = name, department, credits
    @days_of_week, @time_block = days_of_week, time_block
  end

  def students
    @students ||= []
    @students
  end

  def add_student(student)
    student.enroll(self)
  end

  def conflicts_with?(other_course)
    return false if @time_block != other_course.time_block
    !(@days_of_week & other_course.days_of_week).empty?
  end

  def to_s
    "#{@department} (#{@credits})"
  end
end
