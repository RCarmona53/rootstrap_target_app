# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#  content         :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  MAX_CONTENT_LENGTH = 1000

  validates :content, presence: true, length: { maximum: MAX_CONTENT_LENGTH }

  scope :ordered, -> { order(created_at: :asc) }
end
