class User < ActiveRecord::Base

  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :tries, :dependent => :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :avatar,
		attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
		attachment_size: { less_than: 2.megabytes }

	has_attached_file :avatar,
		:styles => {
			:medium => '300x300#',
			:thumb => '100x100#'
		},
		:default_url => '/images/default-avatar.jpg',
		:storage => :s3,
		:s3_credentials => "#{Rails.root}/config/aws.yml"

  def user_comment_count
  	Comment.where(user_id: self.id).count
  end

  def user_rating_count
  	Rating.where(user_id: self.id).count
  end

  def user_score
  	self.user_comment_count + self.user_rating_count
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
