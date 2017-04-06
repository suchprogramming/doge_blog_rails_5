require 'rails_helper'

RSpec.describe UserAvatarHelper, :type => :helper do

  def avatar_attrs
    {
      avatar_approved: true,
      avatar_file_name: '/assets/spacedoge.png',
      avatar_content_type: 'image/pdf'
    }
  end

  describe '#render_user_avatar' do
    it 'returns the user designated avatar after admin approval' do
      expect(render_user_avatar(User.new(avatar_attrs), :thumb))
        .to include('/thumb/spacedoge.png')
      expect(render_user_avatar(User.new(avatar_attrs), :thumb))
        .not_to include('default-user-avatar')
    end

    it 'renders the default avatar when a user avatar is not approved' do
      expect(render_user_avatar(User.new)).to include('default-user-avatar')
    end
  end
end
