FactoryGirl.define do
  factory :user do
    email
    name
    password     123456
    confirmed_at Time.now
  end

  factory :current_user, class: 'User' do
    email
    name
    password     123456
    confirmed_at Time.now
  end

  factory :alternate_user, class: 'User' do
    email
    name
    password     123456
    confirmed_at Time.now
  end
end
