class SongsController < ApplicationController

    get "/songs" do 
        @songs = Song.all
        erb :"songs/index"
    end 

    get "/songs/new" do 
        @artists = Artist.all 
        @genres = Genre.all
        erb :"songs/new"
    end 

    post "/songs" do
        @song = Song.find_or_create_by(name: params[:Name])
        if params[:genres]
            params[:genres].each do |genre|
            @song.genres << Genre.find_by(name: genre)
            end
        end 
        if !params["Artist Name"].empty?
            @artist = Artist.find_or_create_by(name: params["Artist Name"])
            @song.artist = @artist
        elsif params[:artist] != ""
            @song.artist = Artist.find_by(name: params[:artist])
        end
        @song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end 

    get "/songs/:slug" do 
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/show"
    end 

    get "/songs/:slug/edit" do 
        @song = Song.find_by_slug(params[:slug]) 
        @artists = Artist.all 
        @genres = Genre.all
        erb :"songs/edit"
    end 

    patch "/songs/:slug" do 
        @song = Song.find_or_create_by(name: params[:Name])
        if params[:genres]
            @song.genres = []
            params[:genres].each do |genre|
            @song.genres << Genre.find_by(name: genre)
            end
        end 
        if !params["Artist Name"].empty?
            @artist = Artist.find_or_create_by(name: params["Artist Name"])
            @song.artist = @artist
        elsif params[:artist] != ""
            @song.artist = Artist.find_by(name: params[:artist])
        end
        @song.save
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end

end     