class User < ActiveRecord::Base
  # add associatons!
  has_many :reviews
  has_many :movies, through: :reviews



  ####################################################################
  ######################  Login/Register page      ###################
  ####################################################################

###################################################################
#Registering Page##################################################
###################################################################
  def self.create_new_user
    prompt = TTY::Prompt.new(active_color: :yellow)
    user_input_name = prompt.ask("What is your username:")
    #user needs to enter a valid username only alphabet and numbers. 
    while user_input_name.nil? || user_input_name.match(/[\W,\s]/) 
      puts "Invalid, please enter alphabet or numbers only."
      user_input_name = prompt.ask("What is your username:")
    end
    found_user = User.all.find_by(name: user_input_name)
    until !found_user
      puts "Sorry, Username already taken. Try again"
      user_input_name = prompt.ask("What is your username:") 
      found_user = User.all.find_by(name: user_input_name)
    end
    password = prompt.mask("What is your password:")
    #returning a user instance
    User.create(name: user_input_name, age: rand(25))
  end
###################################################################
#Login Page########################################################
###################################################################

  def self.login
    prompt = TTY::Prompt.new(active_color: :yellow)
    user_input_name = prompt.ask("User name:")
    found_user = User.all.find_by(name: user_input_name)
    counter = 4
    until found_user
      puts "Username not found, try again, you have #{counter} times attempts remaining"
      user_input_name = prompt.ask("User name:")
      found_user = User.all.find_by(name: user_input_name)
      counter -= 1
      if counter < 1
        user_1 = User.new
        puts "Ok, guess you don't have an account with us, please try to register an account."
        user_1.go_back_to_login_page_with_yes
      end
    end
    password = prompt.mask("Password:")
    #returning a user instance
    found_user
  end

  #############################################################
  #############################################################
  ##  An User instance - user account features
  #############################################################
  #############################################################

###################################################################
#Delete my account feature#########################################
###################################################################
      def delete_my_account
        prompt = TTY::Prompt.new(active_color: :yellow)
        answer = prompt.select("Are you sure you are leaving me💔?") do |menu|
        menu.choice "Yes", -> {
          puts "Good Bye #{self.name}."
          self.destroy
          sleep 2.5
          system 'clear'
          go_back_to_login_page
        }
        menu.choice "No", -> {
          puts "Good, you are not leaving."
          sleep 2.5
          system 'clear'
          go_back_to_homepage
        }     
      end
    end
###################################################################
#My reviewed movie list feature####################################
###################################################################
    def all_my_review_movies
      prompt = TTY::Prompt.new(active_color: :yellow)
     #Iterating over user reviews 
      review_array = self.reviews.pluck(:review)
      rating_array = self.reviews.pluck(:rating)
      titles_array = self.movies.pluck(:title)
     #Modifing the arrays 
      review_array_list = review_array.map{|comment| "Review: #{comment}" }
      rating_array_list = rating_array.map{|num| "Rating: #{num}" }
      titles_array_list = titles_array.map{|title| "Title: #{title}" }
      #zip the array the the desired output
      movie_list = titles_array_list.zip(rating_array_list,review_array_list)
      movie_list = movie_list.map{|x| x.join(" | ")}
      movie_list.each_with_index{|movie_1, movie_index|
        puts "#{movie_index+1}, #{movie_1}"
      }
      go_back_to_homepage_with_yes
    end
###################################################################################
#Add new moview review ############################################################
###################################################################################
    def add_new_movie_review
      prompt = TTY::Prompt.new(active_color: :yellow)
      #get movie title from the user and validate the movie title
      movie_title = prompt.ask("Which movie are you going to review?:")
      movie_title = validate_movie_title(movie_title)

      #get review statement from the user and validate the review statement
      review_statement = prompt.ask("Lets start your review:")
      review_statement =  validate_review_statement(review_statement)

      #get rating_num from the user and validate the rating num
      rating_num = prompt.ask("Rate the movie from 1 - 10:")
      rating_num = validate_rating_num(rating_num)

      if current_movie_instance = Movie.all.find_by(title: movie_title)
        review = Review.create(user: self, movie: current_movie_instance, review: review_statement, rating: rating_num )       
      else
        reviewed_movie = Movie.create(title: movie_title)
        review = Review.create(user: self, movie: reviewed_movie, review: review_statement, rating: rating_num )
      end
      puts "Congratulations!!⭐️ You just added a new review to #{movie_title}."
      go_back_to_homepage_with_yes

    end
###################################################################
#Update a movie review feature#####################################
###################################################################
    def update_a_movie_review
      prompt = TTY::Prompt.new(active_color: :yellow)
     
      review_array = self.reviews.pluck(:review)
      rating_array = self.reviews.pluck(:rating)
      titles_array = self.movies.pluck(:title)

      review_array_list = review_array.map{|comment| "Review: #{comment}" }
      rating_array_list = rating_array.map{|num| "Rating: #{num}" }
      titles_array_list = titles_array.map{|title| "Title: #{title}" }

      movie_list = titles_array_list.zip(rating_array_list,review_array_list)
      movie_list = movie_list.map{|x| x.join(" | ")}
      movie_list << "Exit"
      user_input = prompt.select("Which movie do you wish to update?",  movie_list, per_page: 15)
      review_section = user_input.rpartition("Review:").last.strip

      if user_input == "Exit"
        go_back_to_homepage_with_yes
      end

      Review.all.find_by(review: review_section)

      #get review_statement from the user and validate the review_statement
      review_statement = prompt.ask("Let's update your review:")
      review_statement = validate_review_statement(review_statement)
      
      #get rating_num from the user and validate the rating_num
      rating_num = prompt.ask("Let's update your rating from 1 - 10:")
      rating_num = validate_rating_num(rating_num)

      found_review = self.reviews.find_by(review: review_section)
      found_review.update(review: review_statement, rating: rating_num)

      puts "Congratulations!!⭐️ You just updated your review sucessfully."

      go_back_to_homepage_with_yes
    end

###################################################################
#View all reviews for all movies feature###########################
###################################################################
    def view_all_reviews_for_movie
      movie_list = Movie.order(:title).pluck(:title)
      prompt = TTY::Prompt.new(active_color: :yellow)
      # condition if the user is new
      #if movie_list is empty, "return puts you dont have any re
      user_choice = prompt.select("Which movie do you want to view?", movie_list.uniq, per_page: 10) 
      id_of_movie = Movie.all.find_by(title: user_choice).id
      array_of_reviews = Review.all.where(movie_id: id_of_movie)
      array_of_reviews.map { |review| puts "#{review.review.colorize(:green)} --#{review.user.name.colorize(:green)}" }
      # binding.pry
      # array_of_reviews = Review.all.where(movie_id: id_of_movie).pluck(:review)
      # array_of_reviews.each_with_index do |review, ind|
      #   puts "#{ind +1 }. #{review}."
      # end
      #add user name after the review. if we have time.
      go_back_to_homepage_with_yes
  end
###################################################################
#View and update My Profile feature################################
###################################################################
    def my_profile
        puts "Name: #{self.name}".colorize(:yellow) 
        puts "Age: #{self.age}".colorize(:yellow) 
        prompt = TTY::Prompt.new(active_color: :yellow)
        prompt.select("Would you like to update your profile?") do |menu|
          menu.choice "Update my username", -> {self.my_profile_username_update}
          menu.choice "Update my age", -> {self.my_profile_userage_update}
          menu.choice "Back to homepage", -> {self.go_back_to_homepage}
        end
    end

    def my_profile_username_update
      prompt = TTY::Prompt.new(active_color: :yellow)
      new_user_name_input = prompt.ask("What is your new username?:")
      self.name = new_user_name_input 
      puts "Congratulations, you successfully updated your username to #{self.name}."
      self.save
      go_back_to_homepage_with_yes
    end

    def my_profile_userage_update
      prompt = TTY::Prompt.new(active_color: :yellow)
      new_user_age_input = prompt.ask("What is your new age?:")
      self.age = new_user_age_input 
      puts "Congratulations, you successfully updated your age to #{self.age}."
      self.save
      go_back_to_homepage_with_yes
    end
###################################################################
#browse_in_theater_movie feature###################################
###################################################################

    def browse_in_theater_movie
      now_playing = Movie.all.where(in_theaters: true)
      now_playing.each_with_index do |movie, ind|
        puts "#{ind+1}. #{movie.title}".colorize(:magenta)
      end
      go_back_to_homepage_with_yes
    end

###################################################################
#browse_in_theater_movie feature###################################
###################################################################

    def logout
      Tuzki.go
      go_back_to_login_page
    end


    ################################################################
    # Helper Method Section ########################################
    ################################################################
    def go_back_to_homepage
      interface = Interface.new
      #self is an instance of a user, user has not logged out
      interface.user = self
      interface.home_page
    end

    def go_back_to_homepage_with_yes
      only_yes_home
      Loading.go
      go_back_to_homepage
    end

    def go_back_to_login_page
        #current user has logged out
        Loading.go
        system 'clear'
        app = MovieMate.new
        app.run
    end

    def go_back_to_login_page_with_yes
      #current user has logged out
      only_yes_login
      Dance.go
      system 'clear'
      app = MovieMate.new
      app.run
  end

    def only_yes_home
      prompt = TTY::Prompt.new(active_color: :yellow)
      prompt.select("Go back to homepage?", ["Yes"])
    end

    def only_yes_login
      prompt = TTY::Prompt.new(active_color: :yellow)
      prompt.select("Go back to login page?", ["Yes"])
    end

    def delay 
      sleep (2.5)
      system 'clear'
    end

############################### validation helpers ###############################

    def validate_movie_title(str_1)
      prompt = TTY::Prompt.new(active_color: :yellow)
      while str_1.nil? do
        system "clear"
        puts "Please enter a valid movie name."
        str_1 = prompt.ask("Which movie are you going to review?:")
      end
        str_1
    end

    def validate_review_statement(str)
      prompt = TTY::Prompt.new(active_color: :yellow)
      while str.nil? do
        system "clear"
        puts "Please enter a valid review."
        str = prompt.ask("Let's update your review:")
      end
        str
    end

    def validate_rating_num(rating_num)
      prompt = TTY::Prompt.new(active_color: :yellow)
      while rating_num.nil? || rating_num.match(/\D/) do
        system "clear"
        puts "Please enter a number from 1 to 10."
        rating_num = prompt.ask("Let's update your rating from 1 - 10:")
      end
      rating_num.to_i.clamp(1,10)
    end

end

    ###########################################################################
    ##################### The End #############################################
    ###########################################################################