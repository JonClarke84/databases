require 'bookmarks'
require 'database_helpers'

describe Bookmarks do
  describe '#all' do
    it 'returns all bookmarks' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/news', name: 'BBC News')
      Bookmarks.create(url: 'https://www.guardian.co.uk/football', name: 'Guardian Football')
      Bookmarks.create(url: 'https://www.youtube.com/', name: 'YouTube')
      bookmarks = Bookmarks.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmarks
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.url).to eq 'https://www.bbc.co.uk/news'
      expect(bookmarks.first.name).to eq 'BBC News'
    end
  end

  describe '#create' do
    it 'creates a new bookmark in the database' do
      bookmark = Bookmarks.create(url: 'https://www.mytesturl.com', name: 'My big test page')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.name).to eq 'My big test page'
      expect(bookmark.url).to eq 'https://www.mytesturl.com'
    end
  end

  describe '#delete' do
    it 'deletes a bookmark from the database' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/news', name: 'BBC News')
      Bookmarks.delete(id: bookmark.id)
      expect(Bookmarks.all.length).to eq 0
    end
  end
end
