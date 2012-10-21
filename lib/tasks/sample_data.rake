namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
  	admin = User.create!(
                         email: "admin@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
  	User.create!(
                 email: "this@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.notes.create!(content: content) }
    end
  end
end