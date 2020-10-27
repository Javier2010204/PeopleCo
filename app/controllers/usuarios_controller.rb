class UsuariosController < ApplicationController
	before_action :authenticate_user!
	before_action :set_usuario, except: [:index, :new, :create]

	def show
		@are_friends = current_user.my_friend?(@usuario)
	end

	def index
		@usuarios = User.all
		authorize! :manage, User, :all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(usuario_params)

		respond_to do |format|
			if @user.save
				format.html{redirect_to @user, notice: 'se guardo exitosamente'}
			else
				format.html{render :new, alert: 'error al guardar el usuario'}
			end
		end
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
			params.require(:user).permit(:my_photos, :username, :my_cover, :email, :password)
		end
end


