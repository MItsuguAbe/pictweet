class CommentsController < ApplicationController
    def create
        @comment = Comment.create(text: comment_params[:text], tweet_id: comment_params[:tweet_id], user_id: current_user.id)
        respond_to do |format|
            format.html { redirect_to tweet_path(params[:tweet_id])  }
            format.json
        end
    end
    #ローカル変数commentだとスコープの関係でこの後のjbuilder側で使用できないので、インスタンス変数@commentに編集します。
    
    private
    def comment_params
        params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
    end
end
