class Person < ActiveRecord::Base

  def fetch_email
    fb = FbGraph::User.me(access_token).fetch
    self.email = fb.email
    save!
  end


  def chosen_a_team?
    !preference.nil?
  end
end
