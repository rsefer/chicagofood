module ApplicationHelper

	def inline_icon(filename, text = '', svgClass = nil)
		svgIcon(filename, svgClass) + text
  end

	def svgIcon(filename, svgClass = nil)
		File.open('app/assets/images/icons/' + filename + '.svg', "rb") do |file|
			doc = Nokogiri::HTML open(file)
			svg = doc.at_css 'svg'
			svg['class'] = 'icon icon-' + filename
			svg['width'] = nil
			svg['height'] = nil
			svg['stroke'] = nil
			if svgClass.present?
				svg['class'] = svg['class'] + ' ' + svgClass
			end
	    raw svg
		end
	end

	def svg(filename)
		File.open('app/assets/images/' + filename + '.svg', "rb") do |file|
			doc = Nokogiri::HTML open(file)
			svg = doc.at_css 'svg'
	    raw svg
		end
	end

	def is_current_user(user, isUserID = false)
		if isUserID
			user = User.find(user.id)
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
	  carets = title + self.inline_icon('chevron-down', '', 'right') + self.inline_icon('chevron-up', '', 'right')
	  link_to raw(carets), params.permit(:sort, :direction).merge(:sort => column, :direction => direction), { :class => css_class }
	end

	def render_venuetype_hierarchy(parent_id, listClasses = '')
		children = Venuetype.find(parent_id).children
		if children.present?
			listcontent = '<ul'
			if listClasses.present?
				listcontent += ' class="' + listClasses + '"'
			end
			listcontent += '>'
			children.each do |venuetype|
				listcontent += '<li>'
				if parent_id != 1 and parent_id != 2
					listcontent += self.inline_icon('corner-down-right', '', 'left')
				end
				listcontent += '<a href="' + venuetype_path(venuetype.id) + '">' + venuetype.name + '</a>'
				if venuetype.children.present?
					listcontent += render_venuetype_hierarchy(venuetype.id)
				end
				listcontent += '</li>'
			end
			listcontent += '</ul>'
		end
		if listcontent.present?
			listcontent.html_safe
		end
	end

  def render_neighborhood_hierarchy(parent_id, listClasses = '')
		children = Neighborhood.find(parent_id).children
		if children.present?
			listcontent = '<ul'
			if listClasses.present?
				listcontent += ' class="' + listClasses + '"'
			end
			listcontent += '>'
			children.each do |neighborhood|
				listcontent += '<li>'
	      listcontent += self.inline_icon('corner-down-right', '', 'left')
				listcontent += '<a href="' + neighborhood_path(neighborhood.id) + '">' + neighborhood.name + '</a>'
				if neighborhood.children.present?
					listcontent += render_neighborhood_hierarchy(neighborhood.id)
				end
				listcontent += '</li>'
			end
			listcontent += '</ul>'
		end
		if listcontent.present?
			listcontent.html_safe
		end
	end

	def render_price(price)
		if price == 4
			'$$$$'.html_safe
		elsif price == 3
			'$$$'.html_safe
		elsif price == 2
			'$$'.html_safe
		elsif price == 1
			'$'.html_safe
		else
			render_dash
		end
	end

	def render_stars(star_rating)
		if star_rating >= 4.8
			(inline_icon('star', '', 'fill') * 5).html_safe
		elsif star_rating >= 4.3
			(inline_icon('star', '', 'fill') * 4 + inline_icon('star-half') * 1).html_safe
		elsif star_rating >= 3.8
			(inline_icon('star', '', 'fill') * 4 + inline_icon('star') * 1).html_safe
		elsif star_rating >= 3.3
			(inline_icon('star', '', 'fill') * 3 + inline_icon('star-half') * 1 + inline_icon('star') * 1).html_safe
		elsif star_rating >= 2.8
			(inline_icon('star', '', 'fill') * 3 + inline_icon('star') * 2).html_safe
		elsif star_rating >= 2.3
			(inline_icon('star', '', 'fill') * 2 + inline_icon('star-half') * 1 + inline_icon('star') * 2).html_safe
		elsif star_rating >= 1.8
			(inline_icon('star', '', 'fill') * 2 + inline_icon('star') * 3).html_safe
		elsif star_rating >= 1.3
			(inline_icon('star', '', 'fill') * 1 + inline_icon('star-half') * 1 + inline_icon('star') * 3).html_safe
		elsif star_rating >= 0.8
			(inline_icon('star', '', 'fill') * 1 + inline_icon('star') * 4).html_safe
		elsif star_rating >= 0.3
			(inline_icon('star-half') * 1 + inline_icon('star') * 4).html_safe
		else
			(inline_icon('star') * 5).html_safe
		end
	end

	def render_dash
		'<span class="dash">&mdash;</span>'.html_safe
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
