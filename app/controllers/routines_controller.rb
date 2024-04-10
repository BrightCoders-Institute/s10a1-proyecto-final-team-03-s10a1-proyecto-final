class RoutinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_routine, only: %i[show destroy edit update]

  def new
    @routine = Routine.new
  end

  def create
    @routine = current_user.routines.build(post_params)
    redirect_to routines_path if @routine.save
  end

  def index
    @routines = Routine.all
  end

  def show; end

  def edit
    return if current_user == @routine.user

    redirect_to root_path, alert: 'You are not authorized to edit this post.',
                           status: :unauthorized
  end

  def update
    unless current_user == @routine.user
      redirect_to root_path, alert: 'You are not authorized to update this post.',
                             status: :unauthorized
    end

    redirect_to routines_path if @routine.update(post_params)
  end

  def destroy
    @routine.destroy
  end

  private

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def post_params
    params.require(:routine).permit(:exercise)
  end
end
