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

class Target < ApplicationRecord
  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :lat, :lng, presence: true, numericality: true

  belongs_to :topic
  belongs_to :user

  validate :max_target_amount_reached, unless: -> { user.nil? }

  MAX_TARGETS = ENV.fetch('TARGET_CREATION_LIMIT', '3').to_i

  private

  def max_target_amount_reached
    return if user.targets.count < MAX_TARGETS

    errors.add(:user, I18n.t('api.errors.max_targets_reached'))
  end
end
