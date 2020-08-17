class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  has_many :boards, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  #throughオプションでユーザーがブックマークしたスレッドを直接アソシエーションで取得可能
  has_many :bookmark_boards, through: :bookmarks, source: :board
  has_many :board_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  # active_notifications：自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # passive_notifications：相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


  # (case_sensitive: :falssは大文字小文字の区別をしないということ）
  validates :nickname,uniqueness: { case_sensitive: :false }, presence: true, length: { maximum: 10 } 
  validates :introduction, presence: true, length: { maximum: 33 } 

  # Skinny Controller, Fat Model
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

  def bookmark_map?(user)
    bookmarks.where(user_id: user.id).exists?
  end

end
