class Contact < ApplicationRecord
    validates :email, presence: true, length: {maximum:255},format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
    validates :message, presence: true

    enum status: {
    	未対応: 0,
    	審議中: 1,
    	対応済み: 2
    }

    enum category: {
        スレッド・レス: 0,
        Hobby: 1,
        その他: 2
    }

end