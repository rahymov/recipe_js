class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  belongs_to :user
  belongs_to :recipe
end
