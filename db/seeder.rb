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
    db.execute('DROP TABLE IF EXISTS todos')
  end

  def self.create_tables
    db.execute('CREATE TABLE towatch (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                genre TEXT NOT NULL,
                year INTEGER,
                imdb_rating TEXT,
                runtime INTEGER,
                service TEXT)')

    db.execute('CREATE TABLE watched (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                genre TEXT NOT NULL,
                watchdate TEXT,
                score TEXT,
                imdb_rating TEXT,
                notes TEXT)')
  end

  def self.populate_tables
    db.execute('INSERT INTO towatch (name, genre, year, imdb_rating, runtime, service) VALUES ("Oppenheimer", "Thriller", 2023, "8.3", 180, "Netflix")')
    db.execute('INSERT INTO towatch (name, genre, year, imdb_rating, runtime, service) VALUES ("Rymdimperiet slår tillbaka", "Sci-fi", 1980, "8.7", 124, "Disney+")')
    db.execute('INSERT INTO watched (name, genre, watchdate, score, imdb_rating, notes) VALUES ("The Dark knight", "Action", "16/05/2021", "10", "9.3", "IM BATMAN")')
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