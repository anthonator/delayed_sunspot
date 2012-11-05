module DelayedSunspot
  module DelayedJob
    class SunspotJob
      attr_reader :session, :proxy, :method

      def initialize(proxy, method, *args, &block)
        @proxy = proxy
        @session = proxy.session
        @method = method
        @args = args
      end

      def perform
        rebuild_config
        @args ? @session.send(method, *@args) : @session.send(method)
      end

      private
      def rebuild_config
        @session.instance_variable_set("@config", DelayedSunspot::Sunspot::Configuration.new(session.config))
      end
    end
  end
end
