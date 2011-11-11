class ClosingMailer < ActionMailer::Base
  default :from => "Pepys Inc. <hello@pepysinc.com>"

  def user_data_confirmation(user)
    @user = user
    subject = "Party Peeple"
    subject += " (#{Rails.env})" if Rails.env.development?
    mail(:to => user.email, :subject => subject)
  end

  
end

