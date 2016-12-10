class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true

  belongs_to :author
  belongs_to :post

  belongs_to(
    :parent_comment,
    class_name: :Comment,
    foreign_key: :parent_comment_id,
    primary_key: :id
  )

  has_many(
    :child_comments,
    class_name: :Comment,
    foreign_key: :parent_comment_id,
    primary_key: :id,
    dependent: :destroy
  )
end
