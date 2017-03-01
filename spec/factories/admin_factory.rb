FactoryGirl.define do
  factory :admin do
    email        'admin@dogeadmin.com'
    name         'TurdFerguson'
    password     123456
  end

  factory :alternate_admin, class: 'Admin' do
    email        'alternate_admin@dogeadmin.com'
    name         'Mapache'
    password     123456
  end

  factory :super_admin, class: 'SuperAdmin' do
    email        'superadmin@admin.com'
    name         'Bob Ross'
    password     123456
  end
end
