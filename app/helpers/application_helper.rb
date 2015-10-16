module ApplicationHelper

	def is_current_user(user, isUserID = false)
		if isUserID
			user = User.find(user)
		end

		if !current_user.nil? && user.id == current_user.id
			true
		else
			false
		end
	end

	def pluralize_without_count(count, noun, text = nil)
	  if count != 0
	    count == 1 ? "an #{noun}#{text}" : "#{noun.pluralize}#{text}"
	  end
	end

	def to_url(string)
		string.gsub(' ', '+').gsub(',', '').gsub('#', '')
	end

	def sortable(column, title = nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "sortablecol current #{sort_direction}" : "sortablecol"
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  carets = title + '<i class="fa fa-caret-down right"></i><i class="fa fa-caret-up right"></i>'.html_safe
	  link_to raw(carets), {:sort => column, :direction => direction}, {:class => css_class}
	end

	def render_venuetype_hierarchy(parent_id, listClasses = '')
		listcontent = '<ul class="' + listClasses + '">'
		Venuetype.find(parent_id).childTypes.each do |venuetype|
			listcontent += '<li>'
			logger.debug "Name: #{venuetype.name} Parent: #{venuetype.parent.name}"
			if parent_id != 1 and parent_id != 2
				listcontent += '<i class="fa fa-fw fa-rotate-90 fa-level-up"></i>'
			end
			listcontent += '<a href="' + venuetype_path(venuetype.id) + '">' + venuetype.name + '</a>'
			if venuetype.childTypes.present?
				listcontent += render_venuetype_hierarchy(venuetype.id, 'venue-type-list')
			end
			listcontent += '</li>'
		end
		listcontent += '</ul>'
		listcontent.html_safe
	end

	def render_price(price)
		if price == 4
			'<i class="fa fa-usd"></i><i class="fa fa-usd"></i><i class="fa fa-usd"></i><i class="fa fa-usd"></i>'.html_safe
		elsif price == 3
			'<i class="fa fa-usd"></i><i class="fa fa-usd"></i><i class="fa fa-usd"></i>'.html_safe
		elsif price == 2
			'<i class="fa fa-usd"></i><i class="fa fa-usd"></i>'.html_safe
		elsif price == 1
			'<i class="fa fa-usd"></i>'.html_safe
		end
	end

	def render_stars(star_rating)
		if star_rating >= 4.8
			'<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i>'.html_safe
		elsif star_rating >= 4.3
			'<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-half-o"></i>'.html_safe
		elsif star_rating >= 3.8
			'<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i>'.html_safe
		elsif star_rating >= 3.3
			'<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-half-o"></i><i class="fa fa-star-o"></i>'.html_safe
		elsif star_rating >= 2.8
			'<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>'.html_safe
		elsif star_rating >= 2.3
			'<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-half-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>'.html_safe
		elsif star_rating >= 1.8
			'<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>'.html_safe
		elsif star_rating >= 1.3
			'<i class="fa fa-star"></i><i class="fa fa-star-half-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>'.html_safe
		elsif star_rating >= 0.8
			'<i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>'.html_safe
		elsif star_rating >= 0.3
			'<i class="fa fa-star-half-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>'.html_safe
		else
			'<i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>'.html_safe
		end
	end

	def us_states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
	end
end
