# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  User.create!([
    {:username => "redleader", :name => "Gerald", :email => "redleader@gmail.com"},
    {:username => "stormtrooper", :name => "Harold", :email => "stormtrooper@gmail.com"},
    {:username => "droid", :name => "Barry", :email => "droid@gmail.com"}
  ])

  Contact.create!([
    {
      :name => 'Chewbacca',
      :email => 'chewbacca@appacademy.io',
      :user_id => 1
    },
    {
      :name => 'Han',
      :email => 'han@appacademy.io',
      :user_id => 1
    },
    {
      :name => 'Leia',
      :email => 'leia@appacademy.io',
      :user_id => 1
    },
    {
      :name => 'Vader',
      :email => 'vader@appacademy.io',
      :user_id => 2
    },
    {
      :name => 'Palpatine',
      :email => 'palpatine@appacademy.io',
      :user_id => 2
    },
    {
      :name => 'General Grievous',
      :email => 'g.grievous@appacademy.io',
      :user_id => 2
    },
    {
      :name => 'Jabba',
      :email => 'jabba@appacademy.io',
      :user_id => 2
    },
    {
      :name => 'Greedo',
      :email => 'greedo@appacademy.io',
      :user_id => 1
    }
  ])

  ContactShare.create!([
    { user_id: 3, contact_id: 1 },
    { user_id: 3, contact_id: 2 },
    { user_id: 3, contact_id: 3 },
    { user_id: 3, contact_id: 4 },
    { user_id: 3, contact_id: 5 },
    { user_id: 3, contact_id: 6 },
    { user_id: 1, contact_id: 7 },
    { user_id: 3, contact_id: 7 }
  ])

  Group.create!([
    { group_name: 'Allies', user_id: 1 },
    { group_name: 'Enemies', user_id: 1 },
    { group_name: 'Best Friends', user_id: 3 }
  ])

  GroupMembership.create!([
    { group_id: 1, contact_id: 1 },
    { group_id: 1, contact_id: 2 },
    { group_id: 1, contact_id: 3 },
    { group_id: 2, contact_id: 7 },
    { group_id: 2, contact_id: 8 },
    { group_id: 3, contact_id: 1 },
    { group_id: 3, contact_id: 2 },
    { group_id: 3, contact_id: 3 },
    { group_id: 3, contact_id: 4 },
    { group_id: 3, contact_id: 5 },
    { group_id: 3, contact_id: 6 }
  ])

end