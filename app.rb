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
      @towatch = db.execute('SELECT * FROM towatch WHERE watched = 0')
      @watched = db.execute('SELECT * FROM towatch WHERE watched = 1')
      erb(:"index")
    end

    get '/index' do 
      erb(:'index')
    end
    get '/add' do
      erb(:"add")
    end

    get '/show/:id' do |id|
      @movieinfo = db.execute('SELECT * FROM towatch WHERE id=?', id.to_i).first
      erb(:"movieinfo")
    end

    post '/add' do
      p params
      db.execute("INSERT INTO towatch (name, genre, year, imdb_rating, runtime, service, watched) VALUES (?,?,?,?,?,?, 0)", params.values)
      redirect('/')
    end
end
