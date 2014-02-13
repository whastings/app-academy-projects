ActiveRecord::Base.transaction do

  will = User.create!(email: 'will@example.com')

  ars = ShortenedUrl.create_for_user_and_long_url!(
    will,
    'http://arstechnica.com'
  )
  oreilly = ShortenedUrl.create_for_user_and_long_url!(
    will,
    'http://oreilly.com'
  )
  ShortenedUrl.create_for_user_and_long_url!(will, 'http://net.tutsplus.com')

  web_dev_tag = TagTopic.create!(name: 'Web Development')
  tech_tage = TagTopic.create!(name: 'Technology')
  programming_tag = TagTopic.create!(name: 'Programming')

end
