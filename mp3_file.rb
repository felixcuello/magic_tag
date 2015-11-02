class Mp3File

  def initialize(file_name)
    @file_name = file_name
    if /^\s*([0-9]+)(.+)\.mp3\s*/i.match file_name
      @track_number = normalize_track_number($1)
      @track_name   = normalize_track_name($2)
    end
  end

  private

  def normalize_track_number(track_number)
    track_number.gsub(/[^0-9]/,'')
  end

  def normalize_track_name(track_name)
    track_name.gsub(/^[^a-z0-9]+/i,'')
  end

end

