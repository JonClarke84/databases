feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmark' do
    Bookmarks.create(url: 'http://www.bbc.co.uk/news', name: 'BBC News')
    visit('/bookmarks')
    expect(page).to have_link('BBC News', href: 'http://www.bbc.co.uk/news')

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('BBC News', href: 'http://www.bbc.co.uk/news')
  end
end
