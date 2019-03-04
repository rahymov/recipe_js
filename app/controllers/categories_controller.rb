class CategoriesController < ApplicationController
  def index
    @category = Category.find(params[:id])
    @recipes = @category.recipes
  end

  def show
  end
end
