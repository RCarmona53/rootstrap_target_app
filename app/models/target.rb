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

  scope :exclude_current_user, ->(current_user_id) { where.not(user_id: current_user_id) }
  scope :with_same_topic, ->(topic) { where(topic_id: topic) }

  belongs_to :topic
  belongs_to :user

  validate :max_targets, unless: -> { user.nil? }, on: :create
  after_create :create_conversation

  MAX_TARGETS = ENV.fetch('TARGET_CREATION_LIMIT', '3').to_i

  def matched_targets
    Target.exclude_current_user(user_id).with_same_topic(topic_id)
  end

  private

  def max_targets
    return unless user.targets.count == MAX_TARGETS

    errors.add(:user, I18n.t('api.errors.max_targets_reached', max_targets: MAX_TARGETS))
  end

  def create_conversation
    matched_users = matched_targets.map do |target|
      matched_user = target.user
      Conversation.create_chat(user, matched_user)
      matched_user
    end
    matched_users.uniq
  end
end
