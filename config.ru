#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'emojifier'
require 'rack'
require 'rack/server'

Thread.new do
	Emojifier.run
end

app = lambda { |_| [200, {}, 'Hello!'] }

Rack::Server.start(
  app: app,
  Port: ENV['PORT'],
  server: 'webrick'
)