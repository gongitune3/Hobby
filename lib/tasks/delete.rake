namespace :delete do

    desc "1週間レスがないスレッドを削除する"
    #モデルにアクセスする場合は :environmentの指定が必須。
    task delete_board: :environment do
        boards = Board.all

        comments = []
        boards.each do |board|
            comments << board.board_comments
        end

        comments.each do |comment|
            if Date.current - 7 > comment.created_at
                comment.board.destroy
            end
        end

    end

end
