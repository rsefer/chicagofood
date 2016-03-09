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

    email_html_raw = render_to_string(:action => 'deletion_request_email.html', :locals => { :user => @user, :requested => @requested, :requested_text_label => @requested_text_label, :requested_link => @requested_link })

    html_roadie = Roadie::Document.new email_html_raw
    html_inlined = html_roadie.transform

    ses = Aws::SES::Client.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
    ses.send_email({
      source: "Chicago Food <chicagofood@seferdesign.com>",
      destination: {
        to_addresses: ["chicagofood@seferdesign.com"]
      },
      message: {
        subject: {
          data: "Deletion Request"
        },
        body: {
          html: {
            data: html_inlined
          }
        }
      }
    })

  end

end
