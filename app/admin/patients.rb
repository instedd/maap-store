ActiveAdmin.register Patient do
  actions :index, :edit, :update
  permit_params :gender, :year_of_birth, :level_of_education

  includes :site

  form do |f|
    inputs 'Details' do
      input :patient_id, input_html: { disabled: true }
      input :gender, as: :select, collection: ['not specified', 'female', 'male', 'other']
      input :year_of_birth
      input :level_of_education
    end
    actions
  end
  
  csv do
    column :id
    column :gender
    column :year_of_birth
    column :level_of_education
    column :patient_id
    column :site_id
    column :created_at
    column :updated_at
  end

  filter :site
  filter :patient_id
  filter :patient_id_state
  filter :gender
  filter :year_of_birth
  filter :level_of_education
  filter :created_at
  filter :updated_at
end
