class Item < ActiveRecord::Base

  belongs_to :venue
  has_many :item_ratings, :dependent => :destroy
  has_many :eats, :dependent => :destroy

  scope :alpha, -> { order('name ASC') }

  def totalRatings
    ItemRating.where(item_id: self.id).count
  end

  def totalLikes
    ItemRating.where(item_id: self.id).where(liked: true).count
  end

  def percentLiked
    if totalRatings > 0
      self.totalLikes.to_f / self.totalRatings.to_f
    else
      false
    end
  end

end
