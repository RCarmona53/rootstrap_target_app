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
FactoryBot.define do
  factory :conversation do
    factory :conversation_with_users do
      transient do
        user1 { create(:user) }
        user2 { create(:user) }
      end

      after(:build) do |conversation, evaluator|
        conversation.users << evaluator.user1
        conversation.users << evaluator.user2
        conversation.user_id = evaluator.user2.id
      end
    end

    trait :with_matching_targets do
      after(:create) do |conversation|
        user = conversation.users.first
        user2 = conversation.users.last

        target = create(:target, user: user)
        create_list(
          :target, 2,
          topic: target.topic,
          user: user2,
          lat: target.lat,
          lng: target.lng
        )
      end
    end
  end
end
