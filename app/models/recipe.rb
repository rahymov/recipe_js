class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  validates :title, :description, presence: true, uniqueness: true
  ratyrate_rateable "title"
  has_one_attached :image
  delegate :filename, to: :image, allow_nil: true

  has_many :directions
  has_many :ingredients
  accepts_nested_attributes_for :ingredients,
																reject_if: proc {|attributes| attributes['name'].blank?},
																allow_destroy: true
	accepts_nested_attributes_for :directions,
																reject_if: proc {|attributes| attributes['step'].blank?},
																allow_destroy: true

  scope :order_and_categories, -> { order("title")}
  def self.order_by_created_at_desc
    order("created_at desc")
  end
  has_many :reviews
  has_many :comments, :dependent => :destroy

  def self.review_order_by_date
    where(recipe_id: @recipe.id).order("created_at DESC")
  end
end
