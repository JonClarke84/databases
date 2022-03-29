def setup_test_database
  require 'pg'
  p 'Setting up database...'
  db = PG.connect(dbname: 'bookmark_manager_test', user: 'jonathan.clarke')
  db.exec('TRUNCATE bookmarks RESTART IDENTITY;')
end
