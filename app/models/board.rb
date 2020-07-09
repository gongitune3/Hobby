class Board < ApplicationRecord
    has_many :board_comments, dependent: :destroy
    has_many :board_tags, dependent: :destroy
    has_many :bookmraks, despendent: :destroy
    belongs_to :user
end
