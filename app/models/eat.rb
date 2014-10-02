class Eat < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  belongs_to :venue

  include Recent
  
end
