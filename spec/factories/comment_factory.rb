FactoryGirl.define do
  factory :comment do
    association :commentable
    association :post
    text 'I agree!'
  end
end
