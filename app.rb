require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/bookmarks'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'hello world'
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb :bookmarks
  end

  run! if app_file == $0
end
