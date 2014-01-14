module PensioAPI
  module Mixins
    module ID
      def id
        @raw["#{ self.class.name.demodulize }Id"]
      end
    end
  end
end
