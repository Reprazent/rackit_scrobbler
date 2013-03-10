require "ostruct"
module RackitScrobbler
  class Configuration
    attr_accessor :last_fm, :rackit, :config_file
    def initialize
      if File.exists?(Configuration.config_path)
        @config_file = YAML::load_file(Configuration.config_path)
      else
        @config_file = {}
      end
    end

    def last_fm
      @last_fm ||= OpenStruct.new(config_file["last_fm"])
    end

    def rackit
      @rackit ||= OpenStruct.new(config_file["rackit"])
    end

    def write!
      File.open(self.class.config_path, "w+") do |f|
        YAML.dump({ "last_fm" =>  last_fm.to_h.stringify_keys,
                    "rackit" => rackit.to_h.stringify_keys}, f)
      end
    end

    def self.config_path
      "#{Dir.home}/.rackit_scrobbler"
    end

  end
end
