class WelcomeController < ApplicationController
  before_action :find_story, only: [:show]
  
  def index
    # @stories = Story.order(created_at: :desc).includes(:user)
    # @stories = Story.where(status: 'published').order(created_at: :desc).includes(:user)
    # @stories = Story.published_stories.order(created_at: :desc).includes(:user)
    @stories = Story.published_stories
    @stories_five = Story.published_stories.limit(5)
  end
  
  def show
    @comment = @story.comments.new
    @comments = @story.comments.order(id: :desc)
  end
  
  def user
    @user = User.find_by(username: params[:username])
    @stories = @user.stories.published_stories
  end
  
  private
  
  def find_story
    @story = Story.friendly.find(params[:story_id])
  end
end