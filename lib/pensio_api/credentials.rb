module PensioAPI
  class Credentials
    class << self
      attr_accessor :credentials, :allow_defaults
      
      # backwards compatability - set default credentials
      
      def base_uri
        default_credentials.base_uri
      end
      
      def base_uri=(value)
        default_credentials.base_uri = value
      end
      
      def username
        default_credentials.username
      end
      
      def username=(value)
        default_credentials.username = value
      end
      
      def password
        default_credentials.password
      end
      
      def password=(value)
        default_credentials.password = value
      end
      
      def for(context)
        self.credentials ||= {}
        self.credentials[context.to_sym] ||= PensioAPI::Credentials.new
      end
      
      def default_credentials
        self.for(:default)
      end
      
      def credentials_mode
        self.for(:default)
        self.credentials.count == 1 ? :default : :multiple
      end
    end
    
    def supplied?
      !!(base_uri && username && password)
    end
    
    attr_accessor :base_uri, :username, :password
  end
end
