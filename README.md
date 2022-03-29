As a user
I want to see a list of my bookmarks
So I can keep track of websites I like

As a time-pressed user
So that I can save a website
I would like to add the site's address and title to bookmark manager

As a user
So that I can remember a website for later
I want to be able to add a website to my list of bookmarks

1. CREATE THE DATABASE
   Connect to psql
   Create the database using the psql command CREATE DATABASE bookmark_manager;
   Connect to the database using the pqsl command \c bookmark_manager;
   Connect to this database with \c bookmark_manager;
   Run the query we have saved in the file 01_create_bookmarks_table.sql

2. CREATE THE TEST DATABASE
   Create the database using the psql command CREATE DATABASE bookmark_manager_test;
   Connect to this database with \c bookmark_manager_test;
   Then run CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), name VARCHAR(60));
