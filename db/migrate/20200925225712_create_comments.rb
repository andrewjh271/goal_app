class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :subject, polymorphic: true, null: false, index: true
      t.integer :author_id, null: false, index: true

      t.timestamps
    end

    # populate comments table with rows from user_comments and goal_comments
    UserComment.all.each do |user_comment|
      Comment.create!(body: user_comment.body,
                      subject_id: user_comment.user_id,
                      subject_type: 'User',
                      author_id: user_comment.author_id)
    end

    GoalComment.all.each do |goal_comment|
      Comment.create!(body: goal_comment.body,
                      subject_id: goal_comment.goal_id,
                      subject_type: 'Goal',
                      author_id: goal_comment.author_id)
    end

    drop_table :user_comments
    drop_table :goal_comments
  end
end
