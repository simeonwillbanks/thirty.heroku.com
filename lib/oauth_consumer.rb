require "oauth/consumer"

module OAuthConsumer
  
  # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
  def self.access_token
    consumer = OAuth::Consumer.new("NqxQTQEo2o8GeNu5hp4Okw", "UxhB8iH02CSl1vhAcPVdhuT1EIeciDubmjG5RrtI",
      { :site => "http://api.twitter.com",
        :scheme => :header
      })
    # now create the access token object from passed values
    token_hash = { :oauth_token => "186658203-hLY80X84xUcnEiHLYo4DzMoCZ8tFgW5hLsKySzwL",
                   :oauth_token_secret => "kxwjqW3kXnF2yFWhcYAKeUCpLmvpStcig4t3MkOrM"
                 }
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  def self.handle_response(response)
    case response
    when Net::HTTPOK 
      message = begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    when Net::HTTPUnauthorized
      raise Exception, 'The credentials provided did not authorize the user.'
    else
      message = begin
        JSON.parse(response.body)['error']
      rescue JSON::ParserError
        if match = response.body.match(/<error>(.*)<\/error>/)
          match[1]
        else
          'An error occurred processing your Twitter request.'
        end
      end
      raise Exception, message
    end
  end
end