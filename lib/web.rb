require 'sinatra/base'

module Emojifier
  class Web < Sinatra::Base
    get '/' do
      'Emoji are great!'
    end
  end
end