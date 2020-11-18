class CreateLabRecordImportsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_record_imports_tags do |t|
      t.references :lab_record_import, foreign_key: true, :null => false
      t.references :tag, foreign_key: true, :null => false
      t.timestamps

      t.index [ :lab_record_import_id, :tag_id ], :unique => true, :name => 'index_on_lab_record_import_id_and_tag_id'
    end
  end
end
