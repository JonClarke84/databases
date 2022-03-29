# frozen_string_literal: true

# retrives bookmarks from the 'database' and can return as an array

require 'pg'

class Bookmarks
  def initialize
    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    @results = db.exec 'SELECT * FROM bookmarks'
  end

  def self.all
    new.all
  end

  def self.create(url, name)
    new.create(url, name)
  end

  def self.delete(id:)
    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    # binding.irb
    db.exec_params('DELETE FROM bookmarks WHERE id = $1', [id])
  end

  def all
    @bookmarks = []
    @results.each do |bookmark|
      @bookmarks << { id: bookmark['id'], name: bookmark['name'], url: bookmark['url'] }
    end
    @bookmarks
  end

  def create(url, name)
    raise if url.start_with?('http://', 'https://') == false

    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    db.exec_params('INSERT INTO bookmarks (url, name) VALUES ($1, $2) RETURNING id, url, name', [url.to_s, name.to_s])
  end
end
