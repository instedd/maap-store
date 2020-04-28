class FixRecordTypesForElectronicPharmacyStockAttachments < ActiveRecord::Migration[5.2]
  def up
    execute "UPDATE active_storage_attachments SET record_type='ElectronicPharmacyStockRecord' where record_type='MoveLabRecordImportsRowsIntoFiles::ElectronicPharmacyStockRecord'"
  end

  def down
  end
end
