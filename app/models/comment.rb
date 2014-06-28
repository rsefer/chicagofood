class Comment < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user

  include Recent

end
