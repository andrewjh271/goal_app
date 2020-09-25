class GoalCommentsController < ApplicationController
  def create
    comment = GoalComment.new(comment_params)
    comment.goal_id = params[:goal_comment][:goal_id]
    comment.author_id = current_user.id
    comment.save
    redirect_to goal_url(comment.goal_id)
  end

  def destroy
    comment = GoalComment.find_by(id: params[:id])
    comment.destroy
    redirect_to goal_url(comment.goal_id)
  end

  private

  def comment_params
    params.require(:goal_comment).permit(:body)
  end
end