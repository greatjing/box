require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsRecipes
  class Application < Rails::Application

    # 默认语系是中文
    config.i18n.default_locale = "zh-CN"
    # 设置默认时间为北京时间
    config.time_zone = "Beijing"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
