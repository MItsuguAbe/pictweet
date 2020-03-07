class Tweets::SearchesController < ApplicationController
    def index
        @tweets = Tweet.search(params[:keyword])   #searchメソッドはtweetモデルに定義されてます
    end
end


