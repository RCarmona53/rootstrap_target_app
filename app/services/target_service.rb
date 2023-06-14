class TargetService
  def self.create_conversation(user, matched_user)
    Conversation.create_chat(user, matched_user)
  end
end
