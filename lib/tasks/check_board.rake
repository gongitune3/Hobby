namespace :check_board do
      desc "1レスが3日以内にレスされなければ、該当スレを削除"

      #モデルにアクセスする場合は :environmentの指定が必須。
      task delete_board: :environment do
            Board.all.each do |board|
                  if Date.current - 3 > board.created_at && board.board_comments.count == 0
                      board.destroy
                  end
              end 
      end
end