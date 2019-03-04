module RecipesHelper
  def avarage_review
    average(:rating).present? ? @reviews.average(:rating).round(2) : 0
  end

  def recipe_user
    @recipe.user == current_user
  end
end
