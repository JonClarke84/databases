# frozen_string_literal: true

# retrives bookmarks from the 'database' and can return as an array

require 'pg'

class Bookmarks
  attr_reader :id, :name, :url

  def initialize(id:, name:, url:)
    @id = id
    @name = name
    @url = url
  end

  def self.all
    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    result = db.exec 'SELECT * FROM bookmarks'
    result.map do |bookmark|
      Bookmarks.new(id: bookmark['id'], name: bookmark['name'], url: bookmark['url'])
    end
  end

  def self.create(url:, name:)
    raise if url.start_with?('http://', 'https://') == false

    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    result = db.exec_params("INSERT INTO bookmarks (url, name) VALUES ('#{url}', '#{name}') RETURNING id, url, name")
    Bookmarks.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end

  def self.delete(id:)
    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    db.exec_params('DELETE FROM bookmarks WHERE id = $1', [id])
  end

  def self.find(id:)
    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    result = db.exec_params('SELECT * FROM bookmarks WHERE id = $1', [id])
    Bookmarks.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end

  def self.update(id:, url:, name:)
    db = if ENV['ENVIRONMENT'] == 'test'
           PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
         else
           PG.connect dbname: 'bookmark_manager', user: 'jonathan.clarke'
         end
    result = db.exec_params(
      "UPDATE bookmarks
      SET url = '#{url}', name = '#{name}'
      WHERE id = #{id}
      RETURNING id, url, name"
    )
    Bookmarks.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end
end
