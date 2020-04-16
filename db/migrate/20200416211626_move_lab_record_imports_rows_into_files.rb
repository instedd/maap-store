class MoveLabRecordImportsRowsIntoFiles < ActiveRecord::Migration[5.2]
  class LabRecordImport < ApplicationRecord
    has_one_attached :rows_file
  end

  def up
    LabRecordImport.all.each do |l|
      # Don't create files unless there is content (!nil or !{})
      if l.rows && !l.rows.empty?
        rows_file = StringIO.new(l.rows)
        l.rows_file.attach(io: rows_file, filename: "rows-lab-record-import-#{l.id}", content_type: 'application/json')
      end
    end
  end

  def down
  end
end
