# RailsAdminDefaults

Allows setting up default values from one models to other.

## Setup
1) Gemfile:
```
gem 'rails_admin_defaults', git: 'https://github.com/iSarCasm/rails_admin_defaults'
gem 'rails_admin', '~> 1.2'
```
2) Add `defaults` to actions `config/initializer/rails_admin.rb`:
```
config.actions do
  dashboard                     # mandatory
  index                         # mandatory
  new
  export
  bulk_delete
  show
  edit
  delete
  show_in_app
  defaults
end
```
3) Require custom JS to `app/assets/javascript/rails_admin/ui.js`:
```
//= require jquery-defaults
```

## Example
Given the Tour model:
```
# == Schema Information
#
# Table name: tours
#
#  id                     :integer          not null, primary key
#  title                  :string
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  slug                   :string
#  tour_type_id           :integer
#  country_id             :integer
#  excursions             :text
#  itinerary              :text
#  important_notes        :text
#  tour_memo              :text
#  default_other_costs    :decimal(, )
#  default_self_drive     :boolean
#  allow_external_agents  :boolean
#  insurance_allowed      :boolean
#  default_allow_deposits :boolean
```

Given the ActiveTour model:
```
# == Schema Information
#
# Table name: active_tours
#
#  id             :integer          not null, primary key
#  tour_id        :integer
#  start_date     :date
#  end_date       :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#  allow_deposits :boolean
#  other_costs    :decimal(, )
#  self_drive     :boolean
```

You need to setup which fields are default:
```
RailsAdmin.config do |config|
  config.model Tour do
    defaults [:allow_deposits, :other_costs, :self_drive]
  end
end
```
Make field which pulls data via AJAX:
```
RailsAdmin.config do |config|
  config.model ActiveTour do
    edit do
      field :tour, :filter_select_with_defaults
    end
  end
end
```
