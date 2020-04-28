class MoveLabRecordImportsRowsIntoFiles < ActiveRecord::Migration[5.2]
  class LabRecordImport < ApplicationRecord
    has_one_attached :rows_file
  end

  def up
    LabRecordImport.find_each do |l|
      # Avoid creating files when there isn't any content (nil or {})
      if l.rows.present?
        rows_file = StringIO.new(l.rows)
        l.rows_file.attach(io: rows_file, filename: "rows.json", content_type: 'application/json')
      end
    end
  end

  def down
  end
end
