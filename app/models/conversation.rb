# == Schema Information
#
# Table name: conversations
#
#  conversation_id :bigint           not null, primary key
#  topic_icon      :string
#  last_message    :string
#  unread_messages :integer          default(0)
#  user_id         :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_conversations_on_user_id  (user_id)
#
class Conversation < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :users, through: :matches

  def self.create_chat(current_user, matched_user)
    ConversationService.create_chat(current_user, matched_user)
  end
end
