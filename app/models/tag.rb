class Tag < ApplicationRecord
    has_many :, dependent: :destroy
end
