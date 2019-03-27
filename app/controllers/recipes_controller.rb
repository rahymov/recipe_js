class RecipesController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , except: [:show, :index]
  before_action :require_user!, only: [:edit, :destroy, :update]
  def index
    @search = Recipe.search(params[:q])
    @recipes = @search.result.order_by_created_at_desc

    respond_to do |f|
      f.html { render :index}
      f.json { render json: @recipes}
    end
    # @recipes = Recipe.all.order_by_created_at_desc
  end

  def new
    @recipe = current_user.recipes.build

  end

  def create
    if current_user
      @recipe = current_user.recipes.build(recipe_params)
  		if @recipe.save
        flash[:success] = "Successfully created."
  			redirect_to @recipe
  		else
  			render 'new'
      end
    end
  end

  def show
    @reviews = Review.where(recipe_id: @recipe.id).order("created_at DESC")
    @comment = Comment.new
    respond_to do |f|
      f.html { render :show}
      f.json {render json: @recipe}
    end
  end

  def edit
  end

  def update
    if current_user
      if @recipe.update(recipe_params)
        flash[:success] = "Recipe successfully updated."
  			redirect_to @recipe
  		else
  			render 'edit'
  		end
    end
  end
  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Recipe successfully deleted."
  end

  def require_user!
    if current_user != Recipe.find(params[:id]).user
      flash[:error] = "Sorry you not authorized!"
      redirect_to root_path
    end
  end
  private
    def set_params
      @recipe = Recipe.find(params[:id])
    end
    def recipe_params
      params.require(:recipe).permit(
          :title, :description, :user_id, :image,
          ingredients_attributes:[:id, :name, :_destroy],
  				directions_attributes: [:id, :step, :_destroy],
          category_ids: [] )
    end
end
