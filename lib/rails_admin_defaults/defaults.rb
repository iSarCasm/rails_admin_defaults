require 'rails_admin/config/sections/base'

module RailsAdmin
  module Config
    class Model
      register_instance_option :defaults do
        []
      end
    end
  end
end
