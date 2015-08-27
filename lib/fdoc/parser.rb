require 'yaml'

module Fdoc
  class Parser

    def initialize(root_path)
      @root_path = root_path
    end

    def parse(file_path)
      file = read_file(file_path)
      puts file
      YAML.load(file)
    end

    private

    def read_file(file_path)
      file = File.open(File.join(@root_path, file_path), "r")

      read_in_depth(file)
    end

    def read_in_depth(file)
      file_readed = ""

      while (line = file.gets)
        import = line.scan(/\# Import: (.*)/).first

        if !import.nil? && !import.empty?
          file_readed += read_file(import.first)
        else
          file_readed += line
        end
      end

      file_readed
    end
  end
end
