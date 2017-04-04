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
    association :postable, factory: :user, email: 'seconduser@email.com', name: 'McCree'
    title 'Bob Ross Fan Club'
    post_content 'Liquid White'
  end

  factory :current_admin_post, class: 'Post' do
    association :postable, factory: :admin
    title 'Admin Post'
    post_content 'Pthalo Blue'
  end

  factory :alternate_admin_post, class: 'Post' do
    association :postable, factory: :admin, email: 'secondadmin@email.com', name: 'Bastion'
    title 'Admin Post 2'
    post_content 'Forgot the Red Color'
  end

  factory :current_user_post_comment, class: 'Post' do
    association :postable, factory: :user, email: 'testingcomments@email.com'
    title 'Testing Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create(:comment, post: post, commentable: post.postable)
      create(:comment, post: post, commentable: create(:user, email: 'testing1@comments.com', name: 'Rheinhardt1'))
      create(:comment, post: post, commentable: create(:admin, email: 'testing2@comments.com', name: 'Rheinhardt2'))
    end
  end

  factory :current_user_post_comment_pack, class: 'Post' do
    association :postable, factory: :user, email: 'testingcomments@email.com', name: 'Reaper'
    title 'Testing Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create_list(:comment, 26, post: post, commentable: post.postable)
    end
  end

  factory :current_admin_post_comment, class: 'Post' do
    association :postable, factory: :admin, email: 'testingcomments@email.com', name: 'Symmetra'
    title 'Testing Admin Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create(:comment, post: post, commentable: post.postable)
      create(:comment, post: post, commentable: create(:user, email: 'testing3@comments.com', name: 'Tracer1'))
      create(:comment, post: post, commentable: create(:admin, email: 'testing4@comments.com', name: 'Tracer2'))
    end
  end

  factory :current_user_post_filter_search, class: 'Post' do
    association :postable, factory: :user, email: 'searching@search.com', name: 'SearchDoge'
    title 'Testing Search & Filter'
    post_content 'Sage Green'

    after(:create) do |post|
      create(:post_with_user, postable: post.postable, title: 'Testing Search & Filter', post_content: 'Sage Green', created_at: 3.days.ago)
      create(:post_with_user, postable: post.postable, title: 'Testing Search & Filter', post_content: 'Sage Green', created_at: 3.weeks.ago)
      create(:post_with_user, postable: post.postable, title: 'Testing Search & Filter', post_content: 'Sage Green', created_at: 3.months.ago)
    end
  end

end
