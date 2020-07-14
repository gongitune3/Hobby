class BoardComment < ApplicationRecord
    belongs_to :user
    belongs_to :board
    has_many :favorites, dependent: :destroy
end
