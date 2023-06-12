json.message_id message.id
json.content message.content
json.user do
  json.user_id message.user.id
  json.username message.user.username
end
json.created_at message.created_at
