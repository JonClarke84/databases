feature 'update a bookmark' do
  scenario 'A user can update a bookmark' do
    Bookmarks.create(url: 'http://www.bbc.co.uk/news', name: 'BBC News')
    visit('/bookmarks')
    expect(page).to have_link('BBC News', href: 'http://www.bbc.co.uk/news')

    click_button 'Update'

    expect(current_path).to eq '/bookmarks/1/update'
    fill_in('url', with: 'http://www.youtube.com')
    fill_in('name', with: 'YouTube')
    click_button('Update')

    expect(page).to have_link('YouTube', href: 'http://www.youtube.com')
  end
end
