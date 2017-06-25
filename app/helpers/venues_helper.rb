module VenuesHelper

  def rating_display(venue)
    if (venue.rating > 0)
      number_with_precision(venue.rating, precision: 2).to_s
    else
      render_dash
    end
  end

end
