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
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  subject { create(:conversation_with_users) }

  context 'validations' do
    it { is_expected.to have_many(:users) }
  end
end
