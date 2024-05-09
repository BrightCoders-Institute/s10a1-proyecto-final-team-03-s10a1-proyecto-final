class StoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @stories = Story.new
  end

  def create
    @stories = current_user.stories.build(stories_params)

    redirect_to posts_path if @stories.save
  end

  def show
    @stories = current_user.stories

    stories_json = @stories.map do |story|
      {
        id: story.id,
        name: story.body,
        day: story.day,
        images: story.images.attached? ? rails_blob_path(story.images.first, only_path: true) : nil
      }
    end

    render json: { stories: stories_json }
  end

  def index
    @stories = current_user.stories.all.paginate(page: params[:page], per_page: 1)
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy if @story.user == current_user
    redirect_to stories_path
  end

  private

  def stories_params
    params.require(:story).permit(:body, :day, images: [])
  end
end
