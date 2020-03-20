class Api::StoriesController < Api::BaseController
  before_action :authenticate_user!

  def clap
    story = Story.friendly.find(params[:id])
    story.increment!(:clap)
    render json: { status: story.clap }
  end

  def bookmark
    render json: { status: "good" }
  end
end
