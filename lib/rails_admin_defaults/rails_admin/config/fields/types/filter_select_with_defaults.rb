module RailsAdmin::Config::Fields::Types
  class FilterSelectWithDefaults < RailsAdmin::Config::Fields::Types::BelongsToAssociation
    RailsAdmin::Config::Fields::Types::register(:filter_select_with_defaults, self)

    register_instance_option(:partial) do
      :filter_select_with_defaults
    end
  end
end
