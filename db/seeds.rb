# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
  when 'development'
  User.destroy_all
  Post.destroy_all
  Admin.destroy_all
  Conversation.destroy_all

  10.times { |i| User.create!(email: "doge#{i+1}@thedogeblog.com", password: 123456, name: "Doge#{i+1}", confirmed_at: Time.current) }
  50.times { |i| Post.create!(title: "Test Post #{i+1}", post_content: 'Testing Posts', postable_id: rand(1..10), postable_type: 'User') }
  50.times { |i| Comment.create!(text: 'Testing!', commentable_type: 'User', commentable_id: rand(1..10), post_id: 50) }

  users = User.all.reject { |user| user.id == 1 }

  9.times do
    conv = Conversation.create!(sendable: User.find(1), receivable: users.shuffle!.pop )
    participants = [conv.sendable, conv.receivable]
    10.times { conv.messages.create!(text: 'TESTING MESSAGES', messageable: participants.sample) }
  end

  SuperAdmin.create!(email: 'superdoge@doge.com', password: 123456, name: 'SuperDoge')
end
