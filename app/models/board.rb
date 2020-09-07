class Board < ApplicationRecord
    belongs_to :user
    has_many :board_comments, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    has_many :notifications, dependent: :destroy
    #--タグ機能中間テーブル--
    has_many :board_tags, dependent: :destroy
    has_many :tags, through: :board_tags
    accepts_nested_attributes_for :tags

    # 多対多のバリデーション用メソッド
    validates :title,uniqueness: { case_sensitive: :false }, presence: true, length: { maximum: 33 } 
    validates :introduction, presence: true, length: { maximum: 53 }
    # validate :tag_holdings→他で使用しているメソッドと相性が悪いた為、休止中。
    validate :board_holdings


    #いいね機能と同様にメソッドの引数にログインユーザーを与えて、ブックマークの外部キーが存在しているか確認している。
    def bookmark_by?(user)
      bookmarks.where(user_id: user.id).exists?
    end

    #タグテーブルから名前を全て配列として取得。古いものと新しいものに仕分け
    def save_tags(tags) 
      current_tags = self.tags.pluck(:name) unless self.tags.nil? #unless→タグが
      old_tags = current_tags - tags
      new_tags = tags - current_tags
  
      #配列で取得した重複している名前の削除
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
      
      #配列で取得し、レコードに存在するデータは探して・なければ作成その上でself.tagsに挿入
      new_tags.each do |new_name|
        board_tag = Tag.find_or_create_by(name:new_name)
        self.tags << board_tag #saveに近い？配列に挿入している。
      end
      
    end

    def create_notification_favorite!(current_user)
      # すでに「いいね」されているか検索
      temp = Notification.where(["visitor_id = ? and visited_id = ? and board_comment_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
      # いいねされていない場合のみ、通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          board_comment_id: id,
          visited_id: user_id,
          action: 'like'
        )
        # 自分の投稿に対するいいねの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

    # 多対多のバリデーション用メソッド。。save_tagsを使用したい為、バリデーションの位置が上手く掛からず不採用。
    # private
    # def tag_holdings
    #   errors.add(:tags, "の設定は1つ以上５以下でお願い致します") if tags.size < 1
    #   errors.add(:tags, "は5個までです") if tags.size > 5
    # end
    private 
    def board_holdings
      # コントローラーで定義している→、bulidでcurrent_userを使用している為、currentは不要、userで取得可能。
      if user.boards.count >= 5
        errors.add(:_e_, "スレッドは５個まででお願い致します")
      end
    end

    def board_comments_retention
      
    end
    
end