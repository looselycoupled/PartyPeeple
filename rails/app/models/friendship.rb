class Friendship < ActiveRecord::Base
  belongs_to :person
  belongs_to :friend, :class_name => "Person"
  
  # create inverse friendship on create
  after_save(:on => :create) do
    Friendship.find_or_create_by_person_id_and_friend_id(self.friend_id,self.person_id)
  end

end
