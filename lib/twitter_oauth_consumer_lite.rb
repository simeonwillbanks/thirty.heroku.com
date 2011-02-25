require "oauth/consumer"

module TwitterOAuthConsumerLite
  
  # Exchange OAUTH_ACCESS_TOKEN and OAUTH_ACCESS_TOKEN_SECRET for an AccessToken instance
  def self.access_token
    consumer = OAuth::Consumer.new(OAUTH_CONSUMER_KEY, OAUTH_CONSUMER_SECRET, 
               {:site => "http://api.twitter.com", :scheme => :header})
    token_hash = {:oauth_token => OAUTH_ACCESS_TOKEN, 
                  :oauth_token_secret => OAUTH_ACCESS_TOKEN_SECRET}
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  # On a 200 response, return hash of JSON body
  # On other response, raise an exception
  def self.handle_response(response)
    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      raise Exception, 'An error occurred processing your Twitter request.'
    end
    if not response.kind_of? Net::HTTPOK
      raise Exception, json['error']
      # Raise CustomError
      # raise json['error']
    end
    json
  end
  
end