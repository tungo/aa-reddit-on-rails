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
  validates :title, :author, presence: true

  validate :require_sub

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post,
    foreign_key: :post_id,
    class_name: :PostSub

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments, dependent: :destroy

  def comments_by_parent_id
    result = Hash.new { |h, k| h[k] = [] }

    self.comments.includes(:author).all.each do |comment|
      result[comment.parent_comment_id] << comment
    end

    result
  end

  private

  def require_sub
    if self.subs.length <= 0
      errors[:subs] << "Require at least 1 sub"
    end
  end

end
