Recaptcha.configure do |config|
  config.site_key = Figaro.env.google_recaptcha_key
  config.secret_key = Figaro.env.google_recaptcha_secret
end
