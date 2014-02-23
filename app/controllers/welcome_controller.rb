class WelcomeController < ApplicationController

  def index
  	@venuetypes = Venuetype.all.sort{ |a,b| a.name <=> b.name }
  	@neighborhoods = Neighborhood.all.sort{ |a,b| a.name <=> b.name }
  	
  	@recentVenues = Venue.all.sort{ |a,b| b.updated_at <=> a.updated_at }.first(10)
  	@recentNeighborhoods = Neighborhood.all.sort{ |a,b| b.updated_at <=> a.updated_at }.first(10)
  	@recentVenuetypes = Venuetype.all.sort{ |a,b| b.updated_at <=> a.updated_at }.first(10)
  	@recentTries = Try.all.sort{ |a,b| b.updated_at <=> a.updated_at }.first(10)
    @recentRatings = Rating.all.sort{ |a,b| b.updated_at <=> a.updated_at }.first(10)
    @recentComments = Comment.all.sort{ |a,b| b.updated_at <=> a.updated_at }.first(10)
    
    @recentActivity = @recentVenues + @recentTries + @recentNeighborhoods + @recentVenuetypes + @recentRatings + @recentComments
    @recentActivity.sort_by(&:updated_at)
  end
  
end
