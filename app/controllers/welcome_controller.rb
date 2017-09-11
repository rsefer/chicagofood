class WelcomeController < ApplicationController

  def index
  	@venuetypes = Venuetype.all
  	@neighborhoods = Neighborhood.all

    if user_signed_in?
      @recentActivity = List.recent + Venue.recent + Neighborhood.recent + Venuetype.recent + Try.recent + Rating.recent + Comment.recent + ItemRating.recent
    else
      @recentActivity = Venue.recent + Neighborhood.recent + Venuetype.recent
    end
    @recentActivity = @recentActivity.sort{ |a,b| b.updated_at <=> a.updated_at }
  end

  def search
    @searchresults = []
    if params[:q]
      searchresultsSet = []
      @original_query = params[:q]
      query = params[:q].downcase.split(' ').map(&:strip).uniq

      query.delete('the')
      query.delete('a')
      query.delete('and')
      query.delete('&')

      byob_results = Set.new
      if query.include? 'byob'
        byob = true
        query.delete('byob')
        byob_results = Venue.where(byob: true).all
      end

      v_results = Set.new
      n_results = Set.new
      vtypes_results = Set.new
      query.each do |qw|
        Venue.where("lower(name) LIKE ?", "%#{qw}%").each do |v|
          v_results.add(v)
        end
        Neighborhood.where("lower(name) LIKE ?", "%#{qw}%").each do |n|
          n.venues_with_children.each do |v|
            n_results.add(v)
          end
        end
        Venuetype.where("lower(name) LIKE ?", "%#{qw}%").each do |vt|
          vt.venues.each do |v|
            vtypes_results.add(v)
          end
        end
      end

      if byob_results.length > 0 and v_results.length > 0 and n_results.length > 0 and vtypes_results.length > 0
        searchresultsSet = byob_results.to_a & v_results.to_a & n_results.to_a & vtypes_results.to_a
      elsif byob_results.length > 0 and v_results.length > 0 and vtypes_results.length > 0
        searchresultsSet = byob_results.to_a & v_results.to_a & vtypes_results.to_a
      elsif byob_results.length > 0 and v_results.length > 0 and n_results.length > 0
        searchresultsSet = byob_results.to_a & v_results.to_a & n_results.to_a
      elsif byob_results.length > 0 and n_results.length > 0 and vtypes_results.length > 0
        searchresultsSet = byob_results.to_a & n_results.to_a & vtypes_results.to_a
      elsif byob_results.length > 0 and v_results.length > 0
        searchresultsSet = byob_results.to_a & v_results.to_a
      elsif byob_results.length > 0 and vtypes_results.length > 0
        searchresultsSet = byob_results.to_a & vtypes_results.to_a
      elsif byob_results.length > 0 and n_results.length > 0
        searchresultsSet = byob_results.to_a & n_results.to_a
      elsif n_results.length > 0 and vtypes_results.length > 0
        searchresultsSet = n_results.to_a | vtypes_results.to_a
      elsif n_results.length > 0 and v_results.length > 0
        searchresultsSet = n_results.to_a | v_results.to_a
      elsif v_results.length > 0 and vtypes_results.length > 0
        searchresultsSet = v_results.to_a | vtypes_results.to_a
      elsif v_results.length > 0
        searchresultsSet = v_results
      elsif byob_results.length > 0
        searchresultsSet = byob_results
      elsif n_results.length > 0
        searchresultsSet = n_results
      elsif vtypes_results.length > 0
        searchresultsSet = vtypes_results
      end

      searchresultsSet.each do |vs|
        @searchresults.push(vs)
      end
      @searchresults = sortable_venues_array(@searchresults)

    end
  end

  def map
    @paramsOptions = [
      :totry,
      :byob,
      :craftbeer,
      :cocktails,
      :outdoor,
      :maxPrice
    ]

    @restaurants = []
    if params[:maxPrice].to_f >= 1 and params[:maxPrice].to_f <= 3
      @restaurants = Venue.where("price <= ?", params[:maxPrice].to_f)
    else
      @includeAllPrices = true
      @restaurants = Venue.all
    end

    @outdoor = []
    if params[:outdoor] == '1'
      @restaurants = @restaurants & Venue.where(outdoor: true)
    end

    @byob = []
    if params[:byob] == '1'
      @restaurants = @restaurants & Venue.where(byob: true)
    end

    @craftbeer = []
    if params[:craftbeer] == '1'
      @restaurants = @restaurants & Venue.where(craftbeer: true)
    end

    @cocktails = []
    if params[:cocktails] == '1'
      @restaurants = @restaurants & Venue.where(cocktails: true)
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
  end

  def deletion_request
    if params[:type] == 'venue'
      @requested = Venue.find(params[:id])
      @requested_text_label = 'venue'
    elsif params[:type] == 'venuetype'
      @requested = Venuetype.find(params[:id])
      @requested_text_label = 'venue type'
    elsif params[:type] == 'neighborhood'
      @requested = Neighborhood.find(params[:id])
      @requested_text_label = 'neighborhood'
    end

    if request.method == 'POST'
      DeletionRequestMailer.deletion_request_email(current_user, params[:type], @requested.id, params[:deletion_request_reason]).deliver
    end

  end

  def about
  end

end
