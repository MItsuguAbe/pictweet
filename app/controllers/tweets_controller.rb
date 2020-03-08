class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  #before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = params[:tag_id].present? ? Tag.find(params[:tag_id]).tweets : Tweet.all
    @tweets = @tweets.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new                          
    @comments = @tweet.comments.includes(:user)     
    @likes_count = Like.where(tweet_id: @tweet.id).count
  end

  def search
    @tweets = Tweet.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end


  private
  def tweet_params
    params.require(:tweet).permit(:image, :text, tag_ids: []).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end