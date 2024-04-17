class SeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_routine
  before_action :set_series, only: %i[show destroy edit update]

  def new
    @series = @routine.series.build
  end

  def create
    @series = @routine.series.build(series_params)
    redirect_to routine_path(@routine) if @series.save
  end

  def index; end

  def show; end

  def edit
    return if current_user == @routine.user

    redirect_to root_path, alert: 'You are not authorized to edit this serie.',
                           status: :unauthorized
  end

  def update
    unless current_user == @routine.user
      redirect_to root_path, alert: 'You are not authorized to update this serie.',
                             status: :unauthorized
    end

    if @series.update(series_params)
      redirect_to routine_path(@routine), notice: 'Series was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    unless current_user == @routine.user
      redirect_to root_path, alert: 'You are not authorized to delete this serie.',
                             status: :unauthorized
    end

    @series.destroy
    redirect_to routine_path(@routine), notice: 'Series was successfully destroyed.'
  end

  private

  def set_routine
    @routine = Routine.find_by(id: params[:routine_id])
  end

  def set_series
    @series = Series.find(params[:id])
  end

  def series_params
    params.require(:series).permit(:name)
  end
end
