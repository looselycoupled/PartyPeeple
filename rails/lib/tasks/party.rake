desc "Sends closing/data confirmation email to partiers"
task :notify_closing => :environment do 
  
  
  if Rails.env.development?
    @people = Person.where("identifier in ('737428913')")
  elsif Rails.env.production?
    @people = Person.where("email is not null") 
  end
  @people.each do |u|
    ClosingMailer.delay.user_data_confirmation(u)
  end

end
