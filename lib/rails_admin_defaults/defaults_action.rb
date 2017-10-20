require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class Defaults < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          false
        end

        register_instance_option :member do
          true
        end

        register_instance_option :controller do
          Proc.new do
            defaults = model_config.defaults.map do |d|
              object.send(d)
            end

            respond_to do |format|
              format.js   { render plain: defaults.to_json, :layout => false }
              format.json { render plain: defaults.to_json, :layout => false }
            end
          end
        end
      end
    end
  end
end
