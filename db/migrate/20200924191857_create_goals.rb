class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false, index: true
      t.string :title, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
