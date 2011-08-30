# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Steve Brown"
  user.email                 "nycbrown@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "stack-#{n}@stkup.com"
end

Factory.define :answer do |a|
  a.stack_id "1"
  a.choice_id "15"
  a.association :user
end

Factory.define :interest do |interest|
  interest.interest_desc    "Parenting"
end
