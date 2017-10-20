require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class DefaultsAction < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :controller do
          Proc.new do
            defaults = model_config.sample_section.defaults

            respond_to do |format|
              format.js { render defaults.to_json, :layout => false }
            end
          end
        end
      end
    end
  end
end
