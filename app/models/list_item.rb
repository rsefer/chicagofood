class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :venue

  validates_uniqueness_of :venue_id, scope: :list_id, :message => 'Venue already exists in this list.'

  default_scope { order('date DESC') }

end
