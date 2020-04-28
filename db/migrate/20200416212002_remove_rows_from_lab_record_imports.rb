class RemoveRowsFromLabRecordImports < ActiveRecord::Migration[5.2]
  def up
    remove_column :lab_record_imports, :rows
  end

  def down
    add_column :lab_record_imports, :rows, :jsonb
  end
end
