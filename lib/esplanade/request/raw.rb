require 'esplanade/request/raw/body'

module Esplanade
  class Request
    class Raw
      def initialize(env)
        @env = env
      end

      def method
        @method ||= @env['REQUEST_METHOD']
      end

      def path
        @path ||= @env['PATH_INFO']
      end

      def body
        @body ||= Body.new(self, @env)
      end
    end
  end
end