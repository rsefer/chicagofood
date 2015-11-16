class WelcomeController < ApplicationController

  def index
  	@venuetypes = Venuetype.all
  	@neighborhoods = Neighborhood.all

  	@recentActivity = List.recent + Venue.recent + Neighborhood.recent + Venuetype.recent + Try.recent + Rating.recent + Comment.recent + ItemRating.recent
    @recentActivity.sort_by(&:updated_at)
  end

  def search
    if params[:q]
      @searchresults = []
      @original_query = params[:q]
      query = params[:q].downcase.split(' ').map(&:strip).uniq

      query.delete('the')

      byob_results = []
      if query.include? 'byob'
        byob = true
        query.delete('byob')
        byob_results = Venue.where(byob: true).all
      end

      n_results = []
      vtypes_results = []
      query.each do |qw|
        Neighborhood.where("lower(name) LIKE ?", "%#{qw}%").each do |n|
          n.venues_with_children.each do |v|
            n_results.push(v)
          end
        end
        Venuetype.where("lower(name) LIKE ?", "%#{qw}%").each do |vt|
          vt.venues.each do |v|
            vtypes_results.push(v)
          end
        end
      end

      if byob_results.length > 0 and n_results.length > 0 and vtypes_results.length > 0
        @searchresults = byob_results & n_results & vtypes_results
      elsif byob_results.length > 0 and vtypes_results.length > 0
        @searchresults = byob_results & vtypes_results
      elsif byob_results.length > 0 and n_results.length > 0
        @searchresults = byob_results & n_results
      elsif n_results.length > 0 and vtypes_results.length > 0
        @searchresults = n_results & vtypes_results
      elsif byob_results.length > 0
        @searchresults = byob_results
      elsif n_results.length > 0
        @searchresults = n_results
      elsif vtypes_results.length > 0
        @searchresults = vtypes_results
      end

    end
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
