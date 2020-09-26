class CommentsIndicesNotUnique < ActiveRecord::Migration[5.2]
  def change
    remove_index :user_comments, column: :author_id
    remove_index :user_comments, column: :user_id
    remove_index :goal_comments, column: :author_id
    remove_index :goal_comments, column: :goal_id

    add_index :user_comments, :author_id
    add_index :user_comments, :user_id
    add_index :goal_comments, :author_id
    add_index :goal_comments, :goal_id
  end
end
