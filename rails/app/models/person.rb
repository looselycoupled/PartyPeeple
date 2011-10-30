class Person < ActiveRecord::Base

  def fetch_email
    fb = FbGraph::User.me(access_token).fetch
    self.email = fb.email
    save!
  end

end
