class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  has_many :boards, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board
  has_many :board_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  scope :perfect_search, -> (nickname, method) { where(nickname: nickname) if method == 'perfect' }
  scope :forward_search, -> (nickname, method) { where('nickname LIKE ?', nickname+'%') if method == 'forward' }
  scope :backward_search, -> (nickname, method) { where('nickname LIKE ?', '%'+nickname) if method == 'backward' }
  scope :partial_search, -> (nickname, method) { where('nickname LIKE ?', '%'+nickname+'%') if method == 'partial' }

  attachment :profile_image

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


  def bookmark_map?(board)
    self.id == board.user_id
  end
  
end
