class Review < ActiveRecord::Base
  # add associatons!
  belongs_to :user
  belongs_to :movie
end
