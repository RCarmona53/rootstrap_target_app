ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :username
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :username
end
