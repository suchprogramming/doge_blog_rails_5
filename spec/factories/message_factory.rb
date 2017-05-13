FactoryGirl.define do
  factory :message do
    association :messageable
    association :conversation
    text        'This is a new message!'
  end
end
