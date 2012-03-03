require 'fluent/admin/web.rb'
require 'optparse'

options = { 
  :conf => nil,
  :port => 22324
}

OptionParser.new { |opt|
  opt.on('-c', '--conf PATH', 'Fluentd used config file') { |c|
    options[:conf] = File.expand_path(c)
  }
  opt.on('-p', '--port NUM', Integer) { |p|
    options[:port] = p
  }
  opt.parse!(ARGV)
}

Fluent::Admin::Web.set_options(options)
Fluent::Admin::Web.run!(:port => options[:port])
