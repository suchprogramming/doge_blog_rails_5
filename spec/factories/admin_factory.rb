FactoryGirl.define do
  factory :admin do
    email 'admin@dogeadmin.com'
    password 123456
  end

  factory :superadmin, class: 'SuperAdmin' do
    email 'superadmin@admin.com'
    password 123456
  end
end
