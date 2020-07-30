namespace :delete do

    desc "1週間レスがないスレッドを削除する"
    task reset_board_flag: :environment do
        Board.all
        Board.where(  )
        destory(entered_flag: false)
    end

end
