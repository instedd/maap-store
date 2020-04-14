ActiveAdmin.register PatientIdHash do
  actions  :index, :destroy

  index :download_links => false

  filter :site_id, label: 'Site Id'
  filter :patient_id
  filter :hashed_value
  filter :created_at
  filter :updated_at
end
