require 'simplecov'
SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('MAP_API_KEY') { ENV['MAP_API_KEY'] }
  config.filter_sensitive_data('WEATHER_API_KEY') { ENV['WEATHER_API_KEY'] }
  config.default_cassette_options = { re_record_interval: 7.days }
  config.default_cassette_options = { allow_playback_repeats: true }
  config.configure_rspec_metadata!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
     with.test_framework :rspec
     with.library :rails
  end
end

def forecast_data
  {
    "current": {
      "last_updated_epoch": 1686517200,
      "last_updated": "2023-06-11 15:00",
      "temp_c": 17.7,
      "temp_f": 63.9,
      "is_day": 1,
      "condition": {
        "text": "Partly cloudy",
        "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
        "code": 1003
      },
      "wind_mph": 10.5,
      "wind_kph": 16.9,
      "wind_degree": 90,
      "wind_dir": "E",
      "pressure_mb": 1019.0,
      "pressure_in": 30.09,
      "precip_mm": 0.7,
      "precip_in": 0.03,
      "humidity": 60,
      "cloud": 75,
      "feelslike_c": 17.7,
      "feelslike_f": 63.9,
      "vis_km": 16.0,
      "vis_miles": 9.0,
      "uv": 4.0,
      "gust_mph": 8.5,
      "gust_kph": 13.7
    },
    "forecast": {
      "forecastday": [
        {
          "date": "2023-06-11",
          "date_epoch": 1686441600,
          "day": {
            "maxtemp_c": 20.8,
            "maxtemp_f": 69.4,
            "mintemp_c": 11.6,
            "mintemp_f": 52.9,
            "avgtemp_c": 14.7,
            "avgtemp_f": 58.4,
            "maxwind_mph": 16.1,
            "maxwind_kph": 25.9,
            "totalprecip_mm": 48.0,
            "totalprecip_in": 1.89,
            "totalsnow_cm": 0.0,
            "avgvis_km": 9.3,
            "avgvis_miles": 5.0,
            "avghumidity": 76.0,
            "daily_will_it_rain": 1,
            "daily_chance_of_rain": 84,
            "daily_will_it_snow": 0,
            "daily_chance_of_snow": 0,
            "condition": {
              "text": "Heavy rain",
              "icon": "//cdn.weatherapi.com/weather/64x64/day/308.png",
              "code": 1195
            },
            "uv": 3.0
          },
          "astro": {
            "sunrise": "05:32 AM",
            "sunset": "08:28 PM",
            "moonrise": "01:50 AM",
            "moonset": "01:55 PM",
            "moon_phase": "Waning Crescent",
            "moon_illumination": "48",
            "is_moon_up": 0,
            "is_sun_up": 1
          },
          "hour": [
            {
              "time_epoch": 1686463200,
              "time": "2023-06-11 00:00",
              "temp_c": 13.5,
              "temp_f": 56.3,
              "is_day": 0,
              "condition": {
                "text": "Clear",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                        "code": 1000
                    },
                    "wind_mph": 3.8,
                    "wind_kph": 6.1,
                    "wind_degree": 323,
                    "wind_dir": "NW",
                    "pressure_mb": 1014.0,
                    "pressure_in": 29.95,
                    "precip_mm": 0.0,
                    "precip_in": 0.0,
                    "humidity": 80,
                    "cloud": 12,
                    "feelslike_c": 13.5,
                    "feelslike_f": 56.3,
                    "windchill_c": 13.5,
                    "windchill_f": 56.3,
                    "heatindex_c": 13.5,
                    "heatindex_f": 56.3,
                    "dewpoint_c": 10.1,
                    "dewpoint_f": 50.2,
                    "will_it_rain": 0,
                    "chance_of_rain": 0,
                    "will_it_snow": 0,
                    "chance_of_snow": 0,
                    "vis_km": 10.0,
                    "vis_miles": 6.0,
                    "gust_mph": 5.6,
                    "gust_kph": 9.0,
                    "uv": 1.0
                },
                {
                    "time_epoch": 1686466800,
                    "time": "2023-06-11 01:00",
                    "temp_c": 13.4,
                    "temp_f": 56.1,
                    "is_day": 0,
                    "condition": {
                        "text": "Clear",
                        "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                        "code": 1000
                    },
                    "wind_mph": 2.9,
                    "wind_kph": 4.7,
                    "wind_degree": 309,
                    "wind_dir": "NW",
                    "pressure_mb": 1014.0,
                    "pressure_in": 29.95,
                    "precip_mm": 0.0,
                    "precip_in": 0.0,
                    "humidity": 82,
                    "cloud": 16,
                    "feelslike_c": 13.7,
                    "feelslike_f": 56.7,
                    "windchill_c": 13.7,
                    "windchill_f": 56.7,
                    "heatindex_c": 13.4,
                    "heatindex_f": 56.1,
                    "dewpoint_c": 10.4,
                    "dewpoint_f": 50.7,
                    "will_it_rain": 0,
                    "chance_of_rain": 0,
                    "will_it_snow": 0,
                    "chance_of_snow": 0,
                    "vis_km": 10.0,
                    "vis_miles": 6.0,
                    "gust_mph": 4.5,
                    "gust_kph": 7.2,
                    "uv": 1.0
                },
              ]}]}}
end


