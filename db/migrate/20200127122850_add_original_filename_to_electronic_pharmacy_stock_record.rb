class AddOriginalFilenameToElectronicPharmacyStockRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :electronic_pharmacy_stock_records, :file_name, :string
    add_column :lab_record_imports, :file_name, :string
  end
end
