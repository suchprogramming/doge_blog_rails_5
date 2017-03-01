FactoryGirl.define do
  factory :user do
    email        'test@test.com'
    password     123456
    name         'Neil'
    confirmed_at Time.now
  end

  factory :current_user, class: 'User' do
    email        'current_user@test.com'
    name         'Mercy'
    password     123456
    confirmed_at Time.now
  end

  factory :alternate_user, class: 'User' do
    email        'alternate_user@test.com'
    name         'Pharah'
    password     123456
    confirmed_at Time.now
  end
end
