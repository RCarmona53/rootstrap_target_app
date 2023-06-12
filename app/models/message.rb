# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true, length: { maximum: 1000 }

  scope :ordered, -> { order(created_at: :asc) }
end
