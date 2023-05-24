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
require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'validations' do
    subject { build :target }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_numericality_of(:radius).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:lat) }
    it { is_expected.to validate_numericality_of(:lng) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:topic) }
  end
end
