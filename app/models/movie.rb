class Movie < ActiveRecord::Base
# add associatons!
    has_many :reviews
    has_many :users, through: :reviews

end
