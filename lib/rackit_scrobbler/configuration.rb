require "ostruct"
module RackitScrobbler
  class Configuration
    CONFIG_FILE = "#{Dir.home}/.rackit_scrobbler"
    attr_accessor :last_fm, :rackit, :config_file
    def initialize
      @config_file = YAML::load_file(Configuration.config_path) || {}
    end

    def last_fm
      @last_fm ||= OpenStruct.new(config_file[:last_fm])
    end

    def rackit
      @rackit ||= OpenStruct.new(config_file[:rackit])
    end

    def write!
      File.open(self.class.config_path, "w+") do |f|
        YAML.dump({last_fm: last_fm.to_h, rackit: rackit.to_h}, f)
      end
    end

    def self.config_path
      CONFIG_FILE
    end

  end
end
