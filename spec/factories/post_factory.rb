FactoryGirl.define do
  factory :post_with_user, class: 'Post' do
    association :postable, factory: :user
    title 'Happy Trees'
    post_content 'Lizard Crimson'
  end

  factory :current_user_post, class: 'Post' do
    association :postable, factory: :user
    title 'Happy Trees'
    post_content 'Lizard Crimson'
  end

  factory :alternate_user_post, class: 'Post' do
    association :postable, factory: :user, email: 'seconduser@email.com'
    title 'Bob Ross Fan Club'
    post_content 'Liquid White'
  end

  factory :current_admin_post, class: 'Post' do
    association :postable, factory: :admin
    title 'Admin Post'
    post_content 'Pthalo Blue'
  end

  factory :alternate_admin_post, class: 'Post' do
    association :postable, factory: :admin, email: 'secondadmin@email.com'
    title 'Admin Post 2'
    post_content 'Forgot the Red Color'
  end
end
