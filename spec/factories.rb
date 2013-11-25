FactoryGirl.define do
  factory :user do
    name                  "Alex Kowalczuk"
    email                 "ask@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end

#  Defining how users should be created when we call 
#  FactoryGirl.create(:user)