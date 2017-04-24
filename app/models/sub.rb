# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    foreign_key: :moderator_id,
    class_name: :User

  has_many :posts_subs, dependent: :destroy,
    foreign_key: :sub_id,
    class_name: :PostSub

  has_many :posts,
    through: :posts_subs,
    source: :post


end
