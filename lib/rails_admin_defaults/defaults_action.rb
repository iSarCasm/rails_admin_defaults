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
            defaults = model_config.defaults.each.with_object({}) do |d, h|
              obj = object.send(d)
              if obj.try(:size) && obj.class != Fixnum # Array or AR Assoc
                obj = obj.to_a.map do |rec|
                  rec.attributes.each.with_object({}) do |(k, v), h|
                    if k =~ /_id$/ && v
                      klass = k[0...-3].split('_').join(' ').titleize.gsub(' ','').constantize
                      found = klass.find(v)
                      h[k] = { data: found, title: found.title }
                    else
                      h[k] = v
                    end
                  end
                end
                h[d] = { data: obj }
              elsif !obj.nil? && obj.try(:title)  # Object
                h[d] = { data: obj, title: obj.title }
              else
                h[d] = { data: obj }
              end
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
