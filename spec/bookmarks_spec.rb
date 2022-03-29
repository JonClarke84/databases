require 'bookmarks'

describe Bookmarks do
  describe '#all' do
    it 'pulls all entries from the bookmarks table in the bookmarks_manager database' do
      db = PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')

      db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.bbc.co.uk/news', 'BBC News');")
      db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.guardian.co.uk/football', 'Guardian Football');")
      db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.youtube.com/', 'YouTube');")

      bookmarks = Bookmarks.all

      expect(bookmarks).to include({ name: 'BBC News', url: 'https://www.bbc.co.uk/news' })
      expect(bookmarks).to include({ name: 'Guardian Football', url: 'https://www.guardian.co.uk/football' })
      expect(bookmarks).to include({ name: 'YouTube', url: 'https://www.youtube.com/' })
    end
  end

  describe '#create' do
    it 'creates a new bookmark in the database' do
      db = PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
      db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.bbc.co.uk/news', 'BBC News');")
      Bookmarks.create('https://www.mytesturl.com', 'My big test page')

      bookmarks = Bookmarks.all

      expect(bookmarks).to include({ name: 'BBC News', url: 'https://www.bbc.co.uk/news' })
      expect(bookmarks).to include({ name: 'My big test page', url: 'https://www.mytesturl.com' })
    end
  end
end
