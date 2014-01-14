module PensioAPI
  module Mixins
    module Timestamps
      def created_at
        Time.parse(@raw['CreatedDate'])
      end

      def updated_at
        Time.parse(@raw['UpdatedDate'])
      end
    end
  end
end
