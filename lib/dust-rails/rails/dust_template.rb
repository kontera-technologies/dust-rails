require 'tilt'
require 'execjs'

module Dust
  module Rails


    module Source

      def self.precompile(data, template)
        @precompile = context.call("dust.compile", data, template)
      end

      private
        def self.path
          @path = File.expand_path('../../../../vendor/dustjs/lib/dust.js', __FILE__)
        end

        def self.contents
          @contents = File.read(path)
        end

        def self.context
          @context = ExecJS.compile(contents)
        end

    end

    class DustTemplate < ::Tilt::Template

      def self.default_mime_type
        'application/javascript'
      end

      def prepare
      end

      def evaluate(scope, locals, &block)
        template_root = Dust.config.template_root
        template_name = file.split(template_root).last.split('.')[0...-2].join('.')
        compiled = Source.precompile(data, template_name)
        if Dust.config.autoload
          compiled = "dust.loadSource(#{compiled.inspect});"
        end
        if Dust.config.use_amd
          compiled = "define('dust!#{template_name}',[], function() { #{compiled} });"
        end
        return compiled
      end
    end
  end
end


