require 'sqlite3'
require_relative '../config'

class Seeder

  def self.seed!
    puts "Using db file: #{DB_PATH}"
    puts "🧹 Dropping old tables..."
    drop_tables
    puts "🧱 Creating tables..."
    create_tables
    puts "🍎 Populating tables..."
    populate_tables
    puts "✅ Done seeding the database!"
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS towatch')
  end

  def self.create_tables
    db.execute('CREATE TABLE towatch (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                genre TEXT NOT NULL,
                year INTEGER,
                imdb_rating TEXT,
                runtime INTEGER,
                service TEXT,
                watched BIT,
                score TEXT,
                note TEXT)')


  end

  def self.populate_tables
    db.execute('INSERT INTO towatch (name, genre, year, imdb_rating, runtime, service, watched) VALUES ("Oppenheimer", "Thriller", 2023, "8.3", 180, "Netflix", 0)')
    db.execute('INSERT INTO towatch (name, genre, year, imdb_rating, runtime, service, watched) VALUES ("Rymdimperiet slår tillbaka", "Sci-fi", 1980, "8.7", 124, "Disney+", 0)')
    db.execute('INSERT INTO towatch (name, genre, year, imdb_rating, runtime, service, watched, score, note) VALUES ("The Dark knight", "Action", 2008, "9.3", 153, "Netflix", 1, "10", "IM BATMAN")')
  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new(DB_PATH)
      db.results_as_hash = true
      db
    end
  end

end

Seeder.seed!