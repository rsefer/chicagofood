class DeletionRequestMailer < ActionMailer::Base
  default from: "chicagofood@seferdesign.com"

  def deletion_request_email(user, requested_type, requested_item_id, reason)
    @user = user
    @reason = reason
    if requested_type == 'venue'
      @requested = Venue.find(requested_item_id)
      @requested_text_label = 'venue'
      @requested_link = 'venues/' + @requested.id.to_s
    elsif requested_type == 'venuetype'
      @requested = Venuetype.find(requested_item_id)
      @requested_text_label = 'venue type'
      @requested_link = 'venuetypes/' + @requested.id.to_s
    elsif requested_type == 'neighborhood'
      @requested = Neighborhood.find(requested_item_id)
      @requested_text_label = 'neighborhood'
      @requested_link = 'neighborhoods/' + @requested.id.to_s
    end

    mail(to: 'rsefer@gmail.com', subject: 'Deletion Request')

  end

end
