class Users::HomesController < ApplicationController
    def top
        #タグをランダム表示
        # @random = Tag.order("RAND()").limit(5)→RANDAM関数はmysqlでは使用できない.RANDはsqlite3で使用できない。
        tag_ids = Tag.joins(:board_tags).distinct.pluck(:id).sample(5)
        @random = Tag.where(id: tag_ids)
        
        #スレッドをブックマークの多い順で表示
        @all_ranks = Board.find(Bookmark.group(:board_id).order('count(board_id) desc').limit(3).pluck(:board_id))
    end
end
