require 'rails'

module Dust
  module Rails
    class Railtie < ::Rails::Railtie
      config.dust = ActiveSupport::OrderedOptions.new

      initializer "dust.configure" do |app|
        Dust.configure do |config|
          config.template_root = app.config.dust[:template_root] if not app.config.dust[:template_root].nil?
          config.autoload = app.config.dust[:autoload] if not app.config.dust[:autoload].nil?
        end
      end
    end
  end
end
