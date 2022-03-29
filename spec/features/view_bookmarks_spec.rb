feature 'viewing bookmarks' do
  scenario 'the user can view their bookmarks on the page' do
    db = PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')

    db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.bbc.co.uk/news', 'BBC News');")
    db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.guardian.co.uk/football', 'Guardian Football');")
    db.exec("INSERT INTO bookmarks (url, name) VALUES ('https://www.youtube.com/', 'YouTube');")

    visit('/bookmarks')
    expect(page).to have_content 'BBC News'
    expect(page).to have_content 'Guardian Football'
    expect(page).to have_content 'YouTube'
  end
end
