class CreateUserComments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_comments do |t|
      t.text :body, null: false
      t.integer :user_id, null: false, index: { unique: true }
      t.integer :author_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
