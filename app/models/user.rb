class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_many :posts
  has_many :comments

  #relacion normal donde yo soy el usuario en la amistad(user_id = current_user)
  has_many :friendships

  #Devuelve las amistades donde yo soy el amigo(friend_id = current_user)
  has_many :followers, class_name: "Friendship", foreign_key: "friend_id"

  # no se para que sirven estas dos 
  has_many :friends_added, through: :friendships, source: :friend
  has_many :friends_who_added, through: :friendships, source: :user

  has_one_attached :covers
  attr_accessor :my_cover
  has_one_attached :photos
  attr_accessor :my_photos

  def my_friend?(friend)
    Friendship.friends?(self,friend)
  end
end
