class Try < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user

  default_scope { order('updated_at DESC') }

  include Recent

end
