require 'bookmarks'

describe Bookmarks do
  describe '#all' do
    it 'pulls all entries from the bookmarks table in the bookmarks_manager database' do
      db = PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')

      db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.bbc.co.uk/news', 'BBC News');")
      db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.guardian.co.uk/football', 'Guardian Football');")
      db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.youtube.com/', 'YouTube');")

      bookmarks = Bookmarks.all
      # binding.irb

      expect(bookmarks).to include({ name: 'BBC News', url: 'https://www.bbc.co.uk/news' })
      expect(bookmarks).to include({ name: 'Guardian Football', url: 'https://www.guardian.co.uk/football' })
      expect(bookmarks).to include({ name: 'YouTube', url: 'https://www.youtube.com/' })
    end
  end
end
