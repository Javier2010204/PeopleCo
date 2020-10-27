class Post < ApplicationRecord
	include AASM

	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :body, presence: true


	aasm column: "status" do
		state :published, initial: true
		state :reported
		state :locked

		event :report do
			transitions from: [:published], to: [:reported]
		end

		event :to_block do
			transitions from: [:reported, :published], to: [:locked]
		end
	end
end
