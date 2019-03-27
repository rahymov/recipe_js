class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
		@recipe = Recipe.find(params[:recipe_id])
		@comment = @recipe.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
		render partial: 'comment', layout: false, :locals => {:comment => @comment}
	end

	def destroy
		@recipe = Recipe.find(params[:recipe_id])
		@comment = @recipe.comments.find(params[:id])
    if @comment.user == current_user
		  @comment.destroy
      respond_to do |f|
        f.html {redirect_to recipe_path(@recipe)}
        f.json {render json: @recipe, status: 201}
        f.js {render 'comments.js'}
      end
    else
      flash[:error] = "You not authorized."
      redirect_to recipe_path(@recipe)
    end
	end
  private
  def comment_params
    params.require(:comment).permit(:title, :body, :user_id, :recipe_id)
  end
end
