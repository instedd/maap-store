class RemoveRowsFromElectronicPharmacyStock < ActiveRecord::Migration[5.2]
  def up
    remove_column :electronic_pharmacy_stock_records, :rows
  end

  def down
    add_column :electronic_pharmacy_stock_records, :rows, :jsonb
  end
end
