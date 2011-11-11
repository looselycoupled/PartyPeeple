ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :user_name => "pepysinc",
  :password => "PHEVcV6gyW2VVyuK",
  :domain => "pepysinc.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# ActionMailer::Base.smtp_settings = {
#  :address               => "smtp.webfaction.com",
#  :port                  => 587,
#  :domain                => "e-geaux.me",
#  :user_name             => "allenleis",
#  :password              => "ihavefever",
#  :enable_starttls_auto => true
# }
# 
