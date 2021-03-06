require "sinatra"
require "sinatra/reloader" if development? #Only want sinatra reloading if we are actively developing
require "active_record"
require_relative "config/environments"
require_relative "./models/show"
require_relative "./models/song"
# require "pry"

after do
  ActiveRecord::Base.clear_active_connections!
end

# Welcome to Broadway.ly!
get "/" do
  erb :index
end

# Index of all shows with links to individual shows
get "/shows" do
  @all_shows = Show.all

  erb :shows
end

# Form to create new show
get "/shows/new" do

  erb :add_show
end

# Create action - new show - redirects to that show
post "/shows" do

  @new_show = Show.new(title: params[:title], year: params[:year].to_i, composer: params[:composer], img_url: params[:img_url])
  @new_show.save

  redirect "/shows/#{@new_show.id}"
end

# Individual show page
# Links to list of all songs `/shows/:id/songs`
# and form to create new songs `/shows/:id/songs/new`
get "/shows/:id" do
  @a_show = Show.find(params[:id])

  erb :show
end

# Form to create new songs
get "/shows/:id/songs/new" do
  @show_title = Show.all.find_by(id: params[:id]).title

  erb :add_song
end

# Create action - new songs for a show - redirects to that song
post "/shows/:id/songs" do
  @new_song = Song.new(title: params[:title], embed_url: params[:embed_url], show_id: params[:id])
  @new_song.save

  redirects "/shows/#{params[:id]}/songs/:#{@new_song.id}"
end

# Lists all songs from the show
get "/shows/:id/songs" do
  @a_show = Show.all.find_by(id: params[:id])
  @songs_from_show = @a_show.songs
  
  erb :songs
end

# Shows just one song from the show
get "/shows/:show_id/songs/:song_id" do
  @a_show = Show.all.find_by(id: params[:show_id])
  @song_from_show = @a_show.songs.find_by(id: params[:song_id])

  erb :song
end