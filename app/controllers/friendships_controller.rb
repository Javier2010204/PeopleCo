class FriendshipsController < ApplicationController
	before_action :find_friend, except:[:index, :update]
	before_action :find_friendship, only: [:update]

	def create
		@friendship = Friendship.new(user: current_user, friend: @friend)

		respond_to do |format|
			if @friendship.save
				format.js
				format.html{redirect_to @friend, notice: "Se agrego exitosamente a tus amigos"}
			else
				format.html{redirect_to @friend, notice: "No se pudo agragar a tus amigos por favor intenta mas tarde"}
			end
		end
	end

	def index
		@pending_friendships = current_user.followers.pending.decorate
		@accepted_friendships = current_user.followers.active.decorate
		@pending_requests = current_user.friendships.pending.decorate
		@rejected_friendships = current_user.followers.denied.decorate
	end

	def update
		if params[:status] == "1"
			@friendship.accepted!
		elsif params[:status] == "0"
			@friendship.rejected!
		end

		respond_to do |format|
			format.html{redirect_to friendships_path}
			format.js
		end
	end

	private
	def find_friend
		@friend = User.find(params[:friend_id])
	end

	def find_friendship
		@friendship = Friendship.find(params[:id])
	end
end