class CreateTimeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_entries do |t|
      t.string :detail, null: false
      t.date :date, null: false
      t.integer :minutes, null: false
      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
