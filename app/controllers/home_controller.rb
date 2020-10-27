class HomeController < ApplicationController
	before_action :set_layout

	def index
		@post = Post.new
		@posts = Post.all
	end

	def unregistered

	end

	def dashboard
		 authorize! :access, "dashboard"
	end
	

	protected
		def set_layout
			return "landing" if action_name == "unregistered"
		end

end
