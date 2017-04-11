FactoryGirl.define do
  factory :current_user_post, class: 'Post' do
    association :postable, factory: :user
    title 'Happy Trees'
    post_content 'Lizard Crimson'
  end

  factory :alternate_user_post, class: 'Post' do
    association :postable, factory: :user
    title 'Bob Ross Fan Club'
    post_content 'Liquid White'
  end

  factory :current_admin_post, class: 'Post' do
    association :postable, factory: :admin
    title 'Admin Post'
    post_content 'Pthalo Blue'
  end

  factory :alternate_admin_post, class: 'Post' do
    association :postable, factory: :admin
    title 'Admin Post 2'
    post_content 'Forgot the Red Color'
  end

  factory :current_user_post_comment, class: 'Post' do
    association :postable, factory: :user
    title 'Testing Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create(:comment, post: post, commentable: post.postable)
      create(:comment, post: post, commentable: create(:user))
      create(:comment, post: post, commentable: create(:admin))
    end
  end

  factory :current_user_post_comment_pack, class: 'Post' do
    association :postable, factory: :user
    title 'Testing Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create_list(:comment, 26, post: post, commentable: post.postable)
    end
  end

  factory :current_admin_post_comment, class: 'Post' do
    association :postable, factory: :admin
    title 'Testing Admin Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create(:comment, post: post, commentable: post.postable)
      create(:comment, post: post, commentable: create(:user))
      create(:comment, post: post, commentable: create(:admin))
    end
  end

  factory :current_user_post_filter_search, class: 'Post' do
    association :postable, factory: :user
    title 'Testing Search & Filter'
    post_content 'Sage Green'

    after(:create) do |post|
      create(:current_user_post, postable: post.postable, title: 'Testing Search & Filter', post_content: 'Sage Green', created_at: 3.days.ago)
      create(:current_user_post, postable: post.postable, title: 'Testing Search & Filter', post_content: 'Sage Green', created_at: 3.weeks.ago)
      create(:current_user_post, postable: post.postable, title: 'Testing Search & Filter', post_content: 'Sage Green', created_at: 3.months.ago)
    end
  end
end
