require './mp3_file'
require './services'

class MagicTag

  def self.play(directory, search_pattern)
    tag_directories(get_directories_to_be_processed(directory), search_pattern)
  end

  private

  # DFS over leaves
  def self.get_directories_to_be_processed(directory)
    result = []
    number_of_inner_directories = 0
    Dir.entries(directory).each do |entry|
      current_entry = File.join(directory,entry)
      if !/\.\.?$/.match(to_UTF8(entry)) and File.directory? current_entry
        number_of_inner_directories += 1
        result += get_directories_to_be_processed(current_entry)
      end
    end 
    result.push(directory) if number_of_inner_directories == 0
    result
  end

  # Tag all directories given an array of directory names and a search pattern
  def self.tag_directories(array_of_directories, search_pattern)
    array_of_directories.each do |path|
      search_pattern = get_search_pattern_from_path(path) unless search_pattern
      if tag_directory(path, search_pattern)
        puts "(+) #{path}"
      else
        puts "(-) #{path}"
      end
    end
  end

  # Heuristic to create a search pattern based on the directory name
  def self.get_search_pattern_from_path(path)
    dirs = path.split('/')
    dirs[-1] + " " + dirs[-2] # I expect a structure like this    .../band/album/
  end

  # Tag a single directory
  def self.tag_directory(directory, search_pattern)
    mp3_files = []
    Dir.entries(directory).each do |entry|
      entry = to_UTF8(entry)
      if /.mp3\s*$/i.match(entry)
        mp3_files << Mp3File.new(entry)
      end
    end

    Services.match_album(mp3_files, search_pattern)
  end

  # Convert a string to UTF8
  def self.to_UTF8(string)
    string.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
  end
end