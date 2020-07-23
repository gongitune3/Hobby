class BoardComment < ApplicationRecord
    belongs_to :user
    belongs_to :board
    has_many :favorites, dependent: :destroy
    validates :comment, presence: true

    def favorited_by?(user)
		  favorites.where(user_id: user.id).exists?
	  end
end
