class Sub < ActiveRecord::Base
  validates :title, :moderator, presence: true

  belongs_to :moderator,
    foreign_key: :moderator_id,
    class_name: :User

end
