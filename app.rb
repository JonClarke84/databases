# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra'
require 'sinatra/flash'
require 'uri'
require_relative 'lib/bookmarks'
require_relative 'database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

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
    if params['url'] =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
      Bookmarks.create(url: params[:url], name: params[:name])
      redirect '/'
    else
      flash[:notice] = 'You must submit a valid URL.'
      redirect '/bookmarks'
    end
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
