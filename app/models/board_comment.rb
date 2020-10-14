class BoardComment < ApplicationRecord
    belongs_to :user
    belongs_to :board
    has_many :favorites, dependent: :destroy
    has_many :notifications, dependent: :destroy
    validates :comment, presence: true, length: { maximum: 100 }

    def favorited_by?(user)
	    favorites.where(user_id: user.id).exists?
	end
end