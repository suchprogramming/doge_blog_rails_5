FactoryGirl.define do
  factory :admin do
    email        'admin@dogeadmin.com'
    password     123456
  end

  factory :alternate_admin, class: 'Admin' do
    email        'alternate_admin@dogeadmin.com'
    password     123456
  end

  factory :super_admin, class: 'SuperAdmin' do
    email        'superadmin@admin.com'
    password     123456
  end
end
