class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_search
  def set_search
    @search=Recipe.search(params[:q])
  end
end
