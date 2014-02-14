# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do

  user1 = User.create!(user_name: 'bob')
  user2 = User.create!(user_name: 'jim')
  user3 = User.create!(user_name: 'joe')
  user4 = User.create!(user_name: 'steve')
  user5 = User.create!(user_name: 'alice')
  user6 = User.create!(user_name: 'goodstudent')

  poll1 = user1.authored_polls.create!(title: 'Student Survey 1')
  poll2 = user2.authored_polls.create!(title: 'Student Survey 2')
  poll3 = user2.authored_polls.create!(title: 'Student Survey 3')

  q1 = poll1.questions.create!(text: 'Best JavaScript MV* Framework')
  q2 = poll1.questions.create!(text: 'Best HTML5 Dance Video')

  q3 = poll2.questions.create!(text: 'Is this class too early?')
  q4 = poll2.questions.create!(text: 'Should we have class outside?')

  q5 = poll3.questions.create!(text: 'A')
  q6 = poll3.questions.create!(text: 'B')

  a1 = q1.answer_choices.create!(text: 'Angular')
  a2 = q1.answer_choices.create!(text: 'Backbone')
  a9 = q1.answer_choices.create!(text: 'Ember')

  a3 = q2.answer_choices.create!(text: 'Swing')
  a4 = q2.answer_choices.create!(text: 'The Waltz')

  a5 = q3.answer_choices.create!(text: 'Yes')
  a6 = q3.answer_choices.create!(text: 'No')

  a7 = q4.answer_choices.create!(text: 'Yes')
  a8 = q4.answer_choices.create!(text: 'No')

  a9 = q5.answer_choices.create!(text: 'Yes')
  a10 = q5.answer_choices.create!(text: 'No')

  a11 = q6.answer_choices.create!(text: 'Yes')
  a12 = q6.answer_choices.create!(text: 'No')

  r1 = a1.responses.create!(user_id: user5.id)
  r2 = a1.responses.create!(user_id: user2.id)
  r3 = a2.responses.create!(user_id: user3.id)
  r4 = a3.responses.create!(user_id: user3.id)
  r5 = a5.responses.create!(user_id: user4.id)
  r6 = a4.responses.create!(user_id: user5.id)
  r7 = a4.responses.create!(user_id: user4.id)

  r8 = a1.responses.create!(user_id: user6.id)
  r9 = a4.responses.create!(user_id: user6.id)
  r10 = a5.responses.create!(user_id: user6.id)
  r11 = a12.responses.create!(user_id: user6.id)


end