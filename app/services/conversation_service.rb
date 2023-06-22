class ConversationService
  def self.create_chat(current_user, matched_user)
    return if already_created?(current_user, matched_user)

    conversation = current_user.conversations.create!(user_id: current_user.id)
    matched_user.conversations << conversation
    conversation
  end

  def self.already_created?(current_user, matched_user)
    current_user.conversations.any? { |conversation| conversation.users.include?(matched_user) }
  end
end
