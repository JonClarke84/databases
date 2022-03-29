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

  def all
    @bookmarks = []
    @results.each do |bookmark|
      @bookmarks << { name: bookmark['name'], url: bookmark['url'] }
    end
    @bookmarks
  end
end
