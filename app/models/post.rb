# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :string           not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :sub, :author, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  has_many :posts_subs, dependent: :destroy,
    foreign_key: :post_id,
    class_name: :PostSub

  has_many :subs,
    through: :posts_subs,
    source: :sub

end
