json.topics do |json|
  json.array! @topics, :id, :name, :image, :created_at, :updated_at
end
