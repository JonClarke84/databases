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
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.name).to eq 'My big test page'
      expect(bookmark.url).to eq 'https://www.mytesturl.com'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmarks.create(url: 'not a real bookmark', name: 'Not a real bookmark')
      expect(Bookmarks.all).to be_empty
    end
  end

  describe '#delete' do
    it 'deletes a bookmark from the database' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/news', name: 'BBC News')
      Bookmarks.delete(id: bookmark.id)
      expect(Bookmarks.all.length).to eq 0
    end
  end

  describe '#find' do
    it 'finds a specific bookmark' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/news', name: 'BBC News')
      Bookmarks.create(url: 'https://www.guardian.co.uk/football', name: 'Guardian Football')
      Bookmarks.create(url: 'https://www.youtube.com/', name: 'YouTube')
      result = Bookmarks.find(id: bookmark.id)

      expect(result).to be_a Bookmarks
      expect(result.id).to eq bookmark.id
      expect(result.name).to eq 'BBC News'
      expect(result.url).to eq 'https://www.bbc.co.uk/news'
    end
  end

  describe 'update' do
    it 'updates a bookmark' do
      bookmark = Bookmarks.create(url: 'https://www.bbc.co.uk/news', name: 'BBC News')
      result = Bookmarks.update(id: bookmark.id, url: 'https://www.youtube.com', name: 'YouTube')

      expect(result).to be_a Bookmarks
      expect(result.id).to eq bookmark.id
      expect(result.name).to eq 'YouTube'
      expect(result.url).to eq 'https://www.youtube.com'
    end
  end

  describe '#comments' do
    it 'returns a list of comments on the bookmark' do
      bookmark = Bookmarks.create(name: 'Makers Academy', url: 'http://www.makersacademy.com')
      DatabaseConnection.query(
        "INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', $1)",
        [bookmark.id]
      )

      comment = bookmark.comments.first

      expect(comment['text']).to eq 'Test comment'
    end
  end
end
