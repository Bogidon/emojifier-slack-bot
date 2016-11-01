# This file is used by Rack-based servers to start the application.

$LOAD_PATH.unshift(File.dirname(__FILE__))

require_relative 'lib/emojifier'
require_relative 'lib/web'

Thread.abort_on_exception = true

Thread.new do
  begin
    Emojifier::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run Emojifier::Web