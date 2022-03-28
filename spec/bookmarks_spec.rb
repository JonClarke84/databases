require 'bookmarks'

describe Bookmarks do
  subject(:bookmarks) { described_class.new }
  describe '#all' do
    it 'returns all bookmarks' do
      expect(bookmarks.all).to eq [{ name: 'BBC News', url: 'http://www.bbc.co.uk' },
                                   { name: 'Guardian Football', url: 'http://www.guardian.co.uk/football' },
                                   { name: 'YouTube', url: 'http://www.youtube.com' }]
    end
  end
end
