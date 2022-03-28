require 'bookmarks'

describe Bookmarks do
  subject(:bookmarks) { described_class.new }

  describe '#all' do
    it 'pulls all entries from the bookmarks table in the bookmarks_manager database' do
      expect(bookmarks.all).to eq [
        { name: 'BBC News', url: 'https://www.bbc.co.uk/news' },
        { name: 'YouTube', url: 'https://www.youtube.com' },
        { name: 'Makers Academy', url: 'http://www.makersacademy.com' },
        { name: 'Guardian Football', url: 'https://www.guardian.co.uk/football' }
      ]
    end
  end
end
