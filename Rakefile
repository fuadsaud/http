$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'sockettp'

task :server do
  Sockettp::Server.new(ENV['SOCKETTP_DIR']).start
end

task :client do
  loop do
    print '>> '
    puts Sockettp::Client.request(STDIN.gets.chomp)
  end
end
