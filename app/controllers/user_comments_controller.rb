class UserCommentsController < ApplicationController
  before_action :require_current_user

  def create
    comment = UserComment.new(comment_params)
    comment.user_id = params[:user_comment][:user_id]
    comment.author_id = current_user.id
    comment.save
    redirect_to user_url(comment.user_id)
  end

  def destroy
    comment = UserComment.find_by(id: params[:id])
    comment.destroy
    redirect_to user_url(comment.user_id)
  end

  private

  def comment_params
    params.require(:user_comment).permit(:body)
  end
end