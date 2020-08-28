class MovieMate
  # here will be your CLI!
  # it is not an AR class so you need to add attr


  def run
    Title.header
    Image.title
    login_page
  end



###############################################################
  private
###############################################################
  def login_page
    interface = Interface.new
    #getting back a user instance either by logging in or creating a new user
    user_instance = interface.login_register_delete_account
    #reassign interface.user to a user instance
    interface.user = user_instance
    Loading.go
    interface.home_page
  end




  
end
