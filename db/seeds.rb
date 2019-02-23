# Add seed data here. Seed your database with `rake db:seed`
@artist = Artist.create(:name => "Taylor Swift") 
blank_space =  Song.create(:name => "Blank Space", :artist => @artist) 
pop = Genre.create(:name => "Pop")
blank_space.genre_ids = pop.id

@artist = Artist.create(:name => "Vic Fuentes") 
blank_space =  Song.create(:name => "King For A Aay", :artist => @artist) 
rock = Genre.create(:name => "Rock")
blank_space.genre_ids = rock.id