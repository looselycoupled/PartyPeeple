ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
 :address               => "smtp.1and1.com",
 :port                  => 587,
 :domain                => "pepysinc.com",
 :user_name             => "e-geaux@pepysinc.com",
 :password              => "samu3l-p3pys",
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
