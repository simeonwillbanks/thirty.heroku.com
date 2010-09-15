require "oauth/consumer"

module TwitterOAuthConsumerLite
  
  CONSUMER_KEY = "NqxQTQEo2o8GeNu5hp4Okw"
  CONSUMER_SECRET = "UxhB8iH02CSl1vhAcPVdhuT1EIeciDubmjG5RrtI"
  ACCESS_TOKEN = "186658203-hLY80X84xUcnEiHLYo4DzMoCZ8tFgW5hLsKySzwL"
  ACCESS_TOKEN_SECRET = "kxwjqW3kXnF2yFWhcYAKeUCpLmvpStcig4t3MkOrM"
  
  # Exchange ACCESS_TOKEN and ACCESS_TOKEN_SECRET for an AccessToken instance
  def self.access_token
    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, 
               {:site => "http://api.twitter.com", :scheme => :header})
    token_hash = {:oauth_token => ACCESS_TOKEN, 
                  :oauth_token_secret => ACCESS_TOKEN_SECRET}
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
    end
    json
  end
  
end