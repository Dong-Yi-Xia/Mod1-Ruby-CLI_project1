User.destroy_all
Movie.destroy_all
Review.destroy_all
User.reset_pk_sequence
Movie.reset_pk_sequence
Review.reset_pk_sequence

########### different ways to write your seeds ############

ash = User.create(name: "Ash", age: rand(10..100))
misty = User.create(name: "Misty", age: rand(10..100))

pokemon = Movie.create(title: "Pokemon Forever", genre: "animation", release_date: "2000", in_theaters: false)
candy_man = Movie.create(title: "Candy Man", genre: "comedy", release_date: "2017", in_theaters: false)
your_name = Movie.create(title: "Your Name", genre: "animation", release_date: "2020", in_theaters: true)
the_godfather = Movie.create(title: "The Godfather", genre: "action", release_date: "2020", in_theaters: true)

ash_review_1 = Review.create(user: ash, movie: pokemon, review: "It was great.", rating: 9)
ash_review_2 = Review.create(user: ash, movie: the_godfather, review: "It was a boring.", rating: 3)
misty_review_1 = Review.create(user: misty, movie: candy_man, review: "It was ok, not the best", rating: 5)
misty_review_2 = Review.create(user: misty, movie: your_name, review: "It was super.", rating: 10)
ash_review_3 = Review.create(user: ash, movie: your_name, review: "It was awesome.", rating: 9)
ash_review_4 = Review.create(user: ash, movie: candy_man, review: "It was tasty", rating: 7)









# # 3. Use Faker and mass create
# ## step 1: write a method that creates a person
def create_user
    user = User.create(
        name: Faker::Games::Pokemon.name, 
        age: rand(10...70)
    )
end



def create_movie
    movie = Movie.create(
        title: Faker::Book.title,
        genre: Faker::Book.genre,
        release_date: rand(1980...2020),
        in_theaters: [true, false].sample
    )
end



## step 2: write a method that creates a joiner
def create_joiners(user)
    moives = rand(1..4)
    moives.times do 
        Review.create(
            movie_id: Movie.all.sample.id, 
            user_id: user.id, 
            rating: rand(1..10), 
            review: Faker::Movie.quote 
        )
    end
end



# step 3: invoke creating joiners by passing in an instance of a person
100.times do     
    create_user()
    create_movie()
    create_joiners(create_user)
    ##### ALTERNATIVE:
    # person = create_person
    # create_joiners(person)
end

# indoor = Category.create(name: "indoors")
# Plant.update(category_id: indoor.id)


puts "😃"