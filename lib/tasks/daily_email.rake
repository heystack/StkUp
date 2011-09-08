namespace :notifications do
   desc "run daily tasks"
   task :daily => :environment do
     User.all.each do |user|
       UserMailer.daily_email(user).deliver
     end
   end
 end