class WelcomeController < ApplicationController

  def index
  	@venuetypes = Venuetype.all
  	@neighborhoods = Neighborhood.all

  	@recentActivity = List.recent + Venue.recent + Neighborhood.recent + Venuetype.recent + Try.recent + Rating.recent + Comment.recent + ItemRating.recent
    @recentActivity.sort_by(&:updated_at)
  end

  def map
    @tries = []
    if user_signed_in? and params[:totry] == '1'
      current_user.tries.each do |t|
        @tries.push(t.venue)
      end
    else
      @tries = Venue.all
    end

    if params[:restaurants] == '0'
      @restaurants = Venue.none
    else
      @restaurants = Venue.all
    end

    @venues = @tries + @restaurants

    @restaurantsButtonHTML = 'Restaurants<i class="fa fa-fw fa-check right"></i><i class="fa fa-fw fa-circle-o right"></i>'
    @tryButtonHTML = 'To Try<i class="fa fa-fw fa-check right"></i><i class="fa fa-fw fa-circle-o right"></i>'
  end

  def about
  end

end
