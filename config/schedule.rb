# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


# Rails.rootを使用するために必要 、本番環境とローカルの環境ではディレクトリの階層が変わる為、動的に処理を
# このファイルでも使える様に、読み込む
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数 中がproductionではなければRAILS_ENVからであればdevelopmentが代入される。
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所、"#{}"で展開している
set :output, "#{Rails.root}/log/cron.log"

# staging環境のみで実行、オブジェクトの指定？？？
if rails_env.to_sym != :development
  # １日事にtaskを走らせる。
  every 1.day do
    begin
      rake 'delete:delete_board', :environment_variable => "RAILS_ENV", :environment => "development"
    rescue => e
      Rails.logger.error("aborted rake delete task")
      raise e
    end
  end
end


