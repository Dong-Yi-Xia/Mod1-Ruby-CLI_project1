require 'bundler'
Bundler.require

#environment setting
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/movie_review.db')
ActiveRecord::Base.logger = nil
require_all 'app'

