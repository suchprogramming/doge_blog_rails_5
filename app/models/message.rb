class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :messageable, polymorphic: true
end
