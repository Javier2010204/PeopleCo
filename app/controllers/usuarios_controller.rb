class UsuariosController < ApplicationController
	before_action :authenticate_user!
	before_action :set_usuario

	def show
		@are_friends = current_user.my_friend?(@usuario)
	end

	def edit
		
	end

	def update
		respond_to	do |format|
			if @usuario.update(usuario_params)
				@usuario.photos.attach(params[:user][:my_photos])
				@usuario.covers.attach(params[:user][:my_cover])
				format.html{render :show}
			else
				format.html{redirect_to @usuario, notice: @usuario.errors.full_messages}
			end
		end
	end

	private

		def set_usuario
			@usuario = User.find(params[:id])
		end

		def usuario_params
			params.require(:user).permit(:my_photos, :username, :my_cover)
		end
end


