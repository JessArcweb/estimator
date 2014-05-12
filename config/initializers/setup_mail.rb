ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :ports => 587,
  :domain => "arcwebtech.com",
  :user_name => "mroll@arcwebtech.com",
  :password => "arcwebpa55",
  :authentication => "plain",
  :enable_starttls_auto => true
}
