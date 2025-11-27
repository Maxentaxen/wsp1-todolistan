require 'debug'
require "awesome_print"

class App < Sinatra::Base

    # Funktion för att prata med databasen
    # Exempel på användning: db.execute('SELECT * FROM fruits')
    def db
      return @db if @db

      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    # Routen /
    get '/' do
      @movies = db.execute('SELECT name, year, imdb_rating, runtime, watched, score, note, GROUP_CONCAT(DISTINCT genre_name) as genres, GROUP_CONCAT(DISTINCT service_name) as services FROM movies
                              INNER JOIN movies_genres 
                                ON movies.id = movies_genres.movie_id
                              INNER JOIN genres
                                ON movies_genres.genre_id = genres.genre_id
                              INNER JOIN movies_services
                                ON movies.id = movies_services.movie_id
                              INNER JOIN services
                                ON movies_services.service_id = services.service_id
                            GROUP BY movies.id
                            ')
      ap @movies
      erb(:"index")
    end

    get '/index' do 
      erb(:'index')
    end
    get '/add' do
      erb(:"add")
    end

    get '/show/:id' do |id|
      
    end

    post '/add' do
      
    end
end
