class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true
  validates :title, uniqueness: { scope: :sub_id }

  belongs_to(
    :author,
    class_name: :User,
    foreign_key: :author_id
  )

  belongs_to :sub
end
