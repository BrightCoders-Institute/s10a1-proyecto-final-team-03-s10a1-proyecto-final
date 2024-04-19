class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_routine
  before_action :set_series
  before_action :set_exercise, only: %i[show destroy edit update]

  def new
    @exercise = @series.exercises.build
  end

  def create
    @exercise = @series.exercises.build(exercise_params)
    redirect_to routine_path(@routine) if @exercise.save
  end

  def index; end

  def show; end

  def edit
    return if current_user == @routine.user

    redirect_to root_path, alert: 'You are not authorized to edit this exercise.',
                           status: :unauthorized
  end

  def update
    unless current_user == @routine.user
      redirect_to root_path, alert: 'You are not authorized to update this exercise.',
                             status: :unauthorized
    end

    if @exercise.update(exercise_params)
      redirect_to routine_path(@routine), notice: 'Exercise was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    unless current_user == @routine.user
      redirect_to root_path, alert: 'You are not authorized to delete this exercise.',
                             status: :unauthorized
    end

    @exercise.destroy
    redirect_to routine_path(@routine), notice: 'Exercise was successfully destroyed.'
  end

  private

  def set_routine
    @routine = Routine.find_by(id: params[:routine_id])
  end

  def set_series
    @series = Series.find_by(id: params[:series_id])
  end

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:repetitions, :weight)
  end
end
