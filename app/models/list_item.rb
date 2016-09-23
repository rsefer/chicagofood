class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :venue
  belongs_to :venuetype
  belongs_to :neighborhood

  validates_uniqueness_of :venue_id, :allow_nil => true, scope: :list_id, :message => 'Venue already exists in this list.'

  default_scope { order('date DESC') }

  def sortable_name
    if self.manual_entry == true
      self.venue_name
    else
      self.venue.sortable_name
    end
  end

end
