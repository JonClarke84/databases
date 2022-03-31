# frozen_string_literal: true

# retrives bookmarks from the 'database' and can return as an array

require 'pg'
require 'database_connection'

class Bookmarks
  attr_reader :id, :name, :url

  def initialize(id:, name:, url:)
    @id = id
    @name = name
    @url = url
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')
    result.map do |bookmark|
      Bookmarks.new(
        url: bookmark['url'],
        name: bookmark['name'],
        id: bookmark['id']
      )
    end
  end

  def self.create(url:, name:)
    raise if url.start_with?('http://', 'https://') == false

    result = DatabaseConnection.query("INSERT INTO bookmarks (url, name) VALUES ('#{url}', '#{name}') RETURNING id, url, name;")
    Bookmarks.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query('DELETE FROM bookmarks WHERE id = $1;', [id])
  end

  def self.find(id:)
    result = DatabaseConnection.query('SELECT * FROM bookmarks WHERE id = $1;', [id])
    Bookmarks.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end

  def self.update(id:, url:, name:)
    result = DatabaseConnection.query(
      "UPDATE bookmarks
      SET url = '#{url}', name = '#{name}'
      WHERE id = #{id}
      RETURNING id, url, name"
    )
    Bookmarks.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end
end
