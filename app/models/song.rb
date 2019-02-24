class Song < ActiveRecord::Base
  require_relative 'concerns/slugifiable'

  has_many :song_genres
  has_many :genres, through: :song_genres
  belongs_to :artist
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  
end
