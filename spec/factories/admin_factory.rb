FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@admin.com" }
    sequence(:name)  { |n| "Admin#{n}" }
    password         123456
  end

  factory :alternate_admin, class: 'Admin' do
    sequence(:email) { |n| "alt_admin#{n}@admin.com" }
    sequence(:name)  { |n| "AltAdmin#{n}" }
    password         123456
  end

  factory :super_admin, class: 'SuperAdmin' do
    sequence(:email) { |n| "superadmin#{n}@admin.com" }
    sequence(:name)  { |n| "SuperAdmin#{n}" }
    password         123456
  end
end
