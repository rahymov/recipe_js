class RecipeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :image
  belongs_to :user
  has_many :ingredients
  has_many :directions
  has_many :comments
  has_many :categories
  def image
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
end
