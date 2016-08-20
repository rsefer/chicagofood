module UsersHelper

  def score_display(score, score_title)
    score_display_markup = '<div class="col-sm-3 col-xs-6"><div class="user-count-number">' + score.to_s + '</div><div class="user-count-title">' + score_title + '</div></div>'
    score_display_markup.html_safe
  end

  def display_activity(activity)
    display_activity_markup = '<li'
    if activity.kind_of? Comment and activity.private
      display_activity_markup += ' class="private"'
    end
    display_activity_markup += '><div class="activity-date pull-right"><small>' + time_ago_in_words(activity.updated_at).titleize + ' ago</small></div>'

    if activity.kind_of? Try
      fa_icon = 'plus'
      sentence = 'Added ' + link_to(activity.venue.name, venue_path(activity.venue)) + ' to the ' + link_to('list of places to try', user_tries_path(activity.user)) + '.'
    elsif activity.kind_of? List
      fa_icon = 'list'
      if activity.updated_at == activity.created_at
        sentence = 'Created'
      else
        sentence = 'Updated'
      end
      sentence += ' the ' + link_to(activity.title, user_list_path(activity.user, activity)) + ' list.'
    elsif activity.kind_of? Rating
      fa_icon = 'star'
      sentence = 'Rated ' + link_to(activity.venue.name, venue_path(activity.venue)) + ' ' + pluralize(activity.rating, "star") + '.'
    elsif activity.kind_of? Comment
      fa_icon = 'quote-left'
      sentence = 'Commented on ' + link_to(activity.venue.name, venue_path(activity.venue)) + ':'
      sentence += '<div class="activity-comment"><i class="fa fa-fw left"></i>' + wrap_quotes(activity.body).html_safe  + '</div>'
    elsif activity.kind_of? ItemRating
      if activity.liked
        fa_icon = 'thumbs-up green'
        sentence = 'Liked'
      else
        fa_icon = 'thumbs-down red'
        sentence = 'Disliked'
      end
      sentence += ' the ' + activity.item.name + ' at ' + link_to(activity.item.venue.name, activity.item.venue) + '.'
    elsif activity.kind_of? Eat
      fa_icon = 'coffee'
      sentence = 'Had the ' + activity.item.name + ' at ' + link_to(activity.item.venue.name, activity.item.venue) + '.'
    else
      fa_icon = ''
      sentence = ''
    end

    display_activity_markup += '<i class="fa fa-fw fa-' + fa_icon + ' left"></i>'
    display_activity_markup += sentence
    display_activity_markup += '</li>'
    display_activity_markup.html_safe
  end

end
