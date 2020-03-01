class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: [:edit, :show, :update]
  
  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    if @story.save
      redirect_to stories_path, notice: "Way to go!"
    else
      render 'new', notice: "Something is in error."
    end
  end

  def update
    if @story.update(story_params)
      redirect_to story_path, notice: "Updated successfully"
    else
      render 'edit', notice: "Somthing is in error."
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :content, :status)
  end

  def find_story
    @story = current_user.stories.find(params[:id])
  end
end
