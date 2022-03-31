# frozen_string_literal: true

# retrives bookmarks from the 'database' and can return as an array

require_relative 'database_connection'
require 'uri'

class Bookmarks
  attr_reader :id, :name, :url

  def initialize(id:, name:, url:)
    @id = id
    @name = name
    @url = url
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks')
    result.map do |bookmark|
      Bookmarks.new(
        url: bookmark['url'],
        name: bookmark['name'],
        id: bookmark['id']
      )
    end
  end

  def self.create(url:, name:)
    return false unless is_url?(url)

    result = DatabaseConnection.query(
      'INSERT INTO bookmarks (url, name) VALUES ($1, $2) RETURNING id, url, name;', [url, name]
    )
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
      SET url = $1, name = $2
      WHERE id = $3
      RETURNING id, url, name;", [url, name, id]
    )
    Bookmarks.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end

  def self.is_url?(url)
    url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end

  def comments
    DatabaseConnection.query(
      'SELECT * FROM comments WHERE bookmark_id = $1;',
      [id]
    )
  end
end
