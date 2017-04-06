require 'rails_helper'

RSpec.describe CommentsHelper, :type => :helper do

  let(:post) { create(:post_with_user) }
  let(:comment) { create(:comment, post_id: post.id, commentable: post.postable) }

  def user
    comment.commentable
  end

  describe '#commenter_link' do
    it 'returns if no comment is present' do
      expect(commenter_link()).to eq(nil)
    end

    it 'returns the comment creators name if no user is logged in' do
      expect(commenter_link(nil, comment)).to eq(comment.commentable.name)
    end

    it 'returns a link to a user profile when given a current user' do
      expect(commenter_link(comment.commentable, comment))
        .to eq("<a href=\"/users/#{user.id}\">#{user.name}</a>")
    end
  end

  describe '#new_comment_link' do
    it 'returns if no user scope is present' do
      expect(new_comment_link(nil, nil)).to eq(nil)
    end

    it 'returns if no active user scope is present' do
      user.update(active: false)

      expect(new_comment_link(user, comment)).to eq(nil)
    end

    it 'returns a new comment link for a given current user' do
      expect(new_comment_link(user, post))
        .to include("/users/#{user.id}/posts/#{post.id}/comments/new")
    end
  end

  describe '#edit_comment_link' do
    it 'returns if no user scope is present' do
      expect(edit_comment_link(nil, nil)).to eq(nil)
    end

    it 'returns a link to edit a current user comment' do
      expect(edit_comment_link(post, comment))
        .to include("/users/#{user.id}/posts/#{post.id}/comments/#{comment.id}/edit")
    end
  end

  describe '#filter_flagged_comment' do
    it 'returns unless a comment object is present' do
      expect(filter_flagged_comment(nil)).to eq(nil)
    end

    it 'returns a static message if a comment has been flagged' do
      comment.update(flagged: true)

      expect(filter_flagged_comment(comment))
        .to eq('This comment has been flagged by administration')
    end

    it 'returns the comment text for appropriate comments' do
      expect(filter_flagged_comment(comment)).to eq(comment.text)
    end
  end

  describe '#user_form_tag' do
    def admin_input_fixture
      "<input type=\"hidden\" name=\"admin_id\" id=\"admin_id\" value=\"1\" />"
    end

    def user_input_fixture
      "<input type=\"hidden\" name=\"user_id\" id=\"user_id\" value=\"1\" />"
    end

    it 'returns if no user scope is provided' do
      expect(user_form_tag).to eq(nil)
    end

    it 'returns a hidden field tag with a user id if the current user is not an admin' do
      expect(user_form_tag(User.new(id: 1))).to eq(user_input_fixture)
    end

    it 'returns a hidden field tag with an admin id if the current user is an admin' do
      expect(user_form_tag(Admin.new(id: 1))).to eq(admin_input_fixture)
    end
  end
end
