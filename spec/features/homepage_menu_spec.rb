feature 'choosing pages from the homepage' do
  scenario 'the user wants to view their bookmarks' do
    visit('/')
    click_link 'View your bookmarks'
    expect(page).to have_content 'Your bookmarks'
  end

  scenario 'the user wants to add a new bookmark' do
    visit('/')
    click_link 'Add a new bookmark'
    expect(page).to have_content 'Add a new bookmark'
  end
end
