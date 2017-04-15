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

  5.times { |i| User.create!(email: "doge#{i+1}@thedogeblog.com", password: 123456, name: "Doge#{i+1}", confirmed_at: Time.current) }
  50.times { |i| Post.create!(title: "Test Post #{i+1}", post_content: 'Testing Posts', postable_id: rand(1..5), postable_type: 'User') }
  50.times { |i| Comment.create!(text: 'Testing!', commentable_type: 'User', commentable_id: rand(1..5), post_id: 50) }

  SuperAdmin.create!(email: 'superdoge@doge.com', password: 123456, name: 'SuperDoge')
end
