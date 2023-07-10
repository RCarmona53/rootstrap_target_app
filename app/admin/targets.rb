ActiveAdmin.register Target do
  permit_params :title, :lat, :lng, :radius, :topic_id
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
