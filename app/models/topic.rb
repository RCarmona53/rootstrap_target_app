# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_name  (name) UNIQUE
#

class Topic < ApplicationRecord
  has_many :targets, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image, presence: true
end
