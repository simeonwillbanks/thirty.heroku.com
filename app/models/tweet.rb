require "twitter_oauth_consumer_lite"

class Tweet < ActiveRecord::Base
  
  #Mass assignment only sets tweets.text
  attr_accessible :text
  
  validates_presence_of :text, :message => "must be entered"
  validates_length_of :text, :within => 1..140, :message => "must be between 1 and 140 characters"
  belongs_to :user
  
  begin
    
    after_create do |tweet|
      response = TwitterOAuthConsumerLite.access_token.request(:post, 
        "http://api.twitter.com/1/statuses/update.json", 
        'status' => tweet.text)
      json = TwitterOAuthConsumerLite.handle_response(response)
      tweet.published = 1
      tweet.status_id = json['id']   
      tweet.save   
      logger.debug("after_create response %s" % json.to_s)   
    end
  
    after_destroy do |tweet|
      if tweet.published
        resource = "http://api.twitter.com/1/statuses/destroy/%d.json" % tweet.status_id
        logger.debug("after_destroy resource '%s'" % resource)
        response = TwitterOAuthConsumerLite.access_token.request(:post, resource)
        json = TwitterOAuthConsumerLite.handle_response(response)
        logger.debug("after_destroy response %s" % json.to_s)      
      end
    end
    
  rescue Exception => e
    raise e.message
    
  end
  
end
