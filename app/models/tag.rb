class Tag < ApplicationRecord
    has_many :board_tags, dependent: :destroy
end
