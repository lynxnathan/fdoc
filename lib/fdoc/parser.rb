require 'yaml'

module Fdoc
  class Parser

    def initialize(file_path)
      @file_path = file_path
      @dirname = File.dirname(file_path)
    end

    def parse
      file = File.open(@file_path, "r")
      imports = parse_imports(file)

      YAML.load(imports + file.read)
    end

    private

    def parse_imports(file)
      imports = ""

      while (line = file.gets)
        import = line.scan(/\# Import: (.*)/).first
        if !import.nil? && !import.empty?
          imports += open_import(import.first)
        end
      end

      file.seek(0, IO::SEEK_SET)
      imports
    end

    def open_import(import)
      File.open(File.join(@dirname, import), "r").read
    end

  end
end
