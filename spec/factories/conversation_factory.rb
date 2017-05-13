FactoryGirl.define do
  factory :conversation do
    association :sendable, factory: :user
    association :receivable, factory: :user

    after(:create) do |conv|
      create(:message, messageable: conv.sendable, conversation: conv)
      create(:message, messageable: conv.receivable, conversation: conv)
    end
  end
end
