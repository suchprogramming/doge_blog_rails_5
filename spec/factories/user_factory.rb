FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "123456"
  end

  factory :current_user, class: "User" do
    email "current_user@test.com"
    password "123456"
  end

  factory :alternate_user, class: "User" do
    email "alternate_user@test.com"
    password "123456"
  end
end
