class RemoveCommentFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :comment, :text
  end
end
