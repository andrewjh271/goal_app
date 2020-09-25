class GoalsController < ApplicationController
  before_action :require_current_user, except: [:index, :show]
  before_action :must_belong_to_user, only: [:update, :edit, :destroy]

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to user_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    # @goal found in before_action
    render :edit
  end

  def update
    # @goal found in before_action
    if @goal.update(goal_params)
      redirect_to user_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])
    if @goal.secret && @goal.user_id != current_user.try(:id)
      redirect_to root_url
    else
      render :show
    end
  end

  def index
    @goals = Goal.where(secret: false)
    render :index
  end

  def destroy
    # @goal found in before_action
    @goal.destroy
    redirect_to user_url
  end

  private

  def must_belong_to_user
    @goal = Goal.find_by(id: params[:id] )
    redirect_to root_url unless @goal.user_id == current_user.id
  end

  def goal_params
    params.require(:goal).permit(:title, :completed, :secret)
  end
end
