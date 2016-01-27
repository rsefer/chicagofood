class User < ActiveRecord::Base

  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :tries, :dependent => :destroy
  has_many :item_ratings, :dependent => :destroy
  has_many :eats, :dependent => :destroy
  has_many :lists, :dependent => :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :avatar,
		attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
		attachment_size: { less_than: 2.megabytes }

	has_attached_file :avatar,
		:styles => {
			:medium => '300x300#',
			:thumb => '100x100#'
		},
		:default_url => ActionController::Base.helpers.asset_path('default-avatar.jpg'),
		:storage => :s3,
		:s3_credentials => "#{Rails.root}/config/aws.yml",
    :s3_region => ENV['AWS_REGION'],
    :s3_protocol => :https

  def user_public_comment_count
  	Comment.where(user_id: self.id).where(private: false).count
  end

  def user_venue_rating_count
  	Rating.where(user_id: self.id).count
  end

  def user_item_rating_count
    ItemRating.where(user_id: self.id).count
  end

  def user_score
  	self.user_public_comment_count + self.user_venue_rating_count + self.user_item_rating_count
  end

  def fullname
		if !self.firstname.blank? && !self.lastname.blank?
			self.firstname + " " + self.lastname
		else
			self.email
		end
	end

	def hasaddress
		if !self.street.blank? && !self.city.blank?
			true
		else
			false
		end
	end

	def fulladdress
		if !self.state.blank?
			self.street + " " + self.city + ", " + self.state
		else
			self.street + " " + self.city
		end
	end

end
