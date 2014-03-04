/* Pair programming partner: Mark Shlick */

function Student(name) {
  this.name = name;
  this.courseList = [];
}

function Course(name, department, numCredits, days, block) {
  this.name = name;
  this.department = department;
  this.numCredits = numCredits;
  this.days = days;
  this.block = block;
  this.enrolledStudents = [];
}

Student.prototype = {
  courses: function() {
    return this.courseList;
  },
  enroll: function(course) {
    if (this.courseList.indexOf(course) === -1 &&
        !this.hasConflict(course)) {
      this.courseList.push(course);
      course.addStudent(this);
    }
  },
  courseLoad: function() {
    var depts = {};
    this.courseList.forEach(function(course){
      if (!depts[course.name]) {
        depts[course.name] = course.numCredits;
      } else {
        depts[course.name] += course.numCredits;
      }
    });
    return depts;
  },
  hasConflict: function(course) {
    return this.courseList.some(function(enrolled) {
      return course.conflictsWith(enrolled);
    });
  }
};

Course.prototype = {
  students: function() {
    this.enrolledStudents;
  },
  addStudent: function(student) {
    this.enrolledStudents.push(student);
  },
  conflictsWith: function(course) {
    if (course.block !== this.block) { return false; }
    return this.days.some(function(day) {
      return course.days.indexOf(day) !== -1;
    });
  }
};
