class CreatePatientEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_entries do |t|
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
