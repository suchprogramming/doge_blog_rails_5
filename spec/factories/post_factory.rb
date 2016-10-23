FactoryGirl.define do
  factory :post do
    association :postable, factory: :user
    title "Happy Trees"
    post_content "Lizard Crimson"
  end
end
