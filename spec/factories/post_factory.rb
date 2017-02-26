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

  factory :current_user_post_comment, class: 'Post' do
    association :postable, factory: :user, email: 'testingcomments@email.com'
    title 'Testing Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create(:comment, post: post, commentable: post.postable)
      create(:comment, post: post, commentable: create(:user, email: 'testing1@comments.com'))
      create(:comment, post: post, commentable: create(:admin, email: 'testing2@comments.com'))
    end
  end

  factory :current_user_post_comment_pack, class: 'Post' do
    association :postable, factory: :user, email: 'testingcomments@email.com'
    title 'Testing Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create_list(:comment, 26, post: post, commentable: post.postable)
    end
  end

  factory :current_admin_post_comment, class: 'Post' do
    association :postable, factory: :admin, email: 'testingcomments@email.com'
    title 'Testing Admin Comments'
    post_content 'Liquid White'

    after(:create) do |post|
      create(:comment, post: post, commentable: post.postable)
      create(:comment, post: post, commentable: create(:user, email: 'testing3@comments.com'))
      create(:comment, post: post, commentable: create(:admin, email: 'testing4@comments.com'))
    end
  end

end
