class Users::HomesController < ApplicationController
    def top
        #タグをランダム表示
        @random = Tag.order("RANDOM()").limit(5)
        #スレッドをブックマークの多い順で表示
        @all_ranks = Board.find(Bookmark.group(:board_id).order('count(board_id) desc').limit(3).pluck(:board_id))
    end
end
