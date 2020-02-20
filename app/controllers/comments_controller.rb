class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to product_path(params[:product_id]), data: {"turbolinks" => false} }
        format.json
      end
    else
      redirect_to product_path(params[:product_id]), data: {"turbolinks" => false}
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
