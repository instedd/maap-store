class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, :null => false
      t.timestamps

      t.index [:name], unique: true
    end
  end
end
