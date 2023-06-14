class ConversationService
  def self.create_chat(current_user, matched_user)
    return if already_created?(current_user, matched_user)

    conversation = current_user.conversations.create!(user_id: current_user.id)
    matched_user.conversations << conversation
    conversation
  end

  def self.already_created?(current_user, matched_user)
    result = false
    current_user.conversations.each do |conv|
      result = true if conv.users.include?(matched_user)
    end
    result
  end
end
