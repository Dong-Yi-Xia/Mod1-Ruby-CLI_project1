
class Interface

    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new(active_color: :yellow)
    end


    def welcome
        puts "Hello, welcome to Movie Mate!".colorize(:blue)
    end

    def login_register_delete_account
        prompt.select("Please select from the following options.") do |menu|
            menu.choice "🎬Login", -> {User.login} 
            menu.choice "🎬Register", -> {User.create_new_user}
        end
    end

    def home_page         
        #current user is the current instance.user      
        prompt.select("Welcome to the Homepage, #{user.name}!", per_page: 8) do |menu|         
            menu.choice "🍿My reviewed movie list", -> {user.all_my_review_movies}       
            menu.choice "🍿Review a movie", -> {user.add_new_movie_review}             
            menu.choice "🍿Update my review", -> {user.update_a_movie_review}          
            menu.choice "🍿Browse movie reviews", -> {user.view_all_reviews_for_movie}                 
            menu.choice "🍿Browse in theater movies", -> {user.browse_in_theater_movie}                
            menu.choice "🍿My profile", -> {user.my_profile}      
            menu.choice "😠Delete my account", -> {user.delete_my_account}          
            menu.choice "🔆Logout", -> {user.logout}   
         end
    end
end