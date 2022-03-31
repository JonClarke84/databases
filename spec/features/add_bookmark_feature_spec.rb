feature 'add a bookmark' do
  scenario 'add a bookmark' do
    visit '/add'
    fill_in('name', with: 'My big test page')
    fill_in('url', with: 'http://www.mybigtestpagejonclarke.com')
    click_button 'Add'
    click_link 'View your bookmarks'
    expect(page).to have_content('My big test page')
  end

  scenario 'The bookmark must be a valid URL' do
    visit '/add'
    fill_in('name', with: 'My big test page')
    fill_in('url', with: 'not a real bookmark')
    click_button 'Add'

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must submit a valid URL.'
  end
end
