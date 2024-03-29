class DradisTasks < Thor
  class Upload < Thor
    namespace "dradis:upload"

    desc  "nipper FILE", "upload nipper results"
    long_desc "This will appear if the user runs 'thor help dradis:upload:nipper'"
    def nipper(file_path)
      require 'config/environment'

      logger = Logger.new(STDOUT)
      logger.level = Logger::DEBUG

      unless File.exists?(file_path)
        $stderr.puts "** the file [#{file_path}] does not exist"
        exit -1
      end

      NipperUpload.import(
        :file => file_path,
        :logger => logger)

      logger.close
    end

  end
end
