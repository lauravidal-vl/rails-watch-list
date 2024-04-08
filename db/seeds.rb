# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url = "https://tmdb.lewagon.com/movie/top_rated"
movies = JSON.parse(URI.open(url).read)["results"]

# for i in 0..9 do
#   movies = JSON.parse(URI.open(url).read)["results"]
#   puts "Creating #{movies[i]["title"]}"
#   base_poster_url = "https://image.tmdb.org/t/p/original"
#   Movie.create(
#     title: movies[i]["title"],
#     overview: movies[i]["overview"],
#     poster_url: "#{base_poster_url}#{movies[i]["backdrop_path"]}",
#     rating: movies[i]["vote_average"]
#   )
# end
# puts "Movies created"

10.times do |i|
  movies = JSON.parse(URI.open(url).read)["results"][i]
  base_poster_url = "https://image.tmdb.org/t/p/original"
  Movie.create(
    title: movies["title"],
    overview: movies["overview"],
    poster_url: "#{base_poster_url}#{movies["backdrop_path"]}",
    rating: movies["vote_average"]
  )
end
puts "Movies created"

top10 = List.create!(name: "Top 10 Movies")
top10_file = URI.open('https://res.cloudinary.com/dvarz39fw/image/upload/v1711194826/laura_dyqsnu.png')
top10.photo.attach(io: top10_file, filename: "laura.png", content_type: "image/png")
top10.save

classic = List.create!(name: "Classic movies")
classic_file = URI.open('https://res.cloudinary.com/dvarz39fw/image/upload/v1711194822/fabien_smrycv.jpg')
classic.photo.attach(io: classic_file, filename: "fabien.png", content_type: "image/png")
classic.save

superhero = List.create!(name: "Superhero movies")
superhero_file = URI.open('https://res.cloudinary.com/dvarz39fw/image/upload/v1711194826/ingrid_vszkta.jpg')
superhero.photo.attach(io: superhero_file, filename: "ingrid.png", content_type: "image/png")
superhero.save

puts "List created"
