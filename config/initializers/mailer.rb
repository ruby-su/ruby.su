ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'ruby.su',
  :user_name            => 'admin@ruby.su',
  :password             => MAILER_PASSWORD,
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
