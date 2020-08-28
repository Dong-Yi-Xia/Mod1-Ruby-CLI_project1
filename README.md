#Movie Mate

#Movie Mate is a CLI app that allows you to manage your movie reviews, and browser in theater movies.

#How to Install
1. Clone the repo onto your local machine.
2. Change the directory to the repo.
3. In you terminal, run 'bundle install'.
4. Run 'rake db:migrate'.
5. Run 'rake db:seed'.
6. Run 'ruby bin.run.rb' to open the app.

## Login / Register Menu
- Login with a existing account
- Register if you don't have an account

## Home Page
1. My Movie Reviews 
	- Allow users to browse all the reviews that have been created by the user.
2. Review a movie
	- Allow users to write a review for a movie, and rate the movie. 
3. Update my review
	- Allow users to update the existing reviews.
4. Browse movie reviews
	- Allow users to browse movie reviews.
5. Browse in theater movies
	- Allow users to browser in theater movies 
6. My profile
	- Allow users to update their username and age. 
7. Delete my account
	- Allow users to delete their account.
7. Logout
	- User can logout

## 	User Storues
	- As a user, I want to be able to manage my movie reviews.
	- As a user, I want to be able to browser in theater movie, so I can decide which movie to watch.
	- As a user, I want to see the reviews for a movie that I'm interested in.
	- Aa a user, I want to be able to delete my account.

## Gem Used
  - [TTY::Prompt](https://github.com/piotrmurach/tty-prompt)
  - [AtiveRecord](https://github.com/rails/rails)
  - [Sinatra-activerecord](https://github.com/sinatra-activerecord/sinatra-activerecord)
  - [Rake](https://github.com/ruby/rake)
  - [Require_all](https://github.com/jarmo/require_all)
  - [Sqlite3](https://github.com/mackyle/sqlite)
  - [Pry](https://github.com/pry/pry)
  - [Faker](https://github.com/faker-ruby/faker)
  - [Colorize](https://github.com/fazibear/colorize)
  - [Activerecord-reset-pk-sequence](https://github.com/rails/rails/tree/master/activerecord)
  - [TTY-Font](https://github.com/piotrmurach/tty-font)
  - [Catpix](https://github.com/pazdera/catpix)

## Domain Model
	Movie ==== <  Review >==== User





