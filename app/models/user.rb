class User < ActiveRecord::Base
	
	mount_uploader :avatar, AvatarUploader
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  def fullname
		if !self.firstname.blank? && !self.lastname.blank?
			self.firstname +  " " + self.lastname
		else
			self.email
		end
	end
  
end
