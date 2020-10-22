class Friendship < ApplicationRecord
	include AASM	
	belongs_to :user
	belongs_to :friend, class_name: "User"
	validates :user_id, uniqueness:{scope: :friend_id}

  def self.friends?(user, friend)
  	return true if user == friend
  	return Friendship.where(user:user, friend:friend).or(Friendship.where(user:friend, friend:user)).any?
  end

  def self.pending_for_user(user)
    Friendship.pending.where(friend: user)
  end

  #Friendship.active_for_user(current_user) asi se llama en el controlador
  def self.active_for_user(user)
    Friendship.active.where(friend: user)
  end


  aasm column: "status" do
  	state :pending, initial: true
  	state :active
  	state :denied

  	event :accepted do
  		transitions from: [:pending], to: [:active]
  	end	

  	event :rejected do
  		transitions from: [:active, :pending], to: [:denied]
  	end
  end

end
