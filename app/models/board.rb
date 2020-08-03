class Board < ApplicationRecord
    belongs_to :user
    has_many :board_comments, dependent: :destroy

    #--タグ機能中間テーブル--
    has_many :board_tags, dependent: :destroy
    has_many :tags, through: :board_tags
    accepts_nested_attributes_for :tags

    has_many :bookmarks, dependent: :destroy
    validates :title,uniqueness: { case_sensitive: :false }, presence: true, length: { maximum: 33 } 
    validates :introduction, presence: true, length: { maximum: 53 }
    # 多対多のバリデーション用メソッド
    # validate :tag_holdings

    def board_delete
      Board.all.each do |board|
        if Date.current - 7 > board.board_comments.last.created_at
            board.destroy
        end
      end
    end

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


    # 多対多のバリデーション用メソッド。。save_tagsを使用したい為、バリデーションの位置が上手く掛からず不採用。
    # private
    # def tag_holdings
    #   errors.add(:tags, "の設定は1つ以上５以下でお願い致します") if tags.size < 1
    #   errors.add(:tags, "は5個までです") if tags.size > 5
    # end
end