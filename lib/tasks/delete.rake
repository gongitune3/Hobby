namespace :delete do

    desc "1週間レスがないスレッドを削除する"
    boards = Board.all
    
        comment = BoardComment.order(updated_at: :desc).limit(1)
        if Date.current - 7 > comment.created_at
            
    end

end
