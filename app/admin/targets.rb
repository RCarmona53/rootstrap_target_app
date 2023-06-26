ActiveAdmin.register Target do
  permit_params :title, :lat, :lng, :radius, :topic_id

  filter :title
  filter :radius
  filter :lat
  filter :lng
  filter :topic, as: :select, collection: -> { Topic.all }, multiple: true
  filter :user

  index do
    selectable_column
    id_column
    column :title
    column :radius, min: 0
    column :lat
    column :lng
    column :topic
    column :user
    actions
  end
  filter :title
  filter :topic
  filter :user

  controller do
    def scoped_collection
      super.includes(:topic, :user)
    end
  end
end
