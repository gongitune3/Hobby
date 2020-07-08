class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :boards, dependent: :destroy
  has_many :bookmraks, dependent: :destroy
  has_many :board_comments, dependent: :destroy
  has_many :relationships
end
