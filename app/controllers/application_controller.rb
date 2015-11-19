class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :sort_column, :sort_direction

  def sortable_venues_array(object_list)
		sorted_object_list = []
		if params[:sort].present? or params[:direction].present?
      if params[:sort] == 'name'
				sorted_object_list = object_list.sort_by { |v| v.sortable_name }
      else
        sorted_object_list = object_list.sort_by(&:"#{params[:sort]}")
      end
		else
			sorted_object_list = object_list.sort_by { |v| v.sortable_name }
		end
    sorted_object_list = sorted_object_list.reverse if params[:direction] == 'desc'
		sorted_object_list
	end

  protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) do |u|
	      u.permit(:email, :password, :password_confirmation, :firstname, :lastname, :avatar, :street, :city, :state)
	    end
	    devise_parameter_sanitizer.for(:account_update) do |u|
	      u.permit(:email, :password, :password_confirmation, :firstname, :lastname, :avatar, :street, :city, :state)
	    end
	  end

    def sort_column
      full_sort_list = Venue.column_names + ['rating', 'neighborhood_name', 'vt_name']
      full_sort_list.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
