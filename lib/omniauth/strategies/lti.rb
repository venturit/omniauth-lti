module OmniAuth
  module Strategies
    class Lti
      include OmniAuth::Strategy
      
      # Hash for storing your Consumer Tools credentials, whether:
      # - the key is the consumer_key 
      # - the value is the comsumer_secret
      option :oauth_credentials, {}
      
      # Defaul username for users when LTI context doesn't provide a name
      option :default_user_name, 'User'
      
      def callback_phase
        # validate request
        return fail!(:invalid_credentials) unless valid_lti?
        #save the launch parameters for use in later request
        env['lti.launch_params'] = @tp.to_params
        super
      end
      
      # define the UID
      uid { @tp.user_id }
      
      # define the hash of info about user
      info do
        {
          :name => @tp.username(options.default_user_name),
          :email => @tp.lis_person_contact_email_primary,
          :first_name => @tp.lis_person_name_given,
          :last_name => @tp.lis_person_name_family,
          :image => @tp.user_image
        }
      end
      
      # define the hash of credentials
      credentials do
        {
          :token => @tp.consumer_key,
          :secret => @tp.consumer_secret
        }
      end
      
      #define extra hash
      extra do
        { :raw_info => @tp.to_params }
      end
      
      private
      
      def valid_lti?
        key = request.params['oauth_consumer_key']
        log :info, "Checking LTI params for key #{key}: #{request.params}"
        log :info, "Checking options.oauth_credentials[key] #{options.oauth_credentials[key]}"
        log :info, "Checking LTI params for key #{key}: #{request.params}"
        log :info, "Checking LTI request: #{request.inspect}"
        @tp = IMS::LTI::ToolProvider.new(key, options.oauth_credentials[key], request.params)
        log :info, "Valid request? #{@tp.valid_request!(request)}"
        @tp.valid_request!(request)
      end
    end
  end
end
