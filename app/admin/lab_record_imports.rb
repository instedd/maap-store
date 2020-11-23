ActiveAdmin.register LabRecordImport do
  actions :index, :edit, :update
  permit_params :tags, tag_ids: []

  includes :site

  index :download_links => false do
    column :id
    column :file do |lab_record|
      next 'Error' if lab_record.error?
      next 'Obfuscating' unless lab_record.obfuscated?
      link_to 'Download',
              rails_blob_path(lab_record.sheet_file, disposition: 'attachment'),
              download: true
    end
    column :site
    column "Site Id", :site_id
    column :header_row
    column :data_rows_from
    column :data_rows_to
    column :tags
    column :error_message
    column :uploaded_at
    if Tag.count > 0 && current_admin_user.admin?
      actions 
    end
  end

  filter :site
  filter :file_name
  filter :header_row
  filter :error_message
  filter :created_at
  filter :uploaded_at

  form title: 'Tags', :html => {:class => "tags_list"} do |f|
    f.input :tags, as: :select, collection: Tag.all, multiple: true, label: false
    f.actions do 
      f.action :submit, as: :button, label: 'Update Tags'
      f.action :cancel, :wrapper_html => { :class => 'cancel'}, label: 'Cancel'
    end
  end
end
