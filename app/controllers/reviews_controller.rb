class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reviews = Review.all
  end
  def create
		@recipe = Recipe.find(params[:id])
		@review = @recipe.reviews.create(review_params)

		redirect_to recipe_path(@recipe)
	end

	def destroy
		@recipe = Recipe.find(params[:recipe_id])
		@review = @recipe.reviews.find(params[:id])

		@comment.destroy
		redirect_to recipes_path(@recipe)
	end
  private
  def review_params
    params.require(:review).permit(:comment)
  end
end
