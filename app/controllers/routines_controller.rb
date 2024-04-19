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
    @routines = current_user.routines.order(created_at: :asc)
  end

  def show; end

  def edit
    return if current_user == @routine.user

    redirect_to root_path, alert: 'You are not authorized to edit this routine.',
                           status: :unauthorized
  end

  def update
    unless current_user == @routine.user
      redirect_to root_path, alert: 'You are not authorized to update this routine.',
                             status: :unauthorized
    end

    redirect_to routines_path if @routine.update(post_params)
  end

  def destroy
    @routine.destroy

    redirect_to routines_path
  end

  private

  def set_routine
    @routine = Routine.find(params[:id])
    @series = @routine.series
    @exercises = @series.map(&:exercises).flatten.uniq
  end

  def post_params
    params.require(:routine).permit(:exercise)
  end
end
