class FriendshipDecorator < Draper::Decorator
  delegate_all

  def user_view
    if h.current_user == object.user
      return object.friend
    end
    return object.user
  end

  def status_of_buttons(logged_user)
  	return buttons if object.pending? && object.user != h.current_user
  	return status
  end

  def status
  	return "Amigos" if object.active?
  	return "Rechazada" if object.denied?
  	return "Esperando respuesta" if object.pending?
  end

  def buttons
  	(accepted_button + denied_button).html_safe
  end

  def accepted_button
  	h.link_to "Aceptar", h.friendship_path(object,status: 1), method: :patch , class: "btn btn--yellow black-text" 
  end

  def denied_button
  	h.link_to "Rechazar", h.friendship_path(object,status: 0), method: :patch, class: "btn btn--black white-text margin-left"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
