feature 'add a bookmark' do
  scenario 'add a bookmark' do
    visit '/add'
    fill_in('name', with: 'My big test page')
    fill_in('url', with: 'http://www.mybigtestpagejonclarke.com')
    click_button 'Add'
    click_link 'View your bookmarks'
    expect(page).to have_content('My big test page')
  end
end
