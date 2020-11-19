ActiveAdmin.register Tag do
  permit_params :name

  index do
    id_column
    column :name
    column :created_at
    actions
  end

  filter :id
  filter :name
  filter :created_at
end
