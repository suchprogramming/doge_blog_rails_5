require 'rails_helper'

RSpec.describe VoteHelper, :type => :helper do
  include SvgIconHelper

  let(:current_user) { User.new(id: 1) }
  let(:post) { Post.new(id: 1, postable_id: user.id, postable_type: 'User') }
  let(:vote) { Vote.new(id: 1, voteable_id: post.id, voteable_type: 'Post', user_id: user.id) }

  def vote_params
    {
      "vote[direction]": 'up',
      post_id: 1
    }
  end

  def config_fixture
    {
      params: {
        "vote[direction]": "up",
        user_id: 1,
        post_id: 1
      },
      remote: true,
      class: "waves-effect waves-teal btn-flat vote-button",
      id: 'vote-post-up-1'
    }
  end

  describe '#vote_btn' do
    it 'returns a vote button form with params and a specified direction' do
      expect(vote_btn(current_user, 'up', vote_params)).to include('active-up')
      expect(vote_btn(current_user, 'up', vote_params)).to include('user_id')
      expect(vote_btn(current_user, 'up', vote_params)).to include('post_id')
      expect(vote_btn(current_user, 'up', vote_params)).to include('vote-post-up-1')
    end

    it 'returns if no current user is present' do
      expect(vote_btn(nil, 'up', vote_params)).to eq(nil)
    end

    it 'returns if no vote direction is specified on the button element' do
      expect(vote_btn(current_user, 'up', { post_id: 1, "vote[direction]": nil })).to eq(nil)
    end

    it 'returns the default button without an active class if direction is not specified' do
      expect(vote_btn(current_user, nil, vote_params)).not_to include('active-up')
      expect(vote_btn(current_user, nil, vote_params)).not_to include('active-down')
    end
  end

  describe '#btn_config' do
    it 'returns a configuration hash given a current user and params' do
      expect(btn_config(current_user, vote_params)).to eq(config_fixture)
    end

    it 'returns if no current user is present' do
      expect(btn_config(nil, vote_params)).to eq(nil)
    end

    it 'returns if no vote direction param is specified' do
      expect(btn_config(current_user, { test: '123'})).to eq(nil)
    end
  end

  describe '#get_active_direction' do
    it 'returns an icon dependent on button direction with optional active class' do
      expect(get_active_direction('up', 'up')).to include('active-up')
      expect(get_active_direction('down', 'down')).to include('active-down')
      expect(get_active_direction('up', 'down')).not_to include('active-up')
      expect(get_active_direction('up', 'down')).not_to include('active-down')
    end

    it 'returns if a user vote direction is not specified' do
      expect(get_active_direction(nil, 'up')).to eq(nil)
    end

    it 'returns if a button vote direction is missing from the button element' do
      expect(get_active_direction('up', nil)).to eq(nil)
    end
  end
end
