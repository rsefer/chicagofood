module Recent
  extend ActiveSupport::Concern

  included do
    scope :recent, -> { all.sort{ |a,b| b.updated_at <=> a.updated_at }.first(10) }
  end

end
