require 'rails_helper'

RSpec.describe VoteHelper, :type => :helper do
  include SvgIconHelper

  let(:post) { create(:current_user_post_vote) }

  def current_user
    post.postable
  end

  def config_fixture
    {
      params: {
        "vote[direction]": "up",
        user_id: current_user.id,
        post_id: post.id
      },
      class: "waves-effect waves-teal btn-flat vote-button",
      id: "vote-post-up-#{post.id}",
      remote: true,
    }
  end

  describe '#upvote_btn' do
    it 'returns a vote button form with params and a specified direction' do
      expect(upvote_btn(current_user, post)).to include('active-up')
      expect(upvote_btn(current_user, post)).to include('user_id')
      expect(upvote_btn(current_user, post)).to include('post_id')
      expect(upvote_btn(current_user, post)).to include("vote-post-up-#{post.id}")
    end

    it 'returns a sign in link if no current user is present' do
      expect(upvote_btn(nil, post)).to include('/users/sign_in')
    end

    it 'returns an inactive button for admins and deactivated users' do
      current_user.update(active: false)

      expect(upvote_btn(current_user, post)).not_to include('vote-button')
    end
  end

  describe '#active_btn' do
    it 'returns unless a valid user, post, and direction are present' do
      expect(active_btn).to eq(nil)
    end

    it 'returns a button with configuration paramters for active current users' do
      expect(active_btn(current_user, post, 'up')).to include('active-up')
      expect(active_btn(current_user, post, 'up')).to include('user_id')
      expect(active_btn(current_user, post, 'up')).to include('post_id')
      expect(active_btn(current_user, post, 'up')).to include("vote-post-up-#{post.id}")
    end
  end

  describe '#vote_btn_config' do
    it 'returns a configuration hash given a current user and params' do
      expect(vote_btn_config(current_user, post, 'up')).to eq(config_fixture)
    end

    it 'returns if no current user is present' do
      expect(vote_btn_config(nil, post)).to eq(nil)
    end

    it 'returns if no post object is specified' do
      expect(vote_btn_config(current_user, nil, 'up')).to eq(nil)
    end

    it 'returns if no vote direction param is specified' do
      expect(vote_btn_config(current_user, post, nil)).to eq(nil)
    end
  end

  describe '#get_active_direction' do
    it 'returns an icon dependent on button direction with optional active class' do
      expect(get_active_direction(current_user, post, 'up')).to include('active-up')
      expect(get_active_direction(current_user, post, 'down')).not_to include('active-up')
    end

    it 'returns if a user vote direction is not specified' do
      expect(get_active_direction(current_user, post, nil)).to eq(nil)
    end
  end
end
