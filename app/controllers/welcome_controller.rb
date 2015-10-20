class WelcomeController < ApplicationController

  def index
  	@venuetypes = Venuetype.all
  	@neighborhoods = Neighborhood.all

  	@recentActivity = List.recent + Venue.recent + Neighborhood.recent + Venuetype.recent + Try.recent + Rating.recent + Comment.recent + ItemRating.recent
    @recentActivity.sort_by(&:updated_at)
  end

  def map


    @restaurants = []
    if params[:maxPrice].to_f >= 1 and params[:maxPrice].to_f <= 3
      @restaurants = Venue.where("price <= ?", params[:maxPrice].to_f)
    else
      @includeAllPrices = true
      @restaurants = Venue.all
    end

    @byob = []
    if params[:byob] == '1'
      @restaurants = @restaurants & Venue.where(byob: true)
    end

    @tries = []
    if user_signed_in? and params[:totry] == '1'
      current_user.tries.each do |t|
        @tries.push(t.venue)
      end
    end

    if @tries.length >= 1
      @venues = @tries & @restaurants
    else
      @venues = @restaurants
    end

    @restaurantsButtonHTML = 'Restaurants<i class="fa fa-fw fa-check right"></i><i class="fa fa-fw fa-circle-o right"></i>'
    @tryButtonHTML = 'To Try<i class="fa fa-fw fa-check right"></i><i class="fa fa-fw fa-circle-o right"></i>'
    @byobButtonHTML = '<i class="fa fa-fw fa-beer left"></i>BYOB<i class="fa fa-fw fa-check right"></i><i class="fa fa-fw fa-circle-o right"></i>'
  end

  def about
  end

end
