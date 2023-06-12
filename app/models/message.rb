# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true, length: { maximum: 1000 }

  scope :ordered, -> { order(created_at: :asc) }
end
