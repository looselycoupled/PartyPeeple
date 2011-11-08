module PartyHelper

  def tab_selector(tab)
    if tab == params[:action]
      "active"
    end
  end


end
