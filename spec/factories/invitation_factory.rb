FactoryGirl.define do
  factory :invitation do
    association :admin, factory: :super_admin
    recipient_email 'new_admin@admin.com'
  end
end
