require "dust-rails/version"
require "dust-rails/rails/engine.rb"
require "dust-rails/rails/dust_template.rb"
require "dust-rails/rails/railtie.rb"

module Dust

  DEFAULT_TEMPLATE_ROOT = 'app/assets/javascripts/templates/'

  class Config
    attr_accessor :template_root
    attr_accessor :auto_load

    def initialize
      @template_root = DEFAULT_TEMPLATE_ROOT
      @autoload = true
    end
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end
end
