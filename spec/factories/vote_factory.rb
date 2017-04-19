FactoryGirl.define do
  factory :vote do
    association :voteable
    association :user
    direction 'up'
  end
end
