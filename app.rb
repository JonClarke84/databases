# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/bookmarks'
require_relative './lib/database_connection'

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
    Bookmarks.create(url: params[:url], name: params[:name])
    redirect '/'
  end

  delete '/bookmarks/:id/delete' do
    Bookmarks.delete(id: params[:id])
    redirect '/bookmarks'
  end

  post '/bookmarks/:id/update' do
    @bookmark = Bookmarks.find(id: params[:id])
    erb :update
  end

  patch '/bookmarks/:id/update' do
    Bookmarks.update(id: params[:id], url: params[:url], name: params[:name])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
