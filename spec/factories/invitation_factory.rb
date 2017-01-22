FactoryGirl.define do
  factory :invitation do
    association :admin, factory: :superadmin
    recipient_email 'new_admin@admin.com'
  end
end
