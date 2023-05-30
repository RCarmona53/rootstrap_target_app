# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  radius     :float            not null
#  lat        :float            not null
#  lng        :float            not null
#  user_id    :bigint           not null
#  topic_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
FactoryBot.define do
  factory :target do
    title       { Faker::Name.name }
    radius      { Faker::Number.between(from: 1.0, to: 600_000.0).round(2) }
    lat         { Faker::Address.latitude }
    lng         { Faker::Address.longitude }
    association :user, factory: :user
    association :topic, factory: :topic
  end
end
