module Esplanade
  class Request
    class Doc
      def initialize(main_documentation, raw)
        @main_documentation = main_documentation
        @raw = raw
      end

      def tomogram
        raise PrefixNotMatch, message unless @main_documentation.prefix_match?(@raw.path)
        @tomogram = @main_documentation.find_request(method: @raw.method, path: @raw.path)
        raise NotDocumented, message if @tomogram.nil?
        @tomogram
      end

      def json_schema
        @json_schema ||= tomogram.request
      end

      def method
        @method ||= tomogram.method
      end

      def path
        @path ||= tomogram.path.to_s
      end

      def responses
        @responses ||= tomogram.responses
      rescue NotDocumented
        []
      end

      private

      def message
        {
          method: @raw.method,
          path: @raw.path
        }
      end
    end
  end
end