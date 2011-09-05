namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_interests
    make_interested_users
    make_stacks
    make_choices
    make_answers
  end
end

def make_users
  admin = User.create!(:name => "Steve Brown",
                       :email => "nycbrown@gmail.com",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  User.create!(:name => "Example User",
               :email => "example@railstutorial.org",
               :password => "foobar",
               :password_confirmation => "foobar")

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
    
def make_interests
  99.times do |n|
    interest_desc = Faker::Company.bs
    Interest.create!(:interest_desc => interest_desc)
  end
end

def make_interested_users
  user = User.all.first
  interests = Interest.all
  interests.each { |interest| user.interested_in!(interest) }
end

def make_stacks
  33.times do |i|
    3.times do |s|
      stk_question = Faker::Lorem.sentence(6).sub!('.', '?')
      stk_question_subtext = Faker::Lorem.sentence(3)
      stk_choice_picker_type = "text"
      stk_chart_type = "pie"
      stk_created_by = s
      Stack.create!(
        :interest_id => i+1,
        :question => stk_question,
        :question_subtext => stk_question_subtext,
        :choice_picker_type => stk_choice_picker_type,
        :chart_type => stk_chart_type,
        :created_by => stk_created_by)
    end
  end
end

def make_choices
  33.times do |i|
    3.times do |s|
      choice_text = Faker::Lorem.sentence(2)
      Choice.create!(
        :stack_id => i+1,
        :choice_text => choice_text)
    end
  end
end

def make_answers
  33.times do |u|
    33.times do |s|
      Answer.create!(
        :user_id => u+1,
        :stack_id => s+1,
        :choice_id => rand(3)+1)
    end
  end
end

def make_answers
  User.all(:limit => 6).each do |user|
    33.times do |s|
      user.answers.create!(
        :stack_id => s+1,
        :choice_id => rand(3)+1)
    end
  end
end

