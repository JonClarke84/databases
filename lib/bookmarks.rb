# retrives bookmarks from the 'database' and can return as an array

class Bookmarks
  def initialize
    @bookmarks = [{ name: 'BBC News', url: 'http://www.bbc.co.uk' },
                  { name: 'Guardian Football', url: 'http://www.guardian.co.uk/football' },
                  { name: 'YouTube', url: 'http://www.youtube.com' }]
  end

  def self.all
    new.all
  end

  def all
    @bookmarks
  end
end
