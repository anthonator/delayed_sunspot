module DelayedSunspot
  module Sunspot
    class Configuration
      def initialize(config)
        @config = config
        singleton = (class <<self; self; end)
        @properties = @config.instance_variable_get("@properties") || {}
        @properties.keys.each do |key|
          singleton.module_eval do
            define_method key do
              if @properties[key].is_a?(LightConfig::Configuration)
                self.class.new(@properties[key])
              else
                @properties[key]
              end
            end
            define_method "#{key}=" do |value|
              @properties[key] = value
            end
          end
        end
      end
    end
  end
end
