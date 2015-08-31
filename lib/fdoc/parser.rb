require 'yaml'

module Fdoc
  class Parser

    def initialize
      @files_imported = []
    end

    def parse(file_path)
      file = read_file(file_path)
      YAML.load(file)
    end

    private

    def read_file(file_path)
      return '' if @files_imported.include? file_path

      file = File.open(file_path, "r")

      @files_imported << file_path

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
