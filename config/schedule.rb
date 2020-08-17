# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   commad "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


require "/home/ec2-user/Hobby/current/config/environment.rb"
# cronを実行する環境変数 中がproductionではなければRAILS_ENVからであればdevelopmentが代入される。
# railsの起動方法をどっちで起動しているかを確認している
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット→起動サーバーを定義
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "/home/ec2-user/Hobby/current/log/cron.log"

# staging環境のみで実行、オブジェクトの指定
if rails_env.to_sym != :development

    every 1.day do
        begin
                                        # 実行する時にに"RAILS_ENV"を見る様に
            rake 'delete:delete_board', :environment_variable => "RAILS_ENV", :environment => "development"
        rescue => e
            Rails.logger.error("aborted rake delete task")
            raise e
        end
    end

    every 30.minutes do
        begin
            rake 'count_stop:delete_board', :environment_variable => "RAILS_ENV", :environment => "development"
            # エラーの例外クラスが来る
        rescue => e 
            Rails.logger.error("aborted rake delete task")
            raise e
        end
    end

end