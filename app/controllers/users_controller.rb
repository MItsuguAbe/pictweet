class UsersController < ApplicationController

    def show
        user = User.find(params[:id])
        @nickname = user.nickname
        @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
    end

    def likes
        @user = User.find_by(id: params[:id])
        @nickname = @user.nickname
        @likes = Like.where(user_id: @user.id)
    end
end
