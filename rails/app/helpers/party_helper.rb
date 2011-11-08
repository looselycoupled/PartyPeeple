module PartyHelper

  def tab_selector(tab)
    if tab == params[:action]
      "active"
    end
  end
  
  def sort_by_selector(sort)
    "active" if sort == "arrival" && params[:letter].nil?
    "active" if sort == "name" && !params[:letter].nil?
  end


end
