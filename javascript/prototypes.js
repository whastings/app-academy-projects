/* Pair programming partner: Mark Shlick */

;(function() {
  "use strict";

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
        if (!depts[course.department]) {
          depts[course.department] = course.numCredits;
        } else {
          depts[course.department] += course.numCredits;
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
      return this.enrolledStudents;
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

  /* Testing: */
  var student1 = new Student("Will Hastings");
  var course1 = new Course("101", "CS", 3, ["mon", "wed", "fri"], 1);
  var course2 = new Course("201", "CS", 3, ["wed"], 1);
  var course3 = new Course("301", "ENG", 3, ["tue"], 1);
  var course4 = new Course("401", "BIO", 3, ["mon", "wed", "fri"], 2);
  student1.enroll(course1);
  student1.enroll(course3);
  student1.enroll(course2);
  console.log(student1.courseLoad());
  console.log(course1.conflictsWith(course2));
  console.log('should be true: ' + course1.conflictsWith(course2));
  console.log('should be false: ' + course1.conflictsWith(course3));
  console.log('should be false: ' + course1.conflictsWith(course4));

})();

