class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  has_many :boards, dependent: :destroy
  has_many :bookmraks, dependent: :destroy
  has_many :board_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  #フォロー時に使用
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  #フォローを解除する際に使用
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  
  #フォローされているか否かの確認
  def following?(user)
    following_user.include?(user)
  end
end
