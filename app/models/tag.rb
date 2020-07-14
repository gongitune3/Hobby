class Tag < ApplicationRecord
    has_many :boards, through: :board_tags
    has_many :board_tags, dependent: :destroy
end
