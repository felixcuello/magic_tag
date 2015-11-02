class Album
  attr_accessor :name          # Album name
  attr_accessor :release_year  # Year of release
  attr_accessor :year          # Year of this album

  def initialize
    @tracks = []
  end

  def add_track( t )
    @track.push(t)
  end

  def number_of_tracks
    @track.length
  end
end
