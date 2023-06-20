json.conversation_id conversation.id
json.topic_icon conversation.topic_icon
json.chat_user conversation.users.where.not(id: current_user.id)
