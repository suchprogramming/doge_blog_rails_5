require 'rails_helper'

RSpec.describe Admin, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_attached_file(:avatar) }
  it { should validate_attachment_content_type(:avatar)
    .allowing('image/png', 'image/gif')
    .rejecting('text/plain', 'text/xml') }

  it { should have_many(:conversations) }
  it { should have_many(:comments) }
  it { should have_many(:invitations) }
  it { should have_many(:messages) }
  it { should have_many(:posts) }

  it 'should raise an ActiveRecord:RecordInvalid error on new_invitation context' do
    expect { build(:admin).save!(context: :new_invitation) }
      .to raise_error(ActiveRecord::RecordInvalid)
  end
end
