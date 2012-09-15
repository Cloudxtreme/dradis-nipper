# NipperUpload

require 'nipper_upload/filters'
require 'nipper_upload/meta'
require 'nipper_upload/processor'

module NipperUpload
  include Core::Plugins::Upload::Base

  class Configuration < Core::Configurator
    configure :namespace => 'nipper_upload'

    setting :category, :default => 'Nipper output'
    setting :author, :default => 'Nipper plugin'
    setting :parent_node, :default => 'plugin.nipper'
  end
end

# This includes the upload plugin module in the Dradis upload plugin repository
module Plugins
  module Upload 
    include NipperUpload
  end
end
