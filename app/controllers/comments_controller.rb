class CommentsController < ApplicationController  
  def create
    @comment = Comment.create(text: comment_params[:text], tweet_id: comment_params[:tweet_id], user_id: current_user.id)
    #コメントと結びつくツイートの詳細画面に遷移する
    respond_to do |format|
      format.html { redirect_to tweet_path(params[:tweet_id])}
      format.json
    end
    # binding.pry
  end
 private
 def comment_params
  params.permit(:text, :tweet_id)
 end
end 