namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin = User.create!(:name => "Steve Brown",
                         :email => "nycbrown@gmail.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)

    99.times do |n|
      name  = Faker::Name.name
      email = "stack+#{n+1}@stkup.com"
      password  = "foobar"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end

