# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :topic do
    name { Faker::Name.unique.name }
    after(:build) do |topic|
      topic.image.attach(io: File.open('app/assets/images/PC.png'), filename: 'PC.png')
    end
  end
end
