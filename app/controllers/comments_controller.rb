class CommentsController < ApplicationController
  before_action :require_current_user

  def create
    comment = Comment.new(comment_params)
    comment.subject_id = params[:comment][:subject_id]
    comment.subject_type = params[:comment][:subject_type]
    comment.author_id = current_user.id
    comment.save
    if comment.subject_type == 'User'
      redirect_to user_url(comment.subject_id)
    else
      redirect_to goal_url(comment.subject_id)
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    comment.destroy
    if comment.subject_type == 'User'
      redirect_to user_url(comment.subject_id)
    else
      redirect_to goal_url(comment.subject_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end