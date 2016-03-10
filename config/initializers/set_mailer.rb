ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
ActionMailer::Base.smtp_settings = {
  :address              => Figaro.env.aws_smtp_server,
  :port                 => 587,
  :user_name            => Figaro.env.aws_smtp_username,
  :password             => Figaro.env.aws_smtp_password,
  :authentication       => 'login',
  :enable_starttls_auto => true,
}
