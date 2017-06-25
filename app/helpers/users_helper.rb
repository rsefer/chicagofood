module UsersHelper

  def score_display(score, score_title)
    score_display_markup = '<div class="pure-u-1-2 pure-u-sm-1-4"><div class="user-count-number">' + score.to_s + '</div><div class="user-count-title">' + score_title + '</div></div>'
    score_display_markup.html_safe
  end

  def display_activity(activity)
    display_activity_markup = '<li'
    if activity.kind_of? Comment and activity.private
      display_activity_markup += ' class="private"'
    end
    display_activity_markup += '><div class="activity-date">' + time_ago_in_words(activity.updated_at).titleize + ' ago</div>'

    icon_class = ''

    if activity.kind_of? Try
      icon_name = 'plus'
      sentence = 'Added ' + link_to(activity.venue.name, venue_path(activity.venue)) + ' to the ' + link_to('list of places to try', user_tries_path(activity.user)) + '.'
    elsif activity.kind_of? List
      icon_name = 'list'
      if activity.updated_at == activity.created_at
        sentence = 'Created'
      else
        sentence = 'Updated'
      end
      sentence += ' the ' + link_to(activity.title, user_list_path(activity.user, activity)) + ' list.'
    elsif activity.kind_of? Rating
      icon_name = 'star'
      sentence = 'Rated ' + link_to(activity.venue.name, venue_path(activity.venue)) + ' ' + pluralize(activity.rating, "star") + '.'
    elsif activity.kind_of? Comment
      icon_name = 'message-circle'
      sentence = 'Commented on ' + link_to(activity.venue.name, venue_path(activity.venue)) + ':'
      sentence += '<div class="activity-comment">' + wrap_quotes(activity.body).html_safe  + '</div>'
    elsif activity.kind_of? ItemRating
      if activity.liked
        icon_name = 'thumbs-up'
        icon_class = ' green'
        sentence = 'Liked'
      else
        icon_name = 'thumbs-down'
        icon_class = ' red'
        sentence = 'Disliked'
      end
      sentence += ' the ' + activity.item.name + ' at ' + link_to(activity.item.venue.name, activity.item.venue) + '.'
    elsif activity.kind_of? Eat
      icon_name = 'zap'
      sentence = 'Had the ' + activity.item.name + ' at ' + link_to(activity.item.venue.name, activity.item.venue) + '.'
    else
      icon_name = ''
      sentence = ''
    end

    display_activity_markup += inline_icon(icon_name, '', 'left' + icon_class)
    display_activity_markup += sentence
    display_activity_markup += '</li>'
    display_activity_markup.html_safe
  end

end
