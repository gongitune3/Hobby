namespace :count_stop do
    desc "コメント数100を超えたスレッドを削除する"

    #モデルにアクセスする場合は :environmentの指定が必須。
    task delete_board: :environment do
        Board.all.each do |board|
            if board.board_comments.count == 100
                if board.board_comments.last.created_at < Time.current - 30.minutes
                    board.destroy
                end
            end
        end

    end
end
