
class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    if Artist.find_by(name: params[:artist_name])
      @artist = Artist.find_by(name: params[:artist_name])
    else
      @artist = Artist.create(name: params[:artist_name])
    end
    @song = Song.create(name: params[:song_name], artist: @artist)
    @song.genres.push(Genre.find(params[:genre_id]))
    @song.save
    flash[:message] = "Successfully created song."
    redirect :"/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @genres= Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    if params[:artist_name]
      @artist = Artist.create(name: params[:artist_name])
    end
    @song.update(name: params[:song_name], artist: @artist)
    @song.genres.clear
    @song.genres.push(Genre.find(params[:genre_id]))
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end


end
