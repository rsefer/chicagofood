class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :sort_column, :sort_direction

  def paginate_venues(venues_array)
    results_per_page = 25
    if params[:page].present?
      @current_page = params[:page].to_i
    else
      @current_page = 1
    end

    if venues_array.count > results_per_page
      @isPaginated = true
    end

    @total_pages = (venues_array.count.to_f / results_per_page.to_f).ceil
    @venues_unpaginated = sortable_venues_array(venues_array)
    @venues = @venues_unpaginated.drop((@current_page - 1) * results_per_page).take(results_per_page)
  end

  def sortable_venues_array(object_list, other_model = false)
		sorted_object_list = []
    other_model_options = ['try', 'rating', 'list', 'list_item', 'item_rating']
		if params[:sort].present? or params[:direction].present?
      if other_model_options.include?(other_model)
        if params[:sort] == 'price'
          sorted_object_list = object_list.sort_by { |t| t.venue.price }
        elsif params[:sort] == 'vt_name'
          sorted_object_list = object_list.sort_by { |t| if t.manual_entry then t.venuetype.sortable_name else t.venue.venuetype.sortable_name end }
        elsif params[:sort] == 'neighborhood_name'
          sorted_object_list = object_list.sort_by { |t| if t.manual_entry then t.neighborhood.sortable_name else t.venue.neighborhood.sortable_name end }
        elsif params[:sort] == 'updated_at'
          sorted_object_list = object_list.sort_by { |t| t.updated_at }
        elsif params[:sort] == 'date'
          sorted_object_list = object_list.sort_by { |li| li.date }
        elsif params[:sort] == 'rating'
          sorted_object_list = object_list.sort_by { |r| r.rating }
        elsif params[:sort] == 'venue_count'
          sorted_object_list = object_list.sort_by { |l| l.venue_count }
        elsif params[:controller] == 'lists' and params[:action] == 'index' and params[:sort] == 'name'
          sorted_object_list = object_list.sort_by { |l| l.title }
        elsif params[:controller] == 'item_ratings'
          if params[:sort] == 'name'
            sorted_object_list = object_list.sort_by { |ir| ir.item.name }
          elsif params[:sort] == 'venue_name'
            sorted_object_list = object_list.sort_by { |ir| ir.item.venue.sortable_name }
          end
        else
          sorted_object_list = object_list.sort_by { |t| if t.manual_entry then t.sortable_name else t.venue.sortable_name end }
        end
      elsif params[:sort] == 'byob'
        sorted_object_list = object_list.sort_by { |v| v.byob ? 0 : 1 }
      elsif params[:sort] == 'name'
				sorted_object_list = object_list.sort_by { |v| v.sortable_name }
      else
        sorted_object_list = object_list.sort_by(&:"#{params[:sort]}")
      end
    elsif other_model_options.include?(other_model)
      sorted_object_list = object_list
		else
			sorted_object_list = object_list.sort_by { |v| v.sortable_name }
		end
    sorted_object_list = sorted_object_list.reverse if params[:direction] == 'desc'
		sorted_object_list
	end

  protected

    def set_display_user
      @user = User.find(params[:user_id])
    end

    def set_display_list
      @list = List.find(params[:list_id])
    end

    def set_venue
      @venue = Venue.find(params[:venue_id])
    end

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) do |u|
	      u.permit(:email, :password, :password_confirmation, :firstname, :lastname, :avatar, :street, :city, :state)
	    end
	    devise_parameter_sanitizer.for(:account_update) do |u|
	      u.permit(:email, :password, :password_confirmation, :firstname, :lastname, :avatar, :street, :city, :state)
	    end
	  end

    def sort_column
      full_sort_list = Venue.column_names + ['rating', 'neighborhood_name', 'vt_name', 'venue_count', 'venue_name']
      if full_sort_list.include?(params[:sort])
        params[:sort]
      elsif params[:controller] == 'tries' or params[:controller] == 'ratings'
        "updated_at"
      elsif params[:controller] == 'lists' and params[:action] == 'show'
        if List.find(params[:id]).hasDates
          "date"
        else
          "name"
        end
      else
        "name"
      end
    end

    def sort_direction
      if %w[asc desc].include?(params[:direction])
        params[:direction]
      elsif params[:controller] == 'tries' or params[:controller] == 'ratings' or (params[:controller] == 'lists' and params[:action] == 'show')
        if params[:controller] == 'lists' and params[:action] == 'show' and !List.find(params[:id]).hasDates
          "asc"
        else
          "desc"
        end
      else
        "asc"
      end
    end

end
