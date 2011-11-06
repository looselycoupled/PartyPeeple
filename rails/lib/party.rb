module Party
  
  def self.recommendation(person, target)
        
    # IF they are not a match for sexual interest (from your perspective), THEN…  Friend
    # IF they are a match for sexual interest  (from your perspective) and they have Digital Capital equal to or greater than [your Digital Capital - 50], THEN…  Flirt
    # IF they are a match for a for sexual interest  (from your perspective) and they have Digital Capital less than [your Digital Capital - 50], THEN… Fuck
    
    if (person.preference == "both" || person.preference = target.gender)
      if ((target.digital_capital || 0) >= (person.digital_capital || 0) - 50)
        "flirt"
      else
        "fuck"
      end
    else
      "friend"
    end
    
  end
  
  def self.friends_in_common(person,target)
    person.friends & target.friends
  end
  
  def self.cleanup
    Page.delete_all
    Person.delete_all
    Friendship.delete_all
  end
  
  
  private
    
  
end