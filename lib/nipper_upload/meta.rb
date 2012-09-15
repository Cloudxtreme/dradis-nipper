module NipperUpload  
  module Meta
    NAME = "This plugin does not have a name, define it at #{__FILE__.gsub(/#{Rails.root.to_s}/,'.')}"
    EXPECTS = "Describe what file format the plugin is able to parse in #{__FILE__.gsub(/#{Rails.root.to_s}/,'.')}"
    # change this to the appropriate version
    module VERSION #:nodoc:
      MAJOR = 2
      MINOR = 10
      TINY = 0

      STRING = [MAJOR, MINOR, TINY].join('.')
    end
  end
end
