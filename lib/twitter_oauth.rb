require "oauth/consumer"

# Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
def prepare_access_token()
  consumer = OAuth::Consumer.new("NqxQTQEo2o8GeNu5hp4Okw", "UxhB8iH02CSl1vhAcPVdhuT1EIeciDubmjG5RrtI",
    { :site => "http://api.twitter.com",
      :scheme => :header
    })
  # now create the access token object from passed values
  token_hash = { :oauth_token => "186658203-hLY80X84xUcnEiHLYo4DzMoCZ8tFgW5hLsKySzwL",
                 :oauth_token_secret => "kxwjqW3kXnF2yFWhcYAKeUCpLmvpStcig4t3MkOrM"
               }
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
  return access_token
end