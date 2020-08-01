namespace :delete do

    desc "1週間レスがないスレッドを削除する"
    #モデルにアクセスする場合は :environmentの指定が必須。
    task delete_board: :environment do
        Board.all.each do |board|
            if Date.current - 7 > board.comments.last.created_at
                board.destroy
            end
        end
    end

end
