require "oauth_consumer"

class Tweet < ActiveRecord::Base
  validates_presence_of :text, :message => "must be entered"
  validates_length_of :text, :within => 1..140, :message => "must be between 1 and 140 characters"
  belongs_to :user
  
  begin
    
    after_create do |tweet|
      response = access_token.request(:post, 
        "http://api.twitter.com/1/statuses/update.json", 
        'status' => tweet.text)
      logger.info("oauth_consumer::handle_response %s" % handle_response(response))      
    end
  
    after_destroy do |tweet|
      if tweet.published
        resource = "http://api.twitter.com/1/statuses/destroy/%d.json" % tweet.status_id
        logger.info("resource is %s" % resource)
        response = access_token.request(:post, resource)
        logger.info("response is %s" % handle_response(response))      
      end
    end
    
  rescue Exception => e
    raise e.message
    
  end
  
end
