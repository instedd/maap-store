class FixRecordTypesForLabRecordImportAttachments < ActiveRecord::Migration[5.2]
  def up
    execute "UPDATE active_storage_attachments SET record_type='LabRecordImport' where record_type='MoveLabRecordImportsRowsIntoFiles::LabRecordImport'"
  end

  def down
  end
end
