feature 'viewing bookmarks' do
  scenario 'the user can view their bookmarks on the page' do
    visit('/bookmarks')
    expect(page).to have_content 'BBC News'
    expect(page).to have_content 'Guardian Football'
    expect(page).to have_content 'YouTube'
  end
end
