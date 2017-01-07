FactoryGirl.define do
  factory :superadmin_invitation, class: 'Invitation' do
    association :admin, factory: :superadmin
    recipient_email "new_admin@admin.com"
  end
end
