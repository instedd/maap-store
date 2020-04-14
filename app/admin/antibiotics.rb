ActiveAdmin.register Antibiotic do
  actions :index, :show, :new, :create, :edit, :update
  permit_params :name, :strength_value, :strength_unit, :form, :pack_size,
                :brand

  form do |f|
    inputs 'Details' do
      input :name
      input :strength_value
      input :strength_unit
      input :form
      input :pack_size
      input :brand
    end
    actions
  end

  csv do
    column :id
    column :name
    column :strength_value
    column :strength_unit
    column :form
    column :pack_size
    column :brand
    column :created_at
    column :updated_at
  end

  filter :name
  filter :strength_value
  filter :strength_unit
  filter :form
  filter :pack_size
  filter :brand
  filter :created_at
  filter :updated_at
end
