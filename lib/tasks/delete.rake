namespace :delete do

    desc "1週間レスがないスレッドを削除する"
    #モデルにアクセスする場合は :environmentの指定が必須。
    task delete_board: :environment do
        board_delete
    end

end
