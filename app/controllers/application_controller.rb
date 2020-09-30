class ApplicationController < ActionController::Base
	before_action :configurate_strong_params, if: :devise_controller?
	layout :set_layout

	protected

		def configurate_strong_params
			devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
		end

		def set_layout
			return "application"
		end
end
