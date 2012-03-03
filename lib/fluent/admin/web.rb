require 'fluent/env'
require 'sinatra/base'
require 'haml'

module Fluent
  module Admin
    class Web < Sinatra::Base
      class << self
        def set_options(options)
          configure do
            set :conf, options[:conf] || Fluent::DEFAULT_CONFIG_PATH
          end
        end
      end

      get '/' do
        @config  = File.read(options.conf)
        @daemons = current_process_status
        @masterd = @daemons.last

        haml :index
      end

      post '/' do
        new_config = params['config']

        # backup
        begin
          FileUtils.cp(options.conf, "#{options.conf}.#{Time.now.strftime('%Y%m%d%H%M%S')}")
        rescue
          # TODO: use flash like Rails
          return haml :error
        end

        # Replace
        begin
          File.open(options.conf, 'w') { |f|
            f.write(new_config)
          }
        rescue
          # TODO: use flash like Rails
          return haml :error
        end

        # Restart
        begin
          `kill -1 #{params['process_id']}`
        rescue
          # TODO: use flash like Rails
          return haml :error
        end

        redirect '/'
      end

      get '/error' do
        haml :error
      end

      def current_process_status
        `LANG=C ps aux | awk '/bin\\/fluentd /{print $2 " " $9 " " $10}'`.split("\n").map { |status|
          status.split(' ')
        }.sort { |a, b| a[2] <=> b[2] }
      end
    end
  end
end
