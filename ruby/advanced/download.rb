require 'open-uri'
require 'json'
require 'active_record'

API_KEY = 'e9743662f5a39568d8e25225f2c97e09'

# connect to SQLite3
conn = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'movies.sqlite3')

# create movies table
ActiveRecord::Schema.define do
  create_table "movies", force: true do |t|
    t.text :title
    t.float :vote_average
    t.date :release_date
    t.text :overview
    t.integer :director_id
    t.integer :genre_id
    t.integer :remote_id
  end
  create_table "directors", force: true do |t|
    t.integer :movie_id
    t.text :name
  end
  create_table "actors", force: true do |t|
    t.string :name
  end
  create_table "characters", force: true do |t|
    t.string :name
    t.integer :movie_id
    t.integer :actor_id
  end
  create_table "genres", force: true do |t|
    t.string :name
    t.integer :remote_id
  end
end

class Movie < ActiveRecord::Base
end
class Actor < ActiveRecord::Base
end
class Director < ActiveRecord::Base
end
class Character < ActiveRecord::Base
end
class Genre < ActiveRecord::Base
end

puts "Getting list of genres..."
url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{API_KEY}"
genre_data = JSON.parse(open(url).read)['genres']
genre_data.each do |genre|
  Genre.create name: genre['name'], remote_id: genre['id']
end

puts "Getting popular movies..."
# Get popular movies from the API
shown = false
1.upto(20) do |page|
  url = "https://api.themoviedb.org/3/movie/popular?api_key=#{API_KEY}&language=en-US&page=#{page}&region=US"
  data = JSON.parse(open(url).read)['results']
  data.each do |movie|
    Movie.create title: movie['title'], vote_average: movie['vote_average'],
                 remote_id: movie['id'], overview: movie['overview'],
                 release_date: Date.parse(movie['release_date']),
                 genre_id: Genre.find_by_remote_id(movie['genre_ids'].first).try(:id)
  end
end

puts "#{Movie.count} movies"

puts "Getting directors and actors..."
Movie.all.each_with_index do |movie, index|
  puts "Getting data for movie ##{index}" if index % 100 == 0 && index > 0
  url = "https://api.themoviedb.org/3/movie/#{movie.remote_id}/credits?api_key=#{API_KEY}"
  data = JSON.parse(open(url).read)
  director = data['crew'].detect { |person| person['job'] == 'Director' }
  if director
    d = Director.find_by_name(director['name'])
    d ||= Director.create movie_id: movie.id, name: director['name']
    movie.update director_id: d.id
  end
  data['cast'].each do |casting|
    actor = Actor.find_by_name(casting['name'])
    actor ||= Actor.create(name: casting['name'])
    character = Character.find_by(actor_id: actor.id, movie_id: movie.id, name: casting['character'])
    character ||= Character.create(actor_id: actor.id, movie_id: movie.id, name: casting['character'])
  end
end

puts "#{Actor.count} actors"
puts "#{Character.count} characters"
