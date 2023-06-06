# == Schema Information
#
# Table name: matches
#
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_matches_on_conversation_id_and_user_id  (conversation_id,user_id)
#
class Match < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
end
