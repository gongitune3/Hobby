class Board < ApplicationRecord
    has_many :board_comments, dependent: :destroy

    #--タグ機能中間テーブル--
    has_many :tags, through: :board_tags
    has_many :board_tags, dependent: :destroy
    #--タグ機能--

    has_many :bookmraks, despendent: :destroy
    belongs_to :user

    def save_posts(savepost_tags)
        current_tags = self.tags.pluck(:name) unless self.tags.nil?
        old_tags = current_tags - savepost_tags
        new_tags = savepost_tags - current_tags

        # Destroy old taggings:
            old_tags.each do |old_name|
            self.tags.delete Tag.find_by(name:old_name)
        end
        # Create new taggings:
          new_tags.each do |new_name|
            post_tag = Tag.find_or_create_by(name:new_name)
            self.tags << post_tag
          end
    end
end
