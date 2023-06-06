json.conversation_id conversation.id
json.chat_user conversation.users.where.not(id: current_user.id)
