# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/bookmarks'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb :bookmarks
  end

  get '/add' do
    erb :add
  end

  post '/create-bookmark' do
    Bookmarks.create(params[:url], params[:name])
    redirect '/'
  end

  delete '/bookmarks/:id' do
    Bookmarks.delete(id: params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
