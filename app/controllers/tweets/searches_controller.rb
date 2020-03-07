class Tweets::SearchesController < ApplicationController
    def index
        @tweets = Tweet.search(params[:keyword])   #searchメソッドはtweetモデルに定義されてます
        respond_to do |format|
            format.html
            format.json
        end
    end
end


