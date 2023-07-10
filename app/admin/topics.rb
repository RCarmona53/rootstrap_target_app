ActiveAdmin.register Topic do
  permit_params :name, :image

  index do
    selectable_column
    id_column
    column :name
    column :image
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :image
    end
  end
end
