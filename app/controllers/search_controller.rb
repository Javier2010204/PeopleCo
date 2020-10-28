class SearchController < ApplicationController

  def create
    busqueda = "%#{params[:keyword]}%"
    @usuarios = User.where("email LIKE ?", busqueda)
    respond_to do |format|
      format.json{render @usuarios.json}
      format.js
      format.html{redirect_to :buscador}
    end
  end

  def buscador
    
  end
  
  
end
