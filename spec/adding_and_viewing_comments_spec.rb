feature 'Adding and viewing comments' do
  feature 'a user can add and then view a comment' do
    scenario 'a comment is added to a bookmark' do
      bookmark = Bookmarks.create(url: 'http://www.makersacademy.com', name: 'Makers Academy')

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Comment'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

      fill_in 'comment', with: 'This is a test comment on this bookmark'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'This is a test comment on this bookmark'
    end
  end
end
