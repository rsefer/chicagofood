ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
ActionMailer::Base.smtp_settings = {
  :address              => 'smtp.mandrillapp.com',
  :port                 => 587,
  :enable_starttls_auto => true,
  :user_name            => 'chicagofood@seferdesign.com',
  :password             => Figaro.env.mandrill_api_key,
  :authentication       => 'login'
}
