class ClosingMailer < ActionMailer::Base
  default :from => "Pepys Inc. <hello@pepysinc.com>"

  def user_data_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Thanks for Opting in")
  end

  
end

