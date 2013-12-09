require 'rails/engine'

module Dust
  module Rails
    class Engine < ::Rails::Engine
      initializer 'dustjs.register', :after => "sporckets.environment", :group => :all do |app|
        next unless app.assets

        app.assets.register_engine('.dust', DustTemplate)
      end
    end
  end
end
