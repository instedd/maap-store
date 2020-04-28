class MoveElectronicPharmacyStockRowsIntoFiles < ActiveRecord::Migration[5.2]
  class ElectronicPharmacyStockRecord < ApplicationRecord
    has_one_attached :rows_file
  end

  def up
    ElectronicPharmacyStockRecord.find_each do |e|
      # Don't create files unless there is content (!nil or !{})
      if e.rows.present?
        rows_file = StringIO.new(e.rows)
        e.rows_file.attach(io: rows_file, filename: "rows.json", content_type: 'application/json')
      end
    end
  end

  def down
  end
end
