class Admin::PostCommentsController < ApplicationController
  def destroy
    post_comment = PostComment.find(params[:id])
    post = post_comment.post
    post_comment.destroy
    redirect_to admin_post_path(post)
  end


  private

  def post_comment_params
     params.require(:post_comment).permit(:comment)
  end
end
