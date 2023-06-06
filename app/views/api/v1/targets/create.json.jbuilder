json.target do
  json.partial! 'target', target: @target
end
json.matched_users do
  json.array!(
    @matched_users,
    partial: '/api/v1/matched_users/matched_user', as: :matched_user
  )
end
