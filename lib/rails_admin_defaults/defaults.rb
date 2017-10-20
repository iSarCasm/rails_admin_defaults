require 'rails_admin/config/sections/base'

module RailsAdmin
  module Config
    module Sections
      # Configuration of the clone action
      class DefaultsSection < RailsAdmin::Config::Sections::Base

        register_instance_option :fields do
          []
        end
      end
    end
  end
end
