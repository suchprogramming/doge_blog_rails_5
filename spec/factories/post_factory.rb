FactoryGirl.define do
  factory :post_with_user, class: "Post" do
    association :postable, factory: :user
    title "Happy Trees"
    post_content "Lizard Crimson"
  end

  factory :post do
    title "Hello HI"
    post_content "TEST"
  end
end
