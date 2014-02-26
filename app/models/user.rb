class User < ActiveRecord::Base
	
	mount_uploader :avatar, AvatarUploader
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :tries, :dependent => :destroy
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def user_comment_count
  	Comment.where(user_id: self.id).count
  end
  
  def user_rating_count
  	Rating.where(user_id: self.id).count
  end
  
  def user_score
  	self.user_comment_count + self.user_rating_count
  end
  
  def avatarurl
  	if self.avatar.blank?
  		"/images/default-avatar.jpg"
  	else
  		self.avatar
  	end
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
